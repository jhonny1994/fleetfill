## Relevant Files

- `apps/mobile/lib/core/auth/auth_repository.dart` - Mobile auth redirect source of truth and recovery/signup redirect wiring.
- `apps/mobile/android/app/src/main/AndroidManifest.xml` - Android deep-link and future App Links intent-filter configuration.
- `backend/supabase/config.toml` - Supabase hosted auth URL allowlist and runtime host contract.
- `backend/supabase/README.md` - Backend documentation for auth redirect and runtime environment rules.
- `apps/admin-web/.env.example` - Admin-web public host contract and local development examples.
- `apps/admin-web/README.md` - Admin-web runtime, environment, and local/hosted behavior documentation.
- `apps/admin-web/next.config.ts` - Likely integration point for serving `/.well-known` files cleanly if needed.
- `apps/admin-web/app/` - App Router surface that will own any public well-known route handling on the existing Vercel origin.
- `.github/workflows/ci.yml` - Main repo-wide quality gate; should gain cross-surface contract validation.
- `.github/workflows/production_supabase.yml` - Existing backend rollout workflow that should become reusable and remain operator-safe.
- `.github/workflows/production_admin_web.yml` - Existing admin-web production deploy workflow that should become reusable and remain operator-safe.
- `.github/workflows/production_flutter.yml` - Existing mobile release workflow that should become reusable while preserving tag-driven releases.
- `.github/workflows/release.yml` - New root orchestration workflow for full-system production promotion.
- `tool/sync_admin_vercel_env.ps1` - Hosted admin-web environment sync helper that must align with the canonical public origin.
- `tool/deploy_supabase_cloud.ps1` - Hosted rollout helper that currently carries production host assumptions.
- `tool/verify_hosted_rollout.ps1` - Hosted verification script that should validate the final whole-system contract.
- `README.md` - Public Arabic-first repository landing page; legal posture and product links must match the final repo model.
- `README.en.md` - English public repository posture and product link documentation.
- `README.fr.md` - French public repository posture and product link documentation.
- `docs/architecture.md` - Active architecture truth that must reflect the final auth/orchestration contract.
- `docs/delivery.md` - Active release model truth that must reflect the new root orchestration path.
- `docs/releases.md` - Production release contract and GitHub Actions/secret model documentation.
- `.gitignore` - Repo-wide generated-output and local-artifact hygiene rules.
- `docs/workitems/system-standardization/tasks-system-standardization.md` - Execution checklist for this whole-system standardization effort.

### Notes

- This work item is cross-surface and must be executed as one coherent product migration, not as isolated fixes.
- The canonical public product/web origin should remain `https://fleetfill.vercel.app`; GitHub Pages should not be introduced unless the current Vercel origin becomes unavailable.
- Local development hosts such as `http://localhost:3000` and `http://127.0.0.1:3005` should remain explicit local/test-only contracts and must not define production truth.
- The mobile custom scheme should be treated as a migration fallback until verified HTTPS App Links are fully working and validated.
- Task labels are intentional:
  - `migration` means introducing or moving to the new canonical path
  - `cleanup` means removing stale, duplicate, misleading, or generated material
  - `removal` means retiring an old path after the replacement is proven
  - `final-state enforcement` means adding guards so drift does not return
- Task `0.0` is included because the template requires it; whether a branch is actually created can be decided during execution.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

 - [x] 0.0 Create feature branch
  - [x] 0.1 Create and checkout a new branch for this work using the repo branch convention, for example `codex/system-standardization`.
  - [x] 0.2 Confirm the branch name reflects the whole-system scope rather than a single app surface.

- [x] 1.0 Standardize the auth, callback, and host contract across mobile, admin-web, Supabase, docs, and rollout tooling
  - [x] 1.1 `migration` Inventory every live reference to auth callbacks, redirect URLs, site URLs, and public hostnames across `apps/mobile`, `apps/admin-web`, `backend/supabase`, `tool/`, `.github/workflows`, and root docs.
  - [x] 1.2 `migration` Define one canonical production contract centered on `https://fleetfill.vercel.app`, including the final mobile auth callback path and the local-only host exceptions that remain supported.
  - [x] 1.3 `migration` Update `apps/mobile/lib/core/auth/auth_repository.dart` so the app uses the canonical callback contract and clearly documents any temporary fallback behavior.
  - [x] 1.4 `migration` Update `backend/supabase/config.toml` so `site_url` and `additional_redirect_urls` match the final production and local-development contract instead of the legacy custom-scheme mismatch.
  - [x] 1.5 `cleanup` Update `backend/supabase/README.md` so the documented callback and redirect rules match the real runtime behavior.
  - [x] 1.6 `cleanup` Update admin-web environment examples and docs in `apps/admin-web/.env.example` and `apps/admin-web/README.md` so production, local dev, and test harness hosts are clearly separated and no stale host naming remains.
  - [x] 1.7 `cleanup` Update rollout and verification scripts in `tool/` so their default host assumptions align with the standardized production origin and no stale host contract survives in automation.
  - [x] 1.8 `cleanup` Update root-facing product links in `README.md`, `README.en.md`, and `README.fr.md` only where needed so public-facing product URLs match the canonical origin.
  - [x] 1.9 `cleanup` Search for remaining stale callback or host references and remove or update them so no conflicting contract remains.

- [ ] 2.0 Migrate Android auth from a custom-scheme-first flow to a verified HTTPS App Links flow on the existing FleetFill public origin
  - [x] 2.1 `migration` Design the final HTTPS App Links callback URL shape under `https://fleetfill.vercel.app`, ensuring it works with Supabase Auth redirect requirements and mobile route handling.
  - [x] 2.2 `migration` Add Android HTTPS App Links intent filters to `apps/mobile/android/app/src/main/AndroidManifest.xml` using `android:autoVerify="true"` and the canonical host.
  - [x] 2.3 `migration` Decide whether the admin-web App Router should serve `/.well-known/assetlinks.json` directly or via static/public hosting, then implement that route on the existing Vercel deployment surface.
  - [x] 2.4 `migration` Generate and publish the correct `assetlinks.json` payload using the release signing certificate fingerprints that correspond to the shipping Android app.
  - [x] 2.5 `migration` Update Supabase redirect allowlists so the HTTPS callback is accepted in production while local dev/test callbacks remain explicitly allowed where needed.
  - [x] 2.6 `migration` Keep the existing `com.carbodex.fleetfill://auth-callback` scheme as a temporary migration fallback only if required for safe rollout.
  - [x] 2.7 `removal` Define the removal conditions for the custom-scheme fallback, including verification success, real-device auth validation, and rollback confidence.
  - [ ] 2.8 `final-state enforcement` Verify end-to-end auth flows on Android for signup confirmation, resend confirmation, password reset, and recovery re-entry using the final callback path.
  - [x] 2.9 `cleanup` Update architecture and release docs so HTTPS App Links are the documented production truth and custom schemes are explicitly marked as transitional or removed.

- [ ] 3.0 Align the repository’s public-but-proprietary legal posture and GitHub governance model with how the project is actually being shared
  - [x] 3.1 `cleanup` Replace README wording that implies the repository is private with wording that accurately describes a public repository with proprietary/no-reuse rights.
  - [x] 3.2 `migration` Add or update a top-level legal/proprietary notice file so the no-reuse stance is explicit, durable, and not buried only in one README language variant.
  - [x] 3.3 `cleanup` Mirror the public-but-proprietary posture across `README.md`, `README.en.md`, and `README.fr.md` so the legal message does not vary by language.
  - [x] 3.4 `cleanup` Review docs for any remaining statements that describe the repo as private and correct them to match the chosen public posture.
  - [x] 3.5 `migration` Enable GitHub branch protection for `main`, including PR requirements and required CI checks from `.github/workflows/ci.yml`.
  - [x] 3.6 `migration` Add GitHub production environments or equivalent approval gates for backend, admin-web, and mobile release actions so production promotion stays operator-reviewed.
  - [x] 3.7 `cleanup` Document the governance model in the active docs so future maintainers know how production access and approvals are expected to work.

- [ ] 4.0 Migrate the split production workflows into one root GitHub orchestration workflow while preserving current operator entrypoints and mobile tag releases
  - [x] 4.1 `migration` Review the current behavior of `production_supabase.yml`, `production_admin_web.yml`, and `production_flutter.yml` and lock the behavior that must not regress.
  - [x] 4.2 `migration` Add `workflow_call` support to `production_supabase.yml` while preserving its current `workflow_dispatch` entrypoint and operator-controlled inputs.
  - [x] 4.3 `migration` Add `workflow_call` support to `production_admin_web.yml` while preserving its current `workflow_dispatch` entrypoint and operator-controlled inputs.
  - [x] 4.4 `migration` Add `workflow_call` support to `production_flutter.yml` while preserving both manual dispatch support and the current tag-driven mobile release path.
  - [x] 4.5 `migration` Create a new root orchestration workflow, for example `.github/workflows/release.yml`, that calls backend first, admin-web second, and mobile third.
  - [x] 4.6 `migration` Define root workflow inputs that let an operator choose which surfaces to promote while still keeping the standard full-release path obvious and safe.
  - [x] 4.7 `migration` Use reusable-workflow input passing and inherited secrets so the orchestration layer does not duplicate every rollout secret declaration by hand.
  - [x] 4.8 `final-state enforcement` Ensure the root workflow does not break the current mobile tag-release behavior and that mobile tags remain a valid release path during migration.
  - [x] 4.9 `cleanup` Update release documentation in `docs/delivery.md` and `docs/releases.md` so the root orchestrator becomes the primary production entrypoint and the surface workflows are documented as wrappers/reusables.
  - [ ] 4.10 `final-state enforcement` Validate the orchestrated path end-to-end with a dry run or controlled test release flow before declaring it canonical.

- [ ] 5.0 Add repo-wide contract validation so shared cross-surface truths fail fast in CI instead of drifting silently
  - [x] 5.1 `migration` Define the list of global contracts CI should enforce, including public origin, auth callback contract, redirect allowlists, release tag/version consistency, and stale function/config references.
  - [x] 5.2 `migration` Add a repo-owned validation script or scripts that read the relevant files and fail clearly when shared values drift across surfaces.
  - [x] 5.3 `final-state enforcement` Wire the new contract-validation step into `.github/workflows/ci.yml` so whole-system drift is caught on pull requests and pushes to `main`.
  - [x] 5.4 `final-state enforcement` Add release-oriented checks for mobile version/tag consistency so `pubspec.yaml`, tags, and release workflows cannot quietly diverge.
  - [x] 5.5 `final-state enforcement` Add workflow hygiene checks for deprecated or stale action/runtime assumptions where feasible, especially around upcoming GitHub Actions runtime changes.
  - [x] 5.6 `final-state enforcement` Expand validation coverage beyond auth by checking other shared truths that should never drift, such as locale registry assumptions and documented production hostnames.
  - [x] 5.7 `cleanup` Document the intent and ownership of the contract-validation layer so future changes update the validator rather than bypassing it.

- [ ] 6.0 Clean global repo hygiene, stale contracts, and generated-output handling so no dead or misleading paths remain after the migration
  - [x] 6.1 `cleanup` Review `.gitignore` and add explicit rules for generated local outputs such as admin-web Playwright artifacts and test result folders that should never be tracked.
  - [x] 6.2 `cleanup` Remove or update stale examples in docs and env templates where local, test, and production host contracts are currently mixed or misleading.
  - [x] 6.3 `cleanup` Audit `backend/supabase/config.toml`, `backend/supabase/functions/`, and related docs for stale function references or dead runtime contracts, then remove or document them properly.
  - [x] 6.4 `cleanup` Check `tool/` scripts for assumptions that no longer match the final production model and clean them up so they align with the new orchestration and host contracts.
  - [ ] 6.5 `cleanup` Move any superseded planning material that still looks active into the correct archive location so current docs remain trustworthy.
  - [x] 6.6 `final-state enforcement` Run the full repo validation set relevant to this migration, including CI-equivalent checks for mobile, admin-web, backend, and the new contract-validation layer.
  - [ ] 6.7 `final-state enforcement` Perform a final whole-system review to confirm there are no dead paths, broken links, stale contracts, or half-migrated release/auth flows left behind.
