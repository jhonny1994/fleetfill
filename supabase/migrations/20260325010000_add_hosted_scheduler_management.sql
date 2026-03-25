create extension if not exists pg_cron;
create extension if not exists pg_net;

create or replace function public.configure_scheduled_automation(
  project_url text,
  bearer_token text
)
returns void
language plpgsql
security definer
set search_path = public, extensions
as $$
begin
  if coalesce(project_url, '') = '' then
    raise exception 'project_url is required';
  end if;

  if coalesce(bearer_token, '') = '' then
    raise exception 'bearer_token is required';
  end if;

  create extension if not exists pg_cron;
  create extension if not exists pg_net;

  delete from vault.secrets
  where name in ('fleetfill_project_url', 'fleetfill_service_role_key');

  perform vault.create_secret(
    project_url,
    'fleetfill_project_url',
    'FleetFill scheduled automation project URL'
  );

  perform vault.create_secret(
    bearer_token,
    'fleetfill_service_role_key',
    'FleetFill scheduled automation bearer token'
  );

  perform cron.unschedule(jobid)
  from cron.job
  where jobname = 'fleetfill-scheduled-automation-tick';

  perform cron.schedule(
    'fleetfill-scheduled-automation-tick',
    '* * * * *',
    $cron$
    select
      net.http_post(
        url := (select decrypted_secret from vault.decrypted_secrets where name = 'fleetfill_project_url') || '/functions/v1/scheduled-automation-tick',
        headers := jsonb_build_object(
          'Content-Type', 'application/json',
          'Authorization', 'Bearer ' || (select decrypted_secret from vault.decrypted_secrets where name = 'fleetfill_service_role_key')
        ),
        body := jsonb_build_object('source', 'pg_cron')
      );
    $cron$
  );
end;
$$;

revoke all on function public.configure_scheduled_automation(text, text) from public;
grant execute on function public.configure_scheduled_automation(text, text) to service_role;

create or replace function public.scheduled_automation_status()
returns table (
  jobname text,
  schedule text,
  active boolean
)
language sql
security definer
set search_path = public, extensions
as $$
  select
    j.jobname::text,
    j.schedule::text,
    true as active
  from cron.job as j
  where j.jobname = 'fleetfill-scheduled-automation-tick';
$$;

revoke all on function public.scheduled_automation_status() from public;
grant execute on function public.scheduled_automation_status() to service_role;
