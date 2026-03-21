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

create unique index if not exists payouts_booking_unique_idx
on public.payouts (booking_id);

create unique index if not exists payout_accounts_one_active_per_carrier_idx
on public.payout_accounts (carrier_id)
where is_active = true;
