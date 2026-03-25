# Tooling

This folder contains active operational scripts for FleetFill.

## Active Production Scripts

- `deploy_supabase_cloud.ps1`
  - pushes the hosted backend, syncs secrets, deploys Edge Functions, syncs Vercel env, and runs hosted verification
- `verify_hosted_rollout.ps1`
  - checks the live cloud function surface and the live admin site
- `sync_github_production_config.ps1`
  - syncs production GitHub variables and secrets from local project config
- `sync_supabase_cloud_secrets.ps1`
  - syncs the required Edge Function secrets from root `.env`
- `sync_admin_vercel_env.ps1`
  - syncs the admin-web public runtime values into Vercel production
- `apply_supabase_scheduler.ps1`
  - installs the hosted cron/scheduler SQL when `SUPABASE_DB_URL` is available
- `run_remote_sql.mjs`
  - internal helper used by the scheduler setup

## Support Scripts

- `locations/generate_supabase_location_seed.dart`
- `locations/import_locations.dart`

## Rule

Do not leave throwaway rollout experiments here. If a script is not part of the active delivery path, remove it or archive it before shipping.
