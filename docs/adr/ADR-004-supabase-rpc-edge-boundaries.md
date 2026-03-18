# ADR-004: Supabase RPC and Edge Function Boundaries

## Status

Accepted

## Decision

Use Postgres/RPC for atomic business workflows and Edge Functions for integration-facing workflows.

RPC owns:

- booking creation
- payment approval/rejection
- dispute resolution
- payout release
- typed client settings

Edge Functions own:

- transactional email dispatch
- email provider webhook handling
- scheduled worker entrypoints
- secure HTTP integration boundaries

## Why

- atomic business state belongs in the database transaction boundary
- external APIs and webhook handling belong in server-side HTTP runtimes
- this is the cleanest fit for Supabase and for FleetFill's risk areas

## Consequences

- business logic should not be duplicated in Edge Function code
- scheduling/outbox patterns must be designed around these boundaries
- RLS, SQL constraints, and triggers remain first-class safeguards
