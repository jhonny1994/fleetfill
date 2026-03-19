# FleetFill Audit For Phases 0 To 4

This document captures the audit findings for work that is already claimed complete in phases 0 through 4.

Use the checklist at the top as the active remediation list.

Rules for this file:

- keep future planned phase work out of the top checklist
- only track issues that affect phases 0 through 4 or their production-readiness truth
- keep exact file references so fixes can be verified quickly
- update this file as issues are fixed

## Active Remediation Checklist For Passed Phases

### Critical

- [x] Fix Supabase runtime config wiring so the app actually loads `supabaseUrl` and `supabaseAnonKey` from environment defines and initializes reliably (`lib/core/config/app_environment.dart:23`, `lib/core/config/app_bootstrap.dart:81`)
- [x] Close the profile insert privilege-escalation path so authenticated users cannot self-assign protected fields such as `role='admin'`, activation, verification, or ratings on first insert (`supabase/migrations/20260317150600_create_storage_policies_and_security_triggers.sql`)
- [x] Close insert-time protection gaps for `vehicles` and `payout_accounts` so users cannot self-set verification-sensitive fields on create (`supabase/migrations/20260317150600_create_storage_policies_and_security_triggers.sql`)
- [x] Rework Phase 4 verification SQL so aggregate profile/vehicle verification state is computed from the latest effective document per type, not all historical rows (`supabase/migrations/20260318170000_create_verification_effective_document_helpers.sql`, `supabase/migrations/20260318170200_create_verification_packet_approval.sql`)
- [x] Rework `admin_approve_verification_packet(...)` so it only approves current effective documents and refuses incomplete packets instead of force-verifying everything (`supabase/migrations/20260318170200_create_verification_packet_approval.sql`)

### High

- [x] Replace placeholder runtime automation functions with real production behavior or roll back the completed checklist claims for Phase 2 automation (`supabase/functions/scheduled-automation-tick/index.ts:1`, `supabase/functions/transactional-email-dispatch-worker/index.ts:1`, `supabase/functions/email-provider-webhook/index.ts:1`, `supabase/functions/support-email-dispatch/index.ts:1`)
- [x] Align Google sign-in truth across config, UI, and docs so it is either fully enabled and working or not exposed/claimed as complete (`supabase/config.toml:36`, `lib/core/auth/auth_repository.dart:84`, `lib/core/auth/auth_screens.dart:104`)
- [x] Narrow payment proof visibility so carriers cannot access shipper payment evidence unless the product explicitly requires that exposure (`supabase/migrations/20260317150500_enable_rls_and_create_table_policies.sql`, `supabase/functions/signed-file-url/index.ts:67`)
- [x] Harden file upload finalization so server truth verifies stored object integrity instead of trusting client-declared metadata too much (`supabase/migrations/20260317150200_create_client_upload_and_finalize_rpc.sql`)
- [x] Make admin verification queue loading scalable with server-side packet shaping or pagination/windowing instead of loading everything client-side (`lib/features/admin/infrastructure/verification_admin_repository.dart:23`, `lib/shared/providers/providers.dart:55`, `lib/features/admin/presentation/admin_screens.dart:237`)
- [x] Turn the shared document viewer into a real production document open/view/download experience instead of exposing a signed URL string as the main UX (`lib/core/routing/shared_route_screens.dart:264`)

### Progress Notes

- runtime config now reads Supabase keys from compile-time defines with supported fallback names, so app bootstrap can actually initialize Supabase from repository-controlled configuration (`lib/core/config/app_environment.dart`)
- sensitive profile, vehicle, and payout-account fields are now protected on insert as well as update, including an explicit block against direct admin-profile creation (`supabase/migrations/20260317150600_create_storage_policies_and_security_triggers.sql`)
- Phase 4 verification review now introduces current-effective-document helpers and incomplete-packet rejection so server truth is closer to the intended versioned-history model (`supabase/migrations/20260318170000_create_verification_effective_document_helpers.sql`, `supabase/migrations/20260318170200_create_verification_packet_approval.sql`)
- payment proof access is now shipper-or-admin only, and finalize flows now verify object existence plus storage metadata before metadata rows are recorded (`supabase/migrations/20260317150200_create_client_upload_and_finalize_rpc.sql`, `supabase/migrations/20260317150500_enable_rls_and_create_table_policies.sql`)
- supporting contract checks were expanded in `test/verification_workflows_test.dart`
- transactional email worker, scheduled automation tick, provider webhook handler, and support acknowledgement dispatcher now have real secured implementations instead of placeholder JSON responders (`supabase/functions/`)
- Google sign-in is now enabled in local Supabase config and gated in the app by explicit environment config so UI and runtime truth stay aligned (`supabase/config.toml`, `lib/core/config/app_environment.dart`, `lib/core/auth/auth_screens.dart`)
- admin verification queue now applies bounded candidate paging, narrows dependent data fetches by selected ids, and fetches packet detail independently from the list view so admin review no longer depends on loading every packet client-side (`lib/features/admin/infrastructure/verification_admin_repository.dart`, `lib/shared/providers/providers.dart`, `lib/features/admin/presentation/admin_screens.dart`)
- shared document viewer now exposes a real open-document action using the signed URL rather than only printing the URL (`lib/core/routing/shared_route_screens.dart`)
- route guard providers now resolve through a single guard pipeline with admin step-up layered on top, reducing duplicated redirect logic and drift risk (`lib/core/routing/app_route_guards.dart`)
- signed document open failures now map to localized document-viewer messaging instead of leaking a hardcoded fallback string (`lib/features/carrier/infrastructure/vehicle_repository.dart`, `lib/core/auth/auth_error_messages.dart`, `lib/core/routing/shared_route_screens.dart`, `lib/l10n/intl_en.arb`)
- route and profile access gates now match the canonical operational-gating rule: profile/settings access stays available without a phone number while operational shipper search and carrier workflow surfaces remain gated (`lib/core/routing/app_route_guards.dart`, `test/auth_routing_guard_test.dart`)
- route constants and helper paths now match registered router paths for shipper booking/payment and carrier/admin detail flows, reducing drift from ad hoc string composition (`lib/core/routing/app_routes.dart`, `lib/features/profile/presentation/profile_screens.dart`, `lib/features/carrier/presentation/carrier_screens.dart`, `lib/features/admin/presentation/admin_screens.dart`)
- focus traversal wrappers are now applied to the main auth, onboarding, profile-edit, vehicle-edit, and admin rejection-reason form surfaces, and reduced-motion policy now drives auth card and submit-button animations (`lib/core/auth/auth_screens.dart`, `lib/features/onboarding/presentation/onboarding_screens.dart`, `lib/features/profile/presentation/profile_components.dart`, `lib/features/carrier/presentation/carrier_screens.dart`, `lib/features/admin/presentation/admin_screens.dart`, `lib/core/auth/auth_forms.dart`)
- bidi-safe formatting is now used more consistently for carrier review scores, vehicle plates, vehicle capacities, admin review metadata, and shared operational identifiers shown to users (`lib/core/routing/shared_route_screens.dart`, `lib/features/carrier/presentation/carrier_screens.dart`, `lib/features/admin/presentation/admin_screens.dart`)
- public-carrier not-found handling and related repository error codes no longer depend on hardcoded English user copy, and product-facing auth/settings/document copy is more operational and less scaffold-like across locales (`lib/core/auth/auth_repository.dart`, `lib/core/routing/shared_route_screens.dart`, `lib/l10n/intl_en.arb`, `lib/l10n/intl_fr.arb`, `lib/l10n/intl_ar.arb`)
- onboarding profile completion, phone completion, admin verification review, and carrier document upload workflows now execute through feature application controllers instead of letting presentation own the end-to-end orchestration (`lib/features/onboarding/application/onboarding_workflows.dart`, `lib/features/admin/application/verification_workflows.dart`, `lib/features/carrier/application/verification_document_workflows.dart`)
- verification document upload now prefers file-path based storage upload on mobile and only falls back to in-memory bytes when needed, which avoids loading large Android uploads entirely into memory (`lib/features/carrier/application/verification_document_workflows.dart`, `lib/features/carrier/infrastructure/vehicle_repository.dart`)
- onboarding and profile editing now share one reusable profile-details form section, eliminating duplicated field/validation layout while preserving role-aware behavior (`lib/features/profile/presentation/profile_components.dart`, `lib/features/onboarding/presentation/onboarding_screens.dart`)
- verification status labeling now comes from one shared helper and feature navigation no longer relies on ad hoc path interpolation in presentation code (`lib/features/profile/presentation/profile_components.dart`, `lib/features/profile/presentation/profile_screens.dart`, `lib/features/carrier/presentation/carrier_screens.dart`, `lib/features/admin/presentation/admin_screens.dart`)
- ADR artifacts are present in-repo under `docs/adr/`, so the Phase 0 implementation-plan completion claim is now backed by repository evidence (`docs/adr/ADR-001-single-role-account-model.md`, `docs/adr/ADR-004-supabase-rpc-edge-boundaries.md`)

### Medium

- [x] Narrow phone gating so it matches the docs requirement of blocking operational actions rather than broad shell/profile access (`lib/core/routing/app_route_guards.dart:36`, `test/auth_routing_guard_test.dart:144`)
- [x] Align unknown-route and forbidden handling with the canonical not-found/forbidden UX instead of leaning on generic error handling (`lib/core/routing/app_router.dart:73`)
- [x] Fix route constant vs router path mismatches for booking/payment-related shipper routes (`lib/core/routing/app_routes.dart:82`, `lib/core/routing/app_router.dart:200`)
- [x] Simplify route guard composition to reduce duplicated evaluation logic and drift risk (`lib/core/routing/app_route_guards.dart:201`)
- [x] Move workflow orchestration out of presentation where it currently owns too much business flow logic (`lib/features/onboarding/application/onboarding_workflows.dart:1`, `lib/features/carrier/application/verification_document_workflows.dart:1`, `lib/features/admin/application/verification_workflows.dart:1`)
- [x] Replace memory-heavy document upload handling with a safer path for older Android devices and larger files (`lib/features/carrier/application/verification_document_workflows.dart:27`, `lib/features/carrier/infrastructure/vehicle_repository.dart:150`)
- [x] Apply reduced-motion policy consistently in real animated UI instead of only defining the policy (`lib/core/theme/motion_policy.dart:7`, `lib/core/auth/auth_forms.dart:169`)
- [x] Apply focus/accessibility helpers consistently to actual forms, dialogs, sheets, and other interactive flows (`lib/core/utils/app_focus.dart:3`, `lib/core/auth/auth_screens.dart:43`, `lib/features/admin/presentation/admin_screens.dart:487`)
- [x] Remove remaining hardcoded user-facing strings outside ARB/localization (`lib/core/auth/auth_repository.dart:145`, `lib/core/routing/shared_route_screens.dart:201`)
- [x] Apply bidi-safe formatting more consistently to operational identifiers actually shown to users (`lib/core/localization/bidi_formatters.dart:7`, `lib/features/carrier/presentation/carrier_screens.dart:186`, `lib/core/routing/shared_route_screens.dart:257`)
- [x] Replace scaffold/dev-style ARB copy with production-ready product language (`lib/l10n/intl_en.arb:4`, `lib/l10n/intl_fr.arb:4`, `lib/l10n/intl_ar.arb:4`)

### Low

- [x] Deduplicate repeated profile form logic between onboarding and profile editing (`lib/features/profile/presentation/profile_components.dart:70`, `lib/features/onboarding/presentation/onboarding_screens.dart:184`)
- [x] Deduplicate verification label mapping logic (`lib/features/profile/presentation/profile_components.dart:249`, `lib/features/profile/presentation/profile_screens.dart:165`)
- [x] Replace ad hoc string path building with safer centralized route helpers or named-route navigation (`lib/core/routing/app_routes.dart:82`, `lib/features/profile/presentation/profile_screens.dart:136`, `lib/features/carrier/presentation/carrier_screens.dart:105`, `lib/features/admin/presentation/admin_screens.dart:29`)
- [x] Either add in-repo ADR artifacts or uncheck the ADR completion claim if that work is not represented in the repository (`docs/07-implementation-plan.md:17`, `docs/adr/ADR-001-single-role-account-model.md:1`)

## Audit Context

### Overall Verdict

- architecture direction is good and now backed by repository truth
- phases 1 through 4 contain substantial real work and the audited remediation items are complete
- the repository is ready to move beyond the Phase 0-4 audit remediation pass
- future work should now focus on upcoming phases instead of unresolved audit debt in passed phases

### What Looks Good

- app structure and stack selection are broadly aligned with the architecture docs (`docs/03-technical-architecture.md:23`, `pubspec.yaml:9`)
- Material 3 theme and design token foundation are strong (`lib/core/theme/app_theme.dart`, `lib/core/theme/design_tokens.dart`)
- ARB localization is broadly adopted and most user-facing copy is not hardcoded (`lib/l10n/intl_en.arb`, `lib/l10n/intl_ar.arb`, `lib/l10n/intl_fr.arb`)
- locale fallback and localization baseline tests are in place (`lib/core/localization/locale_resolver.dart`, `test/foundation_localization_accessibility_test.dart`)
- shell routing and shared-above-shell route structure are mostly aligned with the screen-map docs (`lib/core/routing/app_router.dart`, `docs/08-screen-map-and-routing.md:78`)
- shared page-state widgets are a good match for the architecture guidance (`lib/shared/widgets/page_state_widgets.dart`)
- Phase 4 verification domain modeling and feature-test coverage are meaningful, even though server truth still needs fixes (`lib/features/carrier/domain/vehicle_models.dart`, `test/verification_workflows_test.dart`)

## Detailed Findings From Passed Phases

### Critical

- Supabase environment wiring is incomplete in repo code, so completed phases still depend on runtime setup that the repository itself does not fully express (`lib/core/config/app_environment.dart:23`, `lib/core/config/app_bootstrap.dart:81`)
- profile insert policy allows self-assignment of protected fields on first insert, including admin role escalation (`supabase/migrations/20260317150600_create_storage_policies_and_security_triggers.sql`)
- vehicle and payout-account insert policies do not protect verification-sensitive fields on create (`supabase/migrations/20260317150600_create_storage_policies_and_security_triggers.sql`)
- Phase 4 verification SQL computes status from all historical document rows instead of current effective rows, which breaks the intended replacement-with-history model (`supabase/migrations/20260318170000_create_verification_effective_document_helpers.sql`)
- `Approve all` logic can wrongly verify incomplete or historically rejected packets (`supabase/migrations/20260318170200_create_verification_packet_approval.sql`)

### High

- Phase 2 automation/runtime foundations are marked done, but several Edge Functions are still placeholders that only return descriptive JSON (`supabase/functions/scheduled-automation-tick/index.ts:1`, `supabase/functions/transactional-email-dispatch-worker/index.ts:1`, `supabase/functions/email-provider-webhook/index.ts:1`, `supabase/functions/support-email-dispatch/index.ts:1`)
- Google sign-in is exposed in product/docs/UI but disabled in local Supabase config, so the completed auth claim is overstated (`supabase/config.toml:36`, `lib/core/auth/auth_screens.dart:104`)
- proof-file access is too broad for the product trust model because carriers can reach shipper proof evidence (`supabase/migrations/20260317150500_enable_rls_and_create_table_policies.sql`, `supabase/functions/signed-file-url/index.ts:67`)
- upload/finalize flow does not verify stored-object truth strongly enough for sensitive file workflows (`supabase/migrations/20260317150200_create_client_upload_and_finalize_rpc.sql`)
- admin verification packet loading is not production-scalable because packet shaping happens client-side after large fetches (`lib/features/admin/infrastructure/verification_admin_repository.dart:21`)
- document viewing route exists, but the UX is still a signed-URL exposure flow rather than a true user-facing document experience (`lib/core/routing/shared_route_screens.dart:264`)

### Medium

- phone gating is broader than the canonical docs require for already-completed phases (`lib/core/routing/app_route_guards.dart:95`)
- unknown-route handling does not cleanly map to the documented not-found/forbidden UX (`lib/core/routing/app_router.dart:76`)
- route constants and real path registration are inconsistent in shipper booking/payment areas (`lib/core/routing/app_routes.dart:82`, `lib/core/routing/app_router.dart:204`)
- route guard evaluation is more duplicated than it should be (`lib/core/routing/app_route_guards.dart:214`)
- orchestration/business workflow still leaks into presentation code in onboarding, carrier, and admin flows (`lib/features/onboarding/presentation/onboarding_screens.dart:241`, `lib/features/carrier/presentation/carrier_screens.dart:337`, `lib/features/admin/presentation/admin_screens.dart:436`)
- upload flow is still memory-heavy for the target device profile (`lib/features/carrier/presentation/carrier_screens.dart:762`)
- reduced-motion and accessibility helper policies exist but are not consistently applied in real user flows (`lib/core/theme/motion_policy.dart:7`, `lib/core/utils/app_focus.dart:3`)
- a few hardcoded strings still leak outside localization boundaries (`lib/features/carrier/infrastructure/vehicle_repository.dart:218`, `lib/core/auth/auth_repository.dart:114`, `lib/core/routing/shared_route_screens.dart:201`)
- bidi-safe formatting is underused in actual user-visible identifiers (`lib/core/localization/bidi_formatters.dart:7`)
- some localization copy is still internal/dev-style rather than product-grade wording (`lib/l10n/intl_en.arb:138`, `lib/l10n/intl_en.arb:257`)

### Low

- profile form structure is duplicated in more than one feature surface (`lib/features/onboarding/presentation/onboarding_screens.dart:182`, `lib/features/profile/presentation/profile_components.dart:121`)
- verification label logic is duplicated (`lib/features/profile/presentation/profile_screens.dart:208`, `lib/features/profile/presentation/profile_components.dart:240`)
- route navigation still uses too much manual string composition (`lib/features/profile/presentation/profile_screens.dart:62`, `lib/features/carrier/presentation/carrier_screens.dart:105`, `lib/features/admin/presentation/admin_screens.dart:171`)
- ADR completion is not clearly evidenced in-repo even though it is checked in the plan (`docs/07-implementation-plan.md:17`)

## Broader Audit Notes That Were Deliberately Filtered Out Of The Top Checklist

These observations were intentionally not promoted to the active top checklist because they belong more to future planned work or later-phase expansion:

- missing implementation for future planned phases 5 and beyond
- future integration/performance quality gates that are not yet required by completed phase truth
- later-phase booking, dispute, payout, and workflow hardening that depends on features not yet built

Keep those out of the top remediation queue until the repo reaches the relevant phase.
