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
  v_locale text := public.normalize_supported_locale(
    coalesce(
      nullif(trim(p_locale), ''),
      public.get_profile_preferred_locale(p_profile_id),
      'en'
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
