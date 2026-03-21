-- Run this script in the target Supabase project after pg_cron, pg_net,
-- and Vault secrets are available.
--
-- Required Vault secret names:
-- - fleetfill_project_url
-- - fleetfill_service_role_key

create extension if not exists pg_cron;
create extension if not exists pg_net;

select cron.unschedule(jobid)
from cron.job
where jobname = 'fleetfill-scheduled-automation-tick';

select cron.schedule(
  'fleetfill-scheduled-automation-tick',
  '* * * * *',
  $$
  select
    net.http_post(
      url := (select decrypted_secret from vault.decrypted_secrets where name = 'fleetfill_project_url') || '/functions/v1/scheduled-automation-tick',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (select decrypted_secret from vault.decrypted_secrets where name = 'fleetfill_service_role_key')
      ),
      body := jsonb_build_object('source', 'pg_cron')
    );
  $$
);
