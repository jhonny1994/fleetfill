# FleetFill

FleetFill is a mobile freight marketplace for Algeria that helps shippers find trusted truck capacity and helps carriers fill unused space on their routes.

It is designed for the real transport flow of the Algerian market:

- exact route search
- clear total pricing before payment
- payment verification through FleetFill-controlled accounts
- milestone-based shipment tracking
- carrier ratings and verification
- Arabic, French, and English support

## What FleetFill Does

For shippers, FleetFill makes it easier to:

- create a shipment
- search exact matching trips
- review price and insurance clearly
- pay using supported external rails
- upload payment proof
- track booking progress
- confirm delivery or open a dispute if needed

For carriers, FleetFill makes it easier to:

- publish recurring routes and one-off trips
- manage vehicles and required documents
- receive structured bookings
- update trip progress with clear delivery milestones
- manage payout account details
- build trust through ratings and reviews

## Core Product Principles

- trust before speed
- one shipment, one truck/trip
- exact commitments before fuzzy matching
- clear pricing and clear responsibility
- operational simplicity over unnecessary complexity

## Availability

- Android is the primary production platform
- iOS configuration is supported in the system design, with rollout timing controlled operationally

## Languages

FleetFill is designed for:

- Arabic
- French
- English

## Runtime Contract

FleetFill uses one shared runtime contract across Flutter, admin web, CI, and docs:

- actual behavior comes from the URLs, keys, and secrets supplied to the app
- local development is defined by using local hosts, local Supabase credentials, and local network overrides where needed
- hosted behavior is defined by using hosted URLs and hosted credentials
- Vercel preview is a deployment and review channel, not a separate FleetFill runtime mode

## Support

Support is handled in-app through a ticket and thread workflow, with notifications and optional email as supporting channels rather than the source of truth.

## Policies And Disclosures

Before production launch, FleetFill exposes in-app policy surfaces that cover:

- terms of service
- privacy and retention
- payment and escrow disclosure
- dispute handling policy

## Product Status

FleetFill is under active development.

This repository tracks the product and engineering work behind the app. Public release notes should focus on what changed for users, not internal implementation details.
