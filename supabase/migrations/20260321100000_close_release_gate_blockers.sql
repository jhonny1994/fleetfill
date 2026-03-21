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
    'booking_invoice',
    format('generated/%s/booking-invoice-v1.pdf', v_booking.id)
  );
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
      'truck_technical_inspection',
      'transport_license'
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
