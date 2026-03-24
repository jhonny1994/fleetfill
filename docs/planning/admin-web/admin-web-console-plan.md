# FleetFill Admin Web Console Plan

This is a delivery document for the separate internal admin web console.

It expands the canonical product and architecture decisions without replacing them.

Implementation note:

- the complete consolidated specification now lives in `docs/planning/admin-web/admin-web-master-spec.md`
- this file remains the delivery plan and inventory companion to that master spec

## 1. Goal

Build a desktop-first internal admin console that becomes the primary operations surface for FleetFill staff.

It should replace heavy day-to-day ops work in the Flutter admin shell while reusing the existing Supabase backend contracts.

## 2. Locked Stack

- Next.js
- App Router
- TypeScript
- Tailwind CSS
- shadcn/ui
- TanStack Query
- TanStack Table
- Recharts
- Supabase Auth / Postgres / Storage / RPCs / Edge Functions
- Vercel hosting

Non-goals:

- no Windows-native admin app
- no Flutter Web admin as the primary long-term console
- no second bespoke backend for admin workflows

## 2.1 Locked Next.js Conventions

Use current App Router conventions as the default architecture.

Framework rules:

- TypeScript only
- App Router only
- Server Components by default
- Client Components only when interactivity or browser-only APIs require them
- route-level `loading.tsx`, `error.tsx`, and `not-found.tsx` are required for primary admin areas
- nested layouts should own shell composition, not copy-pasted page wrappers

Recommended app shape:

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
    admin-shell/
    dashboard/
    queues/
    detail/
    shared/
  lib/
    supabase/
    auth/
    i18n/
    formatting/
    permissions/
    queries/
  styles/
```

## 2.2 Rendering Rules

- pages and layouts should fetch data on the server first when possible
- interactive filters, tables, dialogs, command search, and rich preview widgets may use Client Components
- do not mark an entire route tree with `"use client"` just because one child needs it
- keep providers as deep as possible in the tree
- use Suspense boundaries for long-running sections instead of blocking the entire route

Admin-specific rendering policy:

- queue pages are operationally dynamic and should be treated as request-time reads
- static caching is acceptable only for low-risk shared metadata such as locale dictionaries, static navigation config, or rarely changing reference content
- do not rely on static generation or aggressive caching for personalized or fast-changing queue data

## 2.3 Auth And Session Model

Use Supabase SSR patterns for Next.js.

Rules:

- use `@supabase/ssr`
- create separate browser and server Supabase clients
- use cookie-based auth handling
- use `proxy.ts` to refresh auth tokens and pass refreshed cookies through the request/response path
- validate protected routes with trusted server-side auth checks, not client-only guards
- never trust browser-hidden routes as authorization

Environment variables:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY`

Optional server-only variables only if later required for specific backend integration work:

- never expose service-role keys to the browser bundle

## 2.4 Internationalization Lock

The admin web console should support the same canonical FleetFill locales:

- Arabic
- French
- English

Locale rules:

- use sub-path routing with `app/[lang]/...`
- detect preferred locale from the request and redirect through `proxy.ts` when no locale segment is present
- use server-loaded dictionaries per locale
- invalid locale routes should return `notFound()`
- Arabic remains the fallback when a requested locale is unsupported, to stay aligned with FleetFill product policy

Admin UX locale policy:

- desktop admin may default to the admin’s saved profile locale when available
- human-entered operational text is not auto-translated
- dates, money, and counts should use locale-aware formatting while preserving tabular readability for dense tables

## 2.5 Responsive And Breakpoint Lock

Admin web is desktop-first but responsive.

Breakpoints:

- mobile: `< 768px`
- tablet: `768px - 1279px`
- desktop: `1280px+`
- wide desktop: `1536px+`

Rules by breakpoint:

- mobile: functional fallback only, stacked sections, reduced columns, essential actions only
- tablet: collapsible sidebar, fewer visible columns, same core IA
- desktop: full sidebar, dense tables, split content where useful
- wide desktop: allow multi-column detail density, but do not create a different IA

Responsive rules:

- no horizontal page overflow
- queue tables should collapse columns intentionally instead of shrinking text into unreadability
- sticky headers/filters should remain usable at all supported widths
- mobile should not become the primary design target for admin pages

## 2.6 Data Fetching And State Lock

Use TanStack Query for client-driven freshness and interaction-heavy surfaces.

Rules:

- server-render the initial route data when practical
- hydrate client state where interactive queue behavior needs it
- use TanStack Query for refetch, invalidation, optimistic freshness, and mutation status
- keep query keys explicit and stable
- invalidate narrowly after mutations
- do not maintain duplicate client-side state copies of server data unless needed for UX

Preferred pattern:

- server page fetch for initial payload
- client queue/table component for interaction
- mutation hooks that invalidate the smallest relevant query surface

## 2.7 Error, Loading, And Empty State Lock

Use built-in App Router state files and shared components together.

Rules:

- each major route group should have a meaningful `loading.tsx`
- each major route group should have an `error.tsx`
- missing entities should use `notFound()` and `not-found.tsx`
- global catastrophic failure should be handled by `global-error.tsx`
- expected validation and workflow errors should be returned explicitly to the UI, not thrown as uncaught exceptions when avoidable

Queue-state rules:

- preserve filter context during refetch
- show inline reload states instead of blanking the whole table
- empty states must explain what the queue represents and why it may be empty

## 2.8 Forms And Mutations Lock

Rules:

- use `react-hook-form` + `zod`
- validate on blur or submit, not on every keystroke
- disable actions during async mutation
- show inline reason/error states close to the action
- destructive actions require confirmation
- dangerous mutations must capture reason text where the workflow requires it

Use cases:

- reject payment proof
- reject verification document
- resolve dispute
- release payout
- suspend user
- edit platform settings

## 2.9 Navigation And Search Lock

Rules:

- use one persistent sidebar on desktop
- use breadcrumbs only where hierarchy is genuinely deeper than the sidebar location
- active navigation state must always be visually obvious
- keep global search accessible from every admin page
- search results should open canonical detail pages, not transient overlays only

Global search behavior:

- keyboard accessible
- searchable by ID or human terms
- returns mixed entity results grouped by type
- recent searches may be added later, but are not required for v1

## 2.10 Performance Lock

Rules:

- keep client bundles small by limiting `"use client"`
- use route-level streaming and Suspense
- virtualize very long tables only when profiling justifies it
- do not load heavy charts or large preview code on routes that do not need them
- prefer lazy loading for secondary panels and document viewers

Operational performance rules:

- queue pages must stay responsive during filter/search changes
- route transitions should remain interruptible
- shared shell must stay interactive while new route content loads

## 2.11 Accessibility Lock

Rules:

- keyboard navigation across sidebar, filters, tables, dialogs, and action rails
- visible focus states
- accessible table semantics and sort state
- `aria-live` for mutation feedback where appropriate
- dialogs return focus correctly
- color is never the only state signal
- icon-only actions require accessible labels

## 2.12 Vercel Deployment Lock

Rules:

- deploy `admin-web/` as its own Vercel project
- use Preview deployments for branch testing and internal review
- set environment variables separately for Production, Preview, and Development
- remember that changed environment variables require a new deployment to take effect
- use a dedicated admin domain in production later

Environment ownership:

- Vercel owns admin-web frontend environment variables
- Supabase owns backend/project secrets
- browser-safe values use `NEXT_PUBLIC_*`
- sensitive service credentials stay server-side only and should remain minimal in the admin web project

## 3. Product Shape

The admin console should be:

- queue-first
- exception-first
- desktop-first
- auditable
- low-noise
- action-oriented

It should not be:

- chart-heavy for the sake of looking like a dashboard
- a clone of the customer mobile app
- a second source of business logic

## 4. Feature Inventory

### 4.1 Dashboard / Control Tower

Purpose:

- show what needs action now
- show backlog risk and exceptions
- route admins into the right queue quickly

Widgets:

- pending payment proofs
- pending verification packets
- open disputes
- payouts eligible for release
- support tickets needing reply
- failed email/dead-letter counts
- oldest waiting item age by queue
- exception alerts
- quick links
- universal search entry

### 4.2 Payments Queue

Purpose:

- review payment proofs safely

Core capabilities:

- queue list
- booking context
- proof preview
- approve / reject with reason
- payment status history
- audit visibility

### 4.3 Verification Queue

Purpose:

- review carrier verification packets

Core capabilities:

- packet queue
- grouped packet detail
- document previews
- approve document
- reject document with reason
- approve all packet
- missing-document visibility
- verification history

### 4.4 Disputes Queue

Purpose:

- resolve booking disputes with full context

Core capabilities:

- dispute queue
- evidence preview
- booking/timeline/payment context
- decision actions
- decision notes
- audit visibility

### 4.5 Payouts Queue

Purpose:

- release carrier payouts safely

Core capabilities:

- eligible payouts queue
- booking/payout detail
- payout account context
- release action
- released history
- audit visibility

### 4.6 Support Queue

Purpose:

- operate support like a real ticketing workflow

Core capabilities:

- inbox/queue
- ticket statuses
- thread view
- reply
- status change
- linked booking/payment/dispute context
- aging and assignee later

### 4.7 Users

Purpose:

- investigate users and perform account actions

Core capabilities:

- search users
- profile detail
- suspend/reactivate
- verification overview
- vehicle overview
- bookings/support/dispute context

### 4.8 Settings

Purpose:

- operate runtime behavior without app releases

Core capabilities:

- maintenance mode
- minimum app versions
- locale enablement
- operational flags
- pricing/runtime settings
- email resend controls and related operational toggles

### 4.9 Audit And System Health

Purpose:

- observe admin actions and delivery failures

Core capabilities:

- admin audit log
- email logs
- dead-letter queue
- resend actions
- automation/exception visibility

### 4.10 Universal Search

Purpose:

- jump directly to entities without hunting through queues

Targets:

- booking
- shipment
- user
- payment proof
- verification packet
- dispute
- payout
- support request

## 5. Information Architecture

Sidebar:

1. Dashboard
2. Payments
3. Verification
4. Disputes
5. Payouts
6. Support
7. Users
8. Settings
9. Audit & Health

Global header:

- search
- current admin identity
- quick alerts
- sign out

## 5.1 Locked UI Direction

The admin web console should feel like a calm operations workspace.

Chosen style direction:

- light-first
- flat and structured, not glossy
- high information density without visual clutter
- neutral base surfaces with semantic color accents
- strong typography hierarchy and tabular data treatment

Do not use:

- bento-card marketing layouts
- decorative hero sections
- oversized charts at the top of the dashboard
- long mobile-style card stacks as the primary desktop queue pattern
- raw UUIDs in page titles

## 5.2 Visual System

### Color roles

- background: soft neutral, close to off-white
- surface: white or very light neutral
- primary interactive accent: deep blue or blue-teal
- success: muted green
- warning: amber
- danger: red
- info/neutral badges: slate/gray

Rules:

- semantic colors should indicate state, not decorate empty space
- queue pages should remain mostly neutral so risky states stand out immediately
- color must never be the only signal; pair with text/icon/badge label

### Typography

Use a sober desktop pair that reads well in dense tables.

Recommended direction:

- headings/navigation: `Inter` or `IBM Plex Sans`
- data-heavy rows and money/age columns: tabular figures enabled

Rules:

- page title: clear and compact, not oversized
- section titles: medium weight
- table text: regular weight, high contrast
- labels and metadata: smaller but still readable
- use tabular numbers for dates, money, aging, counts, and references

### Spacing and radius

- spacing scale: 4 / 8 / 12 / 16 / 24 / 32
- card radius: subtle, around 10-12px
- table rows: compact but comfortable
- action buttons: clear hierarchy, not oversized

### Shadows and borders

- prefer borders and subtle elevation over heavy shadows
- use one consistent elevation style for dropdowns, dialogs, and sticky filters

## 5.3 Layout Model

### Desktop

Preferred desktop shell:

- left sidebar navigation
- top utility bar
- main content area
- optional right detail or inspector panel on queue pages later

Recommended width behavior:

- full-width app shell
- constrained content rhythm inside each page
- queue pages may use wider layouts than settings pages

### Tablet

- collapsible sidebar
- same IA as desktop
- fewer visible columns in tables

### Mobile fallback

- responsive and functional for emergency use only
- no attempt to make phone the primary admin workspace

## 5.4 Dashboard UI Lock

The dashboard is a control tower, not a KPI poster.

Above the fold should contain:

1. queue backlog strip
2. oldest waiting / needs attention strip
3. exception alerts
4. universal search
5. quick links into queues

Allowed charts:

- one backlog trend
- one throughput or aging trend

Not allowed in v1:

- many decorative charts
- vanity metrics without actionability
- large hero blocks

## 5.5 Queue UI Lock

Queues are the primary interface.

Required structure:

- page title and explanation
- sticky filter/search bar
- active filter chips
- dense table/list
- row selection or row open behavior
- clear empty/loading/error states

Preferred columns by default:

- item title/reference
- status
- age / created / updated
- linked actor
- linked entity
- assignee when added
- action readiness

Queue behavior rules:

- sorting must be visible and predictable
- filters must not fully reset context on refresh
- pull-to-refresh is not the primary web pattern; use refresh controls and background refetch
- the current row should remain visible when detail opens

## 5.6 Detail Workspace Lock

Every high-value entity detail should use the same page pattern:

1. header with human-readable title
2. summary facts block
3. file/evidence preview block when relevant
4. timeline/history block
5. linked entities block
6. action rail
7. audit block

Action rail rules:

- only one primary action at a time
- dangerous actions grouped separately
- confirm high-risk mutations
- keep decision reasons close to the action

## 5.7 Component Set

Must-have shared components:

- app shell
- sidebar nav
- top utility bar
- command/global search
- dashboard metric tile
- alert strip
- queue filter bar
- active filter chip row
- dense data table
- status badge
- SLA/age badge
- entity summary card
- action rail card
- timeline list
- file preview panel
- audit log table
- empty state
- inline error state
- confirmation dialog
- right-side sheet/panel for secondary detail later

## 5.8 Status Language Lock

Use consistent product language:

- `New` / `Seen` for read state
- `Pending` / `In review` / `Approved` / `Rejected` for review workflows
- `Open` / `In progress` / `Waiting for user` / `Resolved` / `Closed` for support
- `Eligible` / `Released` / `Failed` for payouts where applicable

Avoid:

- using `Needs review` to mean unread
- using `Ready` to mean read
- mixing setup state with review state

## 5.9 Accessibility And Interaction Lock

- visible keyboard focus on every interactive element
- 44px minimum interactive targets where practical
- no hover-only affordances for critical actions
- row actions must also be keyboard reachable
- dialogs must return focus correctly on close
- tables must have accessible labels and sortable semantics
- color is never the only state signal

## 5.10 Motion Lock

- minimal motion
- 150-250ms transitions
- use motion only for clarity: panel open, dialog open, state refresh
- no decorative dashboard animation

## 5.11 V1 Design Constraints

To keep the admin product real and shippable:

- prefer 10 solid shared components over 40 custom one-offs
- prefer one excellent queue pattern reused everywhere
- prefer one excellent detail pattern reused everywhere
- do not invent queue-specific design languages for each module
- reuse the same status badge system across payments, verification, disputes, payouts, and support

## 5.12 Suggested First Figma/Implementation Frames

1. Desktop app shell
2. Dashboard
3. Payments queue
4. Verification packet detail
5. Support thread detail
6. User detail
7. Settings

## 6. Page Patterns

### Queue pages

Use:

- filters
- search
- sort
- status chips
- age column
- action readiness
- row click to detail

Preferred layout:

- desktop table or dense list
- optional right-side preview panel later

### Detail pages

Use:

- fact summary
- file preview
- timeline/history
- linked entities
- action panel
- audit segment

## 7. State And Data Rules

- admin web must reuse existing Supabase workflows
- do not duplicate booking, payment, verification, support, payout, or dispute business rules in web-only code
- all sensitive actions should remain server-controlled
- use TanStack Query for cache, refetch, invalidation, and optimistic freshness behavior
- use paginated or windowed loading for queues

## 8. Security Rules

- never expose service-role credentials in the browser
- use authenticated admin sessions through Supabase Auth
- enforce admin rights in the backend, not just hidden buttons in the UI
- require recent sign-in or step-up for sensitive actions where already supported by backend policy

## 9. What Reuses Existing FleetFill Work

Reuse directly:

- database schema
- RLS policies
- storage model
- signed URL helpers
- payment review RPCs
- verification review RPCs
- dispute workflows
- payout release workflows
- support ticket/message workflows
- settings contracts
- audit and email operations

Do not reuse directly:

- Flutter widget code
- mobile navigation structure
- card-first queue composition

## 10. Rollout Plan

### Phase A

- scaffold `admin-web/`
- configure auth
- build shared layout
- build dashboard
- build payments queue
- build verification queue

### Phase B

- build disputes
- build payouts
- build support
- build users

### Phase C

- build settings
- build audit and health
- add universal search
- add denser desktop refinements

### Phase D

- keep Flutter admin as fallback only
- move daily admin operations to web
- reduce future investment in mobile-admin-heavy UX

## 11. Production Readiness Checklist

- admin auth and role guard verified
- no service-role exposure in web bundle
- queue pagination works
- all sensitive actions auditable
- desktop layouts tested at common breakpoints
- empty/loading/error states polished
- Vercel preview deployments enabled
- production environment variables documented
- parity confirmed for critical admin workflows before de-emphasizing Flutter admin
