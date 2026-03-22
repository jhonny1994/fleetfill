# Supabase Backend Layout

This directory holds the FleetFill backend foundation for Supabase.

## Migrations

- migration history is change-oriented, not phase-oriented
- use `YYYYMMDDHHMMSS_<verb>_<subject>.sql`
- keep one concern per migration where practical: schema, helpers, user RPC, privileged RPC, RLS, storage, grants, backfills

Current local baseline is split into:

- `migrations/20260317143000_create_base_types_and_triggers.sql`
- `migrations/20260317143100_create_reference_location_tables.sql`
- `migrations/20260317143200_create_marketplace_core_tables.sql`
- `migrations/20260317143300_create_finance_and_disputes_tables.sql`
- `migrations/20260317143400_create_communications_and_platform_tables.sql`
- `migrations/20260317150000_create_runtime_support_tables.sql`
- `migrations/20260317150100_create_security_and_storage_helpers.sql`
- `migrations/20260317150200_create_client_upload_and_finalize_rpc.sql`
- `migrations/20260317150300_create_privileged_runtime_rpc.sql`
- `migrations/20260317150400_create_storage_buckets.sql`
- `migrations/20260317150500_enable_rls_and_create_table_policies.sql`
- `migrations/20260317150600_create_storage_policies_and_security_triggers.sql`
- `migrations/20260317150700_grant_runtime_function_access.sql`
- `migrations/20260318130000_create_public_carrier_profile_rpc.sql`
- `migrations/20260318170000_create_verification_effective_document_helpers.sql`
- `migrations/20260318170100_create_verification_admin_review_actions.sql`
- `migrations/20260318170200_create_verification_packet_approval.sql`
- `migrations/20260319120000_add_capacity_publication_constraints.sql`
- `migrations/20260319120100_backfill_route_revision_lane_history.sql`
- `migrations/20260319120200_create_capacity_publication_access_helpers.sql`
- `migrations/20260319120300_create_capacity_publication_integrity_guards.sql`
- `migrations/20260319120400_create_capacity_publication_routes_rpc.sql`
- `migrations/20260319120500_create_capacity_publication_oneoff_trip_rpc.sql`
- `migrations/20260319120600_enable_capacity_publication_policies.sql`
- `migrations/20260319120700_harden_verification_helper_access.sql`
- `migrations/20260320120000_add_shipment_domain_constraints.sql`
- `migrations/20260320120100_create_exact_lane_search_rpc.sql`
- `migrations/20260320120200_create_booking_confirmation_rpc.sql`
- `migrations/20260320120300_enforce_booking_status_transitions.sql`
- `migrations/20260320120400_create_payment_proof_review_rpc.sql`
- `migrations/20260320120500_create_tracking_and_delivery_rpc.sql`
- `migrations/20260320120600_create_dispute_and_payout_rpc.sql`
- `migrations/20260320120700_create_carrier_review_rpc.sql`
- `migrations/20260320120710_create_notification_device_rpc.sql`
- `migrations/20260320120720_create_transactional_email_enqueue_rpc.sql`
- `migrations/20260320120800_harden_notification_device_rules.sql`
- `migrations/20260320120810_harden_email_delivery_rules.sql`
- `migrations/20260320120820_create_support_request_email_rpc.sql`
- `migrations/20260320120825_add_dispute_evidence_support.sql`
- `migrations/20260320120830_create_push_notification_runtime.sql`
- `migrations/20260320120900_seed_runtime_and_feature_flag_settings.sql`
- `migrations/20260320121000_create_typed_client_settings_rpc.sql`
- `migrations/20260320121100_create_admin_operational_summary_rpc.sql`
- `migrations/20260320121110_create_admin_platform_settings_rpc.sql`
- `migrations/20260320121120_create_admin_profile_activation_rpc.sql`
- `migrations/20260320121130_create_admin_email_retry_rpc.sql`
- `migrations/20260320121200_track_generated_document_processing.sql`
- `migrations/20260320121210_update_generated_document_record_helper.sql`
- `migrations/20260320121220_add_generated_document_processing_locks.sql`
- `migrations/20260320121230_create_generated_document_processing_rpc.sql`

Rules:

- do not rename or edit historical migrations once they become canonical outside local rebaseline work
- avoid broad names like `phase_*`, `foundation`, or roadmap labels
- keep backfills explicit and separate from unrelated schema changes when possible
- keep user-callable and privileged/service-role functions separated

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
- `TRANSACTIONAL_EMAIL_PROVIDER=...`
- `TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT=https://api.provider.example/send`
- `TRANSACTIONAL_EMAIL_PROVIDER_API_KEY=...`
- `TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET=...`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID=your-google-web-client-id`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET=your-google-client-secret`

Notes:

- The mobile app uses `SUPABASE_ANON_KEY` first in `APP_ENV=local`, because local CLI/self-hosted Supabase does not manage hosted publishable keys.
- The mobile app uses `SUPABASE_PUBLISHABLE_KEY` first in `APP_ENV=staging` and `APP_ENV=production`, with `SUPABASE_ANON_KEY` only as a compatibility fallback.
- Google auth is always treated as enabled in the client runtime. Control availability through Supabase provider setup, not app flags.
- The app push path should normally use native Firebase client config files (`google-services.json` / `GoogleService-Info.plist`) supplied outside git, while the optional `FIREBASE_*` app vars remain available only as explicit runtime overrides.

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
