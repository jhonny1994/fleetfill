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

create or replace function public.enqueue_transactional_email(
  p_event_key text,
  p_profile_id uuid,
  p_recipient_email text,
  p_booking_id uuid default null,
  p_template_key text default null,
  p_locale text default 'en',
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
    coalesce(nullif(trim(p_locale), ''), 'en'),
    trim(p_recipient_email),
    coalesce(nullif(trim(p_priority), ''), 'normal'),
    'queued',
    now(),
    coalesce(p_payload_snapshot, '{}'::jsonb)
  ) returning * into v_result;

  return v_result;
end;
$$;

create unique index if not exists user_devices_profile_push_token_idx
on public.user_devices (profile_id, push_token);

revoke all on function public.submit_carrier_review(uuid, integer, text) from public, anon;
grant execute on function public.submit_carrier_review(uuid, integer, text) to authenticated, service_role;

revoke all on function public.register_user_device(text, text, text) from public, anon;
grant execute on function public.register_user_device(text, text, text) to authenticated, service_role;

revoke all on function public.mark_notification_read(uuid) from public, anon;
grant execute on function public.mark_notification_read(uuid) to authenticated, service_role;

revoke all on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) from public, anon;
grant execute on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) to authenticated, service_role;
