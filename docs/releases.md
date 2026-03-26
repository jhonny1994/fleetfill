# Releases

## Production Release Model

FleetFill release automation is intentionally simple:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml) validates repository quality
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml) promotes hosted backend changes
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml) publishes admin-web on demand
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml) builds signed Android release artifacts

## Active GitHub Actions

- [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml)
  - surface-aware change detection
  - Flutter quality
  - admin-web quality
  - Supabase local validation
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

- `GOOGLE_WEB_CLIENT_ID`
- `GOOGLE_IOS_CLIENT_ID`
- `PRODUCTION_SUPABASE_URL`
- `PRODUCTION_SUPABASE_PUBLISHABLE_KEY`
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
  - can generate a local Android release keystore if one does not already exist

## Flutter Release Flow

Signed Android artifacts are produced by:

- pushing a version tag like `v1.0.0`
- or manually dispatching [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml)

Published artifacts:

- signed Android App Bundle (`.aab`)
- signed Android APK (`.apk`)

## Distribution Posture

- GitHub Releases is the current production artifact channel for Android builds
- Google Play can replace that later without changing the core signing pipeline
- admin-web production publication is now GitHub-controlled through the manual deploy workflow
- secrets and signing material must stay in GitHub secrets, never in git
