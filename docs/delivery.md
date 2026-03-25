# Delivery

## Current State

FleetFill is feature-advanced and locally verifiable across the main product surfaces. The remaining release risk is mostly hosted-environment and representative-device validation, not missing product fundamentals.

## Verified In Repo Or Local Runtime

- Flutter auth flow coverage is in place for confirm-email and password reset user journeys.
- Supabase runtime SQL validation exists for security and email workflow contracts.
- Local Supabase can now verify confirm-email behavior with Mailpit instead of auto-confirming silently.
- Local transactional email can be queued, dispatched by the worker, and accepted by the provider.
- Local scheduled automation can invoke the worker stack successfully.
- Critical auth and routing tests pass.

## Remaining Manual Or Environment-Specific Validation

These items still need representative-device or hosted-environment execution:

- Profile the app on a representative Android device in profile mode.
- Validate repeated jank and long-list behavior on the target device class.
- Run TalkBack and large-text accessibility checks.
- Run manual Arabic, French, and English localization QA.
- Verify hosted Supabase Auth email delivery with real inboxes.
- Deploy and verify hosted Edge Functions, secrets, scheduler, and provider webhooks in Supabase cloud.

## Hosted Rollout Order

Promote the hosted system in this order:

- run the local verification gate from the current `main` state
- run [C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1](C:\Users\raouf\projects\fleetfill\tool\deploy_supabase_cloud.ps1) from the repo root
- push `main` so Vercel Git integration publishes the current `admin-web/` commit
- verify hosted auth, transactional email, push, and admin operations against the real cloud project

## Release Gate

Do not claim production-ready rollout until all of the following are true:

- local automated and runtime checks pass
- cloud backend is deployed from the current repo state
- auth email works in the hosted project
- transactional email works in the hosted project
- manual device and accessibility validation is complete

## Validation Sources

- Flutter tests
- Supabase SQL runtime tests
- local Supabase runtime rehearsal
- admin-web type and lint verification
- manual operator checks before promotion
- hosted verification via [C:\Users\raouf\projects\fleetfill\tool\verify_hosted_rollout.ps1](C:\Users\raouf\projects\fleetfill\tool\verify_hosted_rollout.ps1)
