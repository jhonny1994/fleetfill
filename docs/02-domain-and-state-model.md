# FleetFill Domain And State Model

## 1. Domain Summary

FleetFill has five core domains:

1. identity and profiles
2. carrier capacity publication
3. shipment booking
4. money movement
5. verification and trust

## 2. Core Entities

### 2.1 Profile

One user account profile with exactly one role.

Shared profile responsibilities:

- identity and contact data
- role
- active/suspended status
- verification summary
- public reputation for carriers

### 2.2 Vehicle

A carrier-managed truck or vehicle record that can be assigned to routes and one-off trips.

### 2.3 Route

A recurring lane definition with:

- origin commune
- destination commune
- assigned vehicle
- capacity
- price per kg
- active weekdays
- default departure time
- active/inactive state

### 2.4 One-Off Trip

A single dated trip that is not part of a recurrence pattern.

### 2.5 Shipment

A shipper request to move goods.

Permanent rule:

- one shipment maps to exactly one booking
- one booking maps to exactly one truck/trip

The shipment is described at the shipment level through one details field and travels together on the same trip.

### 2.6 Booking

The commercial and operational contract between shipper and carrier for one shipment on one route instance or one one-off trip.

### 2.7 Payment Proof

The uploaded evidence that a shipper submitted payment through an external rail.

### 2.8 Financial Ledger Entry

An immutable money movement record used for auditability and settlement.

### 2.9 Verification Document

A required or optional document attached to a carrier or vehicle for verification.

### 2.10 Payout Account

The destination account FleetFill uses when paying a carrier.

Supported payout rails:

- CCP
- Dahabia
- bank

### 2.11 Platform Payment Account

The FleetFill-controlled destination account shown to shippers for inbound payment.

### 2.12 Dispute

The auditable case record created when a booking is challenged during the delivery review window.

### 2.13 Refund

The auditable record of money returned to the shipper.

### 2.14 Payout

The auditable record of money released to the carrier.

## 3. Shipment Rules

### 3.1 One Shipment, One Promise

- A shipment either fits on a truck/trip or it does not.
- FleetFill does not automatically split a shipment across trucks or trips.
- If a user wants to send goods in multiple trucks or trips, they create multiple shipments.

### 3.2 Shipment Packaging

- A shipment is one transport request with one shipment-level details field.
- Weight is the mandatory and authoritative capacity constraint.
- Volume is optional and is enforced only when both the shipment and the route/trip publish volume values.
- If volume is missing on either side, matching still proceeds using weight rules only.

## 4. Booking Status Model

`booking.status` is a single top-level enum.

Allowed values:

- `pending_payment`
- `payment_under_review`
- `confirmed`
- `picked_up`
- `in_transit`
- `delivered_pending_review`
- `completed`
- `cancelled`
- `disputed`

### 4.1 Canonical Transition Rules

Main path:

`pending_payment -> payment_under_review -> confirmed -> picked_up -> in_transit -> delivered_pending_review -> completed`

Side paths:

- `pending_payment -> cancelled`
- `payment_under_review -> cancelled`
- `confirmed -> cancelled` (admin-controlled exceptional path)
- `delivered_pending_review -> disputed`
- `disputed -> completed`
- `disputed -> cancelled`

### 4.2 Why `delivered_pending_review` Exists

This status creates an explicit review/dispute window between physical delivery and final completion. It avoids ambiguous delivery claims and keeps payout timing aligned with dispute handling.

## 5. Payment Status Model

`payment_status` is a separate enum.

Allowed values:

- `unpaid`
- `proof_submitted`
- `under_verification`
- `secured`
- `rejected`
- `refunded`
- `released_to_carrier`

### 5.1 Canonical Transition Rules

Primary path:

`unpaid -> proof_submitted -> under_verification -> secured -> released_to_carrier`

Alternative outcomes:

- `under_verification -> rejected`
- `secured -> refunded`
- `rejected -> proof_submitted` when resubmission is allowed

`released_to_carrier` means FleetFill has completed carrier payout settlement for the booking.

### 5.2 Payment Amount Match Rule

The expected booking payment amount must match the verified amount exactly.

Rules:

- underpayment is rejected with a reason
- overpayment is rejected with a reason
- admin does not partially accept or manually net mismatched payments in the canonical flow
- the shipper must re-submit valid proof for the correct amount

### 5.3 Payment Rejection And Resubmission Rule

If payment proof is rejected:

- `payment_status` becomes `rejected`
- `booking_status` returns to `pending_payment`
- the booking keeps a temporary capacity reservation only until the configured payment-resubmission deadline
- if valid proof is re-submitted before the deadline, the flow returns to `proof_submitted`
- if the deadline expires with no valid proof, the booking is cancelled and capacity is released

## 6. Tracking Event Model

Tracking is append-only and event-based.

`tracking_events.event_type` should support at least:

- `payment_under_review`
- `confirmed`
- `picked_up`
- `in_transit`
- `delivered_pending_review`
- `completed`
- `cancelled`
- `disputed`
- `refund_processed`
- `payout_released`

Rules:

- events are never edited or deleted
- booking status is derived from the latest authoritative state change
- internal audit events may exist separately from user-visible timeline events

## 7. Search And Match Rules

### 7.1 Exact Match Policy

FleetFill searches exact origin commune and exact destination commune first.

### 7.2 Result Ordering

Default ordering uses the `Recommended` ranking defined in `docs/01-product-and-scope.md`.

### 7.3 No Exact Result Policy

If there is no exact match on the requested date:

- show exact route results on nearest allowed dates

If there is no exact route at all:

- do not widen geography silently
- ask the user to redefine search

## 8. Pricing And Settlement Rules

### 8.1 Commercial Snapshot

A booking stores immutable commercial values captured at booking time:

- `price_per_kg_dzd`
- `weight_kg`
- `base_price_dzd`
- `platform_fee_dzd`
- `carrier_fee_dzd`
- `insurance_rate`
- `insurance_fee_dzd`
- `tax_fee_dzd`
- `shipper_total_dzd`
- `carrier_payout_dzd`

### 8.2 Insurance Rule

- insurance is optional
- insurance is percentage-based
- insurance has a minimum fee floor
- insurance values are snapshotted per booking

### 8.3 Ledger Rule

Money movement is never represented only by status fields.

Statuses show current state. The ledger records the actual immutable money events.

### 8.4 Refund And Payout Records

Disputes, refunds, and payouts must have first-class records in addition to ledger entries.

Reason:

- ledger entries record money movement
- dispute, refund, and payout records hold workflow state, references, reasons, evidence, and operational metadata

### 8.5 Inbound Payment Accounts

Payment instructions shown to shippers must come from active FleetFill-controlled platform payment accounts, not hardcoded app constants.

## 9. Delivery Confirmation And Proof Of Delivery

FleetFill does not rely on GPS proof of delivery in the canonical launch model.

Recommended delivery strategy:

1. carrier marks the booking as delivered
2. booking moves to `delivered_pending_review`
3. shipper receives a prompt to confirm delivery or raise a dispute
4. if the shipper confirms, booking moves to `completed`
5. if the shipper raises a dispute during the review window, booking moves to `disputed`
6. if the shipper does nothing within the configured grace window, booking auto-completes

This is the best default strategy for FleetFill because it keeps the workflow simple, preserves shipper protection, and avoids over-engineering delivery proof before the operation is mature.

Optional delivery evidence such as a note, handoff comment, or uploaded file can be added later without replacing this status model.

## 10. Dispute, Refund, And Payout Workflow Rules

### 10.1 Dispute Rule

- a dispute may be opened only from `delivered_pending_review`
- the dispute record owns case notes, evidence references, and resolution metadata
- the booking remains `disputed` until resolved by admin workflow

### 10.2 Valid Dispute Outcomes

- resolve to `completed` when delivery is accepted after review
- resolve to `cancelled` when the booking is voided
- trigger `payment_status = refunded` when a shipper refund is approved
- carrier payout may be blocked, reversed before release, or omitted entirely depending on the resolution outcome

### 10.3 Payout Rule

- payout is a first-class operational record, not only a payment status
- payout release requires secured payment, payout eligibility, no unresolved blocking dispute, and one active payout account snapshot
- payout failures and retries belong to the payout record, not the booking row alone

## 11. Verification Rules

### 9.1 Aggregate Verification Status

Profiles and vehicles use:

- `pending`
- `verified`
- `rejected`

Every rejection requires a reason.

### 9.2 Document Review Model

- each document has its own review status and audit metadata
- admin sees the full packet together
- admin may use `Approve all` when the full required set is valid
- `Approve all` must still generate document-level audit records

### 9.3 Required Verification Scope

Required current document sets:

- driver identity/license document
- truck registration
- truck insurance
- truck technical inspection
- transport license

## 12. Route Change Rules

Route changes must not rewrite existing commercial or operational commitments.

Rules:

- deactivation stops new bookings only
- non-critical metadata can be edited directly
- price, capacity, departure time, and vehicle changes apply only through a new future-effective route revision
- existing bookings keep their original snapshot and assignment context

## 13. Background Automation Rules

The following timed workflows require durable background execution:

- delivery review grace-window expiry and auto-completion
- payment resubmission expiry and booking cancellation
- email retry scheduling and dead-letter handling
- stale worker-lock recovery for queued jobs

## 14. Reputation Rules

- only completed bookings may be reviewed
- one rating per completed booking
- carriers have public rating average, count, and written comments
- moderation actions belong to admins and are auditable
