# FleetFill Documentation

This directory is the single home for product, architecture, planning, ADRs, and implementation templates.

Not everything under `docs/` carries the same authority. Use the categories below instead of treating every file as equal product truth.

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

- `docs/planning/admin-web/admin-web-console-plan.md` - detailed admin web scope, IA, feature inventory, and rollout plan
- `docs/planning/admin-web/admin-web-master-spec.md` - consolidated implementation-grade spec for the admin web product
- `docs/planning/admin-web/admin-web-system-design.md` - system design for the admin web product and backend/governance integration
- `docs/planning/admin-web/admin-web-ui-ux-spec.md` - UI/UX specification for the admin web product
- `docs/planning/admin-web/admin-web-production-checklist.md` - release-readiness checklist and certification tracker for the admin web console
- `docs/planning/admin-web/admin-web-browser-qa-checklist.md` - preview/browser QA checklist for certifying admin-web flows before release
- `docs/planning/admin-web/prd-admin-web-console.md` - product requirements document for the admin web console
- `docs/planning/admin-web/tasks-admin-web-console.md` - implementation task list for the admin web console
- `docs/planning/operations/polish-backlog.md` - deferred polish backlog
- `docs/planning/operations/release-operations.md` - release-rehearsal, release-candidate, versioning, and rollback procedures
- `docs/planning/operations/post-launch-stabilization.md` - post-launch operating cadence
- `docs/planning/operations/production-readiness-audit.md` - current cross-phase audit and production-readiness tracker

Consolidation note:

- the old phase 0-4 audit and delivery playbook were folded into `docs/planning/operations/production-readiness-audit.md` and this index to remove stale parallel guidance

Admin planning ecosystem:

- `prd-admin-web-console.md` defines the product contract and launch scope
- `tasks-admin-web-console.md` defines the execution sequence and implementation checklist
- `admin-web-master-spec.md` is the umbrella build spec tying product, architecture, and design together
- `admin-web-system-design.md` owns the admin-web technical architecture, governance model, and backend integration shape
- `admin-web-ui-ux-spec.md` owns the interaction model, visual system, page patterns, and responsive UX rules
- `admin-web-production-checklist.md` owns the broader launch-readiness matrix across product completeness, governance, CI/CD, QA, deployment, and operations
- `admin-web-browser-qa-checklist.md` owns the manual preview QA pass and the role-by-role browser certification checklist
- `admin-web-console-plan.md` is the delivery companion that maps the locked decisions into rollout phases and implementation slices

## Templates And Generators

These files are process templates, not product truth:

- `docs/templates/create-prd.md` - PRD generation rules
- `docs/templates/generate-tasks.md` - task-list generation rules

## Reference Assets

These are supporting assets, not narrative docs:

- `data/locations/wilayas-with-municipalities.json` - Algeria location seed data
- `assets/logo.png` - project asset
- `docs/adr/` - architecture decision records for irreversible or high-cost decisions

## Update Rules

- Do not create parallel truth sources for product rules, states, pricing, schema, or security behavior.
- Update the canonical file instead of adding overlapping notes elsewhere.
- Apply the same consolidation rule used for dev-phase migrations: rewrite the owning canonical doc or tracker layer instead of stacking patch notes on top of older notes.
- Use `docs/planning/operations/polish-backlog.md` only for deferred polish work, not for domain or security truth.
- Use `docs/planning/operations/production-readiness-audit.md` to track findings, remediation, validation status, and historical audit carry-forward notes.
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
