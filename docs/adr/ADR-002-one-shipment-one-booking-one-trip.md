# ADR-002: One Shipment, One Booking, One Trip

## Status

Accepted

## Decision

One shipment maps to exactly one booking and one truck/trip.

FleetFill does not automatically split one shipment across multiple trucks or trips.

## Why

- simpler user promise
- lower dispute risk
- easier pricing, tracking, payout, and audit logic
- better fit for the current product psychology and operational model

## Consequences

- users needing multiple trucks must create multiple shipments
- split-fulfillment optimization is intentionally out of scope unless revisited later
