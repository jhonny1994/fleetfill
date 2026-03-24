# FleetFill Production Readiness Audit

This document is the active cross-phase audit and production-readiness tracker for phases 0 through 14.

Use it to:

- review what is actually implemented, not what was only intended
- track concrete remediation work with file references
- separate code-fix work from manual or operator-only validation
- avoid losing important findings in chat history

This file is not canonical product truth. It is a working audit and remediation tracker.

## Current Verdict

All non-manual blockers for phases 0 through 14 are now closed. Phase 14 remains open only for representative-device and operator-environment validation before external tester rollout or production promotion.

Why:

- automated code, routing, backend, localization, CI, and release-governance gaps identified in the audit have been remediated and revalidated
- the remaining work is limited to real-device rehearsal, accessibility verification with assistive tech, and live-environment operator checks

## Production Blockers

These are the non-manual blockers that still prevent a clean "nothing missing or broken" signoff for phases 0 through 14.

### Critical

- [x] Close shipper and carrier role-guard gaps so authenticated users cannot enter the wrong role shell or role-specific operational routes (`lib/core/routing/app_route_guards.dart`)
- [x] Remove post-auth role mutation from onboarding so one account remains bound to exactly one role after setup (`lib/features/onboarding/presentation/onboarding_screens.dart`, `lib/core/auth/auth_repository.dart`, `docs/01-product-and-scope.md`, `docs/02-domain-and-state-model.md`)
- [x] Widen phone-completion enforcement so shipper operational actions cannot proceed before required business contact data exists (`lib/core/routing/app_route_guards.dart`, `docs/01-product-and-scope.md`, `docs/03-technical-architecture.md`)
- [x] Fix booking lifecycle semantics where booking creation still emits `booking_confirmed` side effects before payment approval secures the booking (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/02-domain-and-state-model.md`, `docs/06-operations-and-compliance.md`)
- [x] Ensure payment approval creates the required notifications and communications for both shipper and carrier, not only one side of the transaction (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/06-operations-and-compliance.md`)
- [x] Remove nullable-role drift in the profile schema so the database matches the exact-one-role product rule (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/01-product-and-scope.md`, `docs/02-domain-and-state-model.md`)
- [x] Remove committed secret-material risk from the repository, including the checked-in Firebase admin SDK JSON (`assets/fleetfill-firebase-adminsdk-fbsvc-f224198ecd.json`, `docs/04-data-and-security-model.md`)

### High

- [x] Allow balanced dispute evidence handling so carrier-side evidence is not structurally blocked when dispute review requires both parties' context (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/06-operations-and-compliance.md`)
- [x] Complete Arabic and French operational localization so critical user-facing copy no longer falls back to English in shipped flows (`lib/l10n/intl_ar.arb`, `lib/l10n/intl_fr.arb`, `docs/05-ux-and-localization.md`)
- [x] Finish the accessibility release pass for core shared widgets and trust-sensitive flows, especially semantics for money summaries, status chips, cards, and async status updates (`lib/shared/widgets/money_summary_card.dart`, `lib/shared/widgets/status_chip.dart`, `lib/shared/widgets/app_list_card.dart`, `docs/05-ux-and-localization.md`)
- [x] Run executable Supabase runtime security and email tests in CI instead of relying only on local instructions and manual invocation (`.github/workflows/supabase_validation.yml`, `supabase/tests/runtime_security_test.sql`, `supabase/tests/runtime_email_test.sql`, `supabase/README.md`)
- [x] Replace the old desktop-hosted smoke-only posture with mobile-agnostic automated critical-flow coverage in regular Flutter tests (`test/features/critical/critical_workflow_flows_test.dart`, `test/features/settings/settings_surface_test.dart`, `docs/03-technical-architecture.md`, `docs/07-implementation-plan.md`)
- [x] Add real release traceability artifacts so every release can map to a changelog entry and user-facing release notes as required by the release policy (`CHANGELOG.md`, `docs/planning/operations/release-operations.md`, `.github/RELEASE_TEMPLATE.md`, `.github/workflows/staging_release_candidate.yml`)

### Medium

- [x] Reconcile search UX with the canonical search contract so result cards and controls expose the intended operational context such as stronger route/capacity detail and supported preference inputs (`lib/features/shipper/presentation/shipper_screens.dart`, `docs/05-ux-and-localization.md`)
- [x] Reconcile shared settings with the documented settings surface so language, theme, and preference management are discoverable from the shared route cluster (`lib/features/profile/presentation/profile_screens.dart`, `docs/08-screen-map-and-routing.md`)
- [x] Reconcile admin queue navigation with the documented detail-route strategy where payment, dispute, payout, and email flows still rely mainly on sheets or inline actions (`lib/features/admin/presentation/admin_screens.dart`, `lib/core/routing/app_router.dart`, `docs/08-screen-map-and-routing.md`)
- [x] Make scheduler wiring and timed-automation invocation more explicit in repo-managed infrastructure so durable automation does not depend on undocumented operator setup (`supabase/scripts/configure_scheduled_automation.sql`, `supabase/README.md`, `supabase/functions/scheduled-automation-tick/index.ts`, `docs/03-technical-architecture.md`)
- [x] Reconcile email delivery log behavior with the append-oriented audit model described in the data and security docs (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/04-data-and-security-model.md`)

## Validation Needed After Fixes

- [x] `dart analyze`
- [x] `flutter test`
- [x] `supabase db reset --yes`
- [x] `supabase db lint --debug`
- [x] `supabase test db "supabase/tests/runtime_security_test.sql"`
- [x] `supabase test db "supabase/tests/runtime_email_test.sql"`

## Exit Criteria For Non-Manual Blocker Closure

- [x] No open item remains in `Production Blockers` critical or high severity
- [x] Docs and implementation agree on role, booking, payment, dispute, notification, and release semantics
- [x] CI enforces executable backend runtime verification in addition to schema reset and lint checks
- [x] Critical cross-feature flows have real integration evidence rather than smoke-only or fake-only coverage
- [x] No secrets or privileged credential files remain committed in the repository

## What Is Already Strong

- phases 0 through 4 are materially aligned after the earlier remediation pass
- core route and booking architecture is broadly aligned with the canonical docs
- newer Supabase migration naming and separation is much better aligned with `docs/09-supabase-implementation-notes.md` and the consolidated update rules in `docs/README.md`
- generated document processing now has a clearer worker boundary with claim and recovery semantics
- typed client settings remain aligned with the controlled settings contract

## Active Remediation Checklist

### Critical

- [x] Restrict `public.create_generated_document_record(...)` so it cannot be called by arbitrary authenticated users without strict ownership and workflow checks (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `supabase/migrations/20260317030000_create_operational_workflows_layer.sql`)
- [x] Harden `public.append_tracking_event(...)` with participant authorization, event allowlisting, and actor integrity so timeline events cannot be forged (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`)
- [x] Add required admin audit logging to payment approval and rejection workflows (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/06-operations-and-compliance.md`)
- [x] Add required admin audit logging to dispute resolution and payout release workflows (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/06-operations-and-compliance.md`)
- [x] Apply recent admin step-up enforcement consistently to dispute resolution and payout release, not only to settings/profile/email retry actions (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `supabase/migrations/20260317030000_create_operational_workflows_layer.sql`)

### High

- [x] Fix the dead-letter email resend safety bug so non-retryable failures stay blocked (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`)
- [x] Add explicit rate limiting to dispute creation because the canonical docs classify it as high-risk (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/04-data-and-security-model.md`)
- [x] Complete the transactional email event inventory so implementation matches the intended lifecycle events for booking, payment, delivery review, dispute, and payout (`supabase/functions/_shared/email-runtime.ts`, `docs/06-operations-and-compliance.md`)
- [x] Align booking lifecycle event naming and behavior where implementation still drifts from canonical semantics such as `booking_confirmed` vs current alternatives (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `docs/03-technical-architecture.md`, `docs/06-operations-and-compliance.md`)
- [x] Replace source-text security evidence tests with executed runtime tests for RLS, signed URLs, upload restrictions, audit logging, rate limiting, and transaction boundaries (`supabase/tests/runtime_security_test.sql`, `supabase/tests/contracts.sql`)

### Medium

- [x] Rename and reorganize phase-oriented tests so they are feature-based or behavior-based instead of plan-timeline based (`test/features/...`, `test/contracts/supabase/...`)
- [x] Split mixed-concern test files into domain-specific files so failures are easier to diagnose and maintain (`test/features/...`, `test/contracts/supabase/...`)
- [x] Move SQL/source regression checks into explicitly named contract or source-regression tests instead of presenting them as repository or integration verification (`test/contracts/supabase/...`)
- [x] Replace the current smoke-only settings coverage with behavior-driven critical-flow coverage in regular Flutter tests (`test/features/settings/settings_surface_test.dart`, `docs/07-implementation-plan.md`)
- [x] Implement real notification pagination or cursoring instead of a shallow bounded list approach if the current provider/repository contract remains fixed-size (`lib/features/notifications/infrastructure/notification_repository.dart`, `lib/features/notifications/application/notification_feed_controller.dart`, `lib/features/notifications/presentation/notifications_screens.dart`)
- [x] Reconcile and then implement Phase 11 push notifications through the configured Firebase Cloud Messaging HTTP v1 client plus worker path so the docs and checklist match real capability (`docs/03-technical-architecture.md`, `docs/07-implementation-plan.md`, `lib/features/notifications/`, `supabase/functions/push-dispatch-worker/index.ts`, `pubspec.yaml`)
- [x] Add broader CI-capable critical-flow coverage for startup restoration, shipper booking/payment state, carrier milestone progression, and admin queue refresh (`test/features/critical/critical_workflow_flows_test.dart`, `docs/07-implementation-plan.md`)
- [x] Add dispute evidence attachment support with private storage, secure access, and admin review visibility (`supabase/migrations/20260317030000_create_operational_workflows_layer.sql`, `lib/features/shipper/infrastructure/dispute_repository.dart`, `lib/core/routing/shared_route_screens.dart`)

### Low

- [x] Review test literals that depend on exact English copy and replace them with more durable assertions where practical (`test/core/localization/foundation_localization_accessibility_test.dart`, `test/features/settings/legal_policies_screen_test.dart`, `test/features/settings/settings_surface_test.dart`)
- [x] Consolidate dev-phase migration history into canonical layer migrations and document the same no-parallel-truth rule for docs and backend ownership (`supabase/README.md`, `docs/README.md`)

## Manual Or User-Intervention Validation Still Required

These are real Phase 14 items, but they require representative devices, staging setup, or operator execution rather than local code changes alone.

- [ ] Profile the app on a representative Android device in profile mode
- [ ] Validate repeated jank and long-list behavior on the target device class
- [ ] Run TalkBack and large-text accessibility checks
- [ ] Run manual Arabic, French, and English localization QA
- [ ] Rehearse critical shipper, carrier, and admin flows on a realistic device or staging path
- [ ] Verify hosted secrets, transactional email provider behavior, and scheduled automation in the real target environment
- [ ] Run true device-backed mobile flows once a supported Android or iOS device/emulator is available

## Phase-By-Phase Findings

### Phases 0 To 4

- Broadly aligned after the earlier remediation work
- Historical phases 0-4 findings were consolidated into this audit after the separate file became stale and redundant
- No current blocker here is the main reason Phase 14 remains open

### Phase 5 - Capacity Publication

- Capacity publication exists and is materially aligned
- Verified-carrier and vehicle gating is server-backed
- Remaining issue is mostly test quality rather than missing feature truth

### Phase 6 - Search

- Exact-lane search exists and is server-driven
- Search contract behavior is stronger than some later flows
- Performance and pagination still need real validation beyond local confidence
- The next consolidation pass should move requested date ownership fully into search so shipment drafts remain reusable and the UI no longer carries a tall shipment summary as the primary search surface

### Phase 7 - Booking And Pricing

- Core booking transaction shape is good: reservation, booking record, notifications, and outbox enqueueing are bundled in DB logic
- Remaining drift is mainly lifecycle naming and comms completeness

### Phase 8 - Payment Proof, Escrow, And Ledger

- Core payment review and ledger model is present
- Sensitive admin review actions now have audit logging and state-transition coverage aligned with the operational docs

### Phase 9 - Tracking, Delivery, And Completion

- Tracking append-only posture exists conceptually
- Timeline event insertion is now server-hardened; remaining confidence work is mainly real-device and operational validation

### Phase 10 - Disputes, Refunds, And Payouts

- Core dispute, refund, payout, audit, and step-up controls are implemented
- Remaining work here is representative-flow rehearsal rather than a known product-code gap

### Phase 11 - Ratings, Notifications, And Support

- In-app notifications and support surfaces exist
- Push delivery now has a concrete Firebase Cloud Messaging HTTP v1 path with client registration, queueing, and worker dispatch
- Support email queueing and email lifecycle are materially aligned; remaining work is real-environment secret/provider verification
- The next consolidation pass should move notification prompting into onboarding, shift entry to a shared app-bar bell, and collapse duplicated settings/help surfaces into one coherent notifications configuration path

### Phase 12 - Admin Surface And Operations

- Admin shell and operational pages are real and useful
- Sensitive admin actions now have stronger step-up, audit, and runtime coverage than earlier audit snapshots reflected

### Phase 13 - Generated Documents

- Generated-document processing is one of the stronger backend areas after the recent worker separation work
- Helper and privilege boundaries are now tighter; remaining validation is mostly runtime and operator-side

### Phase 14 - Hardening, Testing, And Release Readiness

- Non-manual closure achieved
- The remaining open items are manual/device/staging checks, not code or CI gaps

## Test Strategy Findings

Current issues:

- source-level contract checks still exist for broad schema regression, but critical security and transaction behavior now also has executable pgTAP coverage in `supabase/tests/runtime_security_test.sql`
- device-backed integration execution is still pending even though broader cross-feature widget-flow coverage now exists in `test/features/critical/critical_workflow_flows_test.dart`

Recommended target structure:

- `test/core/...`
- `test/shared/...`
- `test/features/auth/...`
- `test/features/verification/...`
- `test/features/capacity/...`
- `test/features/search/...`
- `test/features/booking/...`
- `test/features/payment/...`
- `test/features/tracking/...`
- `test/features/disputes/...`
- `test/features/notifications/...`
- `test/features/admin/...`
- `test/contracts/supabase/...` for explicit SQL or source-regression checks only
- `integration_test/...` only for true end-to-end or near-end-to-end mobile flow verification

Recent reorganization completed:

- phase-oriented test files were split into feature-based and contract-based files under `test/features/...`, `test/shared/...`, `test/core/...`, and `test/contracts/supabase/...`
- the former desktop-hosted integration smoke coverage now lives in `test/features/settings/settings_surface_test.dart`
- SQL/source checks now live in explicit Supabase contract tests rather than in files named as generic phase work

## Validation Baseline For Closing This Audit

Do not close the critical or high items above unless the relevant validations pass again:

- `dart analyze`
- `flutter test`
- `supabase db reset --yes`
- `supabase db lint --debug`

And for the security/test-hardening items, closure should also include executed verification, not just source-file assertions.

## Progress Notes

- executable runtime DB coverage now exercises RLS, upload-session enforcement, signed URL limits, admin step-up enforcement, audit logging, rollback-sensitive workflows, and email outbox/provider-event handling through `supabase/tests/runtime_security_test.sql` and `supabase/tests/runtime_email_test.sql`
- dev-phase Supabase history is now consolidated into three canonical layer migrations instead of accumulating fixup-on-fixup history
- support email enqueueing and generated-document worker orchestration are more aligned with the intended Edge Function vs RPC boundary
- the highest-risk Supabase findings from the recent audit were remediated in migrations covering generated documents, tracking events, payment review, disputes, payouts, and admin step-up enforcement
- the repo now has a central audit file for phases 0 through 14 so findings can be tracked without depending on chat history
- notifications now page through repository/controller state with refresh plus load-more behavior, matching the long-list guidance better than the previous fixed 50-item fetch
- notification, accessibility, and shared-settings tests now rely more on localized/runtime-derived expectations instead of exact English literals
- CI-capable critical-flow coverage now exists in `test/features/critical/critical_workflow_flows_test.dart` and `test/features/settings/settings_surface_test.dart`, while true device-backed mobile execution still depends on a supported Android or iOS device/toolchain
- private dispute evidence attachments now exist end-to-end through upload sessions, private storage access, and admin review surfaces
- push notifications now have a concrete client plus scheduled worker path instead of only device-token capture and in-app delivery
- the old standalone delivery playbook and phase 0-4 audit files were removed after their still-relevant guidance was consolidated into `docs/README.md` and this audit tracker
