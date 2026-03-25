# PRD: Carrier Verification Domain Reset

## Introduction/Overview

FleetFill currently stores verification state on the shared `profiles` table, which causes every user role to inherit carrier-style verification semantics. In practice this produces incorrect behavior such as shippers appearing as "pending review" in admin verification surfaces even though they do not participate in the carrier verification workflow.

This work resets the verification domain to a clean production model:

- carrier verification is carrier-only
- vehicle verification remains vehicle-only
- shippers do not have a verification workflow unless one is explicitly designed later
- admin verification queues and carrier product gating read from a dedicated carrier verification aggregate rather than generic profile fields

The goal is to replace the current mixed model with a role-scoped verification system that matches real-world marketplace and logistics patterns, then reset and redeploy the system cleanly.

## Goals

- Remove carrier verification state from generic profile records.
- Introduce a dedicated carrier verification aggregate that represents carrier operational eligibility.
- Ensure shippers never appear in carrier verification queues, carrier verification badges, or carrier review workflows.
- Keep vehicle verification as its own domain with explicit vehicle-level status.
- Make admin web, Flutter mobile, and Supabase RPCs read from the new verification source of truth.
- Reset the environment cleanly with no legacy compatibility layer, fallback behavior, or dead verification paths.

## User Stories

- As an admin, I want the verification queue to show only carriers who actually require verification, so I can review the right accounts without noise.
- As an admin, I want shipper accounts to appear as normal users, not as verification cases, so account review and carrier verification remain separate concepts.
- As a carrier, I want my verification status to reflect my actual submitted packet and vehicles, so I can understand whether I am pending, verified, or rejected.
- As a shipper, I want my account to function without irrelevant verification warnings, so the product reflects my real onboarding path.
- As a developer, I want one clear source of truth for carrier verification, so UI and backend behavior cannot drift across surfaces.

## Functional Requirements

1. The system must remove carrier verification state from `public.profiles`.
2. The system must introduce a dedicated `public.carrier_verification_packets` table as the single aggregate source of truth for carrier verification status.
3. The `carrier_verification_packets` table must contain at minimum the carrier identifier, verification status, rejection reason, and lifecycle timestamps needed for product and admin reads.
4. The system must keep vehicle verification state on `public.vehicles`.
5. The system must keep verification documents as the historical evidence layer for profile-level carrier documents and vehicle documents.
6. The system must provide a database function that recalculates carrier packet status from the carrier's effective verification documents and vehicle verification state.
7. The system must update admin verification review actions so reviewing a document refreshes the associated carrier packet state.
8. The system must update packet approval actions so they operate on carriers only and resolve through the carrier packet aggregate.
9. The system must update public carrier profile reads to return carrier packet verification status instead of reading profile verification fields.
10. The system must ensure admin verification queue queries return carrier accounts only.
11. The system must ensure admin user list and user detail views do not display carrier verification status for shipper accounts.
12. The system must ensure carrier-only product gates in the Flutter app read the carrier verification packet state rather than generic profile verification fields.
13. The system must ensure shipper product flows are unaffected by the carrier verification model and do not display carrier verification state.
14. The system must localize verification-related labels using role-aware display logic so raw enum values or irrelevant statuses do not leak into the UI.
15. The system must support a full reset deployment path with no legacy compatibility code, no backfill requirements, and no fallback reads from old profile verification fields.
16. The system must update tests and verification tooling so they assert the new carrier-only verification contract.

## Non-Goals (Out of Scope)

- Designing a new shipper verification or business verification workflow.
- Preserving historical compatibility with profile-level verification fields.
- Backfilling or migrating legacy production data from the old verification model.
- Changing the current vehicle verification concept beyond integrating it into carrier packet aggregation.
- Redesigning unrelated onboarding, auth, or admin features outside the verification domain.

## Design Considerations

- Shipper-facing and admin-facing UI should avoid showing placeholder or misleading verification badges for shipper accounts.
- When verification is shown, it should be role-aware and localized.
- Carrier verification screens should communicate packet state clearly and continue to surface rejection reasons when applicable.

## Technical Considerations

- This should be implemented as a reset-oriented schema correction, not a compatibility bridge.
- Because the user explicitly plans to reset environments, the cleanest implementation is to rewrite the consolidated base verification schema to the correct target model rather than preserving obsolete profile verification columns.
- The carrier verification aggregate should be modeled explicitly in SQL instead of recomputing everything ad hoc in every consumer.
- Admin web, Flutter mobile, and Supabase RPC surfaces should all depend on the same carrier verification source of truth.
- Existing enum localization cleanup should be preserved and extended where needed.

## Success Metrics

- Shipper accounts never appear in carrier verification queues after reset.
- Shipper accounts never display carrier-style "pending review" or equivalent verification states.
- Carrier admin verification queue count matches only real carrier packets requiring review.
- Carrier route and booking gates continue to block unverified carriers and allow verified carriers.
- No active runtime consumer reads carrier verification from `profiles`.
- Verification-related admin and app views display localized, role-appropriate labels instead of raw enum keys.

## Open Questions

- None for the target model. Shippers are explicitly outside the carrier verification domain.
