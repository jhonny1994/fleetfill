# FleetFill Delivery Setup

This document closes the Phase 0 working agreement for FleetFill.

It defines how the project is organized before feature development begins.

## 1. Environment Naming

FleetFill uses three named environments:

- `local` - developer machine and local test data
- `staging` - integrated pre-production validation environment
- `production` - live customer environment

Rules:

- do not blur staging and production secrets
- every release candidate should be validated in `staging` first
- runtime config must make the active environment explicit

## 2. Repository And Branch Strategy

FleetFill uses one long-lived protected Git branch:

- `main`

Rules:

- commit only after an approved step from the product owner/user
- keep commits small, stable, and reviewable
- use tags for releases
- do not rely on long-lived feature branches as the default workflow

## 3. Package And Code Structure Strategy

FleetFill currently uses one Flutter app codebase.

Recommended boundaries:

- `core/` - auth, config, routing, theme, localization, permissions, shared infrastructure concerns
- `shared/` - reusable widgets, shared models, shared providers, design-system primitives
- `features/shipper/` - shipper-only flows
- `features/carrier/` - carrier-only flows
- `features/admin/` - internal admin experience inside the same app unless split later
- `features/profile/`, `features/support/`, `features/notifications/`, `features/onboarding/` - cross-role feature groups

Current decision:

- keep one codebase and one app shell for now
- keep admin as an internal role surface, not a separate product yet

## 4. Naming Conventions

### 4.1 Database

- tables: plural `snake_case`
- columns: `snake_case`
- SQL functions/RPC: `snake_case`
- enum values: `snake_case`
- audit/event type strings: `snake_case`

### 4.2 Flutter And Dart

- file names: `snake_case.dart`
- class names: `PascalCase`
- variables/functions: `lowerCamelCase`
- providers: `lowerCamelCaseProvider`
- route-name constants: stable, readable, and grouped by feature/shell

### 4.3 Routes And Storage

- route path segments: lowercase kebab-case or stable readable segments already defined in routing docs
- storage buckets: lowercase kebab-case
- storage object paths: deterministic, actor/entity-aware, and version-friendly

Recommended storage path patterns:

- payment proofs: `<bucket>/<booking_id>/<version>/<file>`
- verification docs: `<bucket>/<entity_type>/<entity_id>/<document_type>/<version>/<file>`
- generated docs: `<bucket>/<booking_id>/<document_type>/<version>/<file>`

## 5. Secrets Ownership

### 5.1 Client-Safe Runtime Config

Client-safe values may be exposed to the app through controlled configuration such as:

- Supabase project URL
- Supabase anon key
- public support and release URLs
- non-secret environment labels

These should be injected through environment-specific app config, not hardcoded repeatedly.

### 5.2 Server Secrets

Use Supabase project secrets / Edge Function secrets for:

- transactional email provider API key
- transactional email provider webhook verification secret where supported
- any third-party integration secret used by Edge Functions

### 5.3 Database-Side Secrets

Use Supabase Vault only when a secret must be read safely from SQL-side scheduled/runtime logic.

### 5.4 Local Development

- local secret files must stay untracked
- production secrets must never be copied into committed files
- secret ownership must be explicit before enabling a production integration

## 6. Release Responsibilities

### 6.1 App Release

- mobile app versioning, build artifacts, store-ready packages, and rollout notes

### 6.2 Backend Release

- Supabase migrations
- SQL functions/RPC
- Edge Functions
- platform settings changes that affect runtime behavior

### 6.3 Storage And Files

- bucket policy changes
- signed URL behavior
- generated document retention behavior

### 6.4 Operations

- support process readiness
- payment verification readiness
- dispute and payout runbooks
- rollback readiness for release-critical issues

## 7. Toolchain Baseline Verified Locally

Verified locally during Phase 0:

- Flutter `3.41.4`
- Dart `3.11.1`
- Java `17`

This confirms the local Flutter toolchain is ready to begin app development.

## 8. ADR Scope

FleetFill should keep ADRs for the most irreversible decisions.

Current ADR set:

- `docs/adr/ADR-001-single-role-account-model.md`
- `docs/adr/ADR-002-one-shipment-one-booking-one-trip.md`
- `docs/adr/ADR-003-platform-held-payment-flow.md`
- `docs/adr/ADR-004-supabase-rpc-edge-boundaries.md`

Add new ADRs only for decisions that significantly affect domain, schema, workflow, or platform shape.
