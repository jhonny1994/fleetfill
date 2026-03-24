# FleetFill Supabase Implementation Notes

This document maps FleetFill onto Supabase features and records the preferred implementation patterns.

It exists to answer one question clearly:

Which Supabase capability should be used for each kind of FleetFill behavior, and why?

## 1. Core Implementation Principle

FleetFill should treat Supabase as a serious backend platform, not only as a database plus auth shortcut.

Recommended architecture posture:

- Postgres is the authoritative workflow engine
- SQL functions/RPC own atomic business transactions
- Edge Functions own external integrations and HTTP-facing orchestration
- RLS protects all exposed data paths
- Storage uses private buckets and controlled signed access
- scheduled automation handles delayed workflows and queue draining

The goal is to keep business correctness inside the database boundary wherever atomicity matters.

## 2. Supabase Feature Mapping

### 2.1 Feature-To-FleetFill Mapping Table

| Supabase feature | FleetFill use | Why | Notes |
| --- | --- | --- | --- |
| `Auth` | email/password, Google sign-in, session management | built-in auth with Flutter support | business roles stay in `profiles`, not only auth metadata |
| `Postgres tables` | bookings, shipments, routes, payouts, disputes, documents, notifications | authoritative business data | use constraints and indexes aggressively |
| `RLS` | row isolation for shipper/carrier/admin access | defense in depth | deny by default |
| `Database Functions / RPC` | atomic booking/payment/dispute/payout/settings workflows | strongest place for multi-write transactional logic | prefer for data-heavy critical flows |
| `Edge Functions` | transactional email sending, provider webhooks, thin orchestration APIs, signed URL helpers | server-side TypeScript integration layer | keep them short-lived and idempotent |
| `Storage` | payment proofs, verification documents, generated PDFs | secure file handling | private buckets only |
| `Storage RLS` | upload/read restrictions on `storage.objects` | secure object access | bind by bucket, path, and actor |
| `Signed URLs` | temporary proof/document/PDF viewing | avoids public files | short TTL only |
| `Realtime` | optional freshness for bookings/queues/notifications | improves UX | correctness must not depend on realtime |
| `pg_cron` | periodic workers and timed automation ticks | native scheduling in Postgres | verify plan behavior in real project |
| `pg_net` | scheduled HTTP calls and DB-triggered async networking | useful for cron-triggered Edge Function invocation | not a substitute for durable business state |
| `Vault` | secrets for DB-side scheduled calls | encrypted secret storage usable from SQL | limit access carefully |
| `Project secrets` | Edge Function secrets such as transactional email provider API keys | standard server secret handling | never expose to client |
| `Logs / dashboard observability` | workflow debugging and ops visibility | baseline production support | complement with structured app logs |

## 3. When To Use SQL Functions vs Edge Functions

### 3.1 Use Database Functions / RPC For

Use SQL or PL/pgSQL functions when the main job is to enforce business rules and commit multiple related records atomically.

Recommended FleetFill RPC candidates:

- `create_booking`
- `approve_payment`
- `reject_payment`
- `open_dispute`
- `resolve_dispute`
- `release_payout`
- `get_client_settings`

Use DB functions here because they need one transaction for:

- main business state change
- ledger writes
- audit log writes
- reservation/capacity updates
- outbox inserts

### 3.2 Use Edge Functions For

Use Edge Functions when the job crosses the database boundary or needs HTTP-facing logic.

Recommended FleetFill Edge Function candidates:

- `transactional-email-dispatch-worker`
- `email-provider-webhook`
- `generate-signed-file-url`
- `scheduled-automation-tick`

Use Edge Functions for:

- external APIs
- webhook verification
- email dispatch
- secure HTTP endpoints that should not expose raw DB contracts
- orchestration that calls RPC and third-party services together

### 3.3 Rule Of Thumb

- if the workflow is mostly DB state and must be atomic, prefer RPC
- if the workflow is mostly HTTP/integration work, prefer Edge Function
- if both are involved, Edge Function should call a DB function, not duplicate business logic in TypeScript

## 4. Recommended FleetFill Supabase Architecture

### 4.1 Auth And Profiles

- `auth.users` owns authentication identity
- `public.profiles` owns app role and business profile
- authorization must come from DB-backed role/profile logic, not user-editable auth metadata

Current Google posture:

- mobile clients use native Google sign-in first, then exchange Google tokens with Supabase Auth through `signInWithIdToken(...)`
- Supabase Google provider configuration still uses the Google web OAuth client ID and secret
- native mobile client IDs remain a platform concern, while the resulting FleetFill session remains a normal Supabase Auth session

Recommended rule:

- use auth only for identity
- use `profiles.role` and operational gates for business authorization

### 4.2 Data Ownership

- shipper-owned data: shipments, own bookings view, own proofs, own notifications
- carrier-owned data: vehicles, payout accounts, routes, one-off trips, own bookings view
- admin-controlled data: verification decisions, payment decisions, disputes, payouts, settings, audits

### 4.3 Settings Contract

`platform_settings` is internal storage.

Clients should consume a typed response from `get_client_settings`, not raw table reads.

Client-facing settings should include only safe/public operational values such as:

- search window
- maintenance mode
- version rules
- insurance settings
- delivery review grace window
- payment proof resubmission window
- active payment account display data needed by the app

## 5. Transactional Data Strategy

### 5.1 Critical Transaction Rule

The following workflows must commit in one DB transaction:

- booking creation
- payment approval
- payment rejection
- dispute resolution
- payout release
- outbox enqueueing related to those actions

Each such transaction should update all required records together:

- primary business table
- audit log
- ledger or case record
- queue/outbox rows when needed

### 5.2 Why This Matters

Without this rule, FleetFill risks:

- booking created without capacity reservation
- payment approved without audit log
- payout released without ledger entry
- business state changed but notification/email not queued

## 6. Capacity Locking And Reservation Model

### 6.1 Why Route-Level Reads Are Not Enough

Recurring routes are templates. They are not safe as the only concurrency boundary for booking confirmation.

If two users book at the same time against the same route/day, simple reads can overbook capacity.

### 6.2 Recommended Model

Introduce a per-date departure capacity record, for example:

- `route_departure_instances`

Recommended fields:

- `id`
- `route_id`
- `departure_date`
- `vehicle_id`
- `total_capacity_kg`
- `reserved_capacity_kg`
- `remaining_capacity_kg`
- `total_capacity_volume_m3 null`
- `reserved_volume_m3 null`
- `remaining_volume_m3 null`
- `status`
- timestamps

### 6.3 Booking Flow

`create_booking` should:

1. resolve the correct route departure instance or one-off trip
2. lock the capacity row with transactional row locking
3. verify remaining weight and optional volume capacity
4. insert the booking snapshot
5. update reserved/remaining capacity
6. write audit/log/outbox rows
7. commit

This is the safest model for FleetFill on Postgres.

## 7. Database Constraints And Triggers

### 7.1 Constraints To Enforce In The DB

Recommended DB constraints:

- exactly one of `route_id` or `oneoff_trip_id` on `bookings`
- unique `shipment_id` on `bookings`
- unique `tracking_number`
- unique `payment_reference`
- partial unique index for one active payout account per carrier
- enum or checked status values for workflow columns

### 7.2 Append-Only Protection

Protect these with DB triggers that reject updates/deletes except through explicit controlled admin/system paths if ever needed:

- `tracking_events`
- `financial_ledger_entries`
- `admin_audit_logs`
- historical `payment_proofs`
- historical `verification_documents`

Recommended pattern:

- `BEFORE UPDATE OR DELETE` trigger
- raise exception unless a narrowly defined trusted path is used

### 7.3 Route Revision Protection

Recurring route edits that affect price/capacity/schedule should create `route_revisions`, not rewrite past commitments.

## 8. RLS Strategy

### 8.1 Baseline Rules

- enable RLS on every exposed table
- use deny-by-default
- write explicit `SELECT`, `INSERT`, `UPDATE`, `DELETE` policies
- use `TO authenticated` where appropriate
- use `(select auth.uid())` style calls in policies

### 8.2 Authorization Data Placement

Do not trust user-editable metadata for authorization.

Best practice:

- auth identity from `auth.users`
- authorization from protected tables and server-controlled fields

### 8.3 Performance Guidance

For RLS performance:

- index every column used in policies
- keep policies simple
- avoid expensive joins when possible
- add normal query filters even when RLS already filters the same field

### 8.4 Sensitive Columns

Protect these from direct client mutation:

- `profiles.role`
- `profiles.is_active`
- verification statuses and rejection fields
- payout verification fields
- audit records
- ledger records

## 9. Storage Strategy

### 9.1 Buckets

Use private buckets only:

- `payment-proofs`
- `verification-documents`
- `generated-documents`

### 9.2 Upload Flow

Recommended flow:

1. client requests upload session
2. server validates actor/entity/document type
3. client uploads with controlled path/policy
4. metadata row is recorded
5. viewing uses short-lived signed URL

### 9.3 File Integrity Metadata

Store metadata for sensitive files where practical:

- content type
- byte size
- checksum/hash
- storage path
- actor
- created time

This helps with:

- tamper detection
- support investigation
- retention/cleanup
- auditability

## 10. Scheduling And Background Work

### 10.1 Recommended Initial Scheduling Mechanism

For FleetFill on Supabase:

- use `pg_cron` to schedule a periodic automation tick
- use either:
  - a cron-triggered Edge Function, or
  - a DB-triggered network call path using `pg_net`

Preferred initial pattern:

- `pg_cron` invokes one Edge Function worker every minute

Why this is best:

- operationally simple
- fits Supabase-native docs
- easy to reason about
- keeps external HTTP and secret handling out of large trigger logic

### 10.2 What The Worker Should Handle

Initial scheduled jobs:

- email outbox draining
- delivery grace-window expiry
- payment resubmission expiry
- stale queue lock recovery

### 10.3 Free Plan Caveat

The architecture is production-grade, but the deployed topology is intentionally small.

For Free plan use:

- one scheduled worker
- small batches
- full idempotency
- full logging
- operational fallback if a run is delayed or missed

Before relying on it in production, verify:

- actual availability of the scheduling mechanism on your project/plan
- acceptable cadence for your workflows
- timeout and quota behavior in real staging tests

## 11. pg_net Guidance

`pg_net` is useful, but should be used intentionally.

Good use cases:

- cron-triggered HTTP calls
- low-frequency DB-initiated async notifications
- simple internal automation bridge calls

Important limitations:

- async request/response storage is not durable business truth
- responses are stored temporarily
- request/response storage uses unlogged tables
- it is not the place to keep canonical workflow state

Best rule:

- use `pg_net` for transport/orchestration help, not as the source of truth

## 12. Vault And Secrets Strategy

### 12.1 Use Vault For

- DB-side secrets needed by scheduled SQL jobs
- project URL / anon token references for cron-triggered HTTP calls if needed

### 12.2 Use Edge Function Project Secrets For

- transactional email provider API keys
- webhook verification secrets where supported
- any integration secrets consumed directly by Edge Functions

### 12.3 Secret Rule

- never expose secrets to the client
- never store secrets in app code
- keep secret ownership explicit per runtime

## 13. Transactional Email On Supabase

### 13.1 Sending Strategy

- outbox rows created in DB transaction
- DB owns canonical transactional email copy in `email_templates`
- scheduled worker invokes the chosen transactional email provider from an Edge Function
- Edge Function resolves the active template row, renders subject/text/html server-side, then updates delivery records through RPC
- current provider adapter baseline is a transactional provider HTTP API adapter
- provider-specific request headers, payload shape, and response parsing should remain inside the Edge adapter, not leak into DB queue contracts
- render failures should be recorded separately from provider failures so broken templates dead-letter immediately and remain operationally visible

### 13.2 Webhook Strategy

Provider webhook handling should live in an Edge Function when the provider supports webhooks.

Requirements:

- verify webhook authenticity
- treat events as idempotent
- handle out-of-order events safely
- record provider event IDs or references
- normalize provider-native event names and message identifiers into FleetFill delivery states before updating logs

## 14. Recommended FleetFill Function Inventory

### 14.1 Database Functions / RPC

- `create_booking`
- `approve_payment`
- `reject_payment`
- `open_dispute`
- `resolve_dispute`
- `release_payout`
- `get_client_settings`
- `create_upload_session`
- `finalize_payment_proof`
- `finalize_verification_document`

### 14.2 Edge Functions

- `scheduled-automation-tick`
- `transactional-email-dispatch-worker`
- `email-provider-webhook`
- `signed-file-url`

These names are placeholders and can change, but the boundaries should remain similar.

## 15. Observability And Operations

### 15.1 What To Monitor

- booking creation failures
- payment review backlog
- dispute backlog
- payout backlog
- email outbox depth
- dead-letter email count
- grace-window expiry job health
- payment-resubmission expiry job health

### 15.2 Operational Fallbacks

If scheduled automation is delayed:

- admin queue should reveal overdue delivery reviews
- admin queue should reveal overdue payment resubmission expiries
- email dead-letter and backlog views must show stuck items

FleetFill should never silently depend on invisible automation.

## 16. Final Supabase Guidance For FleetFill

Best final posture:

- business correctness lives in Postgres
- atomic workflows use DB functions/RPC
- integrations and webhooks use Edge Functions
- scheduling uses `pg_cron` with a minimal but real worker model
- `pg_net` helps with async calls, but is not workflow truth
- RLS and Storage policies enforce data isolation
- the initial topology may be small, but the pattern should already be correct

This gives FleetFill a production-grade Supabase architecture without forcing enterprise-scale infrastructure before the product needs it.
