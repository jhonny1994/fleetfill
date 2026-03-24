# FleetFill Operations And Compliance

## 1. Operational Goals

Operations must keep FleetFill trustworthy, auditable, and practical for Algeria-based freight workflows.

The system should minimize manual effort where possible, but not at the cost of unsafe automation.

## 2. Payment Verification Workflow

### 2.1 Admin Review Packet

For each payment proof review, admin should see:

- booking identifier
- shipper name
- carrier name
- total due
- payment reference
- selected payment rail
- latest uploaded proof
- proof history if resubmitted
- submitted amount
- admin-verified amount and verified reference when approval is completed

### 2.2 Admin Outcomes

- approve and secure payment
- reject with mandatory reason

On approval:

- booking moves to `confirmed`
- payment moves to `secured`
- ledger entry is created
- shipper and carrier notifications are created
- payment confirmation email can be sent through the configured transactional email provider when enabled

On rejection:

- payment proof is marked rejected
- booking returns to `pending_payment`
- capacity remains reserved only until the configured payment-resubmission deadline
- if valid proof is re-submitted before the deadline, review may continue
- if the deadline expires without valid proof, the booking is cancelled and capacity is released
- rejection reason is stored and shown to the shipper
- payment rejection email can be sent through the configured transactional email provider when enabled

Amount mismatch policy:

- if the transferred amount is lower than expected, reject with reason
- if the transferred amount is higher than expected, reject with reason
- admin should not partially secure or manually normalize mismatched incoming payments in the canonical workflow

High-risk operational controls:

- repeat proof rejections should be visible in admin review history
- repeated suspicious payment attempts may trigger temporary account hold or manual escalation
- payout release and dispute resolution should require a fresh privileged session and should be reviewed carefully because they are money-moving actions

## 3. Verification Workflow

### 3.1 Review Packet

Admin reviews all required documents together for:

- carrier profile
- vehicle

### 3.2 Verification Statuses

- `pending`
- `verified`
- `rejected`

Every rejection requires a reason.

### 3.3 Approve All

Admins may use `Approve all` when the required packet is complete and valid.

Requirements:

- still write document-level review metadata
- still write aggregate audit logs
- aggregate verification becomes `verified` only when the full required set passes

## 4. Dispute Workflow

Disputes begin from `delivered_pending_review`.

Admin must be able to see:

- booking summary
- tracking events
- payment proof history
- ledger entries
- carrier and shipper notes/evidence if provided

Possible outcomes:

- complete the booking
- cancel the booking
- refund the shipper

All dispute outcomes must be auditable.

Operational records:

- each dispute must have a first-class dispute record
- each refund must have a first-class refund record
- each carrier payout must have a first-class payout record

## 5. Delivery Confirmation Workflow

Delivery proof in the current canonical product is workflow-based, not GPS-based.

Recommended flow:

1. carrier marks delivered
2. booking enters `delivered_pending_review`
3. shipper may confirm delivery or raise a dispute during the grace window
4. if the grace window expires with no dispute, booking auto-completes

This balances trust and operational simplicity for a small team.

The grace-window auto-completion flow must be driven by durable scheduled/background execution, not manual checking.

## 6. Payout Workflow

### 5.1 Payout Preconditions

Carrier payout can proceed only when:

- payment is secured
- booking has reached payout-eligible completion status
- no active unresolved dispute blocks release
- carrier has an active payout account

### 5.2 Payout Record

Payout release must create:

- a ledger entry
- audit log entry
- booking payment status update to `released_to_carrier`
- payout record update with account snapshot and external reference when applicable

### 5.3 Payout Rails

Supported payout destinations:

- CCP
- bank

## 7. SLA Baseline

Recommended operating targets:

- payment proof verification within 4 working hours
- document verification within 1 business day
- dispute first response within 4 working hours
- dispute resolution within 48 hours where evidence is complete
- payout release within 1 business day after payout eligibility

The delivery confirmation grace period should be configurable in platform settings.

## 8. Quality Gates Before Release

Before a production release candidate is accepted:

- critical unit tests must pass
- critical widget tests must pass
- end-to-end role flows must pass on a representative Android device
- accessibility checks must pass on key booking, payment, and dispute screens
- performance baseline must be reviewed in profile mode for the most important flows

Email quality gates:

- all active transactional templates reviewed in Arabic, French, and English
- variables verified against real payload examples
- broken links, wrong locale fallbacks, and unsafe data exposure checked before release

Release governance gates:

- release candidate must map to a tagged Git commit
- hosted release rehearsal must complete before production rollout
- rollback plan must exist for app release and backend deployment changes
- migrations affecting money, auth, or auditability should not ship without explicit review

## 9. Audit Requirements

The following actions must always create admin audit records:

- payment approval
- payment rejection
- document approval
- document rejection
- approve-all verification action
- dispute resolution
- payout release
- user suspension or reactivation
- sensitive settings changes

## 10. Generated Documents

FleetFill should generate official financial PDFs from canonical system data.

Initial scope:

- payment receipt where applicable
- payout receipt or payout statement where applicable

Generated documents should be reproducible, retained when needed, and referenced in support and finance workflows.

## 11. Transactional Email Operations

FleetFill uses a server-controlled transactional email provider for outbound email.

Current baseline:

- a transactional email provider adapter is the current provider path
- FleetFill uses a durable outbox plus worker model, then maps provider send and webhook payloads into internal delivery states
- provider integration stays behind a small adapter boundary so the queue, retry, dedupe, and admin monitoring model remain stable if the provider changes later
- canonical email copy now lives in the DB-owned `email_templates` registry and is rendered inside the Edge worker, not hardcoded across workflows or delegated to provider-managed template dashboards

Operational rules:

- email templates are mapped by logical event key and resolved from the DB registry
- template variables come from canonical server-side data
- the current production baseline serves Arabic, French, and English transactional email from the DB template registry
- retries must be idempotent for critical lifecycle emails
- delivery failures should be logged for support visibility
- render failures should dead-letter immediately and surface in admin as template/runtime issues rather than provider failures
- invoice information should render in secure HTML email content where needed rather than being attached as PDFs by default
- app and account locale now influence transactional email language through the resolved locale and template registry, with Arabic fallback when needed

High-volume delivery rules:

- use a durable outbox queue for email work
- process queued jobs in bounded batches
- prioritize critical lifecycle emails above low-priority informational emails
- throttle sends when provider rate limits or transient failures increase
- recover stale worker locks before each dispatch cycle so the same automation tick can reclaim newly unstuck work
- use bounded exponential retry delay for transient provider failures
- move repeatedly failing jobs to a dead-letter state for admin review instead of retrying forever

Backend load-handling rules:

- never send high-volume email inline inside the same request path that serves the mobile user
- commit the business transaction first, then let workers drain the outbox asynchronously
- keep worker concurrency configurable so operations can scale up or scale down without code changes
- define separate throughput budgets for critical and non-critical email classes
- isolate scheduled maintenance tasks so one worker or expiry failure does not stop unrelated queue recovery or dispatch work
- monitor backlog age, queue depth, send rate, error rate, and dead-letter count as the main health signals

Current deployment posture:

- the first production deployment may run on Supabase Free with a single scheduled email worker
- this is acceptable as long as the outbox, retry, dedupe, and monitoring model stays intact
- infrastructure can scale later without changing business workflows or data contracts

Timed automation note:

- delivery grace-window expiry, payment-resubmission expiry, and queued email retries all depend on reliable scheduled/background execution and must have monitoring plus an operational fallback if hosted scheduling is delayed

Initial transactional email scope:

- support acknowledgement
- booking confirmed
- payment proof received
- payment rejected
- payment secured
- delivered pending review
- dispute opened or resolved
- payout released
- generated invoice or receipt available

Current content policy:

- transactional email copy must exist for Arabic, French, and English across the active lifecycle event set
- all active lifecycle events must use event-specific templates rather than generic fallback paragraphs

## 12. Template Governance

- keep templates operational, concise, and consistent with in-app copy
- avoid marketing-heavy formatting for trust-sensitive workflows
- maintain one canonical ownership point for template keys, variables, and locale mapping
- changes to status wording in product flows should trigger matching template updates
- sender identities and final branded template copy may remain placeholder configuration until finalized by the business

Edge-case rules:

- if a user changes email after an event is queued, sending should use the intended recipient captured for that event unless policy explicitly requires cancellation
- if the same business event is emitted twice, deduplication must prevent duplicate mail unless a deliberate resend is requested
- if the chosen provider is degraded, business state still completes and email retries continue asynchronously
- if an address bounces or is suppressed, automatic retries stop and support/admin visibility is required
- if many bookings trigger emails at once, low-priority emails may be delayed rather than risking critical-email delivery health
- webhook authenticity and idempotency checks are required before provider delivery events update internal state

Readiness note:

- email is not considered fully production-validated until hosted provider sending and hosted webhook delivery are exercised against the real Supabase environment with real secrets and signature configuration

## 13. Email Delivery Monitoring And Admin View

Admin operations should be able to inspect transactional email delivery health.

Recommended admin capabilities:

- filter email logs by booking, user, template key, locale, provider status, and date range
- view latest delivery state and retry history
- view requested locale, resolved locale, resolved template language, and subject preview
- inspect safe payload snapshot data used for rendering
- distinguish provider failures from render/template failures
- identify bounced, suppressed, and repeatedly failing addresses
- manually trigger a resend only where business-safe and idempotent
- inspect dead-letter queue items and terminal failures
- see queue backlog health, retry volume, and provider-error spikes

Recommended resend rules:

- resend should create or update a tracked delivery attempt with full audit visibility
- resend should be blocked for hard-failed or suppressed addresses until corrected
- resend should never duplicate a money-moving business action; it only re-sends communication

Recommended retry policy:

- transient failures enter retry scheduling with bounded attempts
- use backoff between retries
- permanent failures stop automatic retries and surface to admin/support visibility
- provider webhooks or status polling should update the delivery log when available

Recommended failure classification:

- retryable: timeouts, temporary provider errors, transient network failures, short-lived rate limits
- non-retryable: invalid address, bounced recipient, suppressed recipient, template misconfiguration requiring operator fix

## 14. Compliance And Legal Baseline

Terms and policies must clearly communicate:

- FleetFill receives payment before carrier payout
- booking pricing breakdown and insurance choice
- dispute window and resolution authority
- shipper responsibility for accurate shipment details
- carrier responsibility for valid documents and compliance
- data retention for finance, proofs, and operational audit trails

These terms and policies must exist as real user-facing surfaces before production launch.

Required user-facing baseline copy must state all of the following in substance:

- FleetFill receives shipper payment before carrier payout
- each booking covers one shipment on one confirmed route or trip
- shippers are responsible for accurate shipment details and uploaded proof accuracy
- carriers are responsible for valid transport documents and lawful operating compliance
- pricing breakdown, taxes, platform fees, and optional insurance are shown before proof submission
- disputes must be opened during the documented delivery review window
- finance, proof, support, and audit records may be retained for operational, compliance, and dispute handling needs

## 15. Release And Change Management

Operational release rules:

- if the team uses a single long-lived branch, protect it and rely on CI plus disciplined commits after approved steps
- if pull requests are used, require CI success before merge
- release versions must be traceable to a Git tag and changelog
- production backend and app releases should be staged, reviewed, and reversible
- secrets rotation and deployment access should follow least-privilege principles

Public GitHub surfaces:

- the repository `README.md` should be user-facing and product-facing, not primarily a developer setup page
- GitHub Releases should use human-readable customer-facing release notes instead of internal engineering-only changelog dumps

## 16. Support Operations

Support begins with email-based handling.

Minimum support process:

- publish support email clearly in app
- require booking or tracking reference in support requests where possible
- define response ownership internally
- escalate payment, document, and dispute issues to the correct admin queue

## 17. Documentation Change Discipline

When an operational rule changes:

1. update this file if workflow or SLA changed
2. update `docs/02-domain-and-state-model.md` if statuses or transitions changed
3. update `docs/04-data-and-security-model.md` if schema or access changed
4. update `docs/05-ux-and-localization.md` if user messaging or flow changed
