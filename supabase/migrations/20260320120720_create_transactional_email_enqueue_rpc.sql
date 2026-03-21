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

revoke all on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) from public, anon;
grant execute on function public.enqueue_transactional_email(text, uuid, text, uuid, text, text, jsonb, text, text) to authenticated, service_role;
