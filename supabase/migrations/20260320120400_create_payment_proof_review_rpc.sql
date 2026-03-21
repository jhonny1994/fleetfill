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

  if v_document_type not in ('booking_invoice', 'payment_receipt', 'payout_receipt') then
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

  if v_document_type in ('booking_invoice', 'payment_receipt')
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
