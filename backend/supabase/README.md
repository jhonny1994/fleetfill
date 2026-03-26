# Supabase Backend Layout

This directory holds the FleetFill backend foundation for Supabase.

## Migrations

During the current dev phase, FleetFill uses a rebaselined layer-migration posture instead of keeping a long stack of fixup migrations.

Current local baseline:

- `migrations/20260317010000_create_foundation_layer.sql`
- `migrations/20260317020000_create_verification_and_capacity_layer.sql`
- `migrations/20260317030000_create_operational_workflows_layer.sql`

Rules:

- dev-only schema history should be consolidated into canonical layer migrations instead of adding fixup migrations on top of fixup migrations
- if a concern is still in dev and not yet externally canonical, edit the owning layer migration directly
- keep layer ordering stable: foundation first, then verification/capacity, then operational workflows
- once the project leaves dev-phase rebaseline work, resume normal forward-only migrations for released environments

## Seed Data

- target best practice is deterministic local seeding through `backend/supabase/seed.sql` or `backend/supabase/seeds/`
- FleetFill seeds locations from `backend/supabase/seeds/locations.sql`, generated from the canonical JSON in `data/locations/wilayas-with-municipalities.json`
- local resets automatically seed locations because `backend/supabase/config.toml` includes both `./seed.sql` and `./seeds/locations.sql` under `[db.seed]`
- hosted rollouts should apply the same deterministic seed with `supabase db push --linked --include-seed`; this is now the default behavior in [C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1](C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1)
- regenerate the SQL seed with:
  - `dart run tool/locations/generate_supabase_location_seed.dart`
- the importer below remains available as maintenance tooling, not the primary local bootstrap path
- `tool/locations/import_locations.dart`
  - reads `data/locations/wilayas-with-municipalities.json` directly
  - clears `public.communes` first, then `public.wilayas`
  - imports wilayas as `id`, `name`, and `name_ar`
  - imports communes as `id`, `wilaya_id`, `name`, and `name_ar`
  - prints each commune missing a canonical `id` and continues without failing the whole import

Run it locally with:

  - `dart run tool/locations/import_locations.dart`

## Auth Providers

- email/password
  - available by default in local Supabase auth
  - no extra provider block is required just to enable sign-in with password
- Google sign-in
  - configure `[auth.external.google]` in `backend/supabase/config.toml`
  - keep the Google client ID and secret in root `.env` variables via `env(...)`
  - local callback URI should be `http://127.0.0.1:54321/auth/v1/callback`
  - mobile deep link callback remains allowed through `additional_redirect_urls = ["fleetfill://auth-callback"]`

Example root `.env` entries:

- `SUPABASE_URL=https://your-project-ref.supabase.co`
- `SUPABASE_PUBLISHABLE_KEY=...`
- `SUPABASE_ANON_KEY=...` (local CLI/self-hosted only)
- `SUPABASE_SECRET_KEY=...`
- `INTERNAL_AUTOMATION_TOKEN=...`
- `SUPABASE_DB_URL=...` (needed only when applying repo-owned scheduler SQL directly to the hosted database)
- `MAINTENANCE_MODE=false`
- `FORCE_UPDATE_REQUIRED=false`
- `CRASH_REPORTING_ENABLED=false`
- `SUPPORT_EMAIL=support@example.com`
- `SUPPORT_EMAIL_TO=support@example.com`
- `PUSH_NOTIFICATIONS_ENABLED=true`
- `PUSH_NOTIFICATIONS_PROVIDER=fcm_v1`
- `FIREBASE_SERVICE_ACCOUNT_JSON={...}`
- `TRANSACTIONAL_EMAIL_PROVIDER=your-provider-key`
  - `TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT=https://api.your-provider.example/send`
- `TRANSACTIONAL_EMAIL_PROVIDER_API_KEY=...`
- `TRANSACTIONAL_EMAIL_FROM_EMAIL=no-reply@example.com`
- `TRANSACTIONAL_EMAIL_FROM_NAME=FleetFill`
- `TRANSACTIONAL_EMAIL_MOCK_MODE=false`
- `TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET=...`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID=your-google-web-client-id`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET=your-google-client-secret`

Notes:

- The mobile app prefers `SUPABASE_ANON_KEY` for local CLI/self-hosted targets and `SUPABASE_PUBLISHABLE_KEY` for hosted targets, with fallback only when one key is intentionally absent.
- `SUPABASE_SECRET_KEY` is the repo-facing privileged hosted backend credential for service clients and rollout tooling; hosted Edge Functions receive the same value through `SB_SECRET_KEY` because Supabase blocks custom secrets that start with `SUPABASE_`.
- Recommended ownership split:
  - root `.env`: local Supabase CLI and server-side secrets consumed through `env(...)`, plus optional hosted rollout secrets like `SUPABASE_DB_URL`
  - Flutter `--dart-define` or editor launch config: app runtime values such as `SUPABASE_URL`, `SUPABASE_PUBLISHABLE_KEY` / local `SUPABASE_ANON_KEY`, and `GOOGLE_WEB_CLIENT_ID`
  - GitHub Actions: repository variables for non-secret client IDs and repository secrets for secrets such as `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET`
- Android local runtime should use two explicit launch paths:
  - emulator: `SUPABASE_URL=http://127.0.0.1:54321` with `LOCAL_ANDROID_NETWORK_TARGET=emulator`, so the app rewrites loopback to `10.0.2.2`
  - real device: use a reachable desktop LAN IP in `SUPABASE_URL`, for example `http://192.168.x.x:54321`, with `LOCAL_ANDROID_NETWORK_TARGET=device`
- The phone and desktop must be on the same reachable network for the local-device path.
- ADB over Wi-Fi only helps debugging; it does not replace a reachable backend host in the app runtime config.
- Google auth is always treated as enabled in the client runtime. Control availability through Supabase provider setup, not app flags.
- The app push path should normally use native Firebase client config files (`google-services.json` / `GoogleService-Info.plist`) supplied outside git, while the optional `FIREBASE_*` app vars remain available only as explicit runtime overrides.
- Local Edge Function smoke runs also require the transactional email sender/webhook env vars above; otherwise functions may boot but return `500` on first use because required server secrets are missing.
- The current production-grade email integration path is a transactional email provider adapter behind the shared outbox/retry model. Provider-specific request formatting and webhook normalization should stay inside the Edge layer.

## Runtime Boundaries

Database functions / RPC responsibilities:

- `get_client_settings`
- `create_upload_session`
- `finalize_payment_proof`
- `finalize_verification_document`
- `finalize_dispute_evidence`
- `create_support_request`
- `reply_to_support_request`
- `mark_support_request_read`
- `admin_set_support_request_status`
- `admin_assign_support_request`
- `email_templates` as the canonical transactional email content registry
- `claim_push_outbox_jobs`
- `complete_push_outbox_job`
- `release_retryable_push_job`
- `recover_stale_push_outbox_jobs`
- `claim_generated_document_jobs`
- `complete_generated_document_processing`
- `fail_generated_document_processing`
- `recover_stale_generated_document_jobs`

Edge Function responsibilities:

- `scheduled-automation-tick`
- `transactional-email-dispatch-worker`
- `email-provider-webhook`
- `signed-file-url`
- `generated-document-worker`
- `push-dispatch-worker`

Production-grade alignment notes:

- Edge Functions should orchestrate only HTTP/integration work and call RPC for canonical mutations
- support requests are DB-backed through `support_requests` and `support_messages`; app and admin flows mutate them only through RPC, not direct client table writes
- transactional email content is DB-owned through `email_templates`; the Edge worker resolves and renders the active template before calling the provider adapter
- generated document workers claim, complete, fail, and recover jobs through RPC instead of mutating queue state ad hoc
- scheduled maintenance recovers email, push, and generated-document worker locks before dispatching workers so the same tick can reclaim newly unstuck work
- scheduled maintenance executes recovery, dispatch, and expiry tasks independently and returns a per-task result payload for operations visibility

## Secrets Placement

- Supabase project / Edge Function secrets
  - `SB_SECRET_KEY` for privileged Supabase service clients used by hosted Edge Functions
  - `INTERNAL_AUTOMATION_TOKEN` for scheduler-triggered and worker-to-worker Edge Function authorization
  - Firebase service account JSON for FCM HTTP v1 push delivery
  - transactional email provider API key
  - transactional email provider webhook verification secret where supported
  - any direct integration secrets consumed by Edge Functions
- Supabase Vault
  - DB-side secrets required by scheduled SQL or `pg_cron` / `pg_net`-driven calls, including `fleetfill_internal_automation_token`
  - project URL / anon token references only if a DB-side scheduled call truly needs them

## Scheduling Posture

- preferred pattern: `pg_cron` triggers one Edge Function worker every minute
- repo-managed scheduler setup now lives in `backend/supabase/scripts/configure_scheduled_automation.sql`
- scheduler-to-function and worker-to-worker authorization should use `INTERNAL_AUTOMATION_TOKEN`, not raw service-role bearer reuse
- production rollout can apply it from the repo root with [C:\Users\raouf\projects\fleetfill\tool\apply_supabase_scheduler.ps1](C:\Users\raouf\projects\fleetfill\tool\apply_supabase_scheduler.ps1) when `SUPABASE_DB_URL` is present in root `.env`
- initial worker scope:
  - email outbox draining
  - delivery grace-window expiry
  - payment resubmission expiry
  - stale queue lock recovery
- actual plan quotas and availability still need verification on the target Supabase project before production use

## Hosted Rollout Helpers

- [C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1](C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1)
  - runs the local validation gate
  - pushes cloud migrations and config
  - syncs function secrets
  - deploys all repo-owned Edge Functions that have an `index.ts`
  - installs the scheduler when `SUPABASE_DB_URL` is available
  - syncs Vercel admin env values
  - runs hosted verification
- [C:\Users\raouf\projects\fleetfill\tool\verify_hosted_rollout.ps1](C:\Users\raouf\projects\fleetfill\tool\verify_hosted_rollout.ps1)
  - verifies live function inventory and auth boundaries
  - checks Vercel production env values
  - checks the live admin sign-in route

## Database Regression Checks

- baseline SQL contract checks live in `backend/supabase/tests/contracts.sql`
- run them after reset against the local database with your preferred `psql` workflow
- executable runtime security coverage lives in `backend/supabase/tests/runtime_security_test.sql`
- run it with `supabase test db --workdir backend/supabase "tests/runtime_security_test.sql"` after `supabase db reset --workdir backend/supabase --yes`
- executable email outbox and webhook coverage lives in `backend/supabase/tests/runtime_email_test.sql`
- run it with `supabase test db --workdir backend/supabase "tests/runtime_email_test.sql"` after `supabase db reset --workdir backend/supabase --yes`
