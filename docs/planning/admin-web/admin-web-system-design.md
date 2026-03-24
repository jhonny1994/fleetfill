# FleetFill Admin Web System Design

## 1. Purpose

This document defines the implementation-grade system design for the FleetFill admin web console.

Document role inside the admin-web planning ecosystem:

- the PRD defines product scope and success conditions
- the task list defines execution order and implementation checkpoints
- the master spec ties the full admin program together
- this document owns technical architecture, governance, backend integration, and deployment shape
- the UI/UX spec owns interface behavior, visual rules, and responsive interaction patterns

It exists to answer:

- how the admin web app fits into the FleetFill system
- which backend contracts it reuses
- which backend capabilities must be added
- how auth, RBAC, governance, data loading, actions, and deployment should work together

This document is intentionally opinionated. The goal is to reduce architectural drift before implementation starts.

## 2. System Context

FleetFill will have three major surfaces:

1. Flutter customer app
   - shipper
   - carrier
   - lightweight companion admin fallback
2. Admin web console
   - primary internal operations workspace
3. Shared Supabase backend
   - auth
   - postgres
   - storage
   - RPCs
   - edge functions
   - audit and outbox workflows

System principle:

- mobile and admin-web are both clients of the same backend domain
- business rules stay in Supabase
- admin-web does not become a second backend

## 3. Primary Goals

- provide a production-ready internal admin console
- support full admin operations, not only Flutter-admin parity
- preserve one shared business-rule boundary
- keep privileged flows secure by default
- make admin governance explicit and durable

## 4. Stack

### 4.1 Frontend

- Next.js
- App Router
- TypeScript
- Tailwind CSS
- shadcn/ui
- TanStack Query
- TanStack Table
- Recharts
- react-hook-form
- zod

### 4.2 Backend

- Supabase Auth
- Postgres
- RLS
- Storage
- RPCs
- Edge Functions

### 4.3 Hosting

- Vercel for `admin-web/`
- Supabase for backend services

## 5. Application Boundaries

### 5.1 What belongs in admin-web

- layout and navigation
- queue views
- detail workspaces
- filters and search UI
- local interaction state
- form state and validation
- SSR auth/session shaping
- client-side query invalidation and optimistic freshness behavior

### 5.2 What belongs in Supabase

- authorization truth
- admin role and invitation truth
- booking/payment/verification/dispute/payout workflow rules
- support workflow rules
- audit logging
- settings write validation
- secure signed file access
- outbox and retry logic

### 5.3 What must not happen

- no service-role key in browser
- no browser-only authorization logic
- no duplicated business rules in Next.js route handlers if an RPC should own them
- no direct admin profile-role editing as a shortcut for governance

## 6. Recommended Repo Structure

```text
fleetfill/
  lib/
  supabase/
  docs/
  admin-web/
    app/
    components/
    lib/
    public/
    styles/
    tests/
```

Recommended `admin-web/` structure:

```text
admin-web/
  app/
    [lang]/
      (auth)/
        sign-in/
      (admin)/
        dashboard/
        payments/
        verification/
        disputes/
        payouts/
        support/
        users/
        admins/
        settings/
        audit-and-health/
      layout.tsx
      loading.tsx
      not-found.tsx
    global-error.tsx
    proxy.ts
  components/
    admin-shell/
    dashboard/
    queues/
    detail/
    admin-management/
    shared/
  lib/
    auth/
    supabase/
    i18n/
    formatting/
    permissions/
    queries/
    validation/
  styles/
  tests/
```

## 7. Rendering Model

### 7.1 Core Rules

- Server Components by default
- Client Components only for interaction-heavy surfaces
- narrow `"use client"` boundaries
- route-level `loading.tsx`, `error.tsx`, and `not-found.tsx`
- nested layouts own shell composition

### 7.2 Data Strategy

Use a hybrid SSR + client interaction model:

- server-render the initial route
- hydrate only the parts that need interactivity
- use TanStack Query for:
  - filter/search refetches
  - mutation invalidation
  - stale-while-refresh behavior
  - explicit query cache control

Queue policy:

- queue pages are dynamic operational views
- do not rely on static generation
- preserve visible context during refresh

## 8. Authentication And Session Design

### 8.1 Session Model

Use `@supabase/ssr` with cookie-based auth.

Required pieces:

- server Supabase client
- browser Supabase client
- request-time auth refresh in `proxy.ts`
- server-side admin session reader
- route-level admin role enforcement

### 8.2 Protected Access

Protected admin pages must:

- verify there is an authenticated session
- verify the user is an active admin
- verify the user has sufficient admin role for the route/action

### 8.3 Step-Up

Sensitive admin actions should continue to respect recent-auth / step-up rules where required by backend policy, including:

- payout release
- dispute resolution
- admin activation/deactivation
- role changes
- settings changes with operational impact

The web app must surface these requirements explicitly, not only as opaque backend failures.

## 9. Admin Governance Design

This is the main new backend scope that is not fully defined by the current Flutter admin implementation.

### 9.1 Admin Roles

Exactly two roles:

- `super_admin`
- `ops_admin`

### 9.2 Recommended Data Model

Keep `profiles` as the identity anchor, but add admin-specific governance tables.

Recommended additions:

- `admin_accounts`
  - `profile_id`
  - `admin_role`
  - `is_active`
  - `invited_by`
  - `activated_at`
  - `deactivated_at`
  - `deactivated_by`
- `admin_invitations`
  - `id`
  - `email`
  - `role`
  - `token_hash`
  - `status`
  - `expires_at`
  - `invited_by`
  - `accepted_by_profile_id`
  - timestamps

Optional later:

- `admin_security_events`
- `admin_notes`
- `queue_assignments`

### 9.3 Governance Rules

- no public admin signup
- first admin must be bootstrapped through a controlled path
- only `super_admin` may invite admins
- only `super_admin` may change admin roles
- only `super_admin` may activate/deactivate admins
- never allow the last active `super_admin` to be removed or deactivated
- never allow self-orphaning actions that leave the system without a super admin

### 9.4 First Admin Bootstrap

Recommended approach:

- one controlled bootstrap path via migration seed or privileged one-time function
- not exposed in public auth UI
- explicitly auditable
- disabled or tightly constrained after first successful bootstrap

### 9.5 Invitation Flow

Recommended lifecycle:

1. `super_admin` creates invite
2. system generates single-use expiring token
3. invite email is sent
4. invited person authenticates or creates auth identity
5. invite is accepted through privileged backend flow
6. admin account is activated
7. audit records are written

Required statuses:

- `pending`
- `accepted`
- `expired`
- `revoked`

## 10. Authorization Model

### 10.1 Frontend Guarding

Frontend may hide or disable actions for clarity, but frontend hiding is never authorization.

### 10.2 Backend Truth

Every sensitive mutation must enforce:

- authenticated session
- active admin account
- sufficient admin role
- workflow-specific permission
- recent step-up when required

### 10.3 Role Responsibility Split

Recommended v1 split:

- `super_admin`
  - invite/manage admins
  - role changes
  - admin activation/deactivation
  - high-impact settings
  - everything `ops_admin` can do
- `ops_admin`
  - payments
  - verification
  - disputes
  - support
  - payouts
  - users
  - read operational health
  - limited settings only if explicitly allowed

## 11. Route Architecture

### 11.1 Route Groups

- `(auth)`
- `(admin)`

### 11.2 Core Routes

- `/[lang]/sign-in`
- `/[lang]/dashboard`
- `/[lang]/payments`
- `/[lang]/payments/[bookingId]`
- `/[lang]/verification`
- `/[lang]/verification/[carrierId]`
- `/[lang]/disputes`
- `/[lang]/disputes/[bookingId]`
- `/[lang]/payouts`
- `/[lang]/payouts/[bookingId]`
- `/[lang]/support`
- `/[lang]/support/[requestId]`
- `/[lang]/users`
- `/[lang]/users/[userId]`
- `/[lang]/admins`
- `/[lang]/admins/invitations`
- `/[lang]/settings`
- `/[lang]/audit-and-health`

## 12. Query And Mutation Design

### 12.1 Query Pattern

Recommended pattern:

- server page fetch for initial route
- client table/filter component for interaction
- stable TanStack Query keys
- narrow invalidation after mutations

### 12.2 Mutation Pattern

Mutations should use:

- action-specific zod schemas
- route or hook-level mutation wrappers
- explicit loading/success/error state
- targeted invalidation

### 12.3 No Duplicate Rule

If an RPC or Edge Function already owns a workflow:

- use it
- do not duplicate its decision logic in route handlers

## 13. Queue System Design

Queues are the core product surface.

Required queue modules:

- payments
- verification
- disputes
- payouts
- support
- users
- admins
- audit and health

Queue behavior:

- filters
- search
- sort
- age visibility
- explicit action readiness
- paginated or windowed loading
- preserved context during refetch

## 14. Detail Workspace Design

Every major detail route should follow the same workspace structure:

1. human-readable header
2. facts summary
3. preview/evidence area
4. timeline/history
5. linked entities
6. action rail
7. audit area

This applies to:

- payment detail
- verification packet detail
- dispute detail
- payout detail
- support detail
- user detail
- admin detail later if needed

## 15. Global Search Design

Global search should be:

- keyboard accessible
- available from every admin page
- mixed-entity
- canonical-route opening

Search targets:

- booking
- shipment
- user
- payment proof
- verification packet
- dispute
- payout
- support request
- admin invitation/admin account where appropriate

## 16. Internationalization Design

Supported locales:

- Arabic
- French
- English

Rules:

- use `app/[lang]/...`
- server-loaded dictionaries
- invalid locale routes return `notFound()`
- Arabic remains fallback
- do not auto-translate human-entered operational notes
- use locale-aware formatting with tabular-readability constraints

## 17. UI Token And Component Architecture

Use a three-layer token model:

1. primitive
2. semantic
3. component

No raw hex or random spacing values in feature code.

Required shared component families:

- shell
- navigation
- queue primitives
- detail primitives
- admin-management primitives
- shared states

## 18. Security Design

### 18.1 Browser Security

- no service-role credentials in browser
- no trusting hidden fields for authority decisions
- secure invite token handling
- no insecure admin bootstrap path left exposed

### 18.2 Backend Security

- deny by default
- explicit privileged workflows
- audit on governance actions
- protect last active `super_admin`
- protect against unauthorized admin-role escalation

### 18.3 Operational Security

- MFA should be required for production admin accounts as soon as implementation path is ready
- admin invite and role changes should be treated as security-sensitive events
- high-risk settings should require elevated confirmation

## 19. Deployment Design

### 19.1 Vercel Model

- `admin-web/` deployed as its own Vercel project
- Preview deployments for review
- Production deployment after scope parity checks

### 19.2 Environment Ownership

- Vercel owns frontend env vars
- Supabase owns backend/project secrets
- browser-safe values use `NEXT_PUBLIC_*`
- privileged secrets stay backend-side

### 19.3 Review Workflow

- Preview deployments are the primary review surface for admin-web UI, but they are a delivery channel rather than a separate FleetFill runtime mode
- queue/detail slices should be validated in Preview before merge

## 20. Observability And Audit

At minimum, the system should support:

- admin audit log viewing
- email/dead-letter visibility
- governance audit events
- operational exception visibility

Later expansion may include:

- admin login/session event reporting
- queue SLA reporting
- internal alerts

## 21. Implementation Sequence

1. admin governance backend
2. admin-web scaffold
3. auth and shell
4. queues
5. detail workspaces
6. admin management and settings
7. localization, accessibility, responsive hardening
8. Preview-based validation and rollout

## 22. Done Definition

The admin web system design is satisfied only when:

- first admin can be bootstrapped safely
- future admins can be invited and managed safely
- the system cannot lose the last active `super_admin`
- all major queues and detail workflows run through privileged backend logic
- the admin web app is the primary operations workspace
- the Flutter admin is no longer required for daily operations
