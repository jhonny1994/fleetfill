# Tooling

This folder is the execution layer of the FleetFill production system.

The repo now follows a clear three-layer model:

1. GitHub Actions is the production control plane.
2. `tool/` scripts are the repo-owned execution layer.
3. local helpers exist for maintenance and fallback, but they are not the primary production buttons.

## Production Executors

These scripts are part of the official production path. GitHub Actions calls them or relies on the behavior they encode.

- `sync_supabase_cloud_secrets.ps1`
  - syncs the required Supabase Edge Function secrets from root `.env`
- `apply_supabase_scheduler.ps1`
  - installs or refreshes the hosted scheduler configuration
- `verify_hosted_rollout.ps1`
  - verifies the live hosted Supabase and admin-web surfaces
- `sync_admin_vercel_env.ps1`
  - synchronizes admin-web public runtime values into Vercel production

These are implementation, not shadow ops.

## Operator Helpers

These scripts are still useful, but they are helper-level, not the canonical production entrypoint.

- `workspace.ps1`
  - lightweight local workspace runner for human operators
  - validates `mobile`, `admin-web`, `supabase`, or `all`
  - intentionally stays small and explicit instead of introducing a heavy monorepo framework
- `deploy_supabase_cloud.ps1`
  - local convenience wrapper around the Supabase production rollout steps
  - useful for local operator execution and fallback
  - no longer the primary production control surface now that GitHub Actions owns rollout selection
- `sync_github_production_config.ps1`
  - syncs GitHub production variables and secrets from local config
  - useful when rotating or bootstrapping repository-level deployment configuration
- `create_admin_account.ps1`
  - creates or reuses a hosted auth user, upserts the admin profile, and grants the requested admin role

## Internal Helpers

These support executors or maintenance flows and are not direct operator-facing release entrypoints.

- `run_remote_sql.mjs`
  - internal helper used by scheduler setup
- `locations/generate_supabase_location_seed.dart`
- `locations/import_locations.dart`

## Production Rule

- Do not add throwaway rollout experiments here.
- If a script is production-critical, document which workflow or operation depends on it.
- If a script is only for local convenience, say so explicitly.
- If a script is no longer part of the active delivery path, remove it or archive it before shipping.
