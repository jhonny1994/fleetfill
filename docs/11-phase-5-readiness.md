# Phase 5 Readiness

## Goal

Start Phase 5 - Carrier Capacity Publication on a stable, implementation-ready basis without re-deciding core architecture while building.

Canonical sources used for this readiness pass:

- `docs/01-product-and-scope.md`
- `docs/02-domain-and-state-model.md`
- `docs/03-technical-architecture.md`
- `docs/04-data-and-security-model.md`
- `docs/05-ux-and-localization.md`
- `docs/07-implementation-plan.md`
- `docs/08-screen-map-and-routing.md`
- `docs/09-supabase-implementation-notes.md`

Skill context applied:

- `mobile-developer`
- `flutter-architecture`
- `flutter-state-management`
- `flutter-routing-and-navigation`

## Phase 5 Scope

Phase 5 covers carrier-owned capacity publication:

- recurring route CRUD
- one-off trip CRUD
- vehicle assignment
- capacity and operational validation
- active/inactive toggling
- future-effective route revisions
- weight-first and optional-volume behavior aligned with canonical rules
- carrier routes/trips list UX and reusable create-edit forms
- upcoming capacity summary and booking utilization

## Locked Decisions

These should be treated as settled before implementation starts.

### 1. Layering

- `presentation/` only renders screens, sections, sheets, and local ephemeral UI state
- `application/` owns orchestration for create, edit, activate/deactivate, and revision flows
- `infrastructure/` owns Supabase CRUD and RPC integration
- `domain/` owns immutable route, one-off trip, revision, and utilization models

### 2. Navigation

- keep Phase 5 inside the existing carrier `routes` branch
- use full pages for:
  - `MyRoutesScreen`
  - `RouteFormScreen`
  - `OneOffTripFormScreen`
  - `RouteDetailScreen`
  - `OneOffTripDetailScreen`
- keep vehicle assignment, schedule editing, capacity summary, and active/inactive actions as sections or sheets where practical
- continue using centralized `AppRoutePath` helpers instead of ad hoc string interpolation

### 3. State Management

- list/detail providers should stay Riverpod-based and parameterized where needed
- short-lived form state remains widget-local
- publication workflows that touch multiple repository calls should go through feature application controllers, following the Phase 4 remediation pattern
- long lists or future admin-style collections must be paginated/windowed, never full-table loaded by default

### 4. Capacity Rules

- weight is mandatory and authoritative
- volume is optional and only enforced when both sides publish it
- route/trip publication must always require weight capacity
- recurring route edits that affect schedule, price, vehicle, or capacity must create future-effective revisions rather than mutating historical commitments

### 5. Booking-Safe Data Model Direction

Phase 5 should prepare, not fight, later booking enforcement.

- recurring routes remain templates
- one-off trips remain concrete dated trips
- future-effective changes belong in `route_revisions`
- later booking concurrency will rely on per-date route departure capacity records, so Phase 5 route structures must be compatible with that model

## Recommended Delivery Order

Implement Phase 5 in these slices.

### Slice 1. Domain And Persistence

Create or finalize:

- `routes`
- `oneoff_trips`
- `route_revisions`

Domain models should include:

- recurring route summary/detail
- one-off trip summary/detail
- route revision snapshot
- route/trip form draft input
- capacity utilization summary

Minimum server validations:

- carrier ownership
- verified carrier operational gate respected by app and RLS/trusted paths
- valid commune ids
- origin and destination cannot be equal
- positive `total_capacity_kg`
- non-negative optional `total_capacity_volume_m3`
- positive `price_per_kg_dzd`
- valid departure time / departure timestamp
- valid recurring weekday array

### Slice 2. Repository And Application APIs

Add carrier publication repositories/use-cases for:

- list recurring routes
- list one-off trips
- fetch route detail
- fetch one-off trip detail
- create route
- update route through revision-aware path
- create one-off trip
- update one-off trip
- toggle route active state
- toggle one-off trip active state
- fetch route/trip utilization summaries

Preferred separation:

- repository methods for simple fetches and basic persistence
- application controller/use-case for revision-aware route edits and cross-entity orchestration

### Slice 3. UI Foundation

Replace placeholder carrier routes UI with:

- segmented list for recurring routes vs one-off trips inside `MyRoutesScreen`
- one reusable route/trip form shell with mode-specific sections
- detail pages showing:
  - lane
  - schedule
  - assigned vehicle
  - capacity
  - price per kg
  - active state
  - utilization summary

### Slice 4. Operational UX Refinement

Add:

- vehicle assignment section/sheet
- active/inactive toggle confirmation
- capacity summary card
- localized validation and empty states
- lazy list rendering if counts grow

## File Targets

These are the most likely code targets to extend.

### Carrier Domain

- `lib/features/carrier/domain/domain.dart`
- new route/trip models under `lib/features/carrier/domain/`

### Carrier Infrastructure

- `lib/features/carrier/infrastructure/infrastructure.dart`
- new route/trip repositories under `lib/features/carrier/infrastructure/`

### Carrier Application

- `lib/features/carrier/application/application.dart`
- new publication workflow/controller files under `lib/features/carrier/application/`

### Carrier Presentation

- `lib/features/carrier/presentation/carrier_screens.dart`

### Routing

- `lib/core/routing/app_routes.dart`
- `lib/core/routing/app_router.dart`

### Shared Providers

- `lib/shared/providers/providers.dart`

### Database / Supabase

- `supabase/migrations/`
- possibly shared SQL functions for revision-safe writes if repository-only CRUD is not enough

## Readiness Checklist

Phase 5 should begin only after the first PR-sized slice satisfies this checklist.

- route/trip models are immutable and localized UI does not hardcode strings
- route publication does not place business rules inside widgets
- route edits that change future commitments are revision-safe
- route and trip list loads are bounded and ready for pagination growth
- vehicle assignment uses carrier-owned verified vehicles only
- capacity validation follows weight-first and optional-volume rules exactly
- screens use sections/sheets instead of route-per-microstep flows
- route helpers and guard behavior stay centralized
- tests cover domain validation and revision behavior

## Validation Plan For Phase 5 Work

Run after each meaningful slice:

- `dart analyze`
- `flutter test`
- `supabase db lint`
- `supabase db reset --yes`

Add focused tests for:

- recurring route validation
- one-off trip validation
- route revision creation instead of destructive overwrite
- active/inactive toggle behavior
- carrier ownership and vehicle assignment guardrails
- UI/provider behavior for route/trip list and detail loading

## Recommended First Build Slice

Start with this exact order:

1. add domain models for recurring routes, one-off trips, revisions, and utilization
2. add Supabase schema/migration support if missing or incomplete
3. add infrastructure repository methods for list/detail/create/update/toggle
4. add application controller for revision-aware route updates
5. replace `MyRoutesScreen` placeholder with segmented list state and empty states
6. add reusable create-edit form screens for route and one-off trip

This gives Phase 5 a usable backbone early without prematurely coupling to Phase 6 search or Phase 7 booking logic.
