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

- target best practice is deterministic local seeding through `supabase/seed.sql` or `supabase/seeds/`
- FleetFill seeds locations from `supabase/seeds/locations.sql`, generated from the canonical JSON in `data/locations/wilayas-with-municipalities.json`
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
  - configure `[auth.external.google]` in `supabase/config.toml`
  - keep the Google client ID and secret in root `.env` variables via `env(...)`
  - local callback URI should be `http://127.0.0.1:54321/auth/v1/callback`
  - mobile deep link callback remains allowed through `additional_redirect_urls = ["fleetfill://auth-callback"]`

Example root `.env` entries:

- `APP_ENV=production`
- `SUPABASE_URL=https://your-project-ref.supabase.co`
- `SUPABASE_PUBLISHABLE_KEY=...`
- `SUPABASE_ANON_KEY=...` (local CLI/self-hosted only)
- `SUPABASE_SERVICE_ROLE_KEY=...`
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

- The mobile app uses `SUPABASE_ANON_KEY` first in `APP_ENV=local`, because local CLI/self-hosted Supabase does not manage hosted publishable keys.
- The mobile app uses `SUPABASE_PUBLISHABLE_KEY` first in `APP_ENV=staging` and `APP_ENV=production`, with `SUPABASE_ANON_KEY` only as a compatibility fallback.
- Recommended ownership split:
  - root `.env`: local Supabase CLI and server-side secrets consumed through `env(...)`
  - Flutter `--dart-define` or editor launch config: app runtime values such as `APP_ENV`, `SUPABASE_URL`, `SUPABASE_PUBLISHABLE_KEY` / local `SUPABASE_ANON_KEY`, and `GOOGLE_WEB_CLIENT_ID`
  - GitHub Actions: repository variables for non-secret client IDs and repository secrets for secrets such as `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET`
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
- `enqueue_support_request_emails`
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
- `support-email-dispatch`
- `generated-document-worker`
- `push-dispatch-worker`

Production-grade alignment notes:

- Edge Functions should orchestrate only HTTP/integration work and call RPC for canonical mutations
- support email queueing is server-controlled through `enqueue_support_request_emails(...)`, not direct table inserts from Edge code
- generated document workers claim, complete, fail, and recover jobs through RPC instead of mutating queue state ad hoc
- scheduled maintenance recovers email, push, and generated-document worker locks before running expiry automation

## Secrets Placement

- Supabase project / Edge Function secrets
  - Firebase service account JSON for FCM HTTP v1 push delivery
  - transactional email provider API key
  - transactional email provider webhook verification secret where supported
  - any direct integration secrets consumed by Edge Functions
- Supabase Vault
  - DB-side secrets required by scheduled SQL or `pg_cron` / `pg_net`-driven calls
  - project URL / anon token references only if a DB-side scheduled call truly needs them

## Scheduling Posture

- preferred pattern: `pg_cron` triggers one Edge Function worker every minute
- repo-managed scheduler setup now lives in `supabase/scripts/configure_scheduled_automation.sql`
- initial worker scope:
  - email outbox draining
  - delivery grace-window expiry
  - payment resubmission expiry
  - stale queue lock recovery
- actual plan quotas and availability still need verification on the target Supabase project before production use

## Database Regression Checks

- baseline SQL contract checks live in `supabase/tests/contracts.sql`
- run them after reset against the local database with your preferred `psql` workflow
- executable runtime security coverage lives in `supabase/tests/runtime_security_test.sql`
- run it with `supabase test db "supabase/tests/runtime_security_test.sql"` after `supabase db reset --yes`
- executable email outbox and webhook coverage lives in `supabase/tests/runtime_email_test.sql`
- run it with `supabase test db "supabase/tests/runtime_email_test.sql"` after `supabase db reset --yes`
