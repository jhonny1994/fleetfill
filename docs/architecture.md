# Architecture

## Runtime Contract

FleetFill uses one product contract across local and hosted runtimes.

Behavior is determined by:

- Supabase URL
- publishable and service keys
- redirect URLs
- provider secrets
- deployment host

There is no separate product model for local, staging, or production. The same app runs against different infrastructure targets.

## Application Surfaces

- Flutter app in `apps/mobile/lib/` is the main shipper and carrier client.
- Next.js admin console in `apps/admin-web/` is the primary internal operations console.
- Supabase in `backend/supabase/` owns schema, RLS, RPCs, storage, and Edge Functions.

## Backend Boundaries

- Business rules live in Postgres functions, policies, and controlled Edge workers.
- Flutter and admin-web are clients of the same Supabase backend.
- The admin console is not a second backend.
- Edge Functions are used for scheduled automation, provider integration, document generation, and other privileged workflows.

## Auth And Routing

- Supabase Auth owns email/password signup, confirm-email, password reset, and third-party auth.
- The app uses deep-link aware auth routing and explicit post-auth guards.
- Role, onboarding, and operational access are enforced through shared route guards and backend checks.

## Data And Security

- RLS is the default access boundary.
- Privileged workflows are exposed through narrowly granted RPCs and internally authenticated workers.
- Private files stay in protected storage paths with server-validated access.
- Audit logging is required for sensitive admin actions.
- Rate limiting applies to high-risk user actions like proof uploads and disputes.

## Booking Lifecycle Architecture

- `public.bookings` is the operational center of the shipment lifecycle once capacity is reserved.
- Lifecycle truth is composed from authoritative records already in the system:
  - `bookings`
  - `tracking_events`
  - `payment_proofs`
  - `disputes`
  - `payouts`
  - `payout_requests`
  - `generated_documents`
- Flutter and admin-web present role-specific booking workspaces, but they do not own lifecycle rules.
- Timeline rendering is client-side presentation over backend-owned state, not a second persisted event system in this phase.
- Grace-period and payout eligibility logic stay backend-owned and are exposed through RPCs instead of duplicated UI calculations.
- Home dashboards, booking workspaces, notifications, and admin queue/detail pages must all project the same lifecycle truth instead of inventing role-specific state machines.
- Experience improvements should reuse existing authoritative records before introducing new persistence or duplicated workflow tables.

## Verification Domain

- Carrier verification is carrier-only and is stored in `public.carrier_verification_packets`.
- Vehicle verification remains vehicle-only on `public.vehicles`.
- Shippers are outside the carrier verification domain and must not appear in carrier verification queues or carrier verification UI.
- Admin and mobile carrier gating read packet status from the carrier verification aggregate, not from shared profile fields.
- Verification documents remain the evidence layer for carrier profile documents and vehicle documents, while packet status is the operational aggregate.

## Communications Architecture

Two email systems exist by design:

- Auth email:
  - signup confirmation
  - password reset
  - managed by Supabase Auth
- Transactional email:
  - booking, payment, delivery review, dispute, payout, document, and support events
  - managed by FleetFill outbox tables, workers, provider integration, and provider webhook reconciliation

Push notifications follow the same operational model as transactional email: queue, worker, provider, and delivery status.

Notification architecture is unified at the event level and intentionally separated at the delivery-channel level:

- in-app notifications are the user-facing source of truth
- push notifications are interruption and re-entry channels for mobile users
- transactional email is a supporting external channel
- admin operations remain queue, dashboard, search, and audit driven rather than FCM driven

## Product Experience Architecture

FleetFill product quality depends on one cross-surface contract:

- one booking
- one truth
- one next action
- one timeline

That contract means:

- app and admin should not describe the same lifecycle state with different domain language
- timeline labels should not leak storage enums or mismatched workflow copy
- success, rejection, delay, and blocked states should map to consistent next-step guidance
- generated records and receipts should be presented as part of the lifecycle, not as detached files

## Quality Hardening Rule

When product semantics change, the repo should be updated as one coherent truth:

- canonical migrations
- generated types
- client copy and localization
- docs
- tests

Do not leave compatibility layers, dead UX branches, or stale planning artifacts once the new truth is established.

## Automation

Scheduled operations run through the automation tick and supporting workers. The scheduler is infrastructure, but the workflow contract is repo-owned:

- recover stale jobs
- dispatch transactional email
- dispatch push
- process generated documents
- run bounded operational maintenance tasks

The scheduler and internal worker endpoints use a FleetFill-controlled internal automation token. Service-role credentials remain reserved for privileged database or admin access, not for internal Edge endpoint auth.

## Documentation Rule

Keep implementation detail at the level needed to understand the contract. Put historical rollout notes and superseded plans in `docs/archive/`, not beside active architecture.
