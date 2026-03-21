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
