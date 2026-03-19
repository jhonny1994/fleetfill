create or replace function public.write_admin_audit_log(
  p_action text,
  p_target_type text,
  p_target_id uuid,
  p_outcome text,
  p_reason text default null,
  p_metadata jsonb default '{}'::jsonb
)
returns public.admin_audit_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.admin_audit_logs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin audit log writes require privileged execution';
  end if;

  insert into public.admin_audit_logs (
    actor_id,
    actor_role,
    action,
    target_type,
    target_id,
    outcome,
    reason,
    correlation_id,
    metadata
  )
  values (
    (select auth.uid()),
    public.current_user_role(),
    p_action,
    p_target_type,
    p_target_id,
    p_outcome,
    p_reason,
    gen_random_uuid()::text,
    p_metadata
  )
  returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.claim_email_outbox_jobs(
  p_worker_id text,
  p_batch_size integer default 10
)
returns setof public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_limit integer := greatest(1, least(coalesce(p_batch_size, 10), 50));
begin
  if not public.is_service_role() then
    raise exception 'Email outbox claims require service role access';
  end if;

  return query
  with claimed as (
    update public.email_outbox_jobs as jobs
    set status = 'processing',
        locked_at = now(),
        locked_by = p_worker_id,
        updated_at = now()
    where jobs.id in (
      select candidate.id
      from public.email_outbox_jobs as candidate
      where candidate.status in ('queued', 'retry_scheduled')
        and candidate.available_at <= now()
      order by
        case candidate.priority
          when 'critical' then 0
          when 'high' then 1
          when 'normal' then 2
          else 3
        end,
        candidate.available_at,
        candidate.created_at
      limit v_limit
      for update skip locked
    )
    returning jobs.*
  )
  select * from claimed;
end;
$$;

create or replace function public.release_retryable_email_job(
  p_job_id uuid,
  p_error_code text,
  p_error_message text,
  p_retry_delay_seconds integer default 300
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_outbox_jobs;
  v_delay integer := greatest(60, least(coalesce(p_retry_delay_seconds, 300), 86400));
begin
  if not public.is_service_role() then
    raise exception 'Retry scheduling requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = case
        when attempt_count + 1 >= max_attempts then 'dead_letter'::public.email_outbox_status
        else 'retry_scheduled'::public.email_outbox_status
      end,
      attempt_count = attempt_count + 1,
      available_at = case
        when attempt_count + 1 >= max_attempts then available_at
        else now() + make_interval(secs => v_delay)
      end,
      locked_at = null,
      locked_by = null,
      last_error_code = left(coalesce(p_error_code, 'unknown_error'), 120),
      last_error_message = left(coalesce(p_error_message, 'Unknown email provider failure'), 500),
      updated_at = now()
  where id = p_job_id
  returning * into v_result;

  if not found then
    raise exception 'Email outbox job not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.complete_email_outbox_job(
  p_job_id uuid,
  p_provider text,
  p_provider_message_id text default null,
  p_subject_preview text default null
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.email_outbox_jobs;
begin
  if not public.is_service_role() then
    raise exception 'Email outbox completion requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = 'sent_to_provider',
      attempt_count = attempt_count + 1,
      locked_at = null,
      locked_by = null,
      last_error_code = null,
      last_error_message = null,
      updated_at = now()
  where id = p_job_id
  returning * into v_job;

  if not found then
    raise exception 'Email outbox job not found';
  end if;

  insert into public.email_delivery_logs (
    profile_id,
    booking_id,
    template_key,
    locale,
    recipient_email,
    subject_preview,
    provider_message_id,
    status,
    provider,
    attempt_count,
    last_attempt_at,
    payload_snapshot
  )
  values (
    v_job.profile_id,
    v_job.booking_id,
    v_job.template_key,
    v_job.locale,
    v_job.recipient_email,
    p_subject_preview,
    p_provider_message_id,
    'sent',
    left(coalesce(p_provider, 'provider'), 120),
    v_job.attempt_count,
    now(),
    v_job.payload_snapshot
  )
  on conflict do nothing
  ;

  return v_job;
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
    when 'soft_failed' then 3
    when 'hard_failed' then 4
    when 'bounced' then 5
    when 'suppressed' then 6
    else 0
  end;

  select case status
    when 'queued' then 0
    when 'sent' then 1
    when 'delivered' then 2
    when 'soft_failed' then 3
    when 'hard_failed' then 4
    when 'bounced' then 5
    when 'suppressed' then 6
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

create or replace function public.recover_stale_email_outbox_jobs(
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
    raise exception 'Outbox recovery requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = 'retry_scheduled',
      locked_at = null,
      locked_by = null,
      available_at = now(),
      updated_at = now()
  where status = 'processing'
    and locked_at is not null
    and locked_at < now() - make_interval(secs => v_lock_age);

  get diagnostics v_recovered_count = row_count;
  return v_recovered_count;
end;
$$;
