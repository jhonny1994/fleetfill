# ADR-003: Platform-Held Payment Flow

## Status

Accepted

## Decision

Shippers pay FleetFill-controlled accounts first.

FleetFill verifies proof, secures payment, and releases payout to the carrier only after the delivery confirmation/dispute flow allows it.

## Why

- prevents shipper/carrier bypass of platform revenue flow
- gives the product stronger trust and dispute control
- fits the Algeria-specific payment reality better than instant in-app card-first assumptions

## Consequences

- payment proof review becomes a core operational workflow
- payout and refund records must be first-class
- ledger and auditability are mandatory, not optional
