create or replace function public.enqueue_support_request_emails(
  p_locale text default null,
  p_subject text default null,
  p_message text default null,
  p_support_inbox_email text default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_actor_email text := lower(trim(coalesce(auth.email(), '')));
  v_locale text := public.normalize_supported_locale(p_locale);
  v_subject text := left(nullif(trim(coalesce(p_subject, '')), ''), 160);
  v_message text := left(nullif(trim(coalesce(p_message, '')), ''), 4000);
  v_support_inbox text := lower(trim(coalesce(p_support_inbox_email, '')));
  v_ack_job_id uuid;
  v_forward_job_id uuid;
begin
  if v_actor_id is null or v_actor_email = '' then
    raise exception 'authentication_required';
  end if;

  if v_subject is null or v_message is null then
    raise exception 'Support subject and message are required';
  end if;

  if v_support_inbox = '' then
    raise exception 'Support inbox is required';
  end if;

  perform public.assert_rate_limit(
    'support-email-dispatch:' || v_actor_id::text,
    3,
    3600
  );

  insert into public.email_outbox_jobs (
    event_key,
    dedupe_key,
    profile_id,
    template_key,
    locale,
    recipient_email,
    priority,
    status,
    available_at,
    payload_snapshot
  ) values (
    'support_acknowledgement',
    'support_ack:' || v_actor_id::text || ':' || gen_random_uuid()::text,
    v_actor_id,
    'support_acknowledgement',
    v_locale,
    v_actor_email,
    'high',
    'queued',
    now(),
    jsonb_build_object(
      'subject', v_subject,
      'message', v_message
    )
  )
  returning id into v_ack_job_id;

  insert into public.email_outbox_jobs (
    event_key,
    dedupe_key,
    profile_id,
    template_key,
    locale,
    recipient_email,
    priority,
    status,
    available_at,
    payload_snapshot
  ) values (
    'support_request_forwarded',
    'support_forward:' || v_actor_id::text || ':' || gen_random_uuid()::text,
    v_actor_id,
    'support_request_forwarded',
    v_locale,
    v_support_inbox,
    'high',
    'queued',
    now(),
    jsonb_build_object(
      'subject', v_subject,
      'message', v_message,
      'sender_email', v_actor_email,
      'profile_id', v_actor_id
    )
  )
  returning id into v_forward_job_id;

  return jsonb_build_object(
    'acknowledgement_job_id', v_ack_job_id,
    'forward_job_id', v_forward_job_id,
    'status', 'queued'
  );
end;
$$;

revoke all on function public.enqueue_support_request_emails(text, text, text, text) from public, anon;
grant execute on function public.enqueue_support_request_emails(text, text, text, text) to authenticated, service_role;
