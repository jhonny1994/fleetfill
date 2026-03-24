# Admin Web

## Purpose

The admin web console is the primary internal operations surface for FleetFill staff.

It exists to:

- review trust-sensitive queues
- perform controlled operational actions
- inspect audit and delivery health
- manage runtime settings and users

It is not a generic BI dashboard and not a second backend.

## Scope

The admin console covers:

- verification review
- payment proof review
- disputes
- payouts
- support
- audit and health
- user operations
- controlled settings surfaces

## Technical Contract

- `admin-web/` uses the same Supabase backend as the Flutter app.
- Business rules remain in the database and Edge Functions.
- Admin UI should consume existing RPCs, tables, and queues rather than re-implementing backend logic in Next.js.

## Auth And Governance

- Admin access is internal and role-controlled.
- Sensitive actions must respect step-up and audit requirements.
- Admin surfaces should separate monitoring from mutation and make irreversible actions explicit.

## Communications Scope

- Admin email health views represent FleetFill transactional email queues and logs.
- Supabase Auth email is not part of the transactional outbox and should be labeled separately.

## UX Posture

The admin console should feel:

- operational
- dense where useful
- calm
- traceable
- fast to diagnose

It should avoid dashboard filler, vanity analytics, and unclear ownership of actions.
