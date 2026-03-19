insert into public.platform_settings (key, value, is_public, description)
values (
  'booking_pricing',
  jsonb_build_object(
    'platform_fee_rate', 0.05,
    'carrier_fee_rate', 0,
    'insurance_rate', 0.01,
    'insurance_min_fee_dzd', 100,
    'tax_rate', 0
  ),
  true,
  'Public booking pricing defaults for client and booking calculations'
)
on conflict (key) do nothing;

create or replace function public.create_booking_from_search_result(
  p_shipment_id uuid,
  p_source_type text,
  p_source_id uuid,
  p_departure_date date default null,
  p_include_insurance boolean default false,
  p_idempotency_key text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_shipment public.shipments;
  v_existing_booking public.bookings;
  v_source_type text := lower(trim(coalesce(p_source_type, '')));
  v_route public.routes;
  v_route_revision public.route_revisions;
  v_route_instance public.route_departure_instances;
  v_trip public.oneoff_trips;
  v_vehicle_id uuid;
  v_carrier_id uuid;
  v_departure_at timestamptz;
  v_price_per_kg_dzd numeric;
  v_total_capacity_kg numeric;
  v_total_capacity_volume_m3 numeric;
  v_remaining_capacity_kg numeric;
  v_remaining_volume_m3 numeric;
  v_settings jsonb;
  v_platform_fee_rate numeric;
  v_carrier_fee_rate numeric;
  v_insurance_rate numeric;
  v_insurance_min_fee_dzd numeric;
  v_tax_rate numeric;
  v_base_price_dzd numeric;
  v_platform_fee_dzd numeric;
  v_carrier_fee_dzd numeric;
  v_insurance_fee_dzd numeric := 0;
  v_tax_fee_dzd numeric;
  v_shipper_total_dzd numeric;
  v_carrier_payout_dzd numeric;
  v_tracking_number text;
  v_payment_reference text;
  v_booking public.bookings;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if not exists (
    select 1
    from public.profiles
    where id = v_actor_id
      and role = 'shipper'::public.app_role
      and is_active = true
  ) then
    raise exception 'Only active shippers may create bookings';
  end if;

  perform public.assert_rate_limit('create_booking', 12, 300);

  select * into v_shipment
  from public.shipments
  where id = p_shipment_id
    and shipper_id = v_actor_id
  for update;

  if not found then
    raise exception 'Shipment not found';
  end if;

  if v_shipment.status <> 'draft' then
    select * into v_existing_booking
    from public.bookings
    where shipment_id = p_shipment_id;
    if found then
      return v_existing_booking;
    end if;
    raise exception 'Only draft shipments can be booked';
  end if;

  select * into v_existing_booking
  from public.bookings
  where shipment_id = p_shipment_id;
  if found then
    return v_existing_booking;
  end if;

  select coalesce(value, '{}'::jsonb)
  into v_settings
  from public.platform_settings
  where key = 'booking_pricing'
    and is_public = true;

  v_platform_fee_rate := coalesce((v_settings->>'platform_fee_rate')::numeric, 0.05);
  v_carrier_fee_rate := coalesce((v_settings->>'carrier_fee_rate')::numeric, 0);
  v_insurance_rate := coalesce((v_settings->>'insurance_rate')::numeric, 0.01);
  v_insurance_min_fee_dzd := coalesce((v_settings->>'insurance_min_fee_dzd')::numeric, 100);
  v_tax_rate := coalesce((v_settings->>'tax_rate')::numeric, 0);

  if v_source_type = 'route' then
    if p_departure_date is null then
      raise exception 'Route bookings require a departure date';
    end if;

    select * into v_route
    from public.routes
    where id = p_source_id
      and is_active = true
    for update;

    if not found then
      raise exception 'Route not found';
    end if;

    select * into v_route_revision
    from public.route_revisions
    where route_id = v_route.id
      and effective_from::date <= p_departure_date
    order by effective_from desc, created_at desc
    limit 1;

    if not found then
      raise exception 'Route revision not found';
    end if;

    v_vehicle_id := v_route_revision.vehicle_id;
    v_carrier_id := v_route.carrier_id;
    v_departure_at := (p_departure_date::timestamp + v_route_revision.default_departure_time)::timestamptz;
    v_price_per_kg_dzd := v_route_revision.price_per_kg_dzd;
    v_total_capacity_kg := v_route_revision.total_capacity_kg;
    v_total_capacity_volume_m3 := v_route_revision.total_capacity_volume_m3;

    if v_shipment.origin_commune_id <> v_route.origin_commune_id
       or v_shipment.destination_commune_id <> v_route.destination_commune_id then
      raise exception 'Shipment lane does not match selected route';
    end if;

    if extract(dow from p_departure_date)::int <> any(v_route_revision.recurring_days_of_week) then
      raise exception 'Route is not available on the selected departure date';
    end if;

    insert into public.route_departure_instances (
      route_id,
      departure_date,
      vehicle_id,
      total_capacity_kg,
      reserved_capacity_kg,
      remaining_capacity_kg,
      total_capacity_volume_m3,
      reserved_volume_m3,
      remaining_volume_m3,
      status
    ) values (
      v_route.id,
      p_departure_date,
      v_vehicle_id,
      v_total_capacity_kg,
      0,
      v_total_capacity_kg,
      v_total_capacity_volume_m3,
      0,
      v_total_capacity_volume_m3,
      'open'
    ) on conflict (route_id, departure_date) do nothing;

    select * into v_route_instance
    from public.route_departure_instances
    where route_id = v_route.id
      and departure_date = p_departure_date
    for update;

    v_remaining_capacity_kg := v_route_instance.remaining_capacity_kg;
    v_remaining_volume_m3 := v_route_instance.remaining_volume_m3;
  elsif v_source_type = 'oneoff_trip' then
    select * into v_trip
    from public.oneoff_trips
    where id = p_source_id
      and is_active = true
    for update;

    if not found then
      raise exception 'One-off trip not found';
    end if;

    if p_departure_date is not null and v_trip.departure_at::date <> p_departure_date then
      raise exception 'One-off trip does not match the selected departure date';
    end if;

    v_vehicle_id := v_trip.vehicle_id;
    v_carrier_id := v_trip.carrier_id;
    v_departure_at := v_trip.departure_at;
    v_price_per_kg_dzd := v_trip.price_per_kg_dzd;
    v_total_capacity_kg := v_trip.total_capacity_kg;
    v_total_capacity_volume_m3 := v_trip.total_capacity_volume_m3;

    if v_shipment.origin_commune_id <> v_trip.origin_commune_id
       or v_shipment.destination_commune_id <> v_trip.destination_commune_id then
      raise exception 'Shipment lane does not match selected one-off trip';
    end if;

    select
      v_trip.total_capacity_kg - coalesce(sum(b.weight_kg), 0),
      case
        when v_trip.total_capacity_volume_m3 is null then null
        else v_trip.total_capacity_volume_m3 - coalesce(sum(coalesce(b.volume_m3, 0)), 0)
      end
    into v_remaining_capacity_kg, v_remaining_volume_m3
    from public.bookings as b
    where b.oneoff_trip_id = v_trip.id
      and b.booking_status <> 'cancelled';
  else
    raise exception 'Unsupported booking source type';
  end if;

  if v_departure_at < v_shipment.pickup_window_start
     or v_departure_at > v_shipment.pickup_window_end then
    raise exception 'Selected departure is outside the shipment pickup window';
  end if;

  if v_remaining_capacity_kg < v_shipment.total_weight_kg then
    raise exception 'Selected capacity is no longer available';
  end if;

  if v_shipment.total_volume_m3 is not null
     and v_total_capacity_volume_m3 is not null
     and coalesce(v_remaining_volume_m3, 0) < v_shipment.total_volume_m3 then
    raise exception 'Selected volume capacity is no longer available';
  end if;

  v_base_price_dzd := round(v_shipment.total_weight_kg * v_price_per_kg_dzd, 2);
  v_platform_fee_dzd := round(v_base_price_dzd * v_platform_fee_rate, 2);
  v_carrier_fee_dzd := round(v_base_price_dzd * v_carrier_fee_rate, 2);
  if p_include_insurance then
    v_insurance_fee_dzd := greatest(round(v_base_price_dzd * v_insurance_rate, 2), v_insurance_min_fee_dzd);
  end if;
  v_tax_fee_dzd := round((v_base_price_dzd + v_platform_fee_dzd + v_carrier_fee_dzd + v_insurance_fee_dzd) * v_tax_rate, 2);
  v_shipper_total_dzd := v_base_price_dzd + v_platform_fee_dzd + v_carrier_fee_dzd + v_insurance_fee_dzd + v_tax_fee_dzd;
  v_carrier_payout_dzd := v_base_price_dzd + v_carrier_fee_dzd;
  v_tracking_number := 'FF-' || to_char(now(), 'YYMMDD') || '-' || upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 8));
  v_payment_reference := 'PAY-' || to_char(now(), 'YYMMDD') || '-' || upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 10));

  insert into public.bookings (
    shipment_id,
    route_id,
    route_departure_date,
    oneoff_trip_id,
    shipper_id,
    carrier_id,
    vehicle_id,
    weight_kg,
    volume_m3,
    price_per_kg_dzd,
    base_price_dzd,
    platform_fee_dzd,
    carrier_fee_dzd,
    insurance_rate,
    insurance_fee_dzd,
    tax_fee_dzd,
    shipper_total_dzd,
    carrier_payout_dzd,
    booking_status,
    payment_status,
    tracking_number,
    payment_reference
  ) values (
    v_shipment.id,
    case when v_source_type = 'route' then p_source_id else null end,
    case when v_source_type = 'route' then p_departure_date else null end,
    case when v_source_type = 'oneoff_trip' then p_source_id else null end,
    v_actor_id,
    v_carrier_id,
    v_vehicle_id,
    v_shipment.total_weight_kg,
    v_shipment.total_volume_m3,
    v_price_per_kg_dzd,
    v_base_price_dzd,
    v_platform_fee_dzd,
    v_carrier_fee_dzd,
    case when p_include_insurance then v_insurance_rate else null end,
    v_insurance_fee_dzd,
    v_tax_fee_dzd,
    v_shipper_total_dzd,
    v_carrier_payout_dzd,
    'pending_payment',
    'unpaid',
    v_tracking_number,
    v_payment_reference
  ) returning * into v_booking;

  update public.shipments
  set status = 'booked', updated_at = now()
  where id = v_shipment.id;

  if v_source_type = 'route' then
    update public.route_departure_instances
    set
      reserved_capacity_kg = reserved_capacity_kg + v_shipment.total_weight_kg,
      remaining_capacity_kg = remaining_capacity_kg - v_shipment.total_weight_kg,
      reserved_volume_m3 = case
        when v_shipment.total_volume_m3 is null then reserved_volume_m3
        else coalesce(reserved_volume_m3, 0) + v_shipment.total_volume_m3
      end,
      remaining_volume_m3 = case
        when v_shipment.total_volume_m3 is null then remaining_volume_m3
        when remaining_volume_m3 is null then null
        else remaining_volume_m3 - v_shipment.total_volume_m3
      end,
      updated_at = now()
    where id = v_route_instance.id;
  end if;

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_actor_id,
    'booking_created',
    'booking_created_title',
    'booking_created_body',
    jsonb_build_object('booking_id', v_booking.id)
  );

  insert into public.email_outbox_jobs (
    event_key,
    dedupe_key,
    profile_id,
    booking_id,
    template_key,
    locale,
    recipient_email,
    priority,
    status,
    available_at,
    payload_snapshot
  )
  select
    'booking_created',
    'booking_created:' || coalesce(nullif(trim(p_idempotency_key), ''), v_booking.id::text),
    p.id,
    v_booking.id,
    'booking_created',
    'en',
    p.email,
    'high',
    'queued',
    now(),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'tracking_number', v_tracking_number,
      'payment_reference', v_payment_reference,
      'shipper_total_dzd', v_shipper_total_dzd
    )
  from public.profiles as p
  where p.id = v_actor_id;

  insert into public.tracking_events (
    booking_id,
    event_type,
    visibility,
    note,
    created_by,
    recorded_at
  ) values (
    v_booking.id,
    'payment_pending',
    'user_visible',
    'Booking created and waiting for payment proof.',
    v_actor_id,
    now()
  );

  return v_booking;
end;
$$;

revoke all on function public.create_booking_from_search_result(uuid, text, uuid, date, boolean, text) from public, anon;
grant execute on function public.create_booking_from_search_result(uuid, text, uuid, date, boolean, text) to authenticated, service_role;
