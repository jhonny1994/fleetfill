# Operations

## Three-Layer Production System

FleetFill production operations follow a three-layer model:

- control plane
  - GitHub Actions decides what runs and when
  - operators choose which production surface to promote
- execution plane
  - repo-owned scripts in [C:\Users\raouf\projects\fleetfill\tool](C:\Users\raouf\projects\fleetfill\tool) perform the project-specific rollout work
- hosted platforms
  - Supabase, Vercel, and mobile distribution receive the promoted artifacts or configuration

This split is intentional. It keeps production control centralized while preserving repo-owned rollout logic that would be brittle or duplicated if expanded directly into raw workflow YAML.

## Operational Model

FleetFill is an operator-reviewed marketplace. Verification, payment proof review, dispute handling, payout release, and support all have explicit administrative oversight.

Verification operating rules:

- Carrier verification is reviewed through carrier packets only.
- Vehicle document review feeds carrier operational eligibility through the packet aggregate.
- Shippers do not have a carrier verification state and must not be surfaced in verification queues.
- Reset-oriented deployments should validate carrier verification from a clean database state rather than preserving obsolete profile verification fields.

## Payments

- Shippers pay through approved external rails.
- Payment proof is reviewed before funds are treated as secured.
- Carrier payout is released only after the booking is eligible.
- Carriers can request payout after the grace period, but release remains an admin-reviewed action.
- Payment approval, rejection, refund, and payout release require auditability and step-up where appropriate.

## Delivery And Disputes

- Delivery enters a reviewable state before it becomes fully completed.
- Disputes must be opened inside the allowed review window.
- Resolution outcomes are explicit and auditable.
- Evidence handling must support both sides of the dispute.

## Support

- Support is handled through in-app requests and threaded replies.
- Email is a supporting notification channel, not the system of record.
- Support acknowledgements and forwarding belong to the transactional communications layer.

## Email Ownership

### Supabase Auth Email

Use Supabase Auth for:

- confirm email
- password reset

These flows depend on:

- Supabase Auth settings
- redirect allowlists
- local Mailpit for local development
- hosted SMTP and real inbox validation in cloud environments

### FleetFill Transactional Email

Use FleetFill transactional infrastructure for:

- booking confirmation and lifecycle notices
- payment review outcomes
- delivered pending review
- dispute opened and resolved
- payout released
- generated document available
- support acknowledgement and related operational email

Admin email health surfaces should describe transactional email only unless a dedicated auth diagnostics view is added.

Operational credential split:

- `SUPABASE_SECRET_KEY` is for privileged service-client or admin access.
- `INTERNAL_AUTOMATION_TOKEN` is for FleetFill internal scheduler and worker endpoint authorization.
- Do not reuse the Supabase secret key as the scheduler bearer for internal Edge endpoints.

## Release Operations

Production readiness requires:

- passing automated tests
- verified local backend reset and SQL validation where backend changes exist
- verified auth flow behavior
- verified communications behavior
- release traceability
- manual device and operator rehearsal before promotion

Official production entrypoints:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml)

The `tool/` scripts remain part of real production behavior, but they should be invoked through these documented paths unless a local maintenance or fallback situation requires otherwise.

## Environment Ownership

- root `.env`
  - local operator truth for Supabase CLI, rollout scripts, secret sync, and scheduler setup
  - should exist on trusted machines only
- root `.env.example`
  - shared contract for the backend and rollout variables expected by FleetFill operations
- `apps/admin-web/.env.example`
  - shared contract for admin-web public environment variables
- `apps/admin-web/.env` and `apps/admin-web/.env.local`
  - local admin-web development only
  - do not treat them as the system of record for production
- Flutter mobile runtime
  - environment comes from `--dart-define`, CI secrets, and native platform config files
  - there is no committed app env file
- `backend/supabase/functions/.env`
  - local Edge Function helper only
  - should never be treated as production truth

Production source of truth remains:

- GitHub secrets and variables for workflow control
- Supabase hosted project secrets for Edge Function runtime
- Vercel project environment variables for admin-web production
- local root `.env` only for trusted operator and local development flows

## Booking Operations Model

- Queue pages are for current work; history views are for audit and follow-up.
- Booking-linked queue items should route operators into the booking workspace first, with payment, dispute, and payout detail pages available as focused subviews.
- Active and history separation must also exist in shipper and carrier booking surfaces so day-to-day work stays readable.
- Unsupported or missing lifecycle locales fall back to Arabic across app, admin, and generated booking documents.

## Operational UX Standards

Operational flows should not stop at “the backend accepted the action.” They are only complete when the product clearly explains:

- what just happened
- whether the workflow is now waiting on shipper, carrier, admin, or system
- whether the user should retry, wait, fix data, or contact support
- whether a review window, grace period, or eligibility rule is now in effect

These standards apply especially to:

- payment proof submission and review
- payout request and payout release
- delivery confirmation and dispute opening
- carrier verification and vehicle verification
- generated receipts and business records
- support request state changes

## Queue And History Model

Admin operational domains should prefer a consistent queue model:

- `Open` for actionable work
- `History` for resolved or reviewed work
- `All` for broad investigation and lookup

This same philosophy should carry into end-user surfaces where it improves readability:

- active work
- waiting work
- history or archive

## Archive And Record Retrieval

FleetFill should preserve long-lived operational records without making users hunt for them.

Important retained records include:

- completed bookings and shipments
- payment proofs and reviewed outcomes
- disputes and resolutions
- payout requests and payout releases
- generated receipts and business documents
- support threads with their outcome history

History is not only for audit. It is part of day-two product trust.

## Compliance And Safety

- Secrets must never be committed.
- Money-moving and trust-sensitive actions require clear operator accountability.
- Legal, privacy, payment, and dispute disclosures must be available in product surfaces before public launch.
