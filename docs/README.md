# FleetFill Documentation

This directory is the canonical source of truth for FleetFill.

Read the files in this order:

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

Supporting assets:

- `docs/wilayas-with-municipalities.json` - Algeria location seed data
- `docs/adr/` - architecture decision records for the most irreversible decisions

Rules for all future documentation updates:

- Do not create parallel truth sources for product rules, states, pricing, or schema.
- Update the canonical file instead of adding overlapping notes elsewhere.
- If a decision changes the domain, update `02-domain-and-state-model.md` first.
- If a decision changes data ownership, RLS, or storage, update `04-data-and-security-model.md`.
- If a decision changes user flows or UI behavior, update `05-ux-and-localization.md`.
- If a decision changes SLAs, review workflow, payouts, or legal/support operations, update `06-operations-and-compliance.md`.
- If a decision changes Supabase implementation boundaries, scheduling, RLS strategy, functions, storage, or secret handling, update `09-supabase-implementation-notes.md`.

Current product posture:

- One long-lived product, not a throwaway MVP.
- Android is the first production platform.
- iOS configuration and version policy must remain ready in the system design even if public rollout is delayed.
- One account maps to one role.
- One shipment maps to one booking and one truck/trip.
