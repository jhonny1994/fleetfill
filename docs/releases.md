# Releases

## Production Release Model

FleetFill release automation is intentionally simple:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml) validates repository quality
- [C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml) orchestrates coordinated whole-product releases
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml) promotes hosted backend changes
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml) publishes admin-web on demand
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml) builds signed Android release artifacts

## Governance

- `main` is protected with required pull requests, one approval, stale-review dismissal, linear history, and required conversation resolution
- the required checks are `System Contracts`, `Detect Changed Surfaces`, `Flutter Quality`, `Admin Web Quality`, and `Supabase Validation`
- the production rollout jobs use the GitHub `Production` environment
- the `Production` environment currently requires reviewer approval from `jhonny1994`

## Active GitHub Actions

- [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml)
  - surface-aware change detection
  - cross-surface system contract validation
  - Flutter quality
  - admin-web quality
  - Supabase local validation
- [C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml)
  - coordinated backend -> admin-web -> mobile release orchestration
  - keeps the existing surface workflows as reusable rollout units
  - supports a `validate_only` no-deploy rehearsal mode for contract validation
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml)
  - hosted Supabase rollout
  - operator-selected rollout parts
  - hosted verification
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml)
  - Vercel env sync
  - production build
  - production deploy
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml)
  - signed Android artifact generation
  - GitHub release publication
  - version tag must match `apps/mobile/pubspec.yaml`

## Required GitHub Secrets

For Supabase production rollout:

- `SUPABASE_ACCESS_TOKEN`
- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET`
- `INTERNAL_AUTOMATION_TOKEN`
- `TRANSACTIONAL_EMAIL_PROVIDER_API_KEY`
- `TRANSACTIONAL_EMAIL_PROVIDER_WEBHOOK_SECRET`
- `FIREBASE_SERVICE_ACCOUNT_JSON`
- `VERCEL_TOKEN`

For signed Flutter releases:

- `ANDROID_GOOGLE_SERVICES_JSON`
- `ANDROID_RELEASE_KEYSTORE_BASE64`
- `ANDROID_RELEASE_STORE_PASSWORD`
- `ANDROID_RELEASE_KEY_ALIAS`
- `ANDROID_RELEASE_KEY_PASSWORD`

Local developer note:

- `apps/mobile/android/app/google-services.json` may stay on a developer machine for local builds
- it must remain ignored and untracked in git
- CI must fail if tracked Firebase or service-account files reappear

## Required GitHub Variables

- `SUPABASE_URL`
- `SUPABASE_PUBLISHABLE_KEY`
- `SENTRY_DSN`
- `GOOGLE_WEB_CLIENT_ID`
- `GOOGLE_IOS_CLIENT_ID`
- `TRANSACTIONAL_EMAIL_PROVIDER`
- `TRANSACTIONAL_EMAIL_PROVIDER_ENDPOINT`
- `TRANSACTIONAL_EMAIL_FROM_EMAIL`
- `PUSH_NOTIFICATIONS_ENABLED`
- `PUSH_NOTIFICATIONS_PROVIDER`
- `VERCEL_ORG_ID`
- `VERCEL_ADMIN_WEB_PROJECT_ID`

## Repo-Owned Sync Helper

- [C:\Users\raouf\projects\fleetfill\tool\sync_github_production_config.ps1](C:\Users\raouf\projects\fleetfill\tool\sync_github_production_config.ps1)
  - syncs GitHub production variables and secrets that can be derived from local config
  - keeps GitHub variable names aligned with the runtime contract used by Flutter builds
  - can generate a local Android release keystore if one does not already exist

## Contract Validation Ownership

- [C:\Users\raouf\projects\fleetfill\tool\validate_system_contracts.ps1](C:\Users\raouf\projects\fleetfill\tool\validate_system_contracts.ps1) is the repo-owned guardrail for cross-surface truths
- when auth, locale, host, workflow, or release contracts change, update the validator in the same change
- do not weaken the validator to bypass a migration; land the new contract and the new enforcement together

## Flutter Release Flow

Signed Android artifacts are produced by:

- pushing a version tag like `v1.0.0`
- or manually dispatching [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml)
- or calling the same reusable mobile workflow through [C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml) for a coordinated system release
- the requested tag must equal the current mobile version in `apps/mobile/pubspec.yaml`

Auth callback posture for Android releases:

- Verified Android App Links on `https://fleetfill.vercel.app/auth/mobile-callback` are the production truth
- `com.carbodex.fleetfill://auth-callback` remains a temporary local-development and rollback fallback during migration
- remove the custom-scheme fallback only after real-device signup confirmation, password reset, and recovery re-entry flows are verified through App Links and rollback confidence is documented

Production environment gate:

- the production release workflows are bound to the GitHub `Production` environment
- any reviewers or approval rules configured on that environment gate backend, admin-web, and mobile promotion consistently

Safe orchestration rehearsal:

- dispatch [C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\release.yml) with `validate_only=true` to validate the coordinated release contract without deploying or publishing artifacts
- this mode is the preferred way to rehearse the new root release flow before using it as the primary ship path

Published artifacts:

- signed Android App Bundle (`.aab`)
- signed Android APK (`.apk`)

## Distribution Posture

- GitHub Releases is the current production artifact channel for Android builds
- Google Play can replace that later without changing the core signing pipeline
- admin-web production publication is now GitHub-controlled through the manual deploy workflow
- secrets and signing material must stay in GitHub secrets, never in git
- Sentry DSNs are treated as runtime configuration, not hardcoded source constants
