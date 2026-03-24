# FleetFill Product And Scope

## 1. Product Mission

FleetFill is a mobile-first freight marketplace for Algeria that reduces empty backhaul capacity and gives shippers a more trustworthy way to book transport across long-distance lanes.

The product is optimized for the operational reality of Algeria:

- long north-south corridors
- high trust sensitivity around money and delivery responsibility
- manual bank and postal payment rails
- mixed Arabic/French operational language use
- older Android devices and inconsistent connectivity

FleetFill should feel like a reliable transport office in a phone, not a generic classifieds app.

## 2. Core Value Proposition

For shippers:

- find real upcoming truck capacity
- understand total cost before paying
- pay FleetFill, not the carrier directly
- receive clear proof-based status updates
- choose carriers based on ratings and track record

For carriers:

- publish recurring and one-off trips
- fill unused capacity on known lanes
- receive structured bookings with controlled payment flow
- build a public reputation through ratings and completed trips

For FleetFill operations:

- verify payments and documents
- control escrow release and refunds
- maintain auditability for all sensitive actions
- evolve the platform without rewriting the core model

## 3. Product Principles

1. Trust before speed.
2. Exact commitments before fuzzy matching.
3. One shipment means one operational promise.
4. Historical bookings and money records are immutable.
5. Sensitive workflows are server-controlled; simple CRUD is not over-engineered.
6. Arabic-first clarity is required, not optional.

## 4. Users And Roles

### 4.1 Roles

Each account has exactly one role.

- `shipper`
- `carrier`
- `admin`

There is no multi-role account in the current product model.

### 4.2 Shipper

Shippers are individuals, traders, SMEs, and institutions that need to send goods.

They can:

- manage their profile
- create shipments
- search exact routes by origin, destination, and date
- book matching truck capacity
- pay FleetFill through supported external rails
- upload payment proof
- track shipment progress
- rate carriers after completion

### 4.3 Carrier

Carriers are owner-operators or fleets that publish truck capacity.

They can:

- manage their profile
- manage vehicles and required documents
- manage payout account details
- create recurring routes and one-off trips
- view upcoming bookings tied to their capacity
- update shipment progress at allowed milestones
- receive ratings and public feedback

### 4.4 Admin

Admins share the same privilege level.

They can:

- review payment proofs
- review carrier and vehicle verification documents
- resolve disputes
- approve refunds and payouts
- manage platform settings
- audit sensitive actions

Admins operate primarily through a separate internal web console.

The Flutter app may retain a narrow internal fallback surface for urgent triage during transition, but it is not the long-term primary admin workspace.

## 5. Authentication And Identity

### 5.1 Authentication

Supported authentication methods:

- email and password
- Google sign-in

Phone number is mandatory on the profile before the user can perform operational actions such as creating shipments, creating routes, or receiving payouts.

### 5.2 Identity Model

- Authentication identity and contact phone number are related but separate concerns.
- A user may sign in without SMS.
- The phone number is mandatory business contact data, not the primary authentication method.

## 6. Platform Scope

### 6.1 Included In The Core Product

- Mobile app for shippers and carriers
- Internal admin web operations console
- Exact route search by Algeria commune pair and desired date
- Recurring routes and one-off trips
- One shipment to one booking to one truck/trip
- External payment via CCP, Dahabia, and bank transfer into FleetFill-controlled accounts
- Payment proof upload and admin verification
- Manual status tracking through structured milestones
- Ratings and comments for carriers
- Public carrier profile view with reputation signals
- Payout account management for carriers
- Financial ledger for money movement and auditability
- Multi-language support: Arabic, French, English
- Theme persistence and accessibility support
- One app language preference per account across shipper and carrier surfaces

### 6.2 Explicit Product Constraints

- No automatic split fulfillment for a shipment
- No direct shipper-to-carrier payments
- No broad fuzzy geographic fallback during search results
- No in-app shipper-carrier chat at launch
- No iOS public production rollout until operations choose to enable it

### 6.3 Planned Growth Without Domain Rewrite

The core design must support future improvements without changing the fundamental model. Likely future areas include:

- richer tracking evidence
- better search ranking and alerts
- broader carrier analytics
- improved support tooling
- additional payment and payout automation
- iOS public rollout
- richer admin assignment, reporting, and SLA tooling without rewriting the backend domain

## 7. Supported Payment Rails

Shippers pay FleetFill through external rails only:

- CCP manual office payment
- Dahabia / postal app payment
- bank transfer

FleetFill verifies proof before securing the payment.

## 8. Commercial Model

Each booking stores a complete commercial snapshot.

Current supported money components:

- `base_price`
- `platform_fee`
- `carrier_fee`
- `insurance_fee` (optional)
- `tax_fee` (supported by model, may be zero for now)
- `shipper_total`
- `carrier_payout`

The app always shows users one total amount plus a transparent breakdown.

Insurance is optional, percentage-based, and subject to a minimum fee.

Subscriptions and ads are not active commercial flows in the current canonical product. They may be added later without changing the escrow, booking, or payout model.

## 9. Search Strategy

FleetFill does not guess too broadly when trust matters.

Search behavior:

1. search exact origin commune, exact destination commune, and requested date
2. show only exact route matches for the requested lane
3. rank exact matches using the default `Recommended` sort
4. if no exact same-day result exists, show the same exact route on nearest allowed dates
5. if no exact route exists, ask the user to redefine the search

FleetFill does not silently widen the lane to nearby communes or different corridors in the default behavior.

## 10. Default Search Ranking

Default sort is `Recommended`.

Recommended ranking order:

1. exact route match
2. departure closeness to requested date/time
3. sufficient remaining capacity
4. stronger carrier reputation
5. lower total price
6. earlier departure time when otherwise tied

Alternative user-selectable sorts:

- `Top Rated`
- `Lowest Price`
- `Nearest Departure`

## 11. Support Model

Customer support is database-backed inside the app.

Support is modeled as tickets and threaded replies, not mailbox-style email handling.

There is no consumer-style real-time chat in the initial canonical product definition. Support can evolve later without changing the core domain model.

Transactional email is part of the platform communication model.

FleetFill uses a server-controlled transactional email provider for outbound operational email such as:

- support acknowledgements or fallback alerts
- booking confirmation messages
- payment review and rejection messages
- dispute and payout updates
- invoice or receipt availability notifications where appropriate

## 12. Generated Documents

FleetFill should automatically generate PDF documents from the system for operational and financial traceability.

Initial document scope:

- payment receipt PDF when applicable
- payout receipt or payout statement PDF when applicable

## 13. Launch And Rollout Policy

- Android is the first production platform.
- iOS settings, version keys, and update policy must exist in the system design from day one.
- iOS public release timing is an operations decision, not a data-model gap.
