## Relevant Files

- `lib/core/config/app_environment.dart` - Main Flutter runtime config model; currently contains the enum-based environment split and key/URL branching that needs to be removed.
- `lib/core/config/app_bootstrap.dart` - Flutter bootstrap logic; currently uses named environment state to decide local-backend failure behavior and runtime logging.
- `lib/core/config/config.dart` - Re-exports the config surface; relevant if public config APIs change.
- `test/core/config/app_environment_test.dart` - Core Flutter tests for environment parsing, key precedence, and local URL normalization; must be rewritten around the unified contract.
- `.vscode/launch.json` - Local Flutter launch configs currently pass `APP_ENV`; must be simplified to URL/key-driven startup only.
- `.env.example` - Root env example; currently documents `APP_ENV` and a split local/production model that needs to be collapsed.
- `.github/workflows/flutter_quality.yml` - Flutter CI currently injects `APP_ENV=local`; must stop relying on named runtime environments.
- `.github/workflows/supabase_validation.yml` - Supabase validation workflow currently materializes `APP_ENV` into `.env`; must move to pure URL/key-driven config.
- `.github/workflows/staging_release_candidate.yml` - Release workflow still treats staging as a first-class concept; should be rewritten or renamed around real deploy/release verification.
- `.github/workflows/admin_web_deploy.yml` - Deploy workflow can keep preview/prod as Vercel channels, but wording and assumptions must stop implying app runtime environments.
- `admin-web/lib/admin-environment.ts` - Admin-only inferred environment label helper; should be removed.
- `admin-web/components/admin-shell/admin-header.tsx` - Displays the admin environment badge; must be simplified after environment-label removal.
- `admin-web/app/[lang]/(admin)/layout.tsx` - Consumes the admin header and may need prop/layout cleanup after badge removal.
- `admin-web/lib/i18n/dictionaries.ts` - Contains environment-related admin copy that should be removed if the badge goes away.
- `admin-web/.env.example` - Admin-web env example currently documents `NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL` and a local/preview/production matrix.
- `admin-web/README.md` - Admin-web runtime/deploy docs currently describe a separate admin environment system.
- `README.md` - Top-level project readme should describe one shared runtime contract across clients and ops.
- `docs/03-technical-architecture.md` - Canonical architecture doc; currently references broader environment concepts that need to be unified.
- `docs/07-implementation-plan.md` - Implementation doc likely contains environment/release terminology that must match the new contract.
- `docs/09-supabase-implementation-notes.md` - Backend/runtime notes should describe URL/key-driven behavior, not named app environments.
- `docs/planning/admin-web/admin-web-console-plan.md` - Admin planning doc includes environment matrix language that must be reconciled.
- `docs/planning/admin-web/admin-web-master-spec.md` - Master admin spec needs to stop describing admin runtime environments separately.
- `docs/planning/admin-web/admin-web-system-design.md` - System design should distinguish deployment channel vs runtime behavior.
- `docs/planning/admin-web/admin-web-production-checklist.md` - Production checklist should no longer require validating a separate environment badge/model.
- `docs/planning/admin-web/admin-web-browser-qa-checklist.md` - Browser QA checklist currently references environment verification; needs to be reframed around actual host/backend targets.
- `docs/planning/admin-web/prd-admin-web-console.md` - PRD should align with the unified runtime contract.
- `docs/planning/admin-web/tasks-admin-web-console.md` - Existing admin task plan should be updated so it no longer assumes admin-specific environment management.
- `docs/planning/operations/tasks-environment-contract-unification.md` - Task file for this cross-cutting work item.

### Notes

- Generated Flutter files like `app_environment.freezed.dart` and `app_environment.g.dart` will also change when the source model changes, but they should not be edited manually.
- Vercel preview can remain as a deployment channel without being treated as a FleetFill runtime environment.
- `LOCAL_ANDROID_NETWORK_TARGET` remains a technical transport override, not an environment.
- In implementation, tests should be updated before broad doc cleanup is considered complete, because the runtime contract is changing.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 0.0 Create feature branch
  - [x] 0.1 Create and checkout a new branch for the environment-contract unification work.
  - [x] 0.2 Confirm the branch starts from the intended base and does not mix unrelated UI/admin work.

- [x] 1.0 Lock the unified environment contract
  - [x] 1.1 Define the new contract in implementation terms: FleetFill runtime behavior is determined by actual URLs, client keys, and secrets, not named app environments.
  - [x] 1.2 Remove `staging`, `preview`, and admin-only environment labels as first-class runtime concepts from the implementation plan.
  - [x] 1.3 Keep `LOCAL_ANDROID_NETWORK_TARGET` as the only local-only technical override and explicitly document that it is not an environment.
  - [x] 1.4 Decide the hosted-vs-local classification rule for Flutter runtime logic based on the Supabase host pattern.
  - [ ] 1.5 Record the distinction between deployment channels and runtime contract so future docs do not reintroduce the split.

- [x] 2.0 Refactor Flutter runtime configuration
  - [x] 2.1 Remove the `AppEnvironment` enum from `lib/core/config/app_environment.dart`.
  - [x] 2.2 Remove the `environment` field from `AppEnvironmentConfig`.
  - [x] 2.3 Remove `APP_ENV` parsing from `AppEnvironmentConfig.fromDefines()`.
  - [x] 2.4 Introduce a small internal helper in Flutter config that classifies Supabase URLs as local/dev target vs hosted target.
  - [x] 2.5 Change client-key precedence so local/dev targets prefer `SUPABASE_ANON_KEY` and hosted targets prefer `SUPABASE_PUBLISHABLE_KEY`.
  - [x] 2.6 Keep backward-compatible fallback behavior when only one of the two client keys is present.
  - [x] 2.7 Update local URL normalization so Android emulator host substitution depends on the URL being local/dev plus `LOCAL_ANDROID_NETWORK_TARGET=emulator`.
  - [x] 2.8 Update bootstrap failure handling in `app_bootstrap.dart` so unreachable local/dev backends still fail loudly, while hosted targets degrade safely.
  - [x] 2.9 Remove environment-name-based logging/branching from bootstrap and replace it with target-kind-aware logging where still useful.
  - [x] 2.10 Regenerate the Flutter codegen outputs affected by the config model change.

- [x] 3.0 Update Flutter tests and local tooling
  - [x] 3.1 Rewrite `test/core/config/app_environment_test.dart` around local/dev vs hosted classification instead of enum values.
  - [x] 3.2 Add test cases for loopback, emulator, LAN host, and hosted Supabase URLs.
  - [x] 3.3 Add test cases for client-key precedence using the new contract.
  - [x] 3.4 Add test cases confirming local-only normalization does not affect hosted URLs.
  - [x] 3.5 Remove `APP_ENV` from `.vscode/launch.json`.
  - [x] 3.6 Keep the emulator/device launch distinction only through `LOCAL_ANDROID_NETWORK_TARGET` and URL differences.
  - [x] 3.7 Check for any remaining Flutter/test references to `AppEnvironment`, `APP_ENV`, or `staging` and remove them.

- [ ] 4.0 Remove the separate admin-web environment system
  - [x] 4.1 Delete or inline-remove `admin-web/lib/admin-environment.ts`.
  - [x] 4.2 Remove environment badge rendering from `admin-web/components/admin-shell/admin-header.tsx`.
  - [x] 4.3 Clean up `admin-web/app/[lang]/(admin)/layout.tsx` if header props/layout become simpler after badge removal.
  - [x] 4.4 Remove environment-label strings from `admin-web/lib/i18n/dictionaries.ts`.
  - [x] 4.5 Remove `NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL` from `admin-web/.env.example`.
  - [x] 4.6 Rewrite `admin-web/README.md` so `NEXT_PUBLIC_SITE_URL` is described only as host/callback/deploy context, not as an app environment switch.
  - [x] 4.7 Check the admin web for any remaining references to `Local`, `Preview`, or `Production` runtime labels and remove them.
  - [x] 4.8 Verify the admin shell still has good operator context without the badge and does not need a replacement.

- [ ] 5.0 Unify CI/CD and local environment examples
  - [x] 5.1 Remove `APP_ENV` from `.github/workflows/flutter_quality.yml`.
  - [x] 5.2 Remove `APP_ENV` from `.github/workflows/supabase_validation.yml` and stop writing it into the generated `.env`.
  - [x] 5.3 Ensure Supabase validation still provides only the secrets/URLs the app actually needs.
  - [x] 5.4 Rewrite `.env.example` so it documents one contract driven by secrets and URLs, not named environments.
  - [x] 5.5 Simplify comments in `.env.example` to distinguish local-only values from hosted/cloud values without inventing separate app environments.
  - [ ] 5.6 Review `.github/workflows/admin_web_deploy.yml` and keep preview/production only as Vercel deployment-channel language.
  - [x] 5.7 Rewrite or rename `.github/workflows/staging_release_candidate.yml` so it no longer treats staging as a FleetFill runtime environment.
  - [ ] 5.8 Check for any remaining CI/config references to `staging`, `preview`, or `APP_ENV` that describe runtime behavior and remove them.

- [ ] 6.0 Rewrite docs around the unified contract
  - [ ] 6.1 Update `README.md` so the top-level project explanation uses one shared runtime contract across Flutter, admin web, and backend tooling.
  - [ ] 6.2 Update `docs/03-technical-architecture.md` to define runtime behavior in terms of actual backend target and secrets.
  - [ ] 6.3 Update `docs/07-implementation-plan.md` to remove split environment concepts from implementation guidance.
  - [ ] 6.4 Update `docs/09-supabase-implementation-notes.md` so backend/runtime notes match the new contract.
  - [ ] 6.5 Update admin planning docs to remove the separate admin environment matrix and badge assumptions.
  - [ ] 6.6 Update readiness and QA docs so they validate real host/backend targeting instead of checking display labels.
  - [ ] 6.7 Ensure docs still distinguish Vercel preview deployments from FleetFill runtime behavior.
  - [ ] 6.8 Run a final doc sweep for `staging`, `preview`, `APP_ENV`, and environment-label language that is no longer valid.

- [ ] 7.0 Validate the unified environment contract end to end
  - [ ] 7.1 Run Flutter config tests and confirm the new hosted-vs-local logic passes.
  - [ ] 7.2 Run `dart analyze` and the relevant Flutter test targets that cover config/bootstrap behavior.
  - [ ] 7.3 Run `pnpm --dir admin-web typecheck` and `pnpm --dir admin-web build` to confirm badge-removal cleanup is complete.
  - [ ] 7.4 Run CI-equivalent local checks for the updated workflows where practical.
  - [ ] 7.5 Verify the local Flutter launch configs still work for emulator and real-device testing.
  - [ ] 7.6 Verify the admin web still authenticates and routes correctly without any environment badge dependency.
  - [ ] 7.7 Do a final repo search to confirm no stale first-class runtime environment concepts remain outside legitimate deployment-channel docs.

## Assumptions And Defaults

- The intended final model is one FleetFill runtime contract across the codebase.
- “Environment” will no longer be a first-class product/runtime concept in the code; actual behavior is driven by URLs, keys, and secrets.
- Local development and cloud deployment may still use different values, but that difference is configuration only.
- Vercel preview can remain operationally useful, but it must not be treated as a FleetFill runtime environment.
- The implementation should prefer minimal churn in public naming where possible; for example, `AppEnvironmentConfig` may keep its type name even if the enum is removed.
- This plan does not include introducing a new centralized config package; it focuses on unifying the existing codebase around one contract.
