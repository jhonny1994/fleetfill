# FleetFill Delivery Setup

This document closes the Phase 0 working agreement for FleetFill.

It defines how the project is organized before feature development begins.

## 1. Runtime Contract

FleetFill uses one shared runtime contract across Flutter, admin web, CI, and Supabase:

- local development uses local URLs, local keys, and local-only transport overrides
- hosted behavior uses hosted URLs, hosted keys, and managed secrets

Release candidates and Vercel previews may still exist as delivery channels, but they are not separate FleetFill runtime modes.

Rules:

- do not blur local and hosted secrets
- every release candidate should be validated against the intended hosted configuration before production rollout
- runtime behavior must derive from actual URLs, keys, and secrets rather than a separate environment label

## 2. Repository And Branch Strategy

FleetFill uses one long-lived protected Git branch:

- `main`

Rules:

- commit only after an approved step from the product owner/user
- keep commits small, stable, and reviewable
- use tags for releases
- do not rely on long-lived feature branches as the default workflow

## 3. Package And Code Structure Strategy

FleetFill currently uses one Flutter app codebase for shipper and carrier surfaces, with a separate internal admin web console planned as the long-term primary admin surface.

Recommended boundaries:

- `core/` - auth, config, routing, theme, localization, permissions, shared infrastructure concerns
- `shared/` - reusable widgets, shared models, shared providers, design-system primitives
- `features/shipper/` - shipper-only flows
- `features/carrier/` - carrier-only flows
- `features/admin/` - temporary internal admin fallback surface inside the Flutter app while the primary admin web console reaches parity
- `features/profile/`, `features/support/`, `features/notifications/`, `features/onboarding/` - cross-role feature groups

Current decision:

- keep one customer-facing Flutter app shell for shipper and carrier flows
- build the primary admin experience as a separate internal web product in the same repository

Recommended repository shape:

```text
fleetfill/
  lib/                  # Flutter mobile app
  supabase/             # shared backend
  docs/
  admin-web/            # Next.js internal admin console
```

Admin delivery agreement:

- `admin-web/` is deployed separately from the Flutter app
- the admin web console reuses the same Supabase project, schema, storage, RPCs, and Edge Functions
- business rules remain server-controlled in Supabase; the web app is an operations UI, not a second backend
- the Flutter admin surface remains available only as a transitional fallback for urgent internal operations until web parity is reached

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
- Supabase publishable key for hosted deployments, or legacy anon key for local CLI/self-hosted development
- Google web client ID used as the native mobile `serverClientId`
- optional Google iOS client ID override when the bundled native Firebase config should not be the source of truth
- public support and release URLs
- non-secret public URLs and release metadata

These should be injected through runtime config based on actual targets, not hardcoded repeatedly.

### 5.2 Server Secrets

Use Supabase project secrets / Edge Function secrets for:

- transactional email provider API key
- transactional email provider webhook verification secret where supported
- Supabase Google provider web client secret
- any third-party integration secret used by Edge Functions

### 5.3 Database-Side Secrets

Use Supabase Vault only when a secret must be read safely from SQL-side scheduled/runtime logic.

### 5.4 Local Development

- local secret files must stay untracked
- production secrets must never be copied into committed files
- secret ownership must be explicit before enabling a production integration
- root `.env` is the canonical local secret source for Supabase CLI and Edge worker secrets
- Flutter runtime values still need `--dart-define` or editor launch configuration because the mobile app does not read root `.env` directly

### 5.5 Current Auth And Email Baseline

- FleetFill mobile Google sign-in uses the native `google_sign_in` flow and exchanges Google tokens with Supabase through `signInWithIdToken(...)`
- Supabase Auth still owns the FleetFill session after Google identity is verified
- local and hosted Supabase Google provider setup must use the Google web OAuth client ID and secret
- local Google redirect URI is `http://127.0.0.1:54321/auth/v1/callback`
- hosted Google redirect URI is `https://<project-ref>.supabase.co/auth/v1/callback`
- transactional email is currently standardized on a provider adapter path over secure server-side HTTP, not direct SMTP, while preserving the generic outbox/retry model

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
- `docs/adr/ADR-005-admin-web-console.md`

Add new ADRs only for decisions that significantly affect domain, schema, workflow, or platform shape.
