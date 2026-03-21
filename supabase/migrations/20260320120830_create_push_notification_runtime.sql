create table if not exists public.push_outbox_jobs (
  id uuid primary key default gen_random_uuid(),
  notification_id uuid not null unique references public.notifications (id) on delete cascade,
  profile_id uuid not null references public.profiles (id),
  event_key text not null,
  dedupe_key text not null unique,
  title text not null,
  body text not null,
  payload_snapshot jsonb,
  status text not null default 'queued' check (status in ('queued', 'processing', 'sent', 'skipped', 'dead_letter')),
  attempt_count integer not null default 0,
  max_attempts integer not null default 5,
  available_at timestamptz not null default now(),
  locked_at timestamptz,
  locked_by text,
  provider text,
  provider_message_id text,
  last_error_code text,
  last_error_message text,
  delivered_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists push_outbox_jobs_status_available_at_idx
on public.push_outbox_jobs (status, available_at);

create index if not exists push_outbox_jobs_profile_id_idx
on public.push_outbox_jobs (profile_id);

alter table public.push_outbox_jobs enable row level security;

drop policy if exists push_outbox_jobs_admin_only on public.push_outbox_jobs;
create policy push_outbox_jobs_admin_only
on public.push_outbox_jobs for select to authenticated
using (public.is_admin());

create or replace trigger push_outbox_jobs_set_updated_at
before update on public.push_outbox_jobs
for each row execute function public.set_updated_at();

create or replace function public.enqueue_push_job_from_notification()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.push_outbox_jobs (
    notification_id,
    profile_id,
    event_key,
    dedupe_key,
    title,
    body,
    payload_snapshot
  ) values (
    new.id,
    new.profile_id,
    new.type,
    'notification:' || new.id::text,
    new.title,
    new.body,
    coalesce(new.data, '{}'::jsonb) || jsonb_build_object(
      'notification_id', new.id,
      'route', '/shared/notification/' || new.id::text
    )
  ) on conflict (dedupe_key) do nothing;

  return new;
end;
$$;

drop trigger if exists notifications_enqueue_push_job on public.notifications;
create trigger notifications_enqueue_push_job
after insert on public.notifications
for each row execute function public.enqueue_push_job_from_notification();

create or replace function public.claim_push_outbox_jobs(
  p_worker_id text,
  p_batch_size integer default 10
)
returns setof public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_service_role() then
    raise exception 'Push job claiming requires service role access';
  end if;

  return query
  with claimed as (
    update public.push_outbox_jobs as jobs
    set status = 'processing',
        locked_at = now(),
        locked_by = left(trim(p_worker_id), 120),
        updated_at = now()
    where jobs.id in (
      select candidate.id
      from public.push_outbox_jobs as candidate
      where candidate.status = 'queued'
        and candidate.available_at <= now()
      order by candidate.available_at asc, candidate.created_at asc
      limit greatest(1, least(coalesce(p_batch_size, 10), 25))
      for update skip locked
    )
    returning jobs.*
  )
  select * from claimed;
end;
$$;

create or replace function public.complete_push_outbox_job(
  p_job_id uuid,
  p_status text default 'sent',
  p_provider text default null,
  p_provider_message_id text default null,
  p_error_code text default null,
  p_error_message text default null
)
returns public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.push_outbox_jobs;
begin
  if not public.is_service_role() then
    raise exception 'Push job completion requires service role access';
  end if;

  if p_status not in ('sent', 'skipped') then
    raise exception 'Unsupported push completion status';
  end if;

  update public.push_outbox_jobs
  set status = p_status,
      provider = coalesce(nullif(trim(p_provider), ''), provider),
      provider_message_id = coalesce(nullif(trim(p_provider_message_id), ''), provider_message_id),
      last_error_code = nullif(trim(coalesce(p_error_code, '')), ''),
      last_error_message = nullif(trim(coalesce(p_error_message, '')), ''),
      delivered_at = case when p_status = 'sent' then now() else delivered_at end,
      locked_at = null,
      locked_by = null,
      updated_at = now()
  where id = p_job_id
  returning * into v_result;

  if not found then
    raise exception 'Push outbox job not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.release_retryable_push_job(
  p_job_id uuid,
  p_error_code text default null,
  p_error_message text default null,
  p_retry_delay_seconds integer default 300
)
returns public.push_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.push_outbox_jobs;
  v_attempt_count integer;
begin
  if not public.is_service_role() then
    raise exception 'Push retry scheduling requires service role access';
  end if;

  select * into v_job
  from public.push_outbox_jobs
  where id = p_job_id
  for update;

  if not found then
    raise exception 'Push outbox job not found';
  end if;

  v_attempt_count := v_job.attempt_count + 1;

  update public.push_outbox_jobs
  set attempt_count = v_attempt_count,
      status = case when v_attempt_count >= v_job.max_attempts then 'dead_letter' else 'queued' end,
      available_at = case
        when v_attempt_count >= v_job.max_attempts then v_job.available_at
        else now() + make_interval(secs => greatest(30, least(coalesce(p_retry_delay_seconds, 300), 3600)))
      end,
      locked_at = null,
      locked_by = null,
      last_error_code = nullif(trim(coalesce(p_error_code, '')), ''),
      last_error_message = left(nullif(trim(coalesce(p_error_message, '')), ''), 500),
      updated_at = now()
  where id = p_job_id
  returning * into v_job;

  return v_job;
end;
$$;

create or replace function public.recover_stale_push_outbox_jobs(
  p_lock_age_seconds integer default 900
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_count integer := 0;
begin
  if not public.is_service_role() then
    raise exception 'Push stale job recovery requires service role access';
  end if;

  update public.push_outbox_jobs
  set status = 'queued',
      locked_at = null,
      locked_by = null,
      updated_at = now()
  where status = 'processing'
    and locked_at < now() - make_interval(secs => greatest(60, coalesce(p_lock_age_seconds, 900)));

  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

revoke all on function public.claim_push_outbox_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_push_outbox_jobs(text, integer) to service_role;

revoke all on function public.complete_push_outbox_job(uuid, text, text, text, text, text) from public, anon, authenticated;
grant execute on function public.complete_push_outbox_job(uuid, text, text, text, text, text) to service_role;

revoke all on function public.release_retryable_push_job(uuid, text, text, integer) from public, anon, authenticated;
grant execute on function public.release_retryable_push_job(uuid, text, text, integer) to service_role;

revoke all on function public.recover_stale_push_outbox_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_push_outbox_jobs(integer) to service_role;
