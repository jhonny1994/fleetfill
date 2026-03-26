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
9. Reopen the same booking workspace at any time to review payment proof state, generated receipts, support, and next actions.

### Carrier

1. Sign up or sign in.
2. Complete business, identity, vehicle, and payout setup.
3. Publish recurring routes and one-off trips.
4. Review incoming bookings and perform trip milestones.
5. Complete the delivery flow.
6. Track payout eligibility, blocked reasons, and request state from the booking workspace.
7. Request payout after the grace period and receive release confirmation from the platform.

### Admin

1. Review verification, payment, dispute, support, payout, and communications queues.
2. Apply step-up guarded actions for money-moving and trust-sensitive changes.
3. Monitor transactional email, push delivery, audits, and operational backlog.
4. Use the booking workspace as the operational hub when a queue item relates to a booking lifecycle issue.

## Experience Standards

FleetFill is expected to feel like a real operations product under pressure, not a collection of disconnected screens.

The product quality bar is:

- every major surface explains the current state in human language
- every major workflow makes the next action obvious
- every role can tell who acts next when a booking is blocked or waiting
- every trust-critical workflow explains what changed after success, review, rejection, or delay
- active work and history stay intentionally separated

## Role Workspace Contract

### Shipper

- Home should behave like an operational dashboard, not only a launcher.
- Booking workspaces are the default place to resume live work after a shipment is booked.
- Payment, receipt, delivery review, dispute, and support context should feel like one continuous workflow.

### Carrier

- Home should behave like a carrier operating cockpit.
- Carriers should be able to understand current trip attention, payout readiness, payout blockers, and next action at a glance.
- Booking workspaces should explain whether the carrier is waiting on shipper, admin, system, or self.

### Admin

- Queue pages are the inbox for active work.
- History and all views are for investigation, follow-up, and audit.
- Booking-linked work should route into the booking workspace first so operators can reason from one lifecycle truth.

## Booking Lifecycle Contract

- The booking is the canonical operational object once a shipment is booked.
- Shipper, carrier, and admin all read the same lifecycle truth from booking state, payment state, tracking events, dispute state, payout state, and generated documents.
- Active work and history are intentionally separated so users can focus on the next action without losing audit visibility.
- Timeline copy must explain state in human language, not leak enum storage names.
- Timeline presentation must make current state, actor, and next owner understandable at a glance where the data supports it.
- Trust-critical timelines should explain review windows, grace periods, and reviewed outcomes when they materially affect user decisions.

## Search And Booking Contract

- Search favors exact route/date matches first.
- Recommended ordering is a product decision, not a UI-only sort.
- Price, fees, taxes, and optional insurance must be clear before payment proof is submitted.
- Booking creation does not imply successful payment or completed confirmation.
- Recommended matches should explain why they are a strong fit whenever existing ranking inputs support a meaningful explanation.

## Trust And Communications

- Verification, ratings, and admin review are part of the trust model.
- Signup confirmation and password reset belong to Supabase Auth.
- Business lifecycle notifications belong to FleetFill transactional channels.
- Support is primarily in-app with email as a supporting channel.
- In-app state remains the authoritative product record; push and email exist to re-enter or reinforce that state, not replace it.

## Product Quality Priorities

The current product focus is not expanding into new domains. It is making the existing domain feel complete and trustworthy.

Priority quality themes:

- clarity:
  users should immediately understand what state they are in and what happens next
- trust:
  payment, payout, dispute, verification, and generated-record flows should feel deliberate and professional
- recovery:
  blocked, rejected, delayed, weak-network, and retryable states should tell the user exactly what to do next
- continuity:
  home, booking, notifications, documents, and admin queues should all tell the same lifecycle story

## Localization

FleetFill ships for:

- Arabic
- French
- English

Critical operational and money-moving copy must exist in all supported languages before release.
