# FleetFill Docs

This folder now has one active documentation set and one archive.

Use the active set first:

- [product.md](C:\Users\raouf\projects\fleetfill\docs\product.md) - product scope, users, rules, flows, and shared language
- [architecture.md](C:\Users\raouf\projects\fleetfill\docs\architecture.md) - system design, runtime contract, backend boundaries, and security model
- [operations.md](C:\Users\raouf\projects\fleetfill\docs\operations.md) - support, payments, disputes, release operations, and email ownership
- [admin-web.md](C:\Users\raouf\projects\fleetfill\docs\admin-web.md) - the admin console product and technical contract
- [delivery.md](C:\Users\raouf\projects\fleetfill\docs\delivery.md) - current readiness, validation status, release gates, and remaining manual checks

Reference folders:

- [adr](C:\Users\raouf\projects\fleetfill\docs\adr) - irreversible architectural decisions
- [templates](C:\Users\raouf\projects\fleetfill\docs\templates) - PRD and task generation rules
- [workitems](C:\Users\raouf\projects\fleetfill\docs\workitems) - active feature PRDs and task lists
- [archive](C:\Users\raouf\projects\fleetfill\docs\archive) - historical numbered docs, planning packs, and superseded detail sets

## Rules

- Keep product truth in the active root docs, not in work items or archive notes.
- Update the owning active doc when behavior changes.
- Use `docs/workitems/` for implementation planning only.
- Move superseded or exploratory material into `docs/archive/` instead of leaving parallel truth at the root.

## Ownership

- Update [product.md](C:\Users\raouf\projects\fleetfill\docs\product.md) for domain rules, user journeys, search, booking, and account behavior.
- Update [architecture.md](C:\Users\raouf\projects\fleetfill\docs\architecture.md) for runtime config, Flutter routing, Supabase boundaries, security, storage, and automation.
- Update [operations.md](C:\Users\raouf\projects\fleetfill\docs\operations.md) for payment review, support, disputes, payouts, compliance, and communications.
- Update [admin-web.md](C:\Users\raouf\projects\fleetfill\docs\admin-web.md) for admin console scope and operator experience.
- Update [delivery.md](C:\Users\raouf\projects\fleetfill\docs\delivery.md) for implementation status, release readiness, and manual validation gates.

## Posture

- One long-lived product, not a throwaway MVP.
- Android is the primary production client.
- Supabase local and Supabase cloud run the same product contract with different URLs, keys, and secrets.
- Auth email and transactional email are separate systems and should stay documented that way.
