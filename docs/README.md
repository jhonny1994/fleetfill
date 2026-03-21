# FleetFill Documentation

This directory contains both canonical product docs and working delivery documents.

The folder was getting noisy because not everything under `docs/` is the same kind of artifact. Use the categories below instead of treating every file as equal product truth.

## Canonical Product Truth

These files define the product, domain, architecture, security, UX, and implementation target. Read them in this order:

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

Only these files should define product truth.

## Working Delivery Docs

These files are important, but they are not parallel sources of product truth:

- `docs/12-polish-backlog.md` - deferred polish backlog
- `docs/13-release-operations.md` - staging, release-candidate, versioning, and rollback procedures
- `docs/14-post-launch-stabilization.md` - post-launch operating cadence
- `docs/15-audit-phases-0-to-14.md` - current cross-phase audit and production-readiness tracker

Consolidation note:

- the old phase 0-4 audit and delivery playbook were folded into `docs/15-audit-phases-0-to-14.md` and this index to remove stale parallel guidance

## Reference Assets

These are supporting assets, not narrative docs:

- `docs/wilayas-with-municipalities.json` - Algeria location seed data
- `docs/logo.png` - project asset
- `docs/adr/` - architecture decision records for irreversible or high-cost decisions

## Update Rules

- Do not create parallel truth sources for product rules, states, pricing, schema, or security behavior.
- Update the canonical file instead of adding overlapping notes elsewhere.
- Use `docs/12-polish-backlog.md` only for deferred polish work, not for domain or security truth.
- Use `docs/15-audit-phases-0-to-14.md` to track findings, remediation, validation status, and historical audit carry-forward notes.
- If a decision changes the domain, update `docs/02-domain-and-state-model.md` first.
- If a decision changes data ownership, RLS, or storage, update `docs/04-data-and-security-model.md`.
- If a decision changes user flows or UI behavior, update `docs/05-ux-and-localization.md`.
- If a decision changes SLAs, review workflow, payouts, or legal/support operations, update `docs/06-operations-and-compliance.md`.
- If a decision changes Supabase implementation boundaries, scheduling, RLS strategy, functions, storage, or secret handling, update `docs/09-supabase-implementation-notes.md`.

## Current Product Posture

- One long-lived product, not a throwaway MVP.
- Android is the first production platform.
- iOS configuration and version policy must remain ready in the system design even if public rollout is delayed.
- One account maps to one role.
- One shipment maps to one booking and one truck or trip.
