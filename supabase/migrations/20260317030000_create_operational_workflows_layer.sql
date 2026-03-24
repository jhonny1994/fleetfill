-- Consolidated dev-phase layer migration: 20260317030000_create_operational_workflows_layer.sql
-- Generated from historical dev-only migrations during local rebaseline work.

-- >>> BEGIN 20260320120000_add_shipment_domain_constraints.sql
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'shipments_distinct_lane_check'
  ) then
    alter table public.shipments
    add constraint shipments_distinct_lane_check
    check (origin_commune_id <> destination_commune_id);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipments_positive_weight_check'
  ) then
    alter table public.shipments
    add constraint shipments_positive_weight_check
    check (total_weight_kg > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipments_non_negative_volume_check'
  ) then
    alter table public.shipments
    add constraint shipments_non_negative_volume_check
    check (total_volume_m3 is null or total_volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'bookings_route_date_required_check'
  ) then
    alter table public.bookings
    add constraint bookings_route_date_required_check
    check (
      (route_id is not null and route_departure_date is not null and oneoff_trip_id is null)
      or (route_id is null and route_departure_date is null and oneoff_trip_id is not null)
    );
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_departure_instances_non_negative_capacity_check'
  ) then
    alter table public.route_departure_instances
    add constraint route_departure_instances_non_negative_capacity_check
    check (
      total_capacity_kg >= 0
      and reserved_capacity_kg >= 0
      and remaining_capacity_kg >= 0
      and (total_capacity_volume_m3 is null or total_capacity_volume_m3 >= 0)
      and (reserved_volume_m3 is null or reserved_volume_m3 >= 0)
      and (remaining_volume_m3 is null or remaining_volume_m3 >= 0)
    );
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_departure_instances_capacity_balance_check'
  ) then
    alter table public.route_departure_instances
    add constraint route_departure_instances_capacity_balance_check
    check (
      remaining_capacity_kg = total_capacity_kg - reserved_capacity_kg
      and (
        total_capacity_volume_m3 is null
        or remaining_volume_m3 is null
        or reserved_volume_m3 is null
        or remaining_volume_m3 = total_capacity_volume_m3 - reserved_volume_m3
      )
    );
  end if;
end;
$$;

create unique index if not exists route_departure_instances_route_date_unique_idx
on public.route_departure_instances (route_id, departure_date);

create index if not exists shipments_lane_lookup_idx
on public.shipments (origin_commune_id, destination_commune_id);

create index if not exists bookings_route_active_lookup_idx
on public.bookings (route_id, route_departure_date)
where booking_status <> 'cancelled';

create index if not exists bookings_oneoff_active_lookup_idx
on public.bookings (oneoff_trip_id)
where booking_status <> 'cancelled';

create index if not exists route_revisions_route_effective_idx
on public.route_revisions (route_id, effective_from desc);
-- <<< END 20260320120000_add_shipment_domain_constraints.sql

-- >>> BEGIN 20260320120100_create_exact_lane_search_rpc.sql
create or replace function public.search_exact_lane_capacity(
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_requested_date date,
  p_total_weight_kg numeric,
  p_total_volume_m3 numeric default null,
  p_sort text default 'recommended',
  p_limit integer default 20,
  p_offset integer default 0
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_mode text := 'exact';
  v_requested_day integer := extract(dow from p_requested_date);
  v_normalized_limit integer := greatest(1, least(coalesce(p_limit, 20), 50));
  v_normalized_offset integer := greatest(coalesce(p_offset, 0), 0);
  v_results jsonb := '[]'::jsonb;
  v_total_count integer := 0;
  v_nearest_dates jsonb := '[]'::jsonb;
  v_exact_exists boolean := false;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if p_total_weight_kg <= 0 then
    raise exception 'Shipment weight must be greater than zero';
  end if;

  if not public.is_admin() and not public.is_service_role() then
    if not exists (
      select 1
      from public.profiles
      where id = v_actor_id
        and role = 'shipper'::public.app_role
        and is_active = true
    ) then
      raise exception 'Only active shippers may search exact lane capacity';
    end if;
  end if;

  with recurring_candidates as (
    select
      r.id as source_id,
      'route'::text as source_type,
      r.carrier_id,
      rr.vehicle_id,
      r.origin_commune_id,
      r.destination_commune_id,
      (p_requested_date::timestamp + rr.default_departure_time)::timestamptz as departure_at,
      rr.total_capacity_kg,
      rr.total_capacity_volume_m3,
      rr.price_per_kg_dzd,
      coalesce(rdi.remaining_capacity_kg, rr.total_capacity_kg - coalesce(rb.booked_weight_kg, 0)) as remaining_capacity_kg,
      case
        when rr.total_capacity_volume_m3 is null then null
        else coalesce(rdi.remaining_volume_m3, rr.total_capacity_volume_m3 - coalesce(rb.booked_volume_m3, 0))
      end as remaining_volume_m3,
      p_requested_date as departure_date
    from public.routes as r
    join lateral (
      select rv.*
      from public.route_revisions as rv
      where rv.route_id = r.id
        and rv.effective_from::date <= p_requested_date
      order by rv.effective_from desc, rv.created_at desc
      limit 1
    ) as rr on true
    left join public.route_departure_instances as rdi
      on rdi.route_id = r.id
     and rdi.departure_date = p_requested_date
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.route_id = r.id
        and b.route_departure_date = p_requested_date
        and b.booking_status <> 'cancelled'
    ) as rb on true
    where r.is_active = true
      and r.origin_commune_id = p_origin_commune_id
      and r.destination_commune_id = p_destination_commune_id
      and v_requested_day = any(rr.recurring_days_of_week)
      and (p_requested_date > current_date or (p_requested_date = current_date and rr.default_departure_time >= localtime))
  ),
  oneoff_candidates as (
    select
      t.id as source_id,
      'oneoff_trip'::text as source_type,
      t.carrier_id,
      t.vehicle_id,
      t.origin_commune_id,
      t.destination_commune_id,
      t.departure_at,
      t.total_capacity_kg,
      t.total_capacity_volume_m3,
      t.price_per_kg_dzd,
      t.total_capacity_kg - coalesce(tb.booked_weight_kg, 0) as remaining_capacity_kg,
      case
        when t.total_capacity_volume_m3 is null then null
        else t.total_capacity_volume_m3 - coalesce(tb.booked_volume_m3, 0)
      end as remaining_volume_m3,
      t.departure_at::date as departure_date
    from public.oneoff_trips as t
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.oneoff_trip_id = t.id
        and b.booking_status <> 'cancelled'
    ) as tb on true
    where t.is_active = true
      and t.origin_commune_id = p_origin_commune_id
      and t.destination_commune_id = p_destination_commune_id
      and t.departure_at::date = p_requested_date
      and t.departure_at >= now()
  ),
  exact_candidates as (
    select * from recurring_candidates
    union all
    select * from oneoff_candidates
  )
  select exists(select 1 from exact_candidates) into v_exact_exists;

  if not v_exact_exists then
    v_mode := 'nearest_date';
  end if;

  with recursive upcoming_dates as (
    select p_requested_date as departure_date
    union all
    select departure_date + 1
    from upcoming_dates
    where departure_date < p_requested_date + 7
  ),
  recurring_candidates as (
    select
      r.id as source_id,
      'route'::text as source_type,
      r.carrier_id,
      rr.vehicle_id,
      r.origin_commune_id,
      r.destination_commune_id,
      (d.departure_date::timestamp + rr.default_departure_time)::timestamptz as departure_at,
      rr.total_capacity_kg,
      rr.total_capacity_volume_m3,
      rr.price_per_kg_dzd,
      coalesce(rdi.remaining_capacity_kg, rr.total_capacity_kg - coalesce(rb.booked_weight_kg, 0)) as remaining_capacity_kg,
      case
        when rr.total_capacity_volume_m3 is null then null
        else coalesce(rdi.remaining_volume_m3, rr.total_capacity_volume_m3 - coalesce(rb.booked_volume_m3, 0))
      end as remaining_volume_m3,
      d.departure_date,
      abs(d.departure_date - p_requested_date) as day_distance
    from upcoming_dates as d
    join public.routes as r
      on r.is_active = true
     and r.origin_commune_id = p_origin_commune_id
     and r.destination_commune_id = p_destination_commune_id
    join lateral (
      select rv.*
      from public.route_revisions as rv
      where rv.route_id = r.id
        and rv.effective_from::date <= d.departure_date
      order by rv.effective_from desc, rv.created_at desc
      limit 1
    ) as rr on true
    left join public.route_departure_instances as rdi
      on rdi.route_id = r.id
     and rdi.departure_date = d.departure_date
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.route_id = r.id
        and b.route_departure_date = d.departure_date
        and b.booking_status <> 'cancelled'
    ) as rb on true
    where extract(dow from d.departure_date)::int = any(rr.recurring_days_of_week)
      and (d.departure_date > current_date or (d.departure_date = current_date and rr.default_departure_time >= localtime))
  ),
  oneoff_candidates as (
    select
      t.id as source_id,
      'oneoff_trip'::text as source_type,
      t.carrier_id,
      t.vehicle_id,
      t.origin_commune_id,
      t.destination_commune_id,
      t.departure_at,
      t.total_capacity_kg,
      t.total_capacity_volume_m3,
      t.price_per_kg_dzd,
      t.total_capacity_kg - coalesce(tb.booked_weight_kg, 0) as remaining_capacity_kg,
      case
        when t.total_capacity_volume_m3 is null then null
        else t.total_capacity_volume_m3 - coalesce(tb.booked_volume_m3, 0)
      end as remaining_volume_m3,
      t.departure_at::date as departure_date,
      abs((t.departure_at::date) - p_requested_date) as day_distance
    from public.oneoff_trips as t
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.oneoff_trip_id = t.id
        and b.booking_status <> 'cancelled'
    ) as tb on true
    where t.is_active = true
      and t.origin_commune_id = p_origin_commune_id
      and t.destination_commune_id = p_destination_commune_id
      and t.departure_at::date between p_requested_date and p_requested_date + 7
      and t.departure_at >= now()
  ),
  combined as (
    select * from recurring_candidates
    union all
    select * from oneoff_candidates
  ),
  ranked as (
    select
      c.*,
      p.full_name,
      p.company_name,
      coalesce(p.rating_average, 0) as rating_average,
      coalesce(p.rating_count, 0) as rating_count,
      (p_total_weight_kg * c.price_per_kg_dzd) as estimated_total_dzd,
      case when c.remaining_capacity_kg >= p_total_weight_kg then 1 else 0 end as has_weight_capacity,
      case
        when p_total_volume_m3 is null or c.remaining_volume_m3 is null then 1
        when c.remaining_volume_m3 >= p_total_volume_m3 then 1
        else 0
      end as has_volume_capacity
    from combined as c
    join public.profiles as p on p.id = c.carrier_id
  ),
  filtered as (
    select *
    from ranked
    where has_weight_capacity = 1
      and has_volume_capacity = 1
      and (
        v_mode = 'nearest_date'
        or departure_date = p_requested_date
      )
  ),
  counted as (
    select count(*) as total_count from filtered
  ),
  paged as (
    select *
    from filtered
    order by
      case when lower(coalesce(p_sort, 'recommended')) = 'top_rated' then rating_average end desc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) = 'lowest_price' then estimated_total_dzd end asc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) = 'nearest_departure' then departure_at end asc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) = 'recommended' then day_distance end asc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) = 'recommended' then remaining_capacity_kg end desc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) in ('recommended', 'top_rated') then rating_average end desc nulls last,
      case when lower(coalesce(p_sort, 'recommended')) in ('recommended', 'lowest_price') then estimated_total_dzd end asc nulls last,
      departure_at asc,
      source_type asc,
      source_id asc
    offset v_normalized_offset
    limit v_normalized_limit
  )
  select
    coalesce((select total_count from counted), 0),
    coalesce(
      (
        select jsonb_agg(
          jsonb_build_object(
            'source_id', p.source_id,
            'source_type', p.source_type,
            'carrier_id', p.carrier_id,
            'carrier_name', coalesce(nullif(trim(p.company_name), ''), nullif(trim(p.full_name), ''), p.carrier_id::text),
            'vehicle_id', p.vehicle_id,
            'origin_commune_id', p.origin_commune_id,
            'destination_commune_id', p.destination_commune_id,
            'departure_at', p.departure_at,
            'departure_date', p.departure_date,
            'total_capacity_kg', p.total_capacity_kg,
            'total_capacity_volume_m3', p.total_capacity_volume_m3,
            'remaining_capacity_kg', p.remaining_capacity_kg,
            'remaining_volume_m3', p.remaining_volume_m3,
            'price_per_kg_dzd', p.price_per_kg_dzd,
            'estimated_total_dzd', p.estimated_total_dzd,
            'rating_average', p.rating_average,
            'rating_count', p.rating_count,
            'day_distance', p.day_distance
          )
        )
        from paged as p
      ),
      '[]'::jsonb
    ),
    coalesce(
      (
        select jsonb_agg(to_jsonb(nd.departure_date))
        from (
          select distinct departure_date
          from filtered
          order by departure_date asc
          limit 5
        ) as nd
      ),
      '[]'::jsonb
    )
  into v_total_count, v_results, v_nearest_dates;

  if v_total_count = 0 then
    v_mode := 'redefine_search';
  end if;

  return jsonb_build_object(
    'mode', v_mode,
    'results', v_results,
    'nearest_dates', v_nearest_dates,
    'next_offset', case when v_normalized_offset + v_normalized_limit < v_total_count then v_normalized_offset + v_normalized_limit else null end,
    'total_count', v_total_count
  );
end;
$$;

revoke all on function public.search_exact_lane_capacity(integer, integer, date, numeric, numeric, text, integer, integer) from public, anon;
grant execute on function public.search_exact_lane_capacity(integer, integer, date, numeric, numeric, text, integer, integer) to authenticated, service_role;
-- <<< END 20260320120100_create_exact_lane_search_rpc.sql

-- >>> BEGIN 20260320120200_create_booking_confirmation_rpc.sql
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
    'booking_confirmed',
    'booking_confirmed_title',
    'booking_confirmed_body',
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
    'booking_confirmed',
    'booking_confirmed:' || coalesce(nullif(trim(p_idempotency_key), ''), v_booking.id::text),
    p.id,
    v_booking.id,
    'booking_confirmed',
    public.get_profile_preferred_locale(p.id),
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
-- <<< END 20260320120200_create_booking_confirmation_rpc.sql

-- >>> BEGIN 20260320120300_enforce_booking_status_transitions.sql
create or replace function public.booking_status_transition_allowed(
  p_old public.booking_status,
  p_new public.booking_status
)
returns boolean
language sql
immutable
set search_path = public
as $$
  select case p_old
    when 'pending_payment' then p_new in ('pending_payment', 'payment_under_review', 'cancelled')
    when 'payment_under_review' then p_new in ('pending_payment', 'payment_under_review', 'confirmed', 'cancelled')
    when 'confirmed' then p_new in ('confirmed', 'picked_up', 'cancelled')
    when 'picked_up' then p_new in ('picked_up', 'in_transit')
    when 'in_transit' then p_new in ('in_transit', 'delivered_pending_review')
    when 'delivered_pending_review' then p_new in ('delivered_pending_review', 'completed', 'disputed')
    when 'completed' then p_new = 'completed'
    when 'cancelled' then p_new = 'cancelled'
    when 'disputed' then p_new in ('disputed', 'completed', 'cancelled')
  end;
$$;

create or replace function public.payment_status_transition_allowed(
  p_old public.payment_status,
  p_new public.payment_status
)
returns boolean
language sql
immutable
set search_path = public
as $$
  select case p_old
    when 'unpaid' then p_new in ('unpaid', 'proof_submitted')
    when 'proof_submitted' then p_new in ('proof_submitted', 'under_verification')
    when 'under_verification' then p_new in ('under_verification', 'secured', 'rejected')
    when 'secured' then p_new in ('secured', 'refunded', 'released_to_carrier')
    when 'rejected' then p_new in ('rejected', 'proof_submitted')
    when 'refunded' then p_new = 'refunded'
    when 'released_to_carrier' then p_new = 'released_to_carrier'
  end;
$$;

create or replace function public.enforce_booking_state_transitions()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op <> 'UPDATE' then
    return new;
  end if;

  if not public.booking_status_transition_allowed(old.booking_status, new.booking_status) then
    raise exception 'Invalid booking status transition from % to %', old.booking_status, new.booking_status;
  end if;

  if not public.payment_status_transition_allowed(old.payment_status, new.payment_status) then
    raise exception 'Invalid payment status transition from % to %', old.payment_status, new.payment_status;
  end if;

  return new;
end;
$$;

drop trigger if exists bookings_state_transition_guard on public.bookings;
create trigger bookings_state_transition_guard
before update on public.bookings
for each row
execute function public.enforce_booking_state_transitions();
-- <<< END 20260320120300_enforce_booking_status_transitions.sql

-- >>> BEGIN 20260320120400_create_payment_proof_review_rpc.sql
create or replace function public.current_payment_resubmission_deadline_hours()
returns integer
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((value->>'payment_resubmission_deadline_hours')::integer, 24)
  from public.platform_settings
  where key = 'booking_pricing'
    and is_public = true;
$$;

create or replace function public.create_generated_document_record(
  p_booking_id uuid,
  p_document_type text,
  p_storage_path text
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_document_type text := lower(trim(coalesce(p_document_type, '')));
  v_storage_path text := trim(coalesce(p_storage_path, ''));
  v_result public.generated_documents;
begin
  if p_booking_id is null then
    raise exception 'Booking id is required';
  end if;

  if v_document_type not in ('payment_receipt', 'payout_receipt') then
    raise exception 'Unsupported generated document type';
  end if;

  if v_storage_path = '' then
    raise exception 'Generated document storage path is required';
  end if;

  if not public.is_service_role() and not public.is_admin() then
    raise exception 'Generated document creation requires privileged access';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_document_type = 'payment_receipt'
     and v_booking.payment_status not in ('secured', 'released_to_carrier') then
    raise exception 'Booking financial documents require secured payment';
  end if;

  if v_document_type = 'payout_receipt'
     and v_booking.payment_status <> 'released_to_carrier' then
    raise exception 'Payout receipt requires released payout state';
  end if;

  if v_storage_path <> format('generated/%s/%s-v1.pdf', p_booking_id, replace(v_document_type, '_', '-'))
     and v_storage_path <> format('generated/%s/%s-v%s.pdf', p_booking_id, replace(v_document_type, '_', '-'), 1) then
    if v_storage_path !~ ('^generated/' || p_booking_id::text || '/' || replace(v_document_type, '_', '-') || '-v[0-9]+\.pdf$') then
      raise exception 'Generated document path does not match canonical format';
    end if;
  end if;

  insert into public.generated_documents (
    booking_id,
    document_type,
    storage_path,
    version,
    generated_by
  ) values (
    p_booking_id,
    v_document_type,
    v_storage_path,
    (
      select coalesce(max(version), 0) + 1
      from public.generated_documents
      where booking_id = p_booking_id
        and document_type = v_document_type
    ),
    v_actor_id
  )
  returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.record_refund_ledger_entry(
  p_booking_id uuid,
  p_amount_dzd numeric,
  p_reference text default null,
  p_notes text default null
)
returns public.financial_ledger_entries
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.financial_ledger_entries;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Refund ledger writes require privileged access';
  end if;

  insert into public.financial_ledger_entries (
    booking_id, entry_type, direction, amount_dzd, actor_type, reference, notes, created_by, occurred_at
  ) values (
    p_booking_id,
    'refund_sent',
    'debit',
    p_amount_dzd,
    'platform',
    p_reference,
    p_notes,
    (select auth.uid()),
    now()
  ) returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.record_payout_ledger_entry(
  p_booking_id uuid,
  p_amount_dzd numeric,
  p_reference text default null,
  p_notes text default null
)
returns public.financial_ledger_entries
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.financial_ledger_entries;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Payout ledger writes require privileged access';
  end if;

  insert into public.financial_ledger_entries (
    booking_id, entry_type, direction, amount_dzd, actor_type, reference, notes, created_by, occurred_at
  ) values (
    p_booking_id,
    'carrier_payout_sent',
    'debit',
    p_amount_dzd,
    'platform',
    p_reference,
    p_notes,
    (select auth.uid()),
    now()
  ) returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.finalize_payment_proof(
  p_upload_session_id uuid,
  p_submitted_amount_dzd numeric,
  p_submitted_reference text default null
)
returns public.payment_proofs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session public.upload_sessions;
  v_booking public.bookings;
  v_result public.payment_proofs;
  v_object_exists boolean;
begin
  select * into v_session
  from public.upload_sessions
  where id = p_upload_session_id
    and profile_id = (select auth.uid())
    and bucket_id = 'payment-proofs';

  if not found then
    raise exception 'Upload session not found';
  end if;

  if v_session.status <> 'authorized' or v_session.expires_at <= now() then
    raise exception 'Upload session is no longer valid';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_session.entity_id
    and shipper_id = (select auth.uid())
  for update;

  if not found then
    raise exception 'You cannot upload proof for this booking';
  end if;

  if v_booking.booking_status <> 'pending_payment' then
    raise exception 'Payment proof can only be submitted while payment is pending';
  end if;

  if v_booking.payment_status not in ('unpaid', 'rejected') then
    raise exception 'Payment proof cannot be submitted for this booking state';
  end if;

  select exists (
    select 1
    from storage.objects as so
    where so.bucket_id = v_session.bucket_id
      and so.name = v_session.object_path
      and coalesce((so.metadata->>'size')::bigint, -1) = v_session.byte_size
      and lower(coalesce(so.metadata->>'mimetype', '')) = lower(v_session.content_type)
  ) into v_object_exists;

  if not v_object_exists then
    raise exception 'Uploaded proof file is missing or metadata does not match the authorized session';
  end if;

  insert into public.payment_proofs (
    booking_id,
    storage_path,
    payment_rail,
    submitted_reference,
    submitted_amount_dzd,
    status,
    submitted_at,
    version,
    content_type,
    byte_size,
    checksum_sha256,
    uploaded_by,
    upload_session_id
  )
  values (
    v_session.entity_id,
    v_session.object_path,
    v_session.document_type::public.payment_rail,
    public.normalize_reference_value(p_submitted_reference),
    p_submitted_amount_dzd,
    'pending',
    now(),
    (
      select coalesce(max(pp.version), 0) + 1
      from public.payment_proofs as pp
      where pp.booking_id = v_session.entity_id
    ),
    v_session.content_type,
    v_session.byte_size,
    v_session.checksum_sha256,
    (select auth.uid()),
    v_session.id
  )
  returning * into v_result;

  update public.bookings
  set payment_status = 'under_verification',
      booking_status = 'payment_under_review',
      updated_at = now()
  where id = v_booking.id;

  insert into public.tracking_events (
    booking_id,
    event_type,
    visibility,
    note,
    created_by,
    recorded_at
  ) values (
    v_booking.id,
    'payment_under_review',
    'user_visible',
    'Payment proof submitted and under review.',
    (select auth.uid()),
    now()
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'payment_proof_submitted',
    'payment_proof_submitted_title',
    'payment_proof_submitted_body',
    jsonb_build_object('booking_id', v_booking.id, 'payment_proof_id', v_result.id)
  );

  perform public.enqueue_transactional_email(
    'payment_proof_received',
    v_booking.shipper_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.shipper_id
    ),
    v_booking.id,
    'payment_proof_received',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payment_proof_id', v_result.id
    ),
    'payment_proof_received:' || v_result.id::text,
    'high'
  );

  update public.upload_sessions
  set status = 'finalized', finalized_at = now(), updated_at = now()
  where id = v_session.id;

  return v_result;
end;
$$;

create or replace function public.admin_approve_payment_proof(
  p_payment_proof_id uuid,
  p_verified_amount_dzd numeric,
  p_verified_reference text default null,
  p_decision_note text default null
)
returns public.payment_proofs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_proof public.payment_proofs;
  v_booking public.bookings;
  v_result public.payment_proofs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Payment proof approval requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_proof
  from public.payment_proofs
  where id = p_payment_proof_id
  for update;

  if not found then
    raise exception 'Payment proof not found';
  end if;

  if v_proof.status <> 'pending' then
    raise exception 'Only pending payment proofs can be approved';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_proof.booking_id
  for update;

  if p_verified_amount_dzd <> v_booking.shipper_total_dzd then
    raise exception 'Verified amount must match the expected booking amount exactly';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.payment_proofs
  set status = 'verified',
      verified_amount_dzd = p_verified_amount_dzd,
      verified_reference = public.normalize_reference_value(p_verified_reference),
      decision_note = left(nullif(trim(p_decision_note), ''), 500),
      reviewed_by = (select auth.uid()),
      reviewed_at = now()
  where id = p_payment_proof_id
  returning * into v_result;

  update public.bookings
  set payment_status = 'secured',
      booking_status = 'confirmed',
      confirmed_at = now(),
      updated_at = now()
  where id = v_booking.id;

  insert into public.financial_ledger_entries (
    booking_id, entry_type, direction, amount_dzd, actor_type, reference, notes, created_by, occurred_at
  ) values
    (v_booking.id, 'payment_secured', 'credit', v_booking.shipper_total_dzd, 'shipper', v_booking.payment_reference, 'Payment secured', (select auth.uid()), now()),
    (v_booking.id, 'platform_fee_recorded', 'credit', v_booking.platform_fee_dzd, 'platform', v_booking.payment_reference, 'Platform fee recorded', (select auth.uid()), now()),
    (v_booking.id, 'insurance_fee_recorded', 'credit', v_booking.insurance_fee_dzd, 'platform', v_booking.payment_reference, 'Insurance fee recorded', (select auth.uid()), now());

  perform public.create_generated_document_record(
    v_booking.id,
    'payment_receipt',
    format('generated/%s/payment-receipt-v1.pdf', v_booking.id)
  );

  insert into public.tracking_events (
    booking_id, event_type, visibility, note, created_by, recorded_at
  ) values (
    v_booking.id,
    'confirmed',
    'user_visible',
    'Payment secured and booking confirmed.',
    (select auth.uid()),
    now()
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'payment_secured',
    'payment_secured_title',
    'payment_secured_body',
    jsonb_build_object('booking_id', v_booking.id, 'payment_proof_id', v_result.id)
  );

  perform public.enqueue_transactional_email(
    'payment_secured',
    v_booking.shipper_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.shipper_id
    ),
    v_booking.id,
    'payment_secured',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payment_proof_id', v_result.id
    ),
    'payment_secured:' || v_result.id::text,
    'high'
  );

  perform public.write_admin_audit_log(
    'payment_proof_approved',
    'payment_proof',
    v_result.id,
    'success',
    left(nullif(trim(p_decision_note), ''), 500),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'verified_amount_dzd', p_verified_amount_dzd,
      'verified_reference', public.normalize_reference_value(p_verified_reference)
    )
  );

  perform set_config('app.trusted_operation', 'false', true);
  return v_result;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.admin_reject_payment_proof(
  p_payment_proof_id uuid,
  p_rejection_reason text,
  p_decision_note text default null
)
returns public.payment_proofs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_proof public.payment_proofs;
  v_booking public.bookings;
  v_result public.payment_proofs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Payment proof rejection requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  if nullif(trim(p_rejection_reason), '') is null then
    raise exception 'Payment proof rejection requires a reason';
  end if;

  select * into v_proof
  from public.payment_proofs
  where id = p_payment_proof_id
  for update;

  if not found then
    raise exception 'Payment proof not found';
  end if;

  if v_proof.status <> 'pending' then
    raise exception 'Only pending payment proofs can be rejected';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_proof.booking_id
  for update;

  perform set_config('app.trusted_operation', 'true', true);

  update public.payment_proofs
  set status = 'rejected',
      rejection_reason = left(trim(p_rejection_reason), 500),
      decision_note = left(nullif(trim(p_decision_note), ''), 500),
      reviewed_by = (select auth.uid()),
      reviewed_at = now()
  where id = p_payment_proof_id
  returning * into v_result;

  update public.bookings
  set payment_status = 'rejected',
      booking_status = 'pending_payment',
      updated_at = now()
  where id = v_booking.id;

  insert into public.financial_ledger_entries (
    booking_id, entry_type, direction, amount_dzd, actor_type, reference, notes, created_by, occurred_at
  ) values (
    v_booking.id,
    'payment_rejected',
    'debit',
    v_proof.submitted_amount_dzd,
    'shipper',
    coalesce(v_proof.submitted_reference, v_booking.payment_reference),
    left(trim(p_rejection_reason), 500),
    (select auth.uid()),
    now()
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'payment_rejected',
    'payment_rejected_title',
    'payment_rejected_body',
    jsonb_build_object('booking_id', v_booking.id, 'payment_proof_id', v_result.id)
  );

  perform public.enqueue_transactional_email(
    'payment_rejected',
    v_booking.shipper_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.shipper_id
    ),
    v_booking.id,
    'payment_rejected',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payment_proof_id', v_result.id,
      'rejection_reason', left(trim(p_rejection_reason), 500)
    ),
    'payment_rejected:' || v_result.id::text,
    'high'
  );

  perform public.write_admin_audit_log(
    'payment_proof_rejected',
    'payment_proof',
    v_result.id,
    'success',
    left(trim(p_rejection_reason), 500),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'decision_note', left(nullif(trim(p_decision_note), ''), 500)
    )
  );

  perform set_config('app.trusted_operation', 'false', true);
  return v_result;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.expire_payment_resubmission_deadlines()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_deadline_hours integer := public.current_payment_resubmission_deadline_hours();
  v_cancelled_count integer := 0;
begin
  if not public.is_service_role() then
    raise exception 'Payment deadline expiry requires service role access';
  end if;

  with expired as (
    select b.id, b.shipment_id, b.route_id, b.route_departure_date, b.weight_kg, b.volume_m3
    from public.bookings as b
    join lateral (
      select pp.reviewed_at
      from public.payment_proofs as pp
      where pp.booking_id = b.id
        and pp.status = 'rejected'
      order by pp.version desc, pp.reviewed_at desc nulls last
      limit 1
    ) as latest_rejection on true
    where b.payment_status = 'rejected'
      and b.booking_status = 'pending_payment'
      and latest_rejection.reviewed_at <= now() - make_interval(hours => v_deadline_hours)
    for update
  ),
  cancelled as (
    update public.bookings as b
    set booking_status = 'cancelled',
        payment_status = 'rejected',
        cancelled_at = now(),
        updated_at = now()
    from expired as e
    where b.id = e.id
    returning e.*
  )
  select count(*) into v_cancelled_count from cancelled;

  update public.shipments as s
  set status = 'cancelled', updated_at = now()
  where id in (
    select shipment_id
    from public.bookings
    where booking_status = 'cancelled'
      and payment_status = 'rejected'
      and cancelled_at >= now() - interval '1 minute'
  );

  update public.route_departure_instances as rdi
  set reserved_capacity_kg = reserved_capacity_kg - b.weight_kg,
      remaining_capacity_kg = remaining_capacity_kg + b.weight_kg,
      reserved_volume_m3 = case when b.volume_m3 is null then reserved_volume_m3 else coalesce(reserved_volume_m3, 0) - b.volume_m3 end,
      remaining_volume_m3 = case when b.volume_m3 is null then remaining_volume_m3 else coalesce(remaining_volume_m3, 0) + b.volume_m3 end,
      updated_at = now()
  from public.bookings as b
  where rdi.route_id = b.route_id
    and rdi.departure_date = b.route_departure_date
    and b.booking_status = 'cancelled'
    and b.payment_status = 'rejected'
    and b.cancelled_at >= now() - interval '1 minute';

  insert into public.tracking_events (
    booking_id, event_type, visibility, note, recorded_at
  )
  select
    b.id,
    'cancelled',
    'user_visible',
    'Booking cancelled after payment resubmission deadline expired.',
    now()
  from public.bookings as b
  where b.booking_status = 'cancelled'
    and b.payment_status = 'rejected'
    and b.cancelled_at >= now() - interval '1 minute';

  return v_cancelled_count;
end;
$$;

revoke all on function public.create_generated_document_record(uuid, text, text) from public, anon, authenticated;
grant execute on function public.create_generated_document_record(uuid, text, text) to service_role;

revoke all on function public.record_refund_ledger_entry(uuid, numeric, text, text) from public, anon;
grant execute on function public.record_refund_ledger_entry(uuid, numeric, text, text) to authenticated, service_role;

revoke all on function public.record_payout_ledger_entry(uuid, numeric, text, text) from public, anon;
grant execute on function public.record_payout_ledger_entry(uuid, numeric, text, text) to authenticated, service_role;

revoke all on function public.admin_approve_payment_proof(uuid, numeric, text, text) from public, anon;
grant execute on function public.admin_approve_payment_proof(uuid, numeric, text, text) to authenticated, service_role;

revoke all on function public.admin_reject_payment_proof(uuid, text, text) from public, anon;
grant execute on function public.admin_reject_payment_proof(uuid, text, text) to authenticated, service_role;

revoke all on function public.expire_payment_resubmission_deadlines() from public, anon, authenticated;
grant execute on function public.expire_payment_resubmission_deadlines() to service_role;
-- <<< END 20260320120400_create_payment_proof_review_rpc.sql

-- >>> BEGIN 20260320120500_create_tracking_and_delivery_rpc.sql
insert into public.platform_settings (key, value, is_public, description)
values (
  'delivery_review',
  jsonb_build_object('grace_window_hours', 24),
  true,
  'Delivery review grace window configuration'
)
on conflict (key) do nothing;

create or replace function public.current_delivery_review_grace_window_hours()
returns integer
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((value->>'grace_window_hours')::integer, 24)
  from public.platform_settings
  where key = 'delivery_review'
    and is_public = true;
$$;

create or replace function public.append_tracking_event(
  p_booking_id uuid,
  p_event_type text,
  p_visibility public.tracking_event_visibility,
  p_note text default null,
  p_created_by uuid default null
)
returns public.tracking_events
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_event_type text := lower(trim(coalesce(p_event_type, '')));
  v_result public.tracking_events;
begin
  if p_booking_id is null then
    raise exception 'Booking id is required';
  end if;

  if v_event_type not in (
    'payment_under_review',
    'confirmed',
    'picked_up',
    'in_transit',
    'delivered_pending_review',
    'completed',
    'cancelled',
    'disputed',
    'refund_processed',
    'payout_released'
  ) then
    raise exception 'Unsupported tracking event type';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id;

  if not found then
    raise exception 'Booking not found';
  end if;

  if not public.is_service_role() then
    if v_actor_id is null then
      raise exception 'authentication_required';
    end if;

    if not (
      v_booking.shipper_id = v_actor_id
      or v_booking.carrier_id = v_actor_id
      or public.is_admin()
    ) then
      raise exception 'Tracking events require booking access';
    end if;
  end if;

  if p_visibility = 'internal' and not (public.is_admin() or public.is_service_role()) then
    raise exception 'Internal tracking events require privileged access';
  end if;

  insert into public.tracking_events (
    booking_id,
    event_type,
    visibility,
    note,
    created_by,
    recorded_at
  ) values (
    p_booking_id,
    left(v_event_type, 120),
    p_visibility,
    left(nullif(trim(p_note), ''), 500),
    case
      when public.is_service_role() or public.is_admin() then coalesce(p_created_by, v_actor_id)
      else v_actor_id
    end,
    now()
  ) returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.carrier_record_booking_milestone(
  p_booking_id uuid,
  p_milestone text,
  p_note text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_milestone text := lower(trim(coalesce(p_milestone, '')));
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_milestone = 'picked_up' then
    update public.bookings
    set booking_status = 'picked_up',
        picked_up_at = now(),
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  elsif v_milestone = 'in_transit' then
    update public.bookings
    set booking_status = 'in_transit',
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  elsif v_milestone = 'delivered_pending_review' then
    update public.bookings
    set booking_status = 'delivered_pending_review',
        delivered_at = now(),
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  else
    raise exception 'Unsupported carrier milestone';
  end if;

  perform public.append_tracking_event(
    p_booking_id,
    v_milestone,
    'user_visible',
    p_note,
    v_actor_id
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'booking_milestone_updated',
    'booking_milestone_updated_title',
    'booking_milestone_updated_body',
    jsonb_build_object('booking_id', v_booking.id, 'milestone', v_milestone)
  );

  if v_milestone = 'delivered_pending_review' then
    perform public.enqueue_transactional_email(
      'delivered_pending_review',
      v_booking.shipper_id,
      (
        select lower(trim(email))
        from public.profiles
        where id = v_booking.shipper_id
      ),
      v_booking.id,
      'delivered_pending_review',
      null,
      jsonb_build_object(
        'booking_id', v_booking.id,
        'booking_reference', v_booking.tracking_number,
        'milestone', v_milestone
      ),
      'delivered_pending_review:' || v_booking.id::text,
      'high'
    );
  end if;

  return v_booking;
end;
$$;

create or replace function public.shipper_confirm_delivery(
  p_booking_id uuid,
  p_note text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (shipper_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'delivered_pending_review' then
    raise exception 'Only delivered bookings can be confirmed';
  end if;

  update public.bookings
  set booking_status = 'completed',
      delivery_confirmed_at = now(),
      completed_at = now(),
      updated_at = now()
  where id = p_booking_id
  returning * into v_booking;

  perform public.append_tracking_event(
    p_booking_id,
    'completed',
    'user_visible',
    p_note,
    v_actor_id
  );

  return v_booking;
end;
$$;

create or replace function public.auto_complete_delivered_bookings()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_grace_hours integer := public.current_delivery_review_grace_window_hours();
  v_count integer := 0;
begin
  if not public.is_service_role() then
    raise exception 'Auto completion requires service role access';
  end if;

  with eligible as (
    select id
    from public.bookings
    where booking_status = 'delivered_pending_review'
      and delivered_at is not null
      and delivered_at <= now() - make_interval(hours => v_grace_hours)
    for update
  ),
  completed as (
    update public.bookings as b
    set booking_status = 'completed',
        completed_at = now(),
        updated_at = now()
    where b.id in (select id from eligible)
    returning b.id
  )
  select count(*) into v_count from completed;

  insert into public.tracking_events (
    booking_id, event_type, visibility, note, recorded_at
  )
  select
    b.id,
    'completed',
    'user_visible',
    null,
    now()
  from public.bookings as b
  where b.booking_status = 'completed'
    and b.completed_at >= now() - interval '1 minute';

  return v_count;
end;
$$;

revoke all on function public.append_tracking_event(uuid, text, public.tracking_event_visibility, text, uuid) from public, anon;
grant execute on function public.append_tracking_event(uuid, text, public.tracking_event_visibility, text, uuid) to authenticated, service_role;

revoke all on function public.carrier_record_booking_milestone(uuid, text, text) from public, anon;
grant execute on function public.carrier_record_booking_milestone(uuid, text, text) to authenticated, service_role;

revoke all on function public.shipper_confirm_delivery(uuid, text) from public, anon;
grant execute on function public.shipper_confirm_delivery(uuid, text) to authenticated, service_role;

revoke all on function public.auto_complete_delivered_bookings() from public, anon, authenticated;
grant execute on function public.auto_complete_delivered_bookings() to service_role;
-- <<< END 20260320120500_create_tracking_and_delivery_rpc.sql

-- >>> BEGIN 20260320120600_create_dispute_and_payout_rpc.sql
create or replace function public.create_dispute_from_delivery(
  p_booking_id uuid,
  p_reason text,
  p_description text default null
)
returns public.disputes
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_dispute public.disputes;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  perform public.assert_rate_limit(
    'dispute_creation:' || v_actor_id::text,
    5,
    3600
  );

  if nullif(trim(p_reason), '') is null then
    raise exception 'Dispute reason is required';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (shipper_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'delivered_pending_review' then
    raise exception 'A dispute can only be opened from delivered pending review';
  end if;

  insert into public.disputes (
    booking_id,
    opened_by,
    reason,
    description,
    status
  ) values (
    p_booking_id,
    v_actor_id,
    left(trim(p_reason), 500),
    left(nullif(trim(p_description), ''), 2000),
    'open'
  ) returning * into v_dispute;

  update public.bookings
  set booking_status = 'disputed',
      disputed_at = now(),
      updated_at = now()
  where id = p_booking_id;

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.carrier_id,
    'dispute_opened',
    'dispute_opened_title',
    'dispute_opened_body',
    jsonb_build_object('booking_id', p_booking_id, 'dispute_id', v_dispute.id)
  );

  perform public.enqueue_transactional_email(
    'dispute_opened',
    v_booking.carrier_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.carrier_id
    ),
    v_booking.id,
    'dispute_opened',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'dispute_id', v_dispute.id,
      'reason', left(trim(p_reason), 500)
    ),
    'dispute_opened:' || v_dispute.id::text,
    'high'
  );

  perform public.append_tracking_event(
    p_booking_id,
    'disputed',
    'user_visible',
    p_reason,
    v_actor_id
  );

  return v_dispute;
end;
$$;

create or replace function public.admin_resolve_dispute_complete(
  p_dispute_id uuid,
  p_resolution_note text default null
)
returns public.disputes
language plpgsql
security definer
set search_path = public
as $$
declare
  v_dispute public.disputes;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Dispute resolution requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_dispute
  from public.disputes
  where id = p_dispute_id
  for update;

  if not found then
    raise exception 'Dispute not found';
  end if;

  if v_dispute.status <> 'open' then
    raise exception 'Only open disputes can be resolved';
  end if;

  update public.disputes
  set status = 'resolved',
      resolution = 'completed',
      resolution_note = left(nullif(trim(p_resolution_note), ''), 2000),
      resolved_by = (select auth.uid()),
      resolved_at = now(),
      updated_at = now()
  where id = p_dispute_id
  returning * into v_dispute;

  update public.bookings
  set booking_status = 'completed',
      completed_at = coalesce(completed_at, now()),
      updated_at = now()
  where id = v_dispute.booking_id;

  perform public.append_tracking_event(
    v_dispute.booking_id,
    'completed',
    'user_visible',
    p_resolution_note,
    (select auth.uid())
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    (
      select shipper_id
      from public.bookings
      where id = v_dispute.booking_id
    ),
    'dispute_resolved',
    'dispute_resolved_title',
    'dispute_resolved_body',
    jsonb_build_object('booking_id', v_dispute.booking_id, 'dispute_id', v_dispute.id, 'resolution', 'completed')
  );

  perform public.enqueue_transactional_email(
    'dispute_resolved',
    (
      select shipper_id
      from public.bookings
      where id = v_dispute.booking_id
    ),
    (
      select lower(trim(email))
      from public.profiles
      where id = (
        select shipper_id
        from public.bookings
        where id = v_dispute.booking_id
      )
    ),
    v_dispute.booking_id,
    'dispute_resolved',
    null,
    jsonb_build_object(
      'booking_id', v_dispute.booking_id,
      'booking_reference', (select tracking_number from public.bookings where id = v_dispute.booking_id),
      'dispute_id', v_dispute.id,
      'resolution', 'completed'
    ),
    'dispute_resolved:' || v_dispute.id::text || ':completed',
    'high'
  );

  perform public.write_admin_audit_log(
    'dispute_resolved_complete',
    'dispute',
    v_dispute.id,
    'success',
    left(nullif(trim(p_resolution_note), ''), 500),
    jsonb_build_object(
      'booking_id', v_dispute.booking_id,
      'resolution', 'completed'
    )
  );

  return v_dispute;
end;
$$;

create or replace function public.admin_resolve_dispute_refund(
  p_dispute_id uuid,
  p_refund_amount_dzd numeric,
  p_refund_reason text,
  p_external_reference text default null,
  p_resolution_note text default null
)
returns public.disputes
language plpgsql
security definer
set search_path = public
as $$
declare
  v_dispute public.disputes;
  v_booking public.bookings;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Dispute resolution requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_dispute
  from public.disputes
  where id = p_dispute_id
  for update;

  if not found then
    raise exception 'Dispute not found';
  end if;

  if v_dispute.status <> 'open' then
    raise exception 'Only open disputes can be resolved';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_dispute.booking_id
  for update;

  insert into public.refunds (
    booking_id,
    dispute_id,
    amount_dzd,
    status,
    reason,
    external_reference,
    processed_by,
    processed_at
  ) values (
    v_booking.id,
    v_dispute.id,
    p_refund_amount_dzd,
    'sent',
    left(trim(p_refund_reason), 500),
    public.normalize_reference_value(p_external_reference),
    (select auth.uid()),
    now()
  );

  perform public.record_refund_ledger_entry(
    v_booking.id,
    p_refund_amount_dzd,
    p_external_reference,
    p_refund_reason
  );

  update public.disputes
  set status = 'resolved',
      resolution = 'refunded',
      resolution_note = left(nullif(trim(p_resolution_note), ''), 2000),
      resolved_by = (select auth.uid()),
      resolved_at = now(),
      updated_at = now()
  where id = p_dispute_id
  returning * into v_dispute;

  update public.bookings
  set booking_status = 'cancelled',
      payment_status = 'refunded',
      cancelled_at = now(),
      updated_at = now()
  where id = v_booking.id;

  perform public.append_tracking_event(
    v_booking.id,
    'cancelled',
    'user_visible',
    p_resolution_note,
    (select auth.uid())
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'dispute_resolved',
    'dispute_resolved_title',
    'dispute_resolved_body',
    jsonb_build_object('booking_id', v_booking.id, 'dispute_id', v_dispute.id, 'resolution', 'refunded')
  );

  perform public.enqueue_transactional_email(
    'dispute_resolved',
    v_booking.shipper_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.shipper_id
    ),
    v_booking.id,
    'dispute_resolved',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'dispute_id', v_dispute.id,
      'resolution', 'refunded',
      'refund_amount_dzd', p_refund_amount_dzd
    ),
    'dispute_resolved:' || v_dispute.id::text || ':refunded',
    'high'
  );

  perform public.write_admin_audit_log(
    'dispute_resolved_refund',
    'dispute',
    v_dispute.id,
    'success',
    left(trim(p_refund_reason), 500),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'resolution', 'refunded',
      'refund_amount_dzd', p_refund_amount_dzd,
      'external_reference', public.normalize_reference_value(p_external_reference)
    )
  );

  return v_dispute;
end;
$$;

create or replace function public.admin_release_payout(
  p_booking_id uuid,
  p_external_reference text default null,
  p_note text default null
)
returns public.payouts
language plpgsql
security definer
set search_path = public
as $$
declare
  v_booking public.bookings;
  v_account public.payout_accounts;
  v_payout public.payouts;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Payout release requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_booking
  from public.bookings
  where id = p_booking_id
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'completed' then
    raise exception 'Payout release requires a completed booking';
  end if;

  if v_booking.payment_status <> 'secured' then
    raise exception 'Payout release requires secured payment';
  end if;

  if exists (
    select 1 from public.disputes
    where booking_id = p_booking_id
      and status = 'open'
  ) then
    raise exception 'Payout release is blocked by an open dispute';
  end if;

  if exists (
    select 1 from public.payouts where booking_id = p_booking_id
  ) then
    raise exception 'Payout already exists for this booking';
  end if;

  select * into v_account
  from public.payout_accounts
  where carrier_id = v_booking.carrier_id
    and is_active = true
  order by is_verified desc, updated_at desc
  limit 1;

  if not found then
    raise exception 'No active payout account is available for this carrier';
  end if;

  insert into public.payouts (
    booking_id,
    carrier_id,
    payout_account_id,
    payout_account_snapshot,
    amount_dzd,
    status,
    external_reference,
    processed_by,
    processed_at
  ) values (
    v_booking.id,
    v_booking.carrier_id,
    v_account.id,
    jsonb_build_object(
      'account_type', v_account.account_type,
      'account_holder_name', v_account.account_holder_name,
      'account_identifier', v_account.account_identifier,
      'bank_or_ccp_name', v_account.bank_or_ccp_name
    ),
    v_booking.carrier_payout_dzd,
    'sent',
    public.normalize_reference_value(p_external_reference),
    (select auth.uid()),
    now()
  ) returning * into v_payout;

  perform public.record_payout_ledger_entry(
    v_booking.id,
    v_booking.carrier_payout_dzd,
    p_external_reference,
    p_note
  );

  update public.bookings
  set payment_status = 'released_to_carrier',
      updated_at = now()
  where id = v_booking.id;

  perform public.append_tracking_event(
    v_booking.id,
    'payout_released',
    'internal',
    p_note,
    (select auth.uid())
  );

  perform public.create_generated_document_record(
    v_booking.id,
    'payout_receipt',
    format('generated/%s/payout-receipt-v1.pdf', v_booking.id)
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.carrier_id,
    'payout_released',
    'payout_released_title',
    'payout_released_body',
    jsonb_build_object('booking_id', v_booking.id, 'payout_id', v_payout.id)
  );

  perform public.enqueue_transactional_email(
    'payout_released',
    v_booking.carrier_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.carrier_id
    ),
    v_booking.id,
    'payout_released',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payout_id', v_payout.id,
      'payout_amount_dzd', v_booking.carrier_payout_dzd
    ),
    'payout_released:' || v_payout.id::text,
    'high'
  );

  perform public.write_admin_audit_log(
    'payout_released',
    'payout',
    v_payout.id,
    'success',
    left(nullif(trim(p_note), ''), 500),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'carrier_id', v_booking.carrier_id,
      'amount_dzd', v_booking.carrier_payout_dzd,
      'external_reference', public.normalize_reference_value(p_external_reference)
    )
  );

  return v_payout;
end;
$$;

revoke all on function public.create_dispute_from_delivery(uuid, text, text) from public, anon;
grant execute on function public.create_dispute_from_delivery(uuid, text, text) to authenticated, service_role;

revoke all on function public.admin_resolve_dispute_complete(uuid, text) from public, anon;
grant execute on function public.admin_resolve_dispute_complete(uuid, text) to authenticated, service_role;

revoke all on function public.admin_resolve_dispute_refund(uuid, numeric, text, text, text) from public, anon;
grant execute on function public.admin_resolve_dispute_refund(uuid, numeric, text, text, text) to authenticated, service_role;

revoke all on function public.admin_release_payout(uuid, text, text) from public, anon;
grant execute on function public.admin_release_payout(uuid, text, text) to authenticated, service_role;

create unique index if not exists payout_accounts_one_active_per_carrier_idx
on public.payout_accounts (carrier_id)
where is_active = true;
-- <<< END 20260320120600_create_dispute_and_payout_rpc.sql

-- >>> BEGIN 20260320120700_create_carrier_review_rpc.sql
create or replace function public.refresh_carrier_rating_aggregates(
  p_carrier_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_average numeric;
  v_count integer;
begin
  select avg(score)::numeric, count(*)::integer
  into v_average, v_count
  from public.carrier_reviews
  where carrier_id = p_carrier_id;

  update public.profiles
  set rating_average = v_average,
      rating_count = coalesce(v_count, 0),
      updated_at = now()
  where id = p_carrier_id;
end;
$$;

create or replace function public.submit_carrier_review(
  p_booking_id uuid,
  p_score integer,
  p_comment text default null
)
returns public.carrier_reviews
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_review public.carrier_reviews;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if p_score < 1 or p_score > 5 then
    raise exception 'Carrier review score must be between 1 and 5';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (shipper_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'completed' then
    raise exception 'Only completed bookings may be reviewed';
  end if;

  insert into public.carrier_reviews (
    booking_id,
    carrier_id,
    shipper_id,
    score,
    comment,
    created_at
  ) values (
    p_booking_id,
    v_booking.carrier_id,
    v_actor_id,
    p_score,
    left(nullif(trim(p_comment), ''), 1000),
    now()
  )
  returning * into v_review;

  perform public.refresh_carrier_rating_aggregates(v_booking.carrier_id);

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.carrier_id,
    'carrier_review_submitted',
    'carrier_review_submitted_title',
    'carrier_review_submitted_body',
    jsonb_build_object('booking_id', p_booking_id)
  );

  return v_review;
end;
$$;

revoke all on function public.submit_carrier_review(uuid, integer, text) from public, anon;
grant execute on function public.submit_carrier_review(uuid, integer, text) to authenticated, service_role;
-- <<< END 20260320120700_create_carrier_review_rpc.sql

-- >>> BEGIN 20260320120710_create_notification_device_rpc.sql
create or replace function public.register_user_device(
  p_push_token text,
  p_platform text,
  p_locale text default null
)
returns public.user_devices
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.user_devices;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  insert into public.user_devices (
    profile_id,
    push_token,
    platform,
    locale,
    last_seen_at
  ) values (
    v_actor_id,
    trim(p_push_token),
    trim(p_platform),
    nullif(trim(p_locale), ''),
    now()
  )
  on conflict (profile_id, push_token) do update
  set platform = excluded.platform,
      locale = excluded.locale,
      last_seen_at = now(),
      updated_at = now()
  returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.mark_notification_read(
  p_notification_id uuid
)
returns public.notifications
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.notifications;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  update public.notifications
  set is_read = true,
      read_at = coalesce(read_at, now())
  where id = p_notification_id
    and profile_id = v_actor_id
  returning * into v_result;

  if not found then
    raise exception 'Notification not found';
  end if;

  return v_result;
end;
$$;

create unique index if not exists user_devices_profile_push_token_idx
on public.user_devices (profile_id, push_token);

revoke all on function public.register_user_device(text, text, text) from public, anon;
grant execute on function public.register_user_device(text, text, text) to authenticated, service_role;

revoke all on function public.mark_notification_read(uuid) from public, anon;
grant execute on function public.mark_notification_read(uuid) to authenticated, service_role;
-- <<< END 20260320120710_create_notification_device_rpc.sql

-- >>> BEGIN 20260320120720_create_transactional_email_enqueue_rpc.sql
create or replace function public.enqueue_transactional_email(
  p_event_key text,
  p_profile_id uuid,
  p_recipient_email text,
  p_booking_id uuid default null,
  p_template_key text default null,
  p_locale text default 'ar',
  p_payload_snapshot jsonb default '{}'::jsonb,
  p_dedupe_key text default null,
  p_priority text default 'normal'
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_outbox_jobs;
  v_key text := coalesce(nullif(trim(p_dedupe_key), ''), p_event_key || ':' || gen_random_uuid()::text);
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Transactional email enqueue requires privileged access';
  end if;

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
  ) values (
    p_event_key,
    v_key,
    p_profile_id,
    p_booking_id,
    coalesce(p_template_key, p_event_key),
    public.normalize_supported_locale(coalesce(nullif(trim(p_locale), ''), 'ar')),
    trim(p_recipient_email),
    coalesce(nullif(trim(p_priority), ''), 'normal'),
    'queued',
    now(),
    coalesce(p_payload_snapshot, '{}'::jsonb)
  ) returning * into v_result;

  return v_result;
end;
$$;

revoke all on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) from public, anon;
grant execute on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) to authenticated, service_role;
-- <<< END 20260320120720_create_transactional_email_enqueue_rpc.sql

-- >>> BEGIN 20260320120800_harden_notification_device_rules.sql
create or replace function public.normalize_supported_locale(
  p_locale text
)
returns text
language sql
stable
set search_path = public
as $$
  with localization as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'localization'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'fallback_locale', 'ar',
        'enabled_locales', jsonb_build_array('ar')
      )
    ) as value
  ),
  fallback_locale as (
    select lower(trim(coalesce(localization.value->>'fallback_locale', 'ar'))) as value
    from localization
  ),
  enabled_locales as (
    select coalesce(
      array_agg(lower(trim(locale_code))),
      array[]::text[]
    ) as values
    from localization,
      lateral jsonb_array_elements_text(
        coalesce(localization.value->'enabled_locales', '[]'::jsonb)
      ) as locale_code
    where nullif(trim(locale_code), '') is not null
  ),
  normalized_locale as (
    select lower(trim(coalesce(p_locale, ''))) as value
  )
  select case
    when normalized_locale.value <> ''
      and normalized_locale.value = any(enabled_locales.values)
      then normalized_locale.value
    when array_length(enabled_locales.values, 1) is not null
      and fallback_locale.value = any(enabled_locales.values)
      then fallback_locale.value
    when array_length(enabled_locales.values, 1) is not null
      then enabled_locales.values[1]
    else fallback_locale.value
  end
  from normalized_locale, enabled_locales, fallback_locale;
$$;

create or replace function public.get_profile_preferred_locale(
  p_profile_id uuid
)
returns text
language sql
stable
set search_path = public
as $$
  select coalesce(
    (
      select public.normalize_supported_locale(preferred_locale)
      from public.profiles
      where id = p_profile_id
        and nullif(trim(preferred_locale), '') is not null
      limit 1
    ),
    (
      select public.normalize_supported_locale(locale)
      from public.user_devices
      where profile_id = p_profile_id
        and nullif(trim(locale), '') is not null
      order by last_seen_at desc nulls last, updated_at desc, created_at desc
      limit 1
    ),
    public.normalize_supported_locale(null)
  );
$$;

drop policy if exists notifications_update_owner on public.notifications;
drop policy if exists notifications_update_admin_only on public.notifications;
create policy notifications_update_admin_only
on public.notifications for update to authenticated
using (public.is_admin())
with check (public.is_admin());

create or replace function public.register_user_device(
  p_push_token text,
  p_platform text,
  p_locale text default null
)
returns public.user_devices
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_push_token text := trim(coalesce(p_push_token, ''));
  v_platform text := lower(trim(coalesce(p_platform, '')));
  v_locale text := public.normalize_supported_locale(p_locale);
  v_result public.user_devices;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if v_push_token = '' then
    raise exception 'Push token is required';
  end if;

  if length(v_push_token) > 512 then
    raise exception 'Push token is too large';
  end if;

  if v_platform not in ('android', 'ios', 'web') then
    raise exception 'Unsupported device platform';
  end if;

  delete from public.user_devices
  where push_token = v_push_token
    and profile_id <> v_actor_id;

  insert into public.user_devices (
    profile_id,
    push_token,
    platform,
    locale,
    last_seen_at
  ) values (
    v_actor_id,
    v_push_token,
    v_platform,
    v_locale,
    now()
  )
  on conflict (profile_id, push_token) do update
  set platform = excluded.platform,
      locale = excluded.locale,
      last_seen_at = now(),
      updated_at = now()
  returning * into v_result;

  return v_result;
end;
$$;
-- <<< END 20260320120800_harden_notification_device_rules.sql

-- >>> BEGIN 20260320120810_harden_email_delivery_rules.sql
create or replace function public.enqueue_transactional_email(
  p_event_key text,
  p_profile_id uuid,
  p_recipient_email text,
  p_booking_id uuid default null,
  p_template_key text default null,
  p_locale text default 'ar',
  p_payload_snapshot jsonb default '{}'::jsonb,
  p_dedupe_key text default null,
  p_priority text default 'normal'
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_outbox_jobs;
  v_key text := coalesce(nullif(trim(p_dedupe_key), ''), p_event_key || ':' || gen_random_uuid()::text);
  v_locale text := public.normalize_supported_locale(
    coalesce(
      nullif(trim(p_locale), ''),
      public.get_profile_preferred_locale(p_profile_id),
      'ar'
    )
  );
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Transactional email enqueue requires privileged access';
  end if;

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
  ) values (
    p_event_key,
    v_key,
    p_profile_id,
    p_booking_id,
    coalesce(p_template_key, p_event_key),
    v_locale,
    trim(p_recipient_email),
    coalesce(nullif(trim(p_priority), ''), 'normal'),
    'queued',
    now(),
    coalesce(p_payload_snapshot, '{}'::jsonb)
  ) returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.record_email_provider_event(
  p_provider_message_id text,
  p_status public.email_delivery_status,
  p_error_code text default null,
  p_error_message text default null
)
returns public.email_delivery_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_delivery_logs;
  v_current_rank integer;
  v_next_rank integer;
begin
  if not public.is_service_role() then
    raise exception 'Email provider events require service role access';
  end if;

  v_next_rank := case p_status
    when 'queued' then 0
    when 'sent' then 1
    when 'delivered' then 2
    when 'opened' then 3
    when 'clicked' then 4
    when 'soft_failed' then 5
    when 'hard_failed' then 6
    when 'bounced' then 7
    when 'suppressed' then 8
    else 0
  end;

  select case status
    when 'queued' then 0
    when 'sent' then 1
    when 'delivered' then 2
    when 'opened' then 3
    when 'clicked' then 4
    when 'soft_failed' then 5
    when 'hard_failed' then 6
    when 'bounced' then 7
    when 'suppressed' then 8
    else 0
  end
  into v_current_rank
  from public.email_delivery_logs
  where provider_message_id = p_provider_message_id;

  if v_current_rank is null then
    raise exception 'Email delivery log not found for provider message';
  end if;

  if v_next_rank < v_current_rank then
    select * into v_result
    from public.email_delivery_logs
    where provider_message_id = p_provider_message_id;
    return v_result;
  end if;

  update public.email_delivery_logs
  set status = p_status,
      error_code = case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_code, 120) else null end,
      error_message = case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_message, 500) else null end,
      last_error_at = case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then now() else last_error_at end,
      updated_at = now()
  where provider_message_id = p_provider_message_id
  returning * into v_result;

  if not found then
    raise exception 'Email delivery log not found for provider message';
  end if;

  return v_result;
end;
$$;
-- <<< END 20260320120810_harden_email_delivery_rules.sql

-- >>> BEGIN 20260320120820_create_support_request_runtime.sql
create or replace function public.create_support_request(
  p_subject text,
  p_message text,
  p_locale text default null,
  p_shipment_id uuid default null,
  p_booking_id uuid default null,
  p_payment_proof_id uuid default null,
  p_dispute_id uuid default null
)
returns public.support_requests
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_actor_profile public.profiles;
  v_result public.support_requests;
  v_message text := left(nullif(trim(coalesce(p_message, '')), ''), 4000);
  v_subject text := left(nullif(trim(coalesce(p_subject, '')), ''), 160);
  v_preview text;
  v_locale text := public.normalize_supported_locale(p_locale);
  v_booking_id uuid := p_booking_id;
  v_proof_booking_id uuid;
  v_dispute_booking_id uuid;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  select *
  into v_actor_profile
  from public.profiles
  where id = v_actor_id;

  if v_actor_profile.id is null then
    raise exception 'authentication_required';
  end if;

  if v_subject is null or v_message is null then
    raise exception 'Support subject and message are required';
  end if;

  if p_shipment_id is not null and not exists (
    select 1
    from public.shipments as s
    where s.id = p_shipment_id
      and (s.shipper_id = v_actor_id or public.is_admin())
  ) then
    raise exception 'Support request context is not visible to current user';
  end if;

  if p_payment_proof_id is not null then
    select pp.booking_id
    into v_proof_booking_id
    from public.payment_proofs as pp
    where pp.id = p_payment_proof_id
      and (
        exists (
          select 1
          from public.bookings as b
          where b.id = pp.booking_id
            and public.booking_is_visible_to_current_user(b.id)
        )
        or public.is_admin()
      );

    if v_proof_booking_id is null then
      raise exception 'Support request context is not visible to current user';
    end if;

    if v_booking_id is null then
      v_booking_id := v_proof_booking_id;
    elsif v_booking_id <> v_proof_booking_id then
      raise exception 'Support request context is inconsistent';
    end if;
  end if;

  if p_dispute_id is not null then
    select d.booking_id
    into v_dispute_booking_id
    from public.disputes as d
    where d.id = p_dispute_id
      and (public.booking_is_visible_to_current_user(d.booking_id) or public.is_admin());

    if v_dispute_booking_id is null then
      raise exception 'Support request context is not visible to current user';
    end if;

    if v_booking_id is null then
      v_booking_id := v_dispute_booking_id;
    elsif v_booking_id <> v_dispute_booking_id then
      raise exception 'Support request context is inconsistent';
    end if;
  end if;

  if v_booking_id is not null and
     not (public.booking_is_visible_to_current_user(v_booking_id) or public.is_admin()) then
    raise exception 'Support request context is not visible to current user';
  end if;

  perform public.assert_rate_limit(
    'support-request:' || v_actor_id::text,
    5,
    3600
  );

  v_preview := left(regexp_replace(v_message, '\s+', ' ', 'g'), 280);

  insert into public.support_requests (
    created_by,
    requester_role,
    subject,
    status,
    priority,
    shipment_id,
    booking_id,
    payment_proof_id,
    dispute_id,
    last_message_preview,
    last_message_sender_type,
    last_message_at,
    user_last_read_at,
    admin_last_read_at
  ) values (
    v_actor_id,
    v_actor_profile.role,
    v_subject,
    'open',
    'normal',
    p_shipment_id,
    v_booking_id,
    p_payment_proof_id,
    p_dispute_id,
    v_preview,
    'user',
    now(),
    now(),
    null
  )
  returning * into v_result;

  insert into public.support_messages (
    request_id,
    sender_profile_id,
    sender_type,
    body
  ) values (
    v_result.id,
    v_actor_id,
    'user',
    v_message
  );

  insert into public.notifications (profile_id, type, title, body, data)
  select
    p.id,
    'support_request_created',
    'support_request_created_title',
    'support_request_created_body',
    jsonb_build_object(
      'support_request_id', v_result.id,
      'locale', v_locale,
      'route', '/admin/queues/support/' || v_result.id::text,
      'status', v_result.status,
      'requester_role', v_result.requester_role
    )
  from public.profiles as p
  inner join public.admin_accounts as aa on aa.profile_id = p.id
  where aa.is_active = true
    and p.id <> v_actor_id;

  return v_result;
end;
$$;

create or replace function public.reply_to_support_request(
  p_request_id uuid,
  p_message text
)
returns public.support_messages
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_request public.support_requests;
  v_message text := left(nullif(trim(coalesce(p_message, '')), ''), 4000);
  v_result public.support_messages;
  v_sender_type public.support_message_sender_type;
  v_next_status public.support_request_status;
  v_preview text;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if v_message is null then
    raise exception 'Support message is required';
  end if;

  select *
  into v_request
  from public.support_requests
  where id = p_request_id;

  if v_request.id is null then
    raise exception 'Support request not found';
  end if;

  if public.is_admin() then
    perform public.require_recent_admin_step_up();
    v_sender_type := 'admin';
    v_next_status := case
      when v_request.status in ('resolved', 'closed', 'waiting_for_user') then 'in_progress'
      else v_request.status
    end;
  elsif v_request.created_by = v_actor_id then
    perform public.assert_rate_limit(
      'support-reply:' || v_actor_id::text,
      20,
      3600
    );
    v_sender_type := 'user';
    v_next_status := case
      when v_request.status in ('resolved', 'closed', 'waiting_for_user') then 'open'
      else v_request.status
    end;
  else
    raise exception 'Support request access denied';
  end if;

  insert into public.support_messages (
    request_id,
    sender_profile_id,
    sender_type,
    body
  ) values (
    v_request.id,
    v_actor_id,
    v_sender_type,
    v_message
  )
  returning * into v_result;

  v_preview := left(regexp_replace(v_message, '\s+', ' ', 'g'), 280);

  update public.support_requests
  set status = v_next_status,
      last_message_preview = v_preview,
      last_message_sender_type = v_sender_type,
      last_message_at = now(),
      user_last_read_at = case
        when v_sender_type = 'user' then now()
        else user_last_read_at
      end,
      admin_last_read_at = case
        when v_sender_type = 'admin' then now()
        else admin_last_read_at
      end,
      updated_at = now()
  where id = v_request.id
  returning * into v_request;

  if v_sender_type = 'admin' then
    insert into public.notifications (profile_id, type, title, body, data)
    values (
      v_request.created_by,
      'support_reply_received',
      'support_reply_received_title',
      'support_reply_received_body',
      jsonb_build_object(
        'support_request_id', v_request.id,
        'status', v_request.status,
        'route', '/shared/support/' || v_request.id::text
      )
    );

    perform public.write_admin_audit_log(
      'support_request_replied',
      'support_request',
      v_request.id,
      'success',
      null,
      jsonb_build_object(
        'support_request_id', v_request.id,
        'status', v_request.status
      )
    );
  else
    insert into public.notifications (profile_id, type, title, body, data)
    select
      p.id,
      'support_user_replied',
      'support_user_replied_title',
      'support_user_replied_body',
      jsonb_build_object(
        'support_request_id', v_request.id,
        'status', v_request.status,
        'route', '/admin/queues/support/' || v_request.id::text
      )
    from public.profiles as p
    inner join public.admin_accounts as aa on aa.profile_id = p.id
    where aa.is_active = true
      and p.id <> v_actor_id;
  end if;

  return v_result;
end;
$$;

create or replace function public.mark_support_request_read(
  p_request_id uuid
)
returns public.support_requests
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.support_requests;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if public.is_admin() then
    update public.support_requests
    set admin_last_read_at = now(),
        updated_at = now()
    where id = p_request_id
    returning * into v_result;
  else
    update public.support_requests
    set user_last_read_at = now(),
        updated_at = now()
    where id = p_request_id
      and created_by = v_actor_id
    returning * into v_result;
  end if;

  if v_result.id is null then
    raise exception 'Support request not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.admin_set_support_request_status(
  p_request_id uuid,
  p_status public.support_request_status,
  p_priority public.support_request_priority default null
)
returns public.support_requests
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.support_requests;
  v_previous_status public.support_request_status;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin support status updates require privileged execution';
  end if;

  if public.is_admin() then
    perform public.require_recent_admin_step_up();
  end if;

  select status
  into v_previous_status
  from public.support_requests
  where id = p_request_id;

  update public.support_requests
  set status = p_status,
      priority = coalesce(p_priority, priority),
      updated_at = now()
  where id = p_request_id
  returning * into v_result;

  if v_result.id is null then
    raise exception 'Support request not found';
  end if;

  if v_previous_status is distinct from v_result.status then
    insert into public.notifications (profile_id, type, title, body, data)
    values (
      v_result.created_by,
      'support_status_changed',
      'support_status_changed_title',
      'support_status_changed_body',
      jsonb_build_object(
        'support_request_id', v_result.id,
        'status', v_result.status,
        'route', '/shared/support/' || v_result.id::text
      )
    );
  end if;

  perform public.write_admin_audit_log(
    'support_request_status_updated',
    'support_request',
    v_result.id,
    'success',
    null,
    jsonb_build_object(
      'support_request_id', v_result.id,
      'previous_status', v_previous_status,
      'status', v_result.status,
      'priority', v_result.priority
    )
  );

  return v_result;
end;
$$;

create or replace function public.admin_assign_support_request(
  p_request_id uuid,
  p_assigned_admin_id uuid default null
)
returns public.support_requests
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.support_requests;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin support assignment requires privileged execution';
  end if;

  if public.is_admin() then
    perform public.require_recent_admin_step_up();
  end if;

  if p_assigned_admin_id is not null and not exists (
    select 1
    from public.admin_accounts as aa
    where aa.profile_id = p_assigned_admin_id
      and aa.is_active = true
  ) then
    raise exception 'Assigned admin profile is invalid';
  end if;

  update public.support_requests
  set assigned_admin_id = p_assigned_admin_id,
      updated_at = now()
  where id = p_request_id
  returning * into v_result;

  if v_result.id is null then
    raise exception 'Support request not found';
  end if;

  perform public.write_admin_audit_log(
    'support_request_assigned',
    'support_request',
    v_result.id,
    'success',
    null,
    jsonb_build_object(
      'support_request_id', v_result.id,
      'assigned_admin_id', v_result.assigned_admin_id
    )
  );

  return v_result;
end;
$$;

revoke all on function public.create_support_request(text, text, text, uuid, uuid, uuid, uuid) from public, anon;
grant execute on function public.create_support_request(text, text, text, uuid, uuid, uuid, uuid) to authenticated, service_role;

revoke all on function public.reply_to_support_request(uuid, text) from public, anon;
grant execute on function public.reply_to_support_request(uuid, text) to authenticated, service_role;

revoke all on function public.mark_support_request_read(uuid) from public, anon;
grant execute on function public.mark_support_request_read(uuid) to authenticated, service_role;

revoke all on function public.admin_set_support_request_status(uuid, public.support_request_status, public.support_request_priority) from public, anon;
grant execute on function public.admin_set_support_request_status(uuid, public.support_request_status, public.support_request_priority) to authenticated, service_role;

revoke all on function public.admin_assign_support_request(uuid, uuid) from public, anon;
grant execute on function public.admin_assign_support_request(uuid, uuid) to authenticated, service_role;
-- <<< END 20260320120820_create_support_request_runtime.sql

  -- >>> BEGIN 20260323110000_seed_transactional_email_templates.sql
  insert into public.email_templates (
    template_key,
    language_code,
    subject_template,
    html_template,
    text_template,
    sample_payload,
    description,
    is_enabled
  )
  values
    (
      'booking_confirmed',
      'ar',
      'تم تأكيد الحجز - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم تأكيد الحجز</h1><p style="margin:0 0 12px;line-height:1.9;">تم تأكيد الحجز رقم {{booking_reference}} بنجاح.</p><p style="margin:0;color:#666;line-height:1.8;">يمكنك متابعة التفاصيل من داخل تطبيق FleetFill.</p></div></body></html>',
      'تم تأكيد الحجز\n\nتم تأكيد الحجز رقم {{booking_reference}} بنجاح.\nيمكنك متابعة التفاصيل من داخل تطبيق FleetFill.',
      '{"booking_reference":"FF-1001"}'::jsonb,
      'Arabic booking confirmation.',
      true
    ),
    (
      'payment_proof_received',
      'ar',
      'تم استلام إثبات الدفع - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم استلام إثبات الدفع</h1><p style="margin:0 0 12px;line-height:1.9;">تم استلام إثبات الدفع للحجز {{booking_reference}} وهو الآن بانتظار المراجعة.</p><p style="margin:0;color:#666;line-height:1.8;">لا حاجة لإعادة الإرسال ما لم يطلب منك ذلك داخل التطبيق.</p></div></body></html>',
      'تم استلام إثبات الدفع\n\nتم استلام إثبات الدفع للحجز {{booking_reference}} وهو الآن بانتظار المراجعة.\nلا حاجة لإعادة الإرسال ما لم يطلب منك ذلك داخل التطبيق.',
      '{"booking_reference":"FF-1001"}'::jsonb,
      'Arabic payment proof received notice.',
      true
    ),
    (
      'payment_rejected',
      'ar',
      'تم رفض إثبات الدفع - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم رفض إثبات الدفع</h1><p style="margin:0 0 12px;line-height:1.9;">تمت مراجعة إثبات الدفع للحجز {{booking_reference}} ولا يمكن قبوله بصيغته الحالية.</p><p style="margin:0 0 12px;line-height:1.9;"><strong>سبب الرفض:</strong> {{rejection_reason}}</p><p style="margin:0;color:#666;line-height:1.8;">يرجى إعادة الإرسال من داخل التطبيق قبل انتهاء المهلة.</p></div></body></html>',
      'تم رفض إثبات الدفع\n\nتمت مراجعة إثبات الدفع للحجز {{booking_reference}} ولا يمكن قبوله بصيغته الحالية.\nسبب الرفض: {{rejection_reason}}\nيرجى إعادة الإرسال من داخل التطبيق قبل انتهاء المهلة.',
      '{"booking_reference":"FF-1001","rejection_reason":"الصورة غير واضحة ولا يظهر فيها المبلغ بشكل كامل."}'::jsonb,
      'Arabic payment rejection notice.',
      true
    ),
    (
      'payment_secured',
      'ar',
      'تم تأمين الدفع - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم تأمين الدفع</h1><p style="margin:0 0 12px;line-height:1.9;">تم تأمين الدفع للحجز {{booking_reference}} بنجاح.</p><p style="margin:0;color:#666;line-height:1.8;">يمكنك متابعة التقدم التشغيلي للحجز من داخل التطبيق.</p></div></body></html>',
      'تم تأمين الدفع\n\nتم تأمين الدفع للحجز {{booking_reference}} بنجاح.\nيمكنك متابعة التقدم التشغيلي للحجز من داخل التطبيق.',
      '{"booking_reference":"FF-1001"}'::jsonb,
      'Arabic payment secured notice.',
      true
    ),
    (
      'delivered_pending_review',
      'ar',
      'تم التسليم وبانتظار المراجعة - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم التسليم وبانتظار المراجعة</h1><p style="margin:0 0 12px;line-height:1.9;">تم تعليم الحجز {{booking_reference}} على أنه مُسلَّم.</p><p style="margin:0;color:#666;line-height:1.8;">يمكنك مراجعة التسليم أو فتح نزاع من داخل التطبيق خلال نافذة المراجعة.</p></div></body></html>',
      'تم التسليم وبانتظار المراجعة\n\nتم تعليم الحجز {{booking_reference}} على أنه مُسلَّم.\nيمكنك مراجعة التسليم أو فتح نزاع من داخل التطبيق خلال نافذة المراجعة.',
      '{"booking_reference":"FF-1001"}'::jsonb,
      'Arabic delivery review notice.',
      true
    ),
    (
      'dispute_opened',
      'ar',
      'تم فتح نزاع - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم فتح نزاع</h1><p style="margin:0 0 12px;line-height:1.9;">تم فتح نزاع للحجز {{booking_reference}}.</p><p style="margin:0 0 12px;line-height:1.9;"><strong>سبب النزاع:</strong> {{reason_summary}}</p><p style="margin:0;color:#666;line-height:1.8;">يرجى متابعة التحديثات داخل التطبيق وتجهيز أي معلومات إضافية إذا لزم الأمر.</p></div></body></html>',
      'تم فتح نزاع\n\nتم فتح نزاع للحجز {{booking_reference}}.\nسبب النزاع: {{reason_summary}}\nيرجى متابعة التحديثات داخل التطبيق وتجهيز أي معلومات إضافية إذا لزم الأمر.',
      '{"booking_reference":"FF-1001","reason":"وصول الشحنة بحالة مختلفة عن الاتفاق."}'::jsonb,
      'Arabic dispute opened notice.',
      true
    ),
    (
      'dispute_resolved',
      'ar',
      'تم حل النزاع - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم حل النزاع</h1><p style="margin:0 0 12px;line-height:1.9;">تم حل النزاع المرتبط بالحجز {{booking_reference}}.</p><p style="margin:0 0 12px;line-height:1.9;"><strong>النتيجة:</strong> {{resolution_summary}}</p><p style="margin:0;color:#666;line-height:1.8;"><strong>المبلغ المعاد:</strong> {{refund_amount_label}}</p></div></body></html>',
      'تم حل النزاع\n\nتم حل النزاع المرتبط بالحجز {{booking_reference}}.\nالنتيجة: {{resolution_summary}}\nالمبلغ المعاد: {{refund_amount_label}}',
      '{"booking_reference":"FF-1001","resolution":"refunded","refund_amount_dzd":12500}'::jsonb,
      'Arabic dispute resolved notice.',
      true
    ),
    (
      'payout_released',
      'ar',
      'تم صرف مستحق الناقل - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">تم صرف مستحق الناقل</h1><p style="margin:0 0 12px;line-height:1.9;">تم صرف مستحق الحجز {{booking_reference}} بنجاح.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>قيمة التحويل:</strong> {{payout_amount_label}}</p></div></body></html>',
      'تم صرف مستحق الناقل\n\nتم صرف مستحق الحجز {{booking_reference}} بنجاح.\nقيمة التحويل: {{payout_amount_label}}',
      '{"booking_reference":"FF-1001","payout_amount_dzd":9200}'::jsonb,
      'Arabic payout released notice.',
      true
    ),
    (
      'generated_document_available',
      'ar',
      'المستند جاهز - {{booking_reference}}',
      '<!doctype html><html lang="ar" dir="rtl"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Tahoma,Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">المستند جاهز</h1><p style="margin:0 0 12px;line-height:1.9;">أصبح {{document_type_label}} الخاص بالحجز {{booking_reference}} جاهزاً.</p><p style="margin:0 0 12px;line-height:1.9;"><strong>المسار:</strong> {{document_route}}</p><p style="margin:0;color:#666;line-height:1.8;">يمكنك فتح التطبيق للوصول إلى المستند بشكل آمن.</p></div></body></html>',
      'المستند جاهز\n\nأصبح {{document_type_label}} الخاص بالحجز {{booking_reference}} جاهزاً.\nالمسار: {{document_route}}\nيمكنك فتح التطبيق للوصول إلى المستند بشكل آمن.',
      '{"booking_reference":"FF-1001","document_type":"payment_receipt","document_route":"/shared/generated-document/doc-1001"}'::jsonb,
      'Arabic generated document availability notice.',
      true
    )
on conflict (template_key, language_code) do update
set subject_template = excluded.subject_template,
    html_template = excluded.html_template,
    text_template = excluded.text_template,
    sample_payload = excluded.sample_payload,
    description = excluded.description,
    is_enabled = excluded.is_enabled,
    updated_at = now();

insert into public.email_templates (
  template_key,
  language_code,
  subject_template,
  html_template,
  text_template,
  sample_payload,
  description,
  is_enabled
)
values
  (
    'booking_confirmed',
    'fr',
    'Reservation confirmee - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Reservation confirmee</h1><p style="margin:0 0 12px;line-height:1.8;">Votre reservation {{booking_reference}} est confirmee.</p><p style="margin:0 0 12px;line-height:1.8;"><strong>Numero de suivi :</strong> {{tracking_number}}</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Reference de paiement :</strong> {{payment_reference}}</p></div></body></html>',
    'Reservation confirmee\n\nVotre reservation {{booking_reference}} est confirmee.\nNumero de suivi : {{tracking_number}}\nReference de paiement : {{payment_reference}}',
    '{"booking_reference":"FF-1001","tracking_number":"BK-1001","payment_reference":"PAY-1001"}'::jsonb,
    'French booking confirmation notice.',
    true
  ),
  (
    'payment_proof_received',
    'fr',
    'Preuve de paiement recue - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Preuve de paiement recue</h1><p style="margin:0;line-height:1.8;">La preuve de paiement pour la reservation {{booking_reference}} a ete recue et sera verifiee.</p></div></body></html>',
    'Preuve de paiement recue\n\nLa preuve de paiement pour la reservation {{booking_reference}} a ete recue et sera verifiee.',
    '{"booking_reference":"FF-1001","payment_proof_id":"proof-1001"}'::jsonb,
    'French payment proof received notice.',
    true
  ),
  (
    'payment_rejected',
    'fr',
    'Paiement rejete - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Paiement rejete</h1><p style="margin:0 0 12px;line-height:1.8;">La preuve de paiement pour {{booking_reference}} a ete rejetee.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Raison :</strong> {{rejection_reason}}</p></div></body></html>',
    'Paiement rejete\n\nLa preuve de paiement pour {{booking_reference}} a ete rejetee.\nRaison : {{rejection_reason}}',
    '{"booking_reference":"FF-1001","rejection_reason":"Montant incorrect"}'::jsonb,
    'French payment rejection notice.',
    true
  ),
  (
    'payment_secured',
    'fr',
    'Paiement securise - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Paiement securise</h1><p style="margin:0;line-height:1.8;">Le paiement de la reservation {{booking_reference}} a ete securise avec succes.</p></div></body></html>',
    'Paiement securise\n\nLe paiement de la reservation {{booking_reference}} a ete securise avec succes.',
    '{"booking_reference":"FF-1001","payment_proof_id":"proof-1001"}'::jsonb,
    'French payment secured notice.',
    true
  ),
  (
    'delivered_pending_review',
    'fr',
    'Livraison signalee - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Livraison signalee</h1><p style="margin:0;line-height:1.8;">La livraison de {{booking_reference}} a ete signalee. Vous pouvez confirmer la reception ou ouvrir un litige pendant le delai de revision.</p></div></body></html>',
    'Livraison signalee\n\nLa livraison de {{booking_reference}} a ete signalee. Vous pouvez confirmer la reception ou ouvrir un litige pendant le delai de revision.',
    '{"booking_reference":"FF-1001"}'::jsonb,
    'French delivered pending review notice.',
    true
  ),
  (
    'dispute_opened',
    'fr',
    'Litige ouvert - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Litige ouvert</h1><p style="margin:0 0 12px;line-height:1.8;">Un litige a ete ouvert pour la reservation {{booking_reference}}.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Raison :</strong> {{reason_summary}}</p></div></body></html>',
    'Litige ouvert\n\nUn litige a ete ouvert pour la reservation {{booking_reference}}.\nRaison : {{reason_summary}}',
    '{"booking_reference":"FF-1001","reason":"Colis endommage"}'::jsonb,
    'French dispute opened notice.',
    true
  ),
  (
    'dispute_resolved',
    'fr',
    'Litige resolu - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Litige resolu</h1><p style="margin:0 0 12px;line-height:1.8;">Le litige de la reservation {{booking_reference}} a ete resolu.</p><p style="margin:0 0 12px;line-height:1.8;"><strong>Decision :</strong> {{resolution_summary}}</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Montant du remboursement :</strong> {{refund_amount_label}}</p></div></body></html>',
    'Litige resolu\n\nLe litige de la reservation {{booking_reference}} a ete resolu.\nDecision : {{resolution_summary}}\nMontant du remboursement : {{refund_amount_label}}',
    '{"booking_reference":"FF-1001","resolution":"refunded","refund_amount_dzd":12000}'::jsonb,
    'French dispute resolution notice.',
    true
  ),
  (
    'payout_released',
    'fr',
    'Versement effectue - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Versement effectue</h1><p style="margin:0 0 12px;line-height:1.8;">Le versement pour la reservation {{booking_reference}} a ete effectue.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Montant :</strong> {{payout_amount_label}}</p></div></body></html>',
    'Versement effectue\n\nLe versement pour la reservation {{booking_reference}} a ete effectue.\nMontant : {{payout_amount_label}}',
    '{"booking_reference":"FF-1001","payout_amount_dzd":9200}'::jsonb,
    'French payout released notice.',
    true
  ),
  (
    'generated_document_available',
    'fr',
    'Document disponible - {{booking_reference}}',
    '<!doctype html><html lang="fr"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Document disponible</h1><p style="margin:0 0 12px;line-height:1.8;">Le {{document_type_label}} pour la reservation {{booking_reference}} est pret.</p><p style="margin:0;color:#666;line-height:1.8;">Acces dans l''application : {{document_route}}</p></div></body></html>',
    'Document disponible\n\nLe {{document_type_label}} pour la reservation {{booking_reference}} est pret.\nAcces dans l''application : {{document_route}}',
    '{"booking_reference":"FF-1001","document_type":"payment_receipt","document_route":"/shared/generated-document/doc-1001"}'::jsonb,
    'French generated document availability notice.',
    true
  ),
  (
    'booking_confirmed',
    'en',
    'Booking confirmed - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Booking confirmed</h1><p style="margin:0 0 12px;line-height:1.8;">Your booking {{booking_reference}} is confirmed.</p><p style="margin:0 0 12px;line-height:1.8;"><strong>Tracking number:</strong> {{tracking_number}}</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Payment reference:</strong> {{payment_reference}}</p></div></body></html>',
    'Booking confirmed\n\nYour booking {{booking_reference}} is confirmed.\nTracking number: {{tracking_number}}\nPayment reference: {{payment_reference}}',
    '{"booking_reference":"FF-1001","tracking_number":"BK-1001","payment_reference":"PAY-1001"}'::jsonb,
    'English booking confirmation notice.',
    true
  ),
  (
    'payment_proof_received',
    'en',
    'Payment proof received - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Payment proof received</h1><p style="margin:0;line-height:1.8;">The payment proof for booking {{booking_reference}} was received and will be reviewed.</p></div></body></html>',
    'Payment proof received\n\nThe payment proof for booking {{booking_reference}} was received and will be reviewed.',
    '{"booking_reference":"FF-1001","payment_proof_id":"proof-1001"}'::jsonb,
    'English payment proof received notice.',
    true
  ),
  (
    'payment_rejected',
    'en',
    'Payment rejected - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Payment rejected</h1><p style="margin:0 0 12px;line-height:1.8;">The payment proof for booking {{booking_reference}} was rejected.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Reason:</strong> {{rejection_reason}}</p></div></body></html>',
    'Payment rejected\n\nThe payment proof for booking {{booking_reference}} was rejected.\nReason: {{rejection_reason}}',
    '{"booking_reference":"FF-1001","rejection_reason":"Incorrect amount"}'::jsonb,
    'English payment rejection notice.',
    true
  ),
  (
    'payment_secured',
    'en',
    'Payment secured - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Payment secured</h1><p style="margin:0;line-height:1.8;">The payment for booking {{booking_reference}} has been secured successfully.</p></div></body></html>',
    'Payment secured\n\nThe payment for booking {{booking_reference}} has been secured successfully.',
    '{"booking_reference":"FF-1001","payment_proof_id":"proof-1001"}'::jsonb,
    'English payment secured notice.',
    true
  ),
  (
    'delivered_pending_review',
    'en',
    'Delivery reported - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Delivery reported</h1><p style="margin:0;line-height:1.8;">Delivery for booking {{booking_reference}} was reported. You can confirm receipt or open a dispute during the review window.</p></div></body></html>',
    'Delivery reported\n\nDelivery for booking {{booking_reference}} was reported. You can confirm receipt or open a dispute during the review window.',
    '{"booking_reference":"FF-1001"}'::jsonb,
    'English delivered pending review notice.',
    true
  ),
  (
    'dispute_opened',
    'en',
    'Dispute opened - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Dispute opened</h1><p style="margin:0 0 12px;line-height:1.8;">A dispute was opened for booking {{booking_reference}}.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Reason:</strong> {{reason_summary}}</p></div></body></html>',
    'Dispute opened\n\nA dispute was opened for booking {{booking_reference}}.\nReason: {{reason_summary}}',
    '{"booking_reference":"FF-1001","reason":"Damaged shipment"}'::jsonb,
    'English dispute opened notice.',
    true
  ),
  (
    'dispute_resolved',
    'en',
    'Dispute resolved - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Dispute resolved</h1><p style="margin:0 0 12px;line-height:1.8;">The dispute for booking {{booking_reference}} has been resolved.</p><p style="margin:0 0 12px;line-height:1.8;"><strong>Decision:</strong> {{resolution_summary}}</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Refund amount:</strong> {{refund_amount_label}}</p></div></body></html>',
    'Dispute resolved\n\nThe dispute for booking {{booking_reference}} has been resolved.\nDecision: {{resolution_summary}}\nRefund amount: {{refund_amount_label}}',
    '{"booking_reference":"FF-1001","resolution":"refunded","refund_amount_dzd":12000}'::jsonb,
    'English dispute resolution notice.',
    true
  ),
  (
    'payout_released',
    'en',
    'Payout released - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Payout released</h1><p style="margin:0 0 12px;line-height:1.8;">The payout for booking {{booking_reference}} has been released.</p><p style="margin:0;color:#666;line-height:1.8;"><strong>Amount:</strong> {{payout_amount_label}}</p></div></body></html>',
    'Payout released\n\nThe payout for booking {{booking_reference}} has been released.\nAmount: {{payout_amount_label}}',
    '{"booking_reference":"FF-1001","payout_amount_dzd":9200}'::jsonb,
    'English payout released notice.',
    true
  ),
  (
    'generated_document_available',
    'en',
    'Document available - {{booking_reference}}',
    '<!doctype html><html lang="en"><body style="margin:0;padding:24px;background:#f6f6f6;color:#111;font-family:Arial,sans-serif;"><div style="max-width:640px;margin:0 auto;background:#ffffff;border-radius:16px;padding:28px;"><div style="font-size:13px;color:#777;margin-bottom:12px;">FleetFill</div><h1 style="margin:0 0 16px;font-size:24px;line-height:1.5;">Document available</h1><p style="margin:0 0 12px;line-height:1.8;">The {{document_type_label}} for booking {{booking_reference}} is ready.</p><p style="margin:0;color:#666;line-height:1.8;">Open it in the app: {{document_route}}</p></div></body></html>',
    'Document available\n\nThe {{document_type_label}} for booking {{booking_reference}} is ready.\nOpen it in the app: {{document_route}}',
    '{"booking_reference":"FF-1001","document_type":"payment_receipt","document_route":"/shared/generated-document/doc-1001"}'::jsonb,
    'English generated document availability notice.',
    true
  )
on conflict (template_key, language_code) do update
set subject_template = excluded.subject_template,
    html_template = excluded.html_template,
    text_template = excluded.text_template,
    sample_payload = excluded.sample_payload,
    description = excluded.description,
    is_enabled = excluded.is_enabled,
    updated_at = now();
  -- <<< END 20260323110000_seed_transactional_email_templates.sql

  -- >>> BEGIN 20260320120825_add_dispute_evidence_support.sql
  insert into storage.buckets (id, name, public)
values ('dispute-evidence', 'dispute-evidence', false)
on conflict (id) do nothing;

create table if not exists public.dispute_evidence (
  id uuid primary key default gen_random_uuid(),
  dispute_id uuid not null references public.disputes (id) on delete cascade,
  storage_path text not null,
  note text,
  content_type text,
  byte_size bigint,
  checksum_sha256 text,
  uploaded_by uuid references public.profiles (id),
  upload_session_id uuid references public.upload_sessions (id),
  version integer not null default 1,
  created_at timestamptz not null default now()
);

create unique index if not exists dispute_evidence_dispute_version_idx
on public.dispute_evidence (dispute_id, version);

create index if not exists dispute_evidence_dispute_created_at_idx
on public.dispute_evidence (dispute_id, created_at desc);

alter table public.dispute_evidence enable row level security;

drop policy if exists dispute_evidence_select_participant_or_admin on public.dispute_evidence;
create policy dispute_evidence_select_participant_or_admin
on public.dispute_evidence for select to authenticated
using (
  exists (
    select 1
    from public.disputes as d
    join public.bookings as b on b.id = d.booking_id
    where d.id = dispute_id
      and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists dispute_evidence_upload_via_session on storage.objects;
create policy dispute_evidence_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'dispute-evidence'
  and public.can_upload_storage_object(bucket_id, name)
);

create or replace trigger dispute_evidence_append_only_guard
before update or delete on public.dispute_evidence
for each row execute function public.enforce_append_only_history();

create or replace function public.build_upload_object_path(
  p_bucket_id text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_version integer,
  p_file_extension text
)
returns text
language plpgsql
immutable
set search_path = public
as $$
declare
  v_extension text := lower(trim(coalesce(p_file_extension, 'bin')));
begin
  if p_bucket_id = 'payment-proofs' then
    return format('%s/%s/upload.%s', p_entity_id, p_version, v_extension);
  end if;

  if p_bucket_id = 'verification-documents' then
    return format(
      '%s/%s/%s/%s/upload.%s',
      p_entity_type,
      p_entity_id,
      p_document_type,
      p_version,
      v_extension
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return format('%s/%s/%s/file.%s', p_entity_id, p_document_type, p_version, v_extension);
  end if;

  if p_bucket_id = 'dispute-evidence' then
    return format('%s/%s/file.%s', p_entity_id, p_version, v_extension);
  end if;

  raise exception 'Unsupported bucket %', p_bucket_id;
end;
$$;

create or replace function public.authorize_private_file_access(
  p_bucket_id text,
  p_object_path text
)
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  perform public.assert_rate_limit('signed_url_generation', 30, 60);

  if public.is_admin() then
    return true;
  end if;

  if p_bucket_id = 'payment-proofs' then
    return exists (
      select 1
      from public.payment_proofs as pp
      join public.bookings as b on b.id = pp.booking_id
      where pp.storage_path = p_object_path
        and b.shipper_id = (select auth.uid())
    );
  end if;

  if p_bucket_id = 'verification-documents' then
    return exists (
      select 1
      from public.verification_documents as vd
      where vd.storage_path = p_object_path
        and vd.owner_profile_id = (select auth.uid())
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return exists (
      select 1
      from public.generated_documents as gd
      join public.bookings as b on b.id = gd.booking_id
      where gd.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  if p_bucket_id = 'dispute-evidence' then
    return exists (
      select 1
      from public.dispute_evidence as de
      join public.disputes as d on d.id = de.dispute_id
      join public.bookings as b on b.id = d.booking_id
      where de.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  return false;
end;
$$;

create or replace function public.create_upload_session(
  p_upload_kind text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_file_extension text,
  p_content_type text,
  p_byte_size bigint,
  p_checksum_sha256 text default null
)
returns table (
  upload_session_id uuid,
  bucket_id text,
  object_path text,
  expires_at timestamptz,
  max_file_size_bytes bigint
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := (select auth.uid());
  v_bucket_id text;
  v_entity_type text := trim(lower(p_entity_type));
  v_document_type text := trim(lower(coalesce(p_document_type, '')));
  v_version integer;
  v_object_path text;
  v_session_id uuid := gen_random_uuid();
  v_expires_at timestamptz := now() + interval '15 minutes';
  v_owner_profile_id uuid;
  v_max_file_size bigint := 10485760;
begin
  if v_profile_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_content_type not in ('image/jpeg', 'image/png', 'application/pdf') then
    raise exception 'Unsupported content type';
  end if;

  if p_byte_size <= 0 or p_byte_size > v_max_file_size then
    raise exception 'File size exceeds the allowed limit';
  end if;

  if trim(lower(p_upload_kind)) = 'payment_proof' then
    perform public.assert_rate_limit('proof_upload', 10, 3600);
    v_bucket_id := 'payment-proofs';

    if v_entity_type <> 'booking' then
      raise exception 'Payment proof uploads must target a booking';
    end if;

    if not public.booking_owned_by_current_shipper(p_entity_id) then
      raise exception 'You cannot upload proof for this booking';
    end if;

    if v_document_type not in ('ccp', 'dahabia', 'bank') then
      raise exception 'Payment proof document type must be a payment rail';
    end if;

    select coalesce(max(pp.version), 0) + 1
    into v_version
    from public.payment_proofs as pp
    where pp.booking_id = p_entity_id;

    v_owner_profile_id := v_profile_id;
  elsif trim(lower(p_upload_kind)) = 'verification_document' then
    perform public.assert_rate_limit('verification_document_upload', 20, 3600);
    v_bucket_id := 'verification-documents';

    if v_document_type not in (
      'driver_identity_or_license',
      'truck_registration',
      'truck_insurance',
      'truck_technical_inspection'
    ) then
      raise exception 'Unsupported verification document type';
    end if;

    if v_entity_type = 'profile' then
      if p_entity_id <> v_profile_id then
        raise exception 'Profile verification documents must target the current user';
      end if;
      v_owner_profile_id := v_profile_id;
    elsif v_entity_type = 'vehicle' then
      if not public.vehicle_owned_by_current_carrier(p_entity_id) then
        raise exception 'Vehicle verification documents must target your own vehicle';
      end if;
      select v.carrier_id into v_owner_profile_id
      from public.vehicles as v
      where v.id = p_entity_id;
    else
      raise exception 'Unsupported verification entity type';
    end if;

    select coalesce(max(vd.version), 0) + 1
    into v_version
    from public.verification_documents as vd
    where vd.entity_type::text = v_entity_type
      and vd.entity_id = p_entity_id
      and vd.document_type = v_document_type;
  elsif trim(lower(p_upload_kind)) = 'dispute_evidence' then
    perform public.assert_rate_limit('dispute_evidence_upload', 20, 3600);
    v_bucket_id := 'dispute-evidence';

    if v_entity_type <> 'dispute' then
      raise exception 'Dispute evidence uploads must target a dispute';
    end if;

    select d.opened_by
    into v_owner_profile_id
    from public.disputes as d
    where d.id = p_entity_id
      and d.status = 'open'
      and d.opened_by = v_profile_id;

    if not found then
      raise exception 'You cannot upload evidence for this dispute';
    end if;

    select coalesce(max(de.version), 0) + 1
    into v_version
    from public.dispute_evidence as de
    where de.dispute_id = p_entity_id;

    v_document_type := 'evidence';
  else
    raise exception 'Unsupported upload kind';
  end if;

  v_object_path := public.build_upload_object_path(
    v_bucket_id,
    v_entity_type,
    p_entity_id,
    v_document_type,
    v_version,
    p_file_extension
  );

  insert into public.upload_sessions (
    id,
    profile_id,
    bucket_id,
    object_path,
    entity_type,
    entity_id,
    document_type,
    content_type,
    byte_size,
    checksum_sha256,
    expires_at
  )
  values (
    v_session_id,
    v_owner_profile_id,
    v_bucket_id,
    v_object_path,
    v_entity_type,
    p_entity_id,
    v_document_type,
    p_content_type,
    p_byte_size,
    p_checksum_sha256,
    v_expires_at
  );

  return query
  select v_session_id, v_bucket_id, v_object_path, v_expires_at, v_max_file_size;
end;
$$;

create or replace function public.finalize_dispute_evidence(
  p_upload_session_id uuid,
  p_note text default null
)
returns public.dispute_evidence
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session public.upload_sessions;
  v_result public.dispute_evidence;
  v_object_exists boolean;
begin
  select * into v_session
  from public.upload_sessions
  where id = p_upload_session_id
    and profile_id = (select auth.uid())
    and bucket_id = 'dispute-evidence';

  if not found then
    raise exception 'Upload session not found';
  end if;

  if v_session.status <> 'authorized' or v_session.expires_at <= now() then
    raise exception 'Upload session is no longer valid';
  end if;

  select exists (
    select 1
    from storage.objects as so
    where so.bucket_id = v_session.bucket_id
      and so.name = v_session.object_path
      and coalesce((so.metadata->>'size')::bigint, -1) = v_session.byte_size
      and lower(coalesce(so.metadata->>'mimetype', '')) = lower(v_session.content_type)
  ) into v_object_exists;

  if not v_object_exists then
    raise exception 'Uploaded dispute evidence file is missing or metadata does not match the authorized session';
  end if;

  insert into public.dispute_evidence (
    dispute_id,
    storage_path,
    note,
    content_type,
    byte_size,
    checksum_sha256,
    uploaded_by,
    upload_session_id,
    version
  )
  values (
    v_session.entity_id,
    v_session.object_path,
    left(nullif(trim(p_note), ''), 500),
    v_session.content_type,
    v_session.byte_size,
    v_session.checksum_sha256,
    (select auth.uid()),
    v_session.id,
    (
      select coalesce(max(de.version), 0) + 1
      from public.dispute_evidence as de
      where de.dispute_id = v_session.entity_id
    )
  ) returning * into v_result;

  update public.upload_sessions
  set status = 'finalized', finalized_at = now(), updated_at = now()
  where id = v_session.id;

  return v_result;
end;
$$;

revoke all on function public.finalize_dispute_evidence(uuid, text) from public, anon;
grant execute on function public.finalize_dispute_evidence(uuid, text) to authenticated, service_role;
-- <<< END 20260320120825_add_dispute_evidence_support.sql

-- >>> BEGIN 20260320120830_create_push_notification_runtime.sql
create table if not exists public.push_outbox_jobs (
  id uuid primary key default gen_random_uuid(),
  notification_id uuid not null unique references public.notifications (id) on delete cascade,
  profile_id uuid not null references public.profiles (id),
  event_key text not null,
  dedupe_key text not null unique,
  title text not null,
  body text not null,
  payload_snapshot jsonb,
  status text not null default 'queued' check (status in ('queued', 'processing', 'sent', 'skipped', 'dead_letter')),
  attempt_count integer not null default 0,
  max_attempts integer not null default 5,
  available_at timestamptz not null default now(),
  locked_at timestamptz,
  locked_by text,
  provider text,
  provider_message_id text,
  last_error_code text,
  last_error_message text,
  delivered_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists push_outbox_jobs_status_available_at_idx
on public.push_outbox_jobs (status, available_at);

create index if not exists push_outbox_jobs_profile_id_idx
on public.push_outbox_jobs (profile_id);

alter table public.push_outbox_jobs enable row level security;

drop policy if exists push_outbox_jobs_admin_only on public.push_outbox_jobs;
create policy push_outbox_jobs_admin_only
on public.push_outbox_jobs for select to authenticated
using (public.is_admin());

create or replace trigger push_outbox_jobs_set_updated_at
before update on public.push_outbox_jobs
for each row execute function public.set_updated_at();

create or replace function public.enqueue_push_job_from_notification()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.push_outbox_jobs (
    notification_id,
    profile_id,
    event_key,
    dedupe_key,
    title,
    body,
    payload_snapshot
  ) values (
    new.id,
    new.profile_id,
    new.type,
    'notification:' || new.id::text,
    new.title,
    new.body,
    coalesce(new.data, '{}'::jsonb) || jsonb_build_object(
      'notification_id', new.id,
      'route', '/shared/notification/' || new.id::text
    )
  ) on conflict (dedupe_key) do nothing;

  return new;
end;
$$;

drop trigger if exists notifications_enqueue_push_job on public.notifications;
create trigger notifications_enqueue_push_job
after insert on public.notifications
for each row execute function public.enqueue_push_job_from_notification();

create or replace function public.claim_push_outbox_jobs(
  p_worker_id text,
  p_batch_size integer default 10
)
returns setof public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_service_role() then
    raise exception 'Push job claiming requires service role access';
  end if;

  return query
  with claimed as (
    update public.push_outbox_jobs as jobs
    set status = 'processing',
        locked_at = now(),
        locked_by = left(trim(p_worker_id), 120),
        updated_at = now()
    where jobs.id in (
      select candidate.id
      from public.push_outbox_jobs as candidate
      where candidate.status = 'queued'
        and candidate.available_at <= now()
      order by candidate.available_at asc, candidate.created_at asc
      limit greatest(1, least(coalesce(p_batch_size, 10), 25))
      for update skip locked
    )
    returning jobs.*
  )
  select * from claimed;
end;
$$;

create or replace function public.complete_push_outbox_job(
  p_job_id uuid,
  p_status text default 'sent',
  p_provider text default null,
  p_provider_message_id text default null,
  p_error_code text default null,
  p_error_message text default null
)
returns public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.push_outbox_jobs;
begin
  if not public.is_service_role() then
    raise exception 'Push job completion requires service role access';
  end if;

  if p_status not in ('sent', 'skipped') then
    raise exception 'Unsupported push completion status';
  end if;

  update public.push_outbox_jobs
  set status = p_status,
      provider = coalesce(nullif(trim(p_provider), ''), provider),
      provider_message_id = coalesce(nullif(trim(p_provider_message_id), ''), provider_message_id),
      last_error_code = nullif(trim(coalesce(p_error_code, '')), ''),
      last_error_message = nullif(trim(coalesce(p_error_message, '')), ''),
      delivered_at = case when p_status = 'sent' then now() else delivered_at end,
      locked_at = null,
      locked_by = null,
      updated_at = now()
  where id = p_job_id
  returning * into v_result;

  if not found then
    raise exception 'Push outbox job not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.release_retryable_push_job(
  p_job_id uuid,
  p_error_code text default null,
  p_error_message text default null,
  p_retry_delay_seconds integer default 300
)
returns public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.push_outbox_jobs;
  v_attempt_count integer;
begin
  if not public.is_service_role() then
    raise exception 'Push retry scheduling requires service role access';
  end if;

  select * into v_job
  from public.push_outbox_jobs
  where id = p_job_id
  for update;

  if not found then
    raise exception 'Push outbox job not found';
  end if;

  v_attempt_count := v_job.attempt_count + 1;

  update public.push_outbox_jobs
  set attempt_count = v_attempt_count,
      status = case when v_attempt_count >= v_job.max_attempts then 'dead_letter' else 'queued' end,
      available_at = case
        when v_attempt_count >= v_job.max_attempts then v_job.available_at
        else now() + make_interval(secs => greatest(30, least(coalesce(p_retry_delay_seconds, 300), 3600)))
      end,
      locked_at = null,
      locked_by = null,
      last_error_code = nullif(trim(coalesce(p_error_code, '')), ''),
      last_error_message = left(nullif(trim(coalesce(p_error_message, '')), ''), 500),
      updated_at = now()
  where id = p_job_id
  returning * into v_job;

  return v_job;
end;
$$;

create or replace function public.recover_stale_push_outbox_jobs(
  p_lock_age_seconds integer default 900
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count integer := 0;
begin
  if not public.is_service_role() then
    raise exception 'Push stale job recovery requires service role access';
  end if;

  update public.push_outbox_jobs
  set status = 'queued',
      locked_at = null,
      locked_by = null,
      updated_at = now()
  where status = 'processing'
    and locked_at < now() - make_interval(secs => greatest(60, coalesce(p_lock_age_seconds, 900)));

  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

revoke all on function public.claim_push_outbox_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_push_outbox_jobs(text, integer) to service_role;

revoke all on function public.complete_push_outbox_job(uuid, text, text, text, text, text) from public, anon, authenticated;
grant execute on function public.complete_push_outbox_job(uuid, text, text, text, text, text) to service_role;

revoke all on function public.release_retryable_push_job(uuid, text, text, integer) from public, anon, authenticated;
grant execute on function public.release_retryable_push_job(uuid, text, text, integer) to service_role;

revoke all on function public.recover_stale_push_outbox_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_push_outbox_jobs(integer) to service_role;
-- <<< END 20260320120830_create_push_notification_runtime.sql

-- >>> BEGIN 20260320120900_seed_runtime_and_feature_flag_settings.sql
insert into public.platform_settings (key, value, is_public, description)
values
  (
    'app_runtime',
    jsonb_build_object(
      'maintenance_mode', false,
      'force_update_required', false,
      'minimum_supported_android_version', 1,
      'minimum_supported_ios_version', 1
    ),
    true,
    'Admin-controlled runtime policy for maintenance and minimum supported versions'
  ),
  (
    'feature_flags',
    jsonb_build_object(
      'admin_email_resend_enabled', true
    ),
    false,
    'Admin-controlled feature flags'
  ),
  (
    'localization',
    jsonb_build_object(
      'fallback_locale', 'ar',
      'enabled_locales', jsonb_build_array('ar', 'fr', 'en')
    ),
    true,
    'Public localization policy for enabled locales and fallback locale'
  )
on conflict (key) do nothing;
-- <<< END 20260320120900_seed_runtime_and_feature_flag_settings.sql

-- >>> BEGIN 20260320121000_create_typed_client_settings_rpc.sql
create or replace function public.get_client_settings()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  with booking_pricing as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'booking_pricing'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'platform_fee_rate', 0.05,
        'carrier_fee_rate', 0,
        'insurance_rate', 0.01,
        'insurance_min_fee_dzd', 100,
        'tax_rate', 0,
        'payment_resubmission_deadline_hours', 24
      )
    ) as value
  ),
  delivery_review as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'delivery_review'
          and ps.is_public = true
      ),
      jsonb_build_object('grace_window_hours', 24)
    ) as value
  ),
  app_runtime as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'app_runtime'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'maintenance_mode', false,
        'force_update_required', false,
        'minimum_supported_android_version', 1,
        'minimum_supported_ios_version', 1
      )
    ) as value
  ),
  localization as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'localization'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'fallback_locale', 'ar',
        'enabled_locales', jsonb_build_array('ar')
      )
    ) as value
  ),
  payment_accounts as (
    with current_environment as (
      select coalesce(
        nullif(current_setting('app.settings.environment', true), ''),
        'local'
      )::public.platform_environment as environment
    )
    select coalesce(
      jsonb_agg(
        jsonb_build_object(
          'id', ppa.id,
          'payment_rail', ppa.payment_rail,
          'display_name', ppa.display_name,
          'account_identifier', ppa.account_identifier,
          'account_holder_name', ppa.account_holder_name,
          'instructions_text', ppa.instructions_text
        )
        order by ppa.display_name
      ),
      '[]'::jsonb
    ) as value
    from public.platform_payment_accounts as ppa
    cross join current_environment as ce
    where ppa.is_active = true
      and ppa.environment = ce.environment
  )
  select jsonb_build_object(
    'booking_pricing', booking_pricing.value,
    'delivery_review', delivery_review.value,
    'app_runtime', app_runtime.value,
    'localization', localization.value,
    'platform_payment_accounts', payment_accounts.value
  )
  from booking_pricing, delivery_review, app_runtime, localization, payment_accounts;
$$;

revoke all on function public.get_client_settings() from public;
grant execute on function public.get_client_settings() to anon, authenticated, service_role;
-- <<< END 20260320121000_create_typed_client_settings_rpc.sql

-- >>> BEGIN 20260320121100_create_admin_operational_summary_rpc.sql
create or replace function public.current_admin_email_resend_enabled()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((value->>'admin_email_resend_enabled')::boolean, true)
  from public.platform_settings
  where key = 'feature_flags';
$$;

create or replace function public.admin_get_operational_summary()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_delivery_grace_hours integer := public.current_delivery_review_grace_window_hours();
  v_payment_deadline_hours integer := public.current_payment_resubmission_deadline_hours();
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin summary access requires privileged execution';
  end if;

  return jsonb_build_object(
    'verification_packets', (
      select count(*)
      from public.profiles as p
      where p.role = 'carrier'::public.app_role
        and p.is_active = true
        and p.verification_status in ('pending', 'rejected')
    ),
    'pending_verification_documents', (
      select count(*)
      from public.verification_documents as vd
      where vd.status = 'pending'
    ),
    'payment_proofs', (
      select count(*)
      from public.payment_proofs as pp
      where pp.status = 'pending'
    ),
    'disputes', (
      select count(*)
      from public.disputes as d
      where d.status = 'open'
    ),
    'eligible_payouts', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'completed'
        and b.payment_status = 'secured'
        and not exists (
          select 1
          from public.disputes as d
          where d.booking_id = b.id
            and d.status = 'open'
        )
        and not exists (
          select 1
          from public.payouts as p
          where p.booking_id = b.id
        )
    ),
    'support_needs_reply', (
      select count(*)
      from public.support_requests as sr
      where sr.status not in ('resolved', 'closed')
        and sr.last_message_sender_type = 'user'
    ),
    'email_backlog', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status in ('queued', 'retry_scheduled', 'processing')
    ),
    'email_dead_letter', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status = 'dead_letter'
    ),
    'audit_events_last_24h', (
      select count(*)
      from public.admin_audit_logs as logs
      where logs.created_at >= now() - interval '24 hours'
    ),
    'overdue_delivery_reviews', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'delivered_pending_review'
        and b.delivered_at is not null
        and b.delivered_at <= now() - make_interval(hours => v_delivery_grace_hours)
    ),
    'overdue_payment_resubmissions', (
      with latest_rejection as (
        select pp.booking_id, max(pp.reviewed_at) as reviewed_at
        from public.payment_proofs as pp
        where pp.status = 'rejected'
        group by pp.booking_id
      )
      select count(*)
      from public.bookings as b
      inner join latest_rejection as lr on lr.booking_id = b.id
      where b.payment_status = 'rejected'
        and lr.reviewed_at is not null
        and lr.reviewed_at <= now() - make_interval(hours => v_payment_deadline_hours)
    )
  );
end;
$$;

revoke all on function public.admin_get_operational_summary() from public, anon;
grant execute on function public.admin_get_operational_summary() to authenticated, service_role;
-- <<< END 20260320121100_create_admin_operational_summary_rpc.sql

-- >>> BEGIN 20260320121110_create_admin_platform_settings_rpc.sql
create or replace function public.admin_upsert_platform_setting(
  p_key text,
  p_value jsonb,
  p_is_public boolean default false,
  p_description text default null
)
returns public.platform_settings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.platform_settings;
  v_key text := nullif(trim(p_key), '');
  v_maintenance_mode boolean;
  v_force_update_required boolean;
  v_android_version integer;
  v_ios_version integer;
  v_platform_fee_rate numeric;
  v_carrier_fee_rate numeric;
  v_insurance_rate numeric;
  v_insurance_min_fee_dzd numeric;
  v_tax_rate numeric;
  v_payment_deadline_hours integer;
  v_delivery_grace_hours integer;
  v_admin_email_resend_enabled boolean;
  v_fallback_locale text;
  v_enabled_locale_codes text[];
begin
  if not public.is_super_admin() and not public.is_service_role() then
    raise exception 'Platform setting updates require super admin access';
  end if;

  if public.is_super_admin() then
    perform public.require_recent_admin_step_up();
  end if;

  if v_key is null then
    raise exception 'Platform setting key is required';
  end if;

  if jsonb_typeof(coalesce(p_value, '{}'::jsonb)) <> 'object' then
    raise exception 'Platform setting value must be a JSON object';
  end if;

  case v_key
    when 'app_runtime' then
      v_maintenance_mode := coalesce((p_value->>'maintenance_mode')::boolean, false);
      v_force_update_required := coalesce((p_value->>'force_update_required')::boolean, false);
      v_android_version := greatest(coalesce((p_value->>'minimum_supported_android_version')::integer, 1), 1);
      v_ios_version := greatest(coalesce((p_value->>'minimum_supported_ios_version')::integer, 1), 1);
      p_value := jsonb_build_object(
        'maintenance_mode', v_maintenance_mode,
        'force_update_required', v_force_update_required,
        'minimum_supported_android_version', v_android_version,
        'minimum_supported_ios_version', v_ios_version
      );
    when 'booking_pricing' then
      v_platform_fee_rate := coalesce((p_value->>'platform_fee_rate')::numeric, 0.05);
      v_carrier_fee_rate := coalesce((p_value->>'carrier_fee_rate')::numeric, 0);
      v_insurance_rate := coalesce((p_value->>'insurance_rate')::numeric, 0.01);
      v_insurance_min_fee_dzd := coalesce((p_value->>'insurance_min_fee_dzd')::numeric, 100);
      v_tax_rate := coalesce((p_value->>'tax_rate')::numeric, 0);
      v_payment_deadline_hours := coalesce((p_value->>'payment_resubmission_deadline_hours')::integer, 24);

      if v_platform_fee_rate < 0 or v_carrier_fee_rate < 0 or v_insurance_rate < 0 or v_insurance_min_fee_dzd < 0 or v_tax_rate < 0 then
        raise exception 'Pricing values must be non-negative';
      end if;

      if v_payment_deadline_hours < 1 then
        raise exception 'Payment resubmission deadline must be at least one hour';
      end if;

      p_value := jsonb_build_object(
        'platform_fee_rate', v_platform_fee_rate,
        'carrier_fee_rate', v_carrier_fee_rate,
        'insurance_rate', v_insurance_rate,
        'insurance_min_fee_dzd', v_insurance_min_fee_dzd,
        'tax_rate', v_tax_rate,
        'payment_resubmission_deadline_hours', v_payment_deadline_hours
      );
    when 'delivery_review' then
      v_delivery_grace_hours := coalesce((p_value->>'grace_window_hours')::integer, 24);
      if v_delivery_grace_hours < 1 then
        raise exception 'Delivery grace window must be at least one hour';
      end if;
      p_value := jsonb_build_object('grace_window_hours', v_delivery_grace_hours);
    when 'feature_flags' then
      v_admin_email_resend_enabled := coalesce((p_value->>'admin_email_resend_enabled')::boolean, true);
      p_value := jsonb_build_object(
        'admin_email_resend_enabled',
        v_admin_email_resend_enabled
      );
    when 'localization' then
      v_fallback_locale := lower(trim(coalesce(p_value->>'fallback_locale', 'ar')));
      if v_fallback_locale = '' then
        v_fallback_locale := 'ar';
      end if;

      if jsonb_typeof(coalesce(p_value->'enabled_locales', '[]'::jsonb)) <> 'array' then
        raise exception 'Localization enabled locales must be an array';
      end if;

      select coalesce(
        array_agg(distinct lower(trim(locale_code))),
        array[]::text[]
      )
      into v_enabled_locale_codes
      from jsonb_array_elements_text(
        coalesce(p_value->'enabled_locales', '[]'::jsonb)
      ) as locale_code
      where nullif(trim(locale_code), '') is not null;

      if array_length(v_enabled_locale_codes, 1) is null then
        v_enabled_locale_codes := array[v_fallback_locale];
      elsif not (v_fallback_locale = any(v_enabled_locale_codes)) then
        v_enabled_locale_codes := array_prepend(v_fallback_locale, v_enabled_locale_codes);
      end if;

      p_value := jsonb_build_object(
        'fallback_locale', v_fallback_locale,
        'enabled_locales', to_jsonb(v_enabled_locale_codes)
      );
    else
      raise exception 'Unsupported platform setting key';
  end case;

  insert into public.platform_settings (
    key,
    value,
    is_public,
    description,
    updated_by,
    updated_at
  ) values (
    v_key,
    coalesce(p_value, '{}'::jsonb),
    coalesce(p_is_public, false),
    left(nullif(trim(p_description), ''), 500),
    (select auth.uid()),
    now()
  )
  on conflict (key) do update
  set value = excluded.value,
      is_public = excluded.is_public,
      description = coalesce(excluded.description, public.platform_settings.description),
      updated_by = excluded.updated_by,
      updated_at = excluded.updated_at
  returning * into v_result;

  perform public.write_admin_audit_log(
    'platform_setting_updated',
    'platform_setting',
    null,
    'success',
    null,
    jsonb_build_object(
      'key', v_result.key,
      'is_public', v_result.is_public
    )
  );

  return v_result;
end;
$$;

revoke all on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) from public, anon;
grant execute on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) to authenticated, service_role;
-- <<< END 20260320121110_create_admin_platform_settings_rpc.sql

-- >>> BEGIN 20260320121120_create_admin_profile_activation_rpc.sql
create or replace function public.admin_set_profile_active(
  p_profile_id uuid,
  p_is_active boolean,
  p_reason text default null
)
returns public.profiles
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.profiles;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Profile activation changes require privileged execution';
  end if;

  perform public.require_recent_admin_step_up();

  if p_profile_id is null then
    raise exception 'Profile id is required';
  end if;

  if v_actor_id = p_profile_id and coalesce(p_is_active, true) = false then
    raise exception 'Admins cannot suspend their own account';
  end if;

  update public.profiles
  set is_active = coalesce(p_is_active, true),
      updated_at = now()
  where id = p_profile_id
  returning * into v_result;

  if not found then
    raise exception 'Profile not found';
  end if;

  perform public.write_admin_audit_log(
    case when v_result.is_active then 'profile_reactivated' else 'profile_suspended' end,
    'profile',
    v_result.id,
    'success',
    left(nullif(trim(p_reason), ''), 500),
    jsonb_build_object('is_active', v_result.is_active)
  );

  return v_result;
end;
$$;

revoke all on function public.admin_set_profile_active(uuid, boolean, text) from public, anon;
grant execute on function public.admin_set_profile_active(uuid, boolean, text) to authenticated, service_role;
-- <<< END 20260320121120_create_admin_profile_activation_rpc.sql

-- >>> BEGIN 20260320121130_create_admin_email_retry_rpc.sql
create or replace function public.admin_retry_email_delivery(
  p_delivery_log_id uuid
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_log public.email_delivery_logs;
  v_job public.email_outbox_jobs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Email resend requires privileged execution';
  end if;

  if not public.current_admin_email_resend_enabled() then
    raise exception 'Email resend is currently disabled';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_log
  from public.email_delivery_logs
  where id = p_delivery_log_id;

  if not found then
    raise exception 'Email delivery log not found';
  end if;

  if v_log.status <> 'soft_failed' then
    raise exception 'Email resend is only available for retryable delivery failures';
  end if;

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
    attempt_count,
    max_attempts,
    available_at,
    payload_snapshot
  ) values (
    'manual_resend',
    format('manual_resend:%s:%s', v_log.id, gen_random_uuid()),
    v_log.profile_id,
    v_log.booking_id,
    v_log.template_key,
    v_log.locale,
    v_log.recipient_email,
    'high',
    'queued',
    0,
    5,
    now(),
    v_log.payload_snapshot
  )
  returning * into v_job;

  perform public.write_admin_audit_log(
    'email_delivery_resent',
    'email_delivery_log',
    null,
    'success',
    null,
    jsonb_build_object(
      'delivery_log_id', v_log.id,
      'email_outbox_job_id', v_job.id,
      'template_key', v_log.template_key,
      'recipient_email', v_log.recipient_email
    )
  );

  return v_job;
end;
$$;

create or replace function public.admin_retry_dead_letter_email_job(
  p_job_id uuid
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.email_outbox_jobs;
  v_retry_job public.email_outbox_jobs;
  v_error_code text;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Email resend requires privileged execution';
  end if;

  if not public.current_admin_email_resend_enabled() then
    raise exception 'Email resend is currently disabled';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_job
  from public.email_outbox_jobs
  where id = p_job_id;

  if not found then
    raise exception 'Dead-letter email job not found';
  end if;

  if v_job.status <> 'dead_letter' then
    raise exception 'Only dead-letter email jobs can be retried here';
  end if;

  v_error_code := lower(coalesce(v_job.last_error_code, ''));

  if v_error_code like '%bounce%'
     or v_error_code like '%invalid%'
     or v_error_code like '%suppress%'
     or v_error_code like '%hard%'
  then
    raise exception 'Email resend is blocked for non-retryable delivery failures';
  end if;

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
    attempt_count,
    max_attempts,
    available_at,
    payload_snapshot
  ) values (
    'manual_resend',
    format('manual_resend:%s:%s', v_job.id, gen_random_uuid()),
    v_job.profile_id,
    v_job.booking_id,
    v_job.template_key,
    v_job.locale,
    v_job.recipient_email,
    'high',
    'queued',
    0,
    5,
    now(),
    v_job.payload_snapshot
  )
  returning * into v_retry_job;

  perform public.write_admin_audit_log(
    'dead_letter_email_resent',
    'email_outbox_job',
    v_job.id,
    'success',
    null,
    jsonb_build_object(
      'retry_job_id', v_retry_job.id,
      'template_key', v_job.template_key,
      'recipient_email', v_job.recipient_email
    )
  );

  return v_retry_job;
end;
$$;

revoke all on function public.admin_retry_email_delivery(uuid) from public, anon;
grant execute on function public.admin_retry_email_delivery(uuid) to authenticated, service_role;

revoke all on function public.admin_retry_dead_letter_email_job(uuid) from public, anon;
grant execute on function public.admin_retry_dead_letter_email_job(uuid) to authenticated, service_role;
-- <<< END 20260320121130_create_admin_email_retry_rpc.sql

-- >>> BEGIN 20260320121200_track_generated_document_processing.sql
alter table public.generated_documents
add column if not exists status text not null default 'pending',
add column if not exists available_at timestamptz,
add column if not exists failure_reason text;

update public.generated_documents
set status = 'pending'
where status is null;

create index if not exists generated_documents_status_created_at_idx
on public.generated_documents (status, created_at desc);
-- <<< END 20260320121200_track_generated_document_processing.sql

-- >>> BEGIN 20260320121210_update_generated_document_record_helper.sql
create or replace function public.create_generated_document_record(
  p_booking_id uuid,
  p_document_type text,
  p_storage_path text
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_document_type text := lower(trim(coalesce(p_document_type, '')));
  v_storage_path text := trim(coalesce(p_storage_path, ''));
  v_result public.generated_documents;
begin
  if p_booking_id is null then
    raise exception 'Booking id is required';
  end if;

  if v_document_type not in ('payment_receipt', 'payout_receipt') then
    raise exception 'Unsupported generated document type';
  end if;

  if v_storage_path = '' then
    raise exception 'Generated document storage path is required';
  end if;

  if not public.is_service_role() and not public.is_admin() then
    raise exception 'Generated document creation requires privileged access';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_document_type = 'payment_receipt'
     and v_booking.payment_status not in ('secured', 'released_to_carrier') then
    raise exception 'Booking financial documents require secured payment';
  end if;

  if v_document_type = 'payout_receipt'
     and v_booking.payment_status <> 'released_to_carrier' then
    raise exception 'Payout receipt requires released payout state';
  end if;

  if v_storage_path !~ ('^generated/' || p_booking_id::text || '/' || replace(v_document_type, '_', '-') || '-v[0-9]+\.pdf$') then
    raise exception 'Generated document path does not match canonical format';
  end if;

  insert into public.generated_documents (
    booking_id,
    document_type,
    storage_path,
    version,
    generated_by,
    status,
    available_at,
    failure_reason
  ) values (
    p_booking_id,
    v_document_type,
    v_storage_path,
    (
      select coalesce(max(version), 0) + 1
      from public.generated_documents
      where booking_id = p_booking_id
        and document_type = v_document_type
    ),
    v_actor_id,
    'pending',
    null,
    null
  )
  returning * into v_result;

  return v_result;
end;
$$;
-- <<< END 20260320121210_update_generated_document_record_helper.sql

-- >>> BEGIN 20260320121220_add_generated_document_processing_locks.sql
alter table public.generated_documents
add column if not exists locked_at timestamptz,
add column if not exists locked_by text;

create index if not exists generated_documents_pending_lock_idx
on public.generated_documents (status, locked_at, created_at)
where status = 'pending';
-- <<< END 20260320121220_add_generated_document_processing_locks.sql

-- >>> BEGIN 20260320121230_create_generated_document_processing_rpc.sql
create or replace function public.claim_generated_document_jobs(
  p_worker_id text,
  p_batch_size integer default 5
)
returns setof public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_limit integer := greatest(1, least(coalesce(p_batch_size, 5), 25));
begin
  if not public.is_service_role() then
    raise exception 'Generated document claims require service role access';
  end if;

  return query
  with claimed as (
    update public.generated_documents as documents
    set locked_at = now(),
        locked_by = p_worker_id
    where documents.id in (
      select candidate.id
      from public.generated_documents as candidate
      where candidate.status = 'pending'
        and candidate.locked_at is null
      order by candidate.created_at
      limit v_limit
      for update skip locked
    )
    returning documents.*
  )
  select * from claimed;
end;
$$;

create or replace function public.complete_generated_document_processing(
  p_document_id uuid,
  p_content_type text,
  p_byte_size bigint,
  p_checksum_sha256 text
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_document public.generated_documents;
  v_booking public.bookings;
  v_recipient public.profiles;
  v_result public.generated_documents;
begin
  if not public.is_service_role() then
    raise exception 'Generated document completion requires service role access';
  end if;

  select * into v_document
  from public.generated_documents
  where id = p_document_id
  for update;

  if not found then
    raise exception 'Generated document not found';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_document.booking_id;

  if not found then
    raise exception 'Booking not found for generated document';
  end if;

  if v_document.document_type = 'payout_receipt' then
    select * into v_recipient
    from public.profiles
    where id = v_booking.carrier_id;
  else
    select * into v_recipient
    from public.profiles
    where id = v_booking.shipper_id;
  end if;

  update public.generated_documents
  set status = 'ready',
      content_type = left(nullif(trim(coalesce(p_content_type, '')), ''), 120),
      byte_size = greatest(coalesce(p_byte_size, 0), 0),
      checksum_sha256 = left(nullif(trim(coalesce(p_checksum_sha256, '')), ''), 128),
      available_at = now(),
      failure_reason = null,
      locked_at = null,
      locked_by = null
  where id = p_document_id
  returning * into v_result;

  if v_recipient.id is not null then
    insert into public.notifications (
      profile_id,
      type,
      title,
      body,
      data
    ) values (
      v_recipient.id,
      'generated_document_ready',
      'generated_document_ready_title',
      'generated_document_ready_body',
      jsonb_build_object(
        'booking_id', v_booking.id,
        'document_id', v_result.id,
        'document_type', v_result.document_type
      )
    );

    if nullif(trim(coalesce(v_recipient.email, '')), '') is not null then
      perform public.enqueue_transactional_email(
        'generated_document_available',
        v_recipient.id,
        lower(trim(v_recipient.email)),
        v_booking.id,
        'generated_document_available',
        null,
        jsonb_build_object(
          'booking_id', v_booking.id,
          'booking_reference', v_booking.tracking_number,
          'document_id', v_result.id,
          'document_type', v_result.document_type,
          'document_route', '/shared/generated-document/' || v_result.id::text
        ),
        'generated_document_available:' || v_result.id::text,
        'normal'
      );
    end if;
  end if;

  return v_result;
end;
$$;

create or replace function public.fail_generated_document_processing(
  p_document_id uuid,
  p_failure_reason text default null
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.generated_documents;
begin
  if not public.is_service_role() then
    raise exception 'Generated document failure updates require service role access';
  end if;

  update public.generated_documents
  set status = 'failed',
      failure_reason = left(nullif(trim(coalesce(p_failure_reason, '')), ''), 500),
      available_at = null,
      locked_at = null,
      locked_by = null
  where id = p_document_id
  returning * into v_result;

  if not found then
    raise exception 'Generated document not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.recover_stale_generated_document_jobs(
  p_lock_age_seconds integer default 900
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_recovered_count integer := 0;
  v_lock_age integer := greatest(60, least(coalesce(p_lock_age_seconds, 900), 86400));
begin
  if not public.is_service_role() then
    raise exception 'Generated document recovery requires service role access';
  end if;

  update public.generated_documents
  set locked_at = null,
      locked_by = null
  where status = 'pending'
    and locked_at is not null
    and locked_at < now() - make_interval(secs => v_lock_age);

  get diagnostics v_recovered_count = row_count;
  return v_recovered_count;
end;
$$;

revoke all on function public.claim_generated_document_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_generated_document_jobs(text, integer) to service_role;

revoke all on function public.complete_generated_document_processing(uuid, text, bigint, text) from public, anon, authenticated;
grant execute on function public.complete_generated_document_processing(uuid, text, bigint, text) to service_role;

revoke all on function public.fail_generated_document_processing(uuid, text) from public, anon, authenticated;
grant execute on function public.fail_generated_document_processing(uuid, text) to service_role;

revoke all on function public.recover_stale_generated_document_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_generated_document_jobs(integer) to service_role;
-- <<< END 20260320121230_create_generated_document_processing_rpc.sql

-- >>> BEGIN 20260321100000_close_release_gate_blockers.sql
do $$
begin
  if exists (select 1 from public.profiles where role is null) then
    raise exception 'profiles.role must be backfilled before setting NOT NULL';
  end if;
end;
$$;

alter table public.profiles
alter column role set not null;

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
  v_request_key text := nullif(trim(coalesce(p_idempotency_key, '')), '');
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

  if v_request_key is not null and char_length(v_request_key) > 120 then
    raise exception 'Idempotency key is too long';
  end if;

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

create or replace function public.admin_approve_payment_proof(
  p_payment_proof_id uuid,
  p_verified_amount_dzd numeric,
  p_verified_reference text default null,
  p_decision_note text default null
)
returns public.payment_proofs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_proof public.payment_proofs;
  v_booking public.bookings;
  v_result public.payment_proofs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Payment proof approval requires privileged access';
  end if;

  perform public.require_recent_admin_step_up();

  select * into v_proof
  from public.payment_proofs
  where id = p_payment_proof_id
  for update;

  if not found then
    raise exception 'Payment proof not found';
  end if;

  if v_proof.status <> 'pending' then
    raise exception 'Only pending payment proofs can be approved';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_proof.booking_id
  for update;

  if p_verified_amount_dzd <> v_booking.shipper_total_dzd then
    raise exception 'Verified amount must match the expected booking amount exactly';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.payment_proofs
  set status = 'verified',
      verified_amount_dzd = p_verified_amount_dzd,
      verified_reference = public.normalize_reference_value(p_verified_reference),
      decision_note = left(nullif(trim(p_decision_note), ''), 500),
      reviewed_by = (select auth.uid()),
      reviewed_at = now()
  where id = p_payment_proof_id
  returning * into v_result;

  update public.bookings
  set payment_status = 'secured',
      booking_status = 'confirmed',
      confirmed_at = now(),
      updated_at = now()
  where id = v_booking.id;

  insert into public.financial_ledger_entries (
    booking_id, entry_type, direction, amount_dzd, actor_type, reference, notes, created_by, occurred_at
  ) values
    (v_booking.id, 'payment_secured', 'credit', v_booking.shipper_total_dzd, 'shipper', v_booking.payment_reference, 'Payment secured', (select auth.uid()), now()),
    (v_booking.id, 'platform_fee_recorded', 'credit', v_booking.platform_fee_dzd, 'platform', v_booking.payment_reference, 'Platform fee recorded', (select auth.uid()), now()),
    (v_booking.id, 'insurance_fee_recorded', 'credit', v_booking.insurance_fee_dzd, 'platform', v_booking.payment_reference, 'Insurance fee recorded', (select auth.uid()), now());

  perform public.create_generated_document_record(
    v_booking.id,
    'payment_receipt',
    format('generated/%s/payment-receipt-v1.pdf', v_booking.id)
  );

  insert into public.tracking_events (
    booking_id, event_type, visibility, note, created_by, recorded_at
  ) values (
    v_booking.id,
    'confirmed',
    'user_visible',
    'Payment secured and booking confirmed.',
    (select auth.uid()),
    now()
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values
    (
      v_booking.shipper_id,
      'payment_secured',
      'payment_secured_title',
      'payment_secured_body',
      jsonb_build_object('booking_id', v_booking.id, 'payment_proof_id', v_result.id)
    ),
    (
      v_booking.carrier_id,
      'payment_secured',
      'payment_secured_title',
      'payment_secured_body',
      jsonb_build_object('booking_id', v_booking.id, 'payment_proof_id', v_result.id)
    );

  perform public.enqueue_transactional_email(
    'payment_secured',
    v_booking.shipper_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.shipper_id
    ),
    v_booking.id,
    'payment_secured',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payment_proof_id', v_result.id
    ),
    'payment_secured:shipper:' || v_result.id::text,
    'high'
  );

  perform public.enqueue_transactional_email(
    'payment_secured',
    v_booking.carrier_id,
    (
      select lower(trim(email))
      from public.profiles
      where id = v_booking.carrier_id
    ),
    v_booking.id,
    'payment_secured',
    null,
    jsonb_build_object(
      'booking_id', v_booking.id,
      'booking_reference', v_booking.tracking_number,
      'payment_proof_id', v_result.id
    ),
    'payment_secured:carrier:' || v_result.id::text,
    'high'
  );

  perform public.write_admin_audit_log(
    'payment_proof_approved',
    'payment_proof',
    v_result.id,
    'success',
    left(nullif(trim(p_decision_note), ''), 500),
    jsonb_build_object(
      'booking_id', v_booking.id,
      'verified_amount_dzd', p_verified_amount_dzd,
      'verified_reference', public.normalize_reference_value(p_verified_reference)
    )
  );

  perform set_config('app.trusted_operation', 'false', true);
  return v_result;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.create_upload_session(
  p_upload_kind text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_file_extension text,
  p_content_type text,
  p_byte_size bigint,
  p_checksum_sha256 text default null
)
returns table (
  upload_session_id uuid,
  bucket_id text,
  object_path text,
  expires_at timestamptz,
  max_file_size_bytes bigint
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := (select auth.uid());
  v_bucket_id text;
  v_entity_type text := trim(lower(p_entity_type));
  v_document_type text := trim(lower(coalesce(p_document_type, '')));
  v_version integer;
  v_object_path text;
  v_session_id uuid := gen_random_uuid();
  v_expires_at timestamptz := now() + interval '15 minutes';
  v_owner_profile_id uuid;
  v_max_file_size bigint := 10485760;
begin
  if v_profile_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_content_type not in ('image/jpeg', 'image/png', 'application/pdf') then
    raise exception 'Unsupported content type';
  end if;

  if p_byte_size <= 0 or p_byte_size > v_max_file_size then
    raise exception 'File size exceeds the allowed limit';
  end if;

  if trim(lower(p_upload_kind)) = 'payment_proof' then
    perform public.assert_rate_limit('proof_upload', 10, 3600);
    v_bucket_id := 'payment-proofs';

    if v_entity_type <> 'booking' then
      raise exception 'Payment proof uploads must target a booking';
    end if;

    if not public.booking_owned_by_current_shipper(p_entity_id) then
      raise exception 'You cannot upload proof for this booking';
    end if;

    if v_document_type not in ('ccp', 'dahabia', 'bank') then
      raise exception 'Payment proof document type must be a payment rail';
    end if;

    select coalesce(max(pp.version), 0) + 1
    into v_version
    from public.payment_proofs as pp
    where pp.booking_id = p_entity_id;

    v_owner_profile_id := v_profile_id;
  elsif trim(lower(p_upload_kind)) = 'verification_document' then
    perform public.assert_rate_limit('verification_document_upload', 20, 3600);
    v_bucket_id := 'verification-documents';

    if v_document_type not in (
      'driver_identity_or_license',
      'truck_registration',
      'truck_insurance',
      'truck_technical_inspection'
    ) then
      raise exception 'Unsupported verification document type';
    end if;

    if v_entity_type = 'profile' then
      if p_entity_id <> v_profile_id then
        raise exception 'Profile verification documents must target the current user';
      end if;
      v_owner_profile_id := v_profile_id;
    elsif v_entity_type = 'vehicle' then
      if not public.vehicle_owned_by_current_carrier(p_entity_id) then
        raise exception 'Vehicle verification documents must target your own vehicle';
      end if;
      select v.carrier_id into v_owner_profile_id
      from public.vehicles as v
      where v.id = p_entity_id;
    else
      raise exception 'Unsupported verification entity type';
    end if;

    select coalesce(max(vd.version), 0) + 1
    into v_version
    from public.verification_documents as vd
    where vd.entity_type::text = v_entity_type
      and vd.entity_id = p_entity_id
      and vd.document_type = v_document_type;
  elsif trim(lower(p_upload_kind)) = 'dispute_evidence' then
    perform public.assert_rate_limit('dispute_evidence_upload', 20, 3600);
    v_bucket_id := 'dispute-evidence';

    if v_entity_type <> 'dispute' then
      raise exception 'Dispute evidence uploads must target a dispute';
    end if;

    select case when d.opened_by = v_profile_id then d.opened_by when b.carrier_id = v_profile_id then v_profile_id else null end
    into v_owner_profile_id
    from public.disputes as d
    join public.bookings as b on b.id = d.booking_id
    where d.id = p_entity_id
      and d.status = 'open'
      and (d.opened_by = v_profile_id or b.carrier_id = v_profile_id);

    if not found or v_owner_profile_id is null then
      raise exception 'You cannot upload evidence for this dispute';
    end if;

    select coalesce(max(de.version), 0) + 1
    into v_version
    from public.dispute_evidence as de
    where de.dispute_id = p_entity_id;

    v_document_type := 'evidence';
  else
    raise exception 'Unsupported upload kind';
  end if;

  v_object_path := public.build_upload_object_path(
    v_bucket_id,
    v_entity_type,
    p_entity_id,
    v_document_type,
    v_version,
    p_file_extension
  );

  insert into public.upload_sessions (
    id,
    profile_id,
    bucket_id,
    object_path,
    entity_type,
    entity_id,
    document_type,
    content_type,
    byte_size,
    checksum_sha256,
    expires_at
  )
  values (
    v_session_id,
    v_owner_profile_id,
    v_bucket_id,
    v_object_path,
    v_entity_type,
    p_entity_id,
    v_document_type,
    p_content_type,
    p_byte_size,
    p_checksum_sha256,
    v_expires_at
  );

  return query
  select v_session_id, v_bucket_id, v_object_path, v_expires_at, v_max_file_size;
end;
$$;

create or replace function public.record_email_provider_event(
  p_provider_message_id text,
  p_status public.email_delivery_status,
  p_error_code text default null,
  p_error_message text default null
)
returns public.email_delivery_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_latest public.email_delivery_logs;
  v_current_rank integer;
  v_next_rank integer;
  v_result public.email_delivery_logs;
begin
  if not public.is_service_role() then
    raise exception 'Email provider events require service role access';
  end if;

  select * into v_latest
  from public.email_delivery_logs
  where provider_message_id = p_provider_message_id
  order by
    case status
      when 'queued' then 0
      when 'sent' then 1
      when 'delivered' then 2
      when 'opened' then 3
      when 'clicked' then 4
      when 'soft_failed' then 5
      when 'hard_failed' then 6
      when 'bounced' then 7
      when 'suppressed' then 8
      else 0
    end desc,
    created_at desc,
    id desc
  limit 1;

  if not found then
    raise exception 'Email delivery log not found for provider message';
  end if;

  v_next_rank := case p_status
    when 'queued' then 0 when 'sent' then 1 when 'delivered' then 2 when 'opened' then 3 when 'clicked' then 4 when 'soft_failed' then 5 when 'hard_failed' then 6 when 'bounced' then 7 when 'suppressed' then 8 else 0 end;
  v_current_rank := case v_latest.status
    when 'queued' then 0 when 'sent' then 1 when 'delivered' then 2 when 'opened' then 3 when 'clicked' then 4 when 'soft_failed' then 5 when 'hard_failed' then 6 when 'bounced' then 7 when 'suppressed' then 8 else 0 end;

  if v_next_rank < v_current_rank then
    return v_latest;
  end if;

  insert into public.email_delivery_logs (
    profile_id, booking_id, template_key, locale, recipient_email, subject_preview,
    provider_message_id, status, provider, attempt_count, last_attempt_at,
    next_retry_at, last_error_at, error_code, error_message, payload_snapshot
  ) values (
    v_latest.profile_id, v_latest.booking_id, v_latest.template_key, v_latest.locale,
    v_latest.recipient_email, v_latest.subject_preview, v_latest.provider_message_id,
    p_status, v_latest.provider, greatest(v_latest.attempt_count, 1), now(),
    v_latest.next_retry_at,
    case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then now() else null end,
    case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_code, 120) else null end,
    case when p_status in ('soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_message, 500) else null end,
    v_latest.payload_snapshot
  ) returning * into v_result;

  return v_result;
end;
$$;
-- <<< END 20260321100000_close_release_gate_blockers.sql
