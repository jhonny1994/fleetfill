## Relevant Files

- `backend/supabase/migrations/20260317010000_create_foundation_layer.sql` - Consolidated foundation schema that currently places verification fields on `profiles`.
- `backend/supabase/migrations/20260317020000_create_verification_and_capacity_layer.sql` - Verification RPCs and helper functions that currently refresh and expose profile-level verification state.
- `apps/admin-web/lib/queries/admin-queues.ts` - Admin verification queue query layer.
- `apps/admin-web/lib/queries/admin-verification.ts` - Admin verification detail query layer.
- `apps/admin-web/lib/queries/admin-users.ts` - Admin users listing and filtering logic.
- `apps/admin-web/lib/queries/admin-search.ts` - Admin search metadata that surfaces role and verification labels.
- `apps/admin-web/app/[lang]/(admin)/dashboard/page.tsx` - Dashboard verification preview card rendering.
- `apps/admin-web/app/[lang]/(admin)/users/page.tsx` - Admin users list verification display.
- `apps/admin-web/app/[lang]/(admin)/users/[userId]/page.tsx` - Admin user detail verification display.
- `apps/admin-web/app/[lang]/(admin)/verification/[carrierId]/page.tsx` - Carrier verification review screen.
- `apps/admin-web/lib/i18n/admin-ui.ts` - Shared admin localization and enum label helpers.
- `lib/core/auth/auth_state.dart` - Flutter auth snapshot and profile model, currently carrying profile verification state.
- `lib/core/auth/auth_repository.dart` - Flutter auth repository and public carrier profile reads.
- `lib/core/routing/app_route_guards.dart` - Carrier gating logic based on verification.
- `lib/features/carrier/presentation/carrier_screens.dart` - Carrier home and verification messaging.
- `lib/features/admin/infrastructure/verification_admin_repository.dart` - Flutter admin verification repository.
- `test/contracts/` - Contract tests for verification semantics and schema-dependent behaviors.
- `docs/architecture.md` - Active architecture documentation for verification domain truth.
- `docs/operations.md` - Active operational documentation for reset and deploy posture.

### Notes

- This task list assumes a reset-oriented implementation with no branch creation and no legacy compatibility path.
- Tests should be updated alongside the source files they protect.
- The final implementation should remove obsolete profile verification reads instead of leaving fallback code in place.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 1.0 Redesign the verification domain schema for a carrier-only model
  - [x] 1.1 Remove `verification_status` and `verification_rejection_reason` from the `public.profiles` table definition in the consolidated foundation migration.
  - [x] 1.2 Keep vehicle verification fields on `public.vehicles` and confirm they remain the only entity-level verification columns outside the new carrier packet aggregate.
  - [x] 1.3 Add a new `public.carrier_verification_packets` table with a carrier primary key, status, rejection reason, and audit-friendly timestamps.
  - [x] 1.4 Ensure the new carrier packet table is keyed to carrier profiles only by foreign key and usage contract.
  - [x] 1.5 Remove any profile insert/update trigger behavior that automatically assigns verification state to all users.
- [x] 2.0 Rebuild verification RPCs and database helpers around carrier packets
  - [x] 2.1 Replace profile-based verification refresh logic with a carrier packet refresh function that aggregates effective profile documents and vehicle verification state.
  - [x] 2.2 Preserve and adapt required-document helpers so they validate carrier packets rather than generic profile verification.
  - [x] 2.3 Update admin document review RPCs so document decisions refresh the associated carrier packet and any affected vehicle state.
  - [x] 2.4 Update packet approval RPCs so they operate on carriers only and resolve through the carrier packet aggregate.
  - [x] 2.5 Update public carrier profile RPCs to return verification state from `carrier_verification_packets` instead of `profiles`.
  - [x] 2.6 Remove obsolete SQL functions or branches that write carrier verification state back to `profiles`.
- [x] 3.0 Cut Flutter app auth and carrier UX over to carrier packet verification
  - [x] 3.1 Remove generic profile verification fields from the Flutter auth profile model.
  - [x] 3.2 Introduce carrier-specific verification state in the auth snapshot or equivalent carrier-facing auth contract.
  - [x] 3.3 Update auth repository reads so carrier verification comes from the new packet source rather than direct profile columns.
  - [x] 3.4 Update route guards to keep carrier gating behavior intact while depending on carrier packet verification.
  - [x] 3.5 Update carrier home and verification UI to render packet status and rejection messaging from the new carrier-only source.
  - [x] 3.6 Confirm shipper flows no longer read, infer, or display carrier verification state anywhere in the mobile app.
- [x] 4.0 Cut admin web and Flutter admin surfaces over to carrier-only verification semantics
  - [x] 4.1 Update admin verification queue queries to source status from carrier packets and include carriers only.
  - [x] 4.2 Update admin verification detail queries to join carrier packet data and stop relying on profile verification fields.
  - [x] 4.3 Update admin user list and user detail views so shippers do not display carrier verification state.
  - [x] 4.4 Update admin dashboard verification summaries and preview cards to read the carrier-only verification domain.
  - [x] 4.5 Update admin search and metadata labeling so verification is role-aware and localized from the new source of truth.
  - [x] 4.6 Update Flutter admin repositories and any shared admin models to use carrier packet verification semantics consistently.
- [ ] 5.0 Remove obsolete profile verification usage, update docs, and reset-oriented validation
  - [x] 5.1 Search the repo for remaining reads or writes of profile-level verification fields and delete them.
  - [x] 5.2 Update active architecture and operations docs to describe the carrier-only verification model and reset-first deployment posture.
  - [x] 5.3 Add or update contract tests for carrier packet aggregation, carrier-only admin verification queues, and shipper exclusion from verification semantics.
  - [x] 5.4 Run admin web lint/typecheck and Flutter analysis for the changed verification surfaces.
  - [x] 5.5 Reset the local database from zero, reseed it, and verify the new verification flow against a clean environment.
  - [ ] 5.6 Push the clean schema and application changes to production after reset validation passes.
