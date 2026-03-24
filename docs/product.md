# Product

## Purpose

FleetFill is a freight marketplace for Algeria. It connects shippers that need trusted capacity with carriers that have available truck space on recurring routes or one-off trips.

The product optimizes for trust, operational clarity, and exact commitments instead of loose marketplace matching.

## Users

- Shippers create shipments, search exact capacity, pay through approved external rails, and track delivery.
- Carriers publish routes or trips, maintain verification and vehicle records, accept bookings, and receive payouts after delivery.
- Admin operators review trust-sensitive actions, payment proofs, disputes, payouts, support work, and runtime health.

## Core Product Rules

- One account maps to one role.
- One shipment maps to one booking and one truck or trip.
- Payment is secured by the platform before carrier payout.
- Delivery, dispute, and payout actions follow explicit state transitions.
- Email and push support the product, but in-app state remains the source of truth.

## Major User Flows

### Shipper

1. Sign up or sign in.
2. Complete role-specific onboarding and profile requirements.
3. Create a shipment.
4. Search exact route or trip matches.
5. Review transparent pricing, insurance, and booking details.
6. Create the booking and submit payment proof.
7. Track milestones until delivery.
8. Confirm delivery or open a dispute inside the review window.

### Carrier

1. Sign up or sign in.
2. Complete business, identity, vehicle, and payout setup.
3. Publish recurring routes and one-off trips.
4. Review incoming bookings and perform trip milestones.
5. Complete the delivery flow.
6. Receive payout when the booking becomes eligible.

### Admin

1. Review verification, payment, dispute, support, payout, and communications queues.
2. Apply step-up guarded actions for money-moving and trust-sensitive changes.
3. Monitor transactional email, push delivery, audits, and operational backlog.

## Search And Booking Contract

- Search favors exact route/date matches first.
- Recommended ordering is a product decision, not a UI-only sort.
- Price, fees, taxes, and optional insurance must be clear before payment proof is submitted.
- Booking creation does not imply successful payment or completed confirmation.

## Trust And Communications

- Verification, ratings, and admin review are part of the trust model.
- Signup confirmation and password reset belong to Supabase Auth.
- Business lifecycle notifications belong to FleetFill transactional channels.
- Support is primarily in-app with email as a supporting channel.

## Localization

FleetFill ships for:

- Arabic
- French
- English

Critical operational and money-moving copy must exist in all supported languages before release.
