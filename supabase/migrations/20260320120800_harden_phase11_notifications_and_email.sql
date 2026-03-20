create or replace function public.normalize_supported_locale(
  p_locale text
)
returns text
language sql
immutable
set search_path = public
as $$
  select case lower(trim(coalesce(p_locale, '')))
    when 'ar' then 'ar'
    when 'fr' then 'fr'
    when 'en' then 'en'
    else 'en'
  end;
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
      select public.normalize_supported_locale(locale)
      from public.user_devices
      where profile_id = p_profile_id
        and nullif(trim(locale), '') is not null
      order by last_seen_at desc nulls last, updated_at desc, created_at desc
      limit 1
    ),
    'en'
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
