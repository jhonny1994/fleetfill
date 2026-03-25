# Releases

## Production Release Model

FleetFill currently uses:

- GitHub Actions for validation and release automation
- GitHub Releases for signed Flutter production artifacts
- Vercel Git integration for admin-web deploys from `main`
- Supabase cloud as the production backend

## GitHub Actions

Active workflows:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_quality.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_quality.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_release.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\release_candidate_verification.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\release_candidate_verification.yml)

## Required GitHub Secrets

For signed Flutter releases:

- `ANDROID_GOOGLE_SERVICES_JSON`
- `ANDROID_RELEASE_KEYSTORE_BASE64`
- `ANDROID_RELEASE_STORE_PASSWORD`
- `ANDROID_RELEASE_KEY_ALIAS`
- `ANDROID_RELEASE_KEY_PASSWORD`

Local developer note:

- `android/app/google-services.json` may stay on a developer machine for local builds
- it should remain ignored and untracked in git
- CI should fail if tracked Firebase or service-account files reappear in the repository

For hosted auth/provider validation:

- `SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET`

## Required GitHub Variables

- `GOOGLE_WEB_CLIENT_ID`
- `GOOGLE_IOS_CLIENT_ID`
- `PRODUCTION_SUPABASE_URL`
- `PRODUCTION_SUPABASE_PUBLISHABLE_KEY`

Optional manual Vercel CLI fallback:

- secret `VERCEL_TOKEN`
- variable `VERCEL_ORG_ID`
- variable `VERCEL_ADMIN_WEB_PROJECT_ID`

Repo-owned sync helper:

- [C:\Users\raouf\projects\fleetfill\tool\sync_github_production_config.ps1](C:\Users\raouf\projects\fleetfill\tool\sync_github_production_config.ps1)
  - syncs the production GitHub variables and secrets that can be derived from local config
  - can generate a local Android release keystore if one does not already exist

## Flutter Release Flow

Signed Android artifacts are produced by:

- pushing a version tag like `v1.0.0`
- or manually dispatching [C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_release.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\flutter_release.yml)

Published artifacts:

- signed Android App Bundle (`.aab`)
- signed Android APK (`.apk`)

## Distribution Posture

- GitHub Releases is the current production artifact channel
- Google Play can replace that later without changing the core signing pipeline
- secrets and signing material must stay in GitHub secrets, never in git
