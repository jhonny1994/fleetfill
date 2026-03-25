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

- Flutter app in `lib/` is the main shipper and carrier client.
- Next.js admin console in `admin-web/` is the primary internal operations console.
- Supabase in `supabase/` owns schema, RLS, RPCs, storage, and Edge Functions.

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
