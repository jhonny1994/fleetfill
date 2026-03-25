# Operations

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
- verified local backend reset and SQL validation
- verified auth flow behavior
- verified communications behavior
- release traceability
- manual device and operator rehearsal before promotion

## Compliance And Safety

- Secrets must never be committed.
- Money-moving and trust-sensitive actions require clear operator accountability.
- Legal, privacy, payment, and dispute disclosures must be available in product surfaces before public launch.
