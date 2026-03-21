# Delivery Playbook

## Goal

This file is the execution and handoff playbook for FleetFill after the Phase 0-6 foundation is in place.

Use it when a new engineer or coding agent needs to pick up the project without re-discovering how delivery decisions are supposed to be made.

## Delivery Persona

Build as a production-minded FleetFill operator, not as a hackathon prototype builder.

Expected behavior:

- prefer product truth over placeholder convenience
- prefer server-controlled truth over client-side assumptions
- prefer explicit UX states over silent magic
- prefer small, reviewable units of change over broad bundled edits
- prefer canonical doc updates over side notes and parallel truth files
- do the work so another engineer can pick it up cold

Tone and decision posture:

- operational, not promotional
- deterministic, not approximate unless the docs explicitly allow approximation
- mobile-first, Android-first, but not Android-only in system design
- safe for local Supabase resets and production-minded deployment later

## Canonical Read Order

Read these first, in order:

1. `docs/00-delivery-setup.md`
2. `docs/01-product-and-scope.md`
3. `docs/02-domain-and-state-model.md`
4. `docs/03-technical-architecture.md`
5. `docs/04-data-and-security-model.md`
6. `docs/05-ux-and-localization.md`
7. `docs/06-operations-and-compliance.md`
8. `docs/07-implementation-plan.md`
9. `docs/08-screen-map-and-routing.md`
10. `docs/09-supabase-implementation-notes.md`

Supporting files:

- `docs/10-audit-phases-0-to-4.md`
- `docs/15-audit-phases-0-to-14.md`
- `docs/wilayas-with-municipalities.json`
- `docs/adr/`

## Current Product Posture

Completed and verified enough to continue from:

- Phase 0 through Phase 6

Current next build target:

- Phase 7 - Booking And Pricing Flow

Important product truths already locked:

- one account maps to one role
- one shipment maps to one booking and one truck/trip
- exact-route search is default behavior
- if no exact route exists, the user gets nearest-date fallback or redefine-search guidance, not approximate-route mixing
- payments are external and proof-based
- tracking is milestone-based, not live GPS at launch

## Implementation Rules

### Architecture

- `presentation/` renders UI and owns only local ephemeral state
- `application/` owns orchestration and multi-step workflows
- `infrastructure/` owns Supabase CRUD, RPC, and external integration boundaries
- `domain/` owns immutable business models and state contracts

### Routing

- keep route paths centralized in `lib/core/routing/app_routes.dart`
- do not add ad hoc string interpolation for app paths
- prefer shared above-shell detail routes for reusable detail surfaces
- use sheets/dialogs for microflows before adding more routes

### Supabase

- use change-oriented migration names, never phase-bundle names
- keep migrations narrow and reviewable where practical
- keep deterministic local seed flow under `supabase/seed.sql` and `supabase/seeds/`
- keep user-callable RPC and privileged RPC logically separated
- keep local reset flow healthy: `supabase db reset --yes` and `supabase db lint` must stay green

### UX And Copy

- use operational language, not startup language
- no hardcoded user-facing strings in runtime UI
- keep Arabic/French/English localization in ARB files
- preserve bidi-safe formatting for operational identifiers and prices

## Apply Now vs Defer

### Apply During Feature Delivery

These should be added as soon as the affected feature exists:

- debounce for search/filter inputs
- stale-result protection and request invalidation for overlapping searches
- lazy rendering for long lists and growing result sets
- destructive confirmations for delete/deactivate/cancel flows
- shared loading, empty, retry, offline, forbidden, and not-found states
- page storage keys for long-lived scrollable screens that keep the same layout
- localized backend error mapping instead of leaking raw technical strings

### Defer To End-Of-Major-Phase Polish

These should be logged and applied in a coordinated polish pass after most major phases are complete:

- skeleton loading / shimmer loading for known-content layouts
- broader progressive reveal and transition polish
- image/media optimization where media-heavy screens exist
- final accessibility release pass
- final bidi/localization polish pass

Deferred polish work is tracked in `docs/12-polish-backlog.md`.

## Validation Standard

For meaningful backend/app changes, run:

- `dart analyze`
- `flutter test`
- `supabase db reset --yes`
- `supabase db lint`

Do not mark implementation-plan items complete unless the relevant validation still passes.

## Pick-Up Guidance For The Next Phase

If continuing from here:

- use `docs/07-implementation-plan.md` as the active execution checklist
- use `docs/05-ux-and-localization.md` for UX rules and apply-now vs defer guidance
- use `docs/12-polish-backlog.md` for deferred polish items that should not get lost
- for new irreversible technical decisions, write or update ADRs under `docs/adr/`

## Anti-Drift Rules

- do not create new “readiness” or “phase notes” files unless they are truly necessary and linked from `docs/README.md`
- do not leave phase-specific TODO logic hidden only in chat history
- if implementation changes product truth, update canonical docs first or in the same change
- if implementation only refines delivery quality, update the implementation plan and playbook/backlog instead of duplicating canonical product rules
