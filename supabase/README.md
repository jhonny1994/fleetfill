# Supabase Backend Layout

This directory holds the FleetFill backend foundation for Supabase.

## Migrations

- `migrations/20260317143000_phase_2_schema_foundation.sql`
  - base enums, base tables, primary constraints, and indexing foundation
- `migrations/20260317150000_phase_2_security_and_runtime_foundation.sql`
  - upload sessions, security helpers, RLS, storage policies, append-only protections, and server-side functions

## Seed Data

- `tool/import_locations.dart`
  - reads `docs/wilayas-with-municipalities.json` directly
  - clears `public.communes` first, then `public.wilayas`
  - imports wilayas as `id`, `name`, and `name_ar`
  - imports communes as `id`, `wilaya_id`, `name`, and `name_ar`
  - prints each commune missing a canonical `id` and continues without failing the whole import

Run it locally with:

- `dart run tool/import_locations.dart`

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

- `SUPABASE_URL=http://127.0.0.1:54321`
- `SUPABASE_ANON_KEY=...`
- `SUPABASE_PUBLISHABLE_KEY=...`
- `SUPABASE_SERVICE_ROLE_KEY=...`
- `TRANSACTIONAL_EMAIL_PROVIDER=...`
- `TRANSACTIONAL_EMAIL_PROVIDER_API_KEY=...`
- `TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET=...`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID=your-google-web-client-id`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET=your-google-client-secret`

## Runtime Boundaries

Database functions / RPC responsibilities:

- `get_client_settings`
- `create_upload_session`
- `finalize_payment_proof`
- `finalize_verification_document`

Edge Function responsibilities:

- `scheduled-automation-tick`
- `transactional-email-dispatch-worker`
- `email-provider-webhook`
- `signed-file-url`
- `support-email-dispatch`

## Secrets Placement

- Supabase project / Edge Function secrets
  - transactional email provider API key
  - transactional email provider webhook verification secret where supported
  - any direct integration secrets consumed by Edge Functions
- Supabase Vault
  - DB-side secrets required by scheduled SQL or `pg_cron` / `pg_net`-driven calls
  - project URL / anon token references only if a DB-side scheduled call truly needs them

## Scheduling Posture

- preferred pattern: `pg_cron` triggers one Edge Function worker every minute
- initial worker scope:
  - email outbox draining
  - delivery grace-window expiry
  - payment resubmission expiry
  - stale queue lock recovery
- actual plan quotas and availability still need verification on the target Supabase project before production use
