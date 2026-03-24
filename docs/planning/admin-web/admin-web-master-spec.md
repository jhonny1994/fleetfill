# FleetFill Admin Web Master Spec

This is the implementation-grade master spec for the FleetFill admin web console.

It consolidates the current product decision, architecture direction, UI lock, and delivery plan into one working source so implementation can start without re-deciding fundamentals on the fly.

This file does not replace canonical product truth. It gathers the admin-specific decisions already locked across the canonical docs and turns them into a complete build specification.

Document role inside the admin planning ecosystem:

- the PRD defines the required product scope
- the tasks file defines implementation sequencing
- the system design defines governance, data, auth, and deployment shape
- the UI/UX spec defines interface behavior and visual rules
- this master spec ties those decisions together into one implementation-grade source

## 1. Product Intent

FleetFill admin is not a public-facing dashboard and not a generic SaaS analytics shell.

It is a private operations console for FleetFill staff to:

- review trust-sensitive workflows
- clear operational queues
- resolve exceptions
- manage users and runtime settings
- maintain auditability

The admin product should feel like a transport operations desk:

- serious
- calm
- dense where needed
- decisive
- traceable

It must not feel like:

- a template dashboard
- a glossy BI toy
- a stretched mobile app
- a wall of random cards and charts

## 2. Locked Product Decision

### 2.1 Platform

Primary admin surface:

- separate internal web console

Not chosen:

- Windows-native Flutter admin app
- Flutter Web as the main admin platform
- expanding the mobile admin into the long-term main operations surface

### 2.2 Repo and Backend Relationship

Repository shape:

```text
fleetfill/
  lib/                  # Flutter app
  supabase/             # shared backend
  docs/
  admin-web/            # Next.js admin app
```

Backend relationship:

- the admin web console uses the same Supabase project as the Flutter app
- the admin web console reuses the same schema, storage, RPCs, and Edge Functions
- business rules remain in Supabase
- the admin web app is a UI and orchestration client, not a second backend

### 2.3 Transitional Rule

The existing Flutter admin surface remains available as a transitional fallback for urgent internal actions until the admin web console reaches parity on critical queues.

It should not continue expanding as the long-term primary admin product.

## 3. Locked Stack

### 3.1 Frontend

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

### 3.2 Backend

- Supabase Auth
- Postgres
- RLS
- Storage
- RPCs
- Edge Functions

### 3.3 Hosting

- Vercel for `admin-web/`
- Supabase remains backend host

### 3.4 Explicit Non-Goals

- no Redux by default
- no custom Node backend for admin workflows
- no Electron / desktop packaging
- no analytics warehouse / BI stack for v1
- no graph-heavy dashboard layer for launch

## 4. Design Positioning

### 4.1 Experience Goals

The admin should optimize for:

- scan speed
- decision confidence
- low ambiguity
- context retention
- auditability
- operational calm

### 4.2 Visual Direction

Style:

- light-first
- sharp and restrained
- neutral surfaces
- semantic accents
- dense but not cramped
- minimal ornamental motion

Mood keywords:

- dispatch desk
- review console
- control room
- operations notebook

Avoid:

- glassmorphism
- oversized hero cards
- dashboard bento mosaics
- neon gradients
- “startup metrics” theater
- random iconography

### 4.3 Typography Direction

Recommended pair:

- headings and nav: `IBM Plex Sans` or `Inter`
- body and dense UI: same family for consistency
- tabular figures enabled for money, counts, ages, references, and dates

Typography behavior:

- page titles should be compact and strong
- section titles should not dominate the screen
- metadata should be readable, not tiny
- tables should favor clarity over visual minimalism

### 4.4 Color Direction

Base:

- background: warm-neutral or cool-neutral off-white
- surface: white / soft neutral
- border: visible but subtle neutral
- text: high-contrast dark neutral

Semantic roles:

- primary: deep blue or blue-teal
- success: muted green
- warning: amber
- danger: red
- info/neutral: slate

Rules:

- color indicates state, not decoration
- queue surfaces should remain mostly neutral
- risky states must stand out immediately
- color is never the only signal

### 4.5 Token System Lock

The admin web must use a three-layer token system:

1. primitive tokens
2. semantic tokens
3. component tokens

Token rules:

- no raw hex values inside feature components
- no hardcoded spacing values inside queue/detail feature code unless already mapped to tokens
- typography, spacing, radius, border, shadow, and motion must all resolve through shared tokens
- Tailwind configuration should map to the token system rather than drifting into one-off utility values

Minimum token groups required before broad feature implementation:

- color primitives
- semantic color roles
- spacing scale
- typography scale
- radius scale
- border colors
- shadow levels
- motion durations/easings
- status color tokens

## 4.6 Visual Thesis

Visual thesis:

- FleetFill admin should feel like a freight operations ledger brought into a modern browser workspace: clean, serious, sharp, and quietly authoritative.

Content thesis:

- every page should orient first, clarify second, and only then expose action.

Interaction thesis:

- motion should only support clarity, such as panel appearance, route transitions, and mutation feedback; no ornamental animation should compete with operational scanning.

## 5. UX Principles

### 5.1 Queue First

The dashboard is secondary.

The queues are the real product.

Admins should spend most of their time in:

- payments
- verification
- disputes
- payouts
- support
- users

### 5.2 Exception First

The system should surface:

- what is blocked
- what is aging
- what is risky
- what is overdue
- what failed to deliver

Not just how many things exist.

### 5.3 Human Titles, Not Raw IDs

Do not put raw UUIDs in top headers or app-level page titles.

Use:

- human-readable names
- compact references
- lane summaries
- business labels

Raw IDs can remain in:

- metadata rows
- audit panels
- copyable technical references

### 5.4 Shared Patterns Over One-Off Screens

We should not design each module as a different mini-product.

V1 should use:

- one queue pattern
- one detail workspace pattern
- one filter bar pattern
- one badge system
- one action rail pattern

## 6. Information Architecture

### 6.1 Primary Sidebar

1. Dashboard
2. Payments
3. Verification
4. Disputes
5. Payouts
6. Support
7. Users
8. Admins
9. Settings
10. Audit & Health

### 6.2 Global Header

- command/global search
- alerts summary
- admin identity menu
- sign out

### 6.3 Navigation Rules

- sidebar is persistent on desktop
- collapsible on tablet
- mobile is emergency fallback only
- active location is always visible
- deep links should land on canonical pages

## 7. Page Inventory

### 7.1 Dashboard

Purpose:

- orient the admin quickly
- show where to go next

Must contain:

- queue backlog strip
- oldest waiting / aging strip
- exception alerts
- quick links
- universal search entry

Allowed charts:

- one backlog trend
- one throughput/aging trend

Not allowed:

- chart walls
- vanity metrics without action
- giant hero blocks

### 7.2 Payments

Queue page:

- proof status
- booking reference
- shipper
- carrier
- amount
- created age
- review action

Detail page:

- booking summary
- proof preview
- payment metadata
- history/timeline
- approve/reject action rail
- audit log

### 7.3 Verification

Queue page:

- carrier
- verification state
- missing docs
- packet age
- newest upload age
- open packet

Packet detail:

- driver section
- vehicle section
- document previews
- missing-document summary
- approve document
- reject document with reason
- approve full packet
- audit trail

### 7.4 Disputes

Queue page:

- dispute reason
- booking reference
- parties
- age
- current status
- open detail

Detail page:

- booking summary
- payment context
- shipment/tracking context
- evidence preview
- decision panel
- audit trail

### 7.5 Payouts

Queue page:

- eligible payout amount
- carrier
- booking reference
- readiness
- age

Detail page:

- booking commercial summary
- payout account context
- release panel
- payout history
- audit trail

### 7.6 Support

Queue page:

- subject
- requester
- status
- linked context
- unread/new state
- last reply age

Detail page:

- ticket header
- linked entity context
- thread timeline
- reply composer
- status controls
- audit/assignment area later

### 7.7 Users

List page:

- search
- role
- status
- verification summary
- recent activity hints

Detail page:

- profile
- role/status
- verification overview
- vehicles
- bookings
- disputes/support context
- suspend/reactivate action

### 7.8 Settings

Sections:

- runtime
- maintenance
- minimum versions
- locale enablement
- ops flags
- pricing/runtime controls
- delivery controls

### 7.9 Audit & Health

Sections:

- admin audit log
- email logs
- dead-letter queue
- resend controls
- automation exception visibility

### 7.10 Admins

List page:

- active admins
- pending and historical invitations
- role visibility
- active/inactive status
- invite action

Detail and management actions:

- create invite
- revoke invite
- change admin role
- activate/deactivate admin
- show governance safeguards and blocked actions explicitly

## 8. Layout System

### 8.1 Breakpoints

- mobile: `< 768px`
- tablet: `768px - 1279px`
- desktop: `1280px+`
- wide desktop: `1536px+`

### 8.2 Desktop Shell

- left sidebar
- top utility bar
- content frame
- optional right-side detail/inspector panel later

### 8.3 Layout Rules

- full viewport shell
- no horizontal overflow
- queues can use wider content widths than settings/detail pages
- sticky headers and filter bars allowed
- keep page titles and primary actions near the top edge

### 8.4 Mobile Rule

Mobile support exists for emergency access only.

We do not optimize the core admin UI around phone-first card stacks.

## 9. Queue Pattern Lock

Every queue page should use the same backbone:

1. page header
2. short page description
3. sticky filter/search bar
4. active filters row
5. dense table/list
6. pagination / incremental loading
7. inline empty/loading/error handling

### 9.1 Queue Columns

Preferred reusable columns:

- title/reference
- state
- actor
- linked entity
- created
- updated
- age
- action readiness

### 9.2 Queue Behavior

- sorting must be visible
- filter state must persist during refresh
- background refetch preferred over page blanking
- row open behavior must be predictable
- bulk actions only where operationally safe

## 10. Detail Workspace Lock

Every important detail page should follow this structure:

1. header with human title
2. summary facts
3. preview/evidence area when relevant
4. timeline/history
5. linked entities
6. action rail
7. audit block

### 10.1 Action Rail Rules

- one primary action at a time
- dangerous actions separated visually
- confirmations for high-risk actions
- reason capture close to the action
- button copy must be operationally explicit

## 11. Component System Lock

Must-have shared components:

- admin shell
- sidebar nav
- top utility bar
- command search
- dashboard metric tile
- alert rail
- queue filter bar
- active filter chips
- dense data table
- status badge
- age badge
- entity summary card
- action rail card
- timeline list
- file preview panel
- audit table
- inline empty state
- inline error state
- confirmation dialog

### 11.1 Component Rules

- prefer fewer stronger primitives
- no queue-specific badge systems
- no page-specific card inventions unless truly necessary
- one table pattern reused across modules

### 11.2 Required Component Specs

These components must have explicit specs before broad implementation:

- sidebar navigation
- top utility header
- command search
- dashboard metric tile
- exception alert strip
- queue filter bar
- dense data table
- status badge
- SLA/age badge
- action rail
- file preview panel
- timeline panel
- confirmation dialog
- form field primitives

Each spec should define:

- default state
- hover state
- focus state
- active state
- disabled state where relevant
- loading state where relevant
- error state where relevant
- keyboard interaction behavior
- responsive behavior

## 12. Status Language Lock

Use:

- `New` / `Seen` for read state
- `Pending` / `In review` / `Approved` / `Rejected` for review workflows
- `Open` / `In progress` / `Waiting for user` / `Resolved` / `Closed` for support
- `Eligible` / `Released` / `Failed` where applicable for payouts
- `Setup required` for missing setup state

Avoid:

- `Needs review` to mean unread
- `Ready` to mean seen
- mixing setup state with review state

## 13. Next.js Application Lock

### 13.1 App Router

Use:

- App Router only
- `layout.tsx`
- `loading.tsx`
- `error.tsx`
- `not-found.tsx`
- `global-error.tsx`

### 13.2 Rendering

- Server Components by default
- Client Components only for interaction-heavy parts
- narrow `"use client"` boundaries
- route-level loading and error handling
- queue pages treated as dynamic operational pages

### 13.3 Suggested Folder Shape

```text
admin-web/
  app/
    [lang]/
      (auth)/
      (admin)/
        dashboard/
        payments/
        verification/
        disputes/
        payouts/
        support/
        users/
        settings/
        audit-and-health/
      layout.tsx
      not-found.tsx
    global-error.tsx
    proxy.ts
  components/
  lib/
  styles/
```

## 14. Auth and Security Lock

- use `@supabase/ssr`
- separate browser and server Supabase clients
- cookie-based session handling
- `proxy.ts` for auth token refresh and locale routing
- never expose service-role keys to the browser
- frontend guards are convenience only; backend authorization remains authoritative

Sensitive actions must continue to use:

- RPCs
- Edge Functions
- existing audit logging

### 14.1 Secure-by-Default Rules

Admin-web implementation must follow these security defaults:

- all admin-only routes must be verified server-side before render
- all super-admin-only routes must be verified server-side before render
- the browser must never decide authorization by UI visibility alone
- all sensitive mutations must be denied by default unless the backend explicitly authorizes them
- mutation forms must not trust hidden fields for actor, role, or target authority
- invitation tokens must be single-use, expiring, and non-enumerable
- first-admin bootstrap must be one-time or tightly controlled and must not remain publicly reusable
- audit writes must happen in the same privileged workflow as the protected action wherever possible
- any admin-management action must protect against loss of the last active `super_admin`

### 14.2 Session And Account Security

- production admin accounts should require MFA as soon as the implementation path is available
- session refresh should be handled centrally through SSR/cookie flow
- the admin UI should expose clear session-expired recovery paths
- recent step-up requirements for sensitive actions should be reflected in the web UX, not only as backend errors
- admin sign-in, invite acceptance, and privilege changes should all be represented in audit trails

## 15. Internationalization Lock

Supported locales:

- Arabic
- French
- English

Rules:

- use `app/[lang]/...`
- server-loaded dictionaries
- invalid locale routes return not found
- Arabic remains fallback for unsupported locales
- locale-aware formatting for dates, money, and counts
- keep tabular readability for operational tables

## 16. Responsive Lock

Desktop-first rules:

- desktop is the primary design target
- tablet keeps the same IA with reduced columns
- mobile remains a graceful fallback

Table behavior:

- collapse columns intentionally
- never shrink into unreadable text
- preserve key actions at all supported widths

Desktop layout behavior:

- queue pages should prefer table + detail navigation patterns
- detail pages may use two-column layouts on desktop where context density benefits from it
- tablet may collapse the sidebar and reduce table columns, but should not invent a separate IA
- mobile should preserve critical access, but not force full queue density

## 17. Data and State Lock

- use TanStack Query for interactive data freshness
- explicit stable query keys
- narrow invalidation after mutations
- no duplicate business logic in client state
- preserve filter context during refetch
- avoid global loading resets

## 18. Form and Mutation Lock

- `react-hook-form` + `zod`
- visible labels
- validate on blur or submit
- disable during mutation
- inline error feedback
- confirmation for destructive/high-risk actions
- reason capture where workflows require it

## 19. Accessibility Lock

- visible focus states
- keyboard navigation across shell, queues, dialogs, and detail workspaces
- accessible table semantics and sort states
- icon-only actions require labels
- dialogs restore focus correctly
- color is never the only signal

## 20. Motion Lock

- minimal motion
- 150-250ms transitions
- motion only for clarity
- no decorative analytics animation

## 21. Vercel Lock

- deploy `admin-web/` as its own Vercel project
- Preview deployments for branch testing
- separate Development / Preview / Production environment variables
- `NEXT_PUBLIC_*` only for browser-safe values
- changed environment variables require a new deployment to take effect

Deployment workflow:

- every meaningful admin-web branch should have a Preview deployment available for review
- preview environments should be considered the primary UI review surface before merging
- production deployment should happen only after parity checks against the locked v1 scope
- deployment instructions must not tell implementers to curl/fetch the deployment as the source of truth; the deployment URL itself is the review surface

Environment ownership:

- Vercel owns web runtime variables
- Supabase owns backend secrets and privileged credentials
- if a variable is browser-visible, it must use the `NEXT_PUBLIC_` prefix and be safe to expose
- service-role credentials must never be placed in Vercel browser-exposed env vars

## 22. V1 Scope

Build first:

1. shell
2. dashboard
3. payments
4. verification
5. disputes
6. payouts
7. support
8. users
9. admins
10. settings
11. audit & health

## 23. Not In V1

- BI-heavy analytics suite
- custom report builder
- elaborate saved views system
- advanced assignment rules engine
- giant map/dispatch board
- desktop app packaging

## 24. First Design/Build Frames

1. app shell
2. dashboard
3. payments queue
4. verification packet detail
5. support detail
6. user detail
7. settings

## 25. Build Readiness Checklist

We are ready to start implementation only if we keep these locked:

- separate admin web app
- same Supabase backend
- queue-first UX
- light, serious, non-generic visual system
- table-first desktop operations patterns
- shared patterns over one-offs
- App Router conventions
- Supabase SSR auth
- Vercel deployment model

If any of these drift during implementation, the product will slide back toward a stale generic dashboard.
