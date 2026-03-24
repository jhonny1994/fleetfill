# FleetFill Admin Web UI/UX Spec

## 1. Purpose

This document defines the UI and UX specification for the FleetFill admin web console.

Document role inside the admin-web planning ecosystem:

- the PRD defines what must be delivered
- the task list defines how implementation is sequenced
- the master spec ties product, architecture, and design together
- the system design owns backend/governance/auth/deployment architecture
- this document owns page patterns, component behavior, visual direction, and responsive UX rules

It is intended to make the interface buildable without drifting into:

- stale template dashboards
- random module-by-module UI styles
- desktop pages built like stretched mobile screens

## 2. Product Feel

FleetFill admin should feel like:

- a freight operations desk
- a reviewed ledger
- a control room with discipline

It should not feel like:

- a generic startup admin template
- a chart poster
- a pastel SaaS card collection
- a marketing landing page with queue widgets dropped in

## 3. Experience Principles

### 3.1 Queue First

The queue is the product.

Admins should spend most of their time in structured queue surfaces, not wandering through decorative dashboard cards.

### 3.2 Calm, Not Loud

The UI should reduce stress during operational review work.

That means:

- strong hierarchy
- low decorative noise
- clear next actions
- stable layouts

### 3.3 Dense, But Humane

Desktop information density is required, but it must remain readable.

Targets:

- compare rows quickly
- scan status and age easily
- keep details close to action

### 3.4 Context Before Action

Before the UI asks an admin to approve, reject, release, suspend, or resolve, it must show enough context to make the decision responsibly.

## 4. Visual Direction

### 4.1 Art Direction

Style:

- light-first
- flat and structured
- subtle depth
- serious typography
- restrained color

Mood keywords:

- archival
- operational
- exact
- trustworthy

### 4.2 Anti-Patterns

Do not use:

- bento grids for the main admin experience
- multi-color card mosaics
- oversized decorative metrics
- hero sections
- floating dashboard mini-cards everywhere
- excessive rounded toy-like UI
- heavy shadows
- purple-on-white startup defaults

## 5. Layout System

### 5.1 Breakpoints

- mobile: `< 768px`
- tablet: `768px - 1279px`
- desktop: `1280px+`
- wide desktop: `1536px+`

### 5.2 Primary Shell

Desktop shell:

- persistent left sidebar
- top utility bar
- main content panel
- optional right contextual panel later

Tablet shell:

- collapsible sidebar
- same IA
- fewer visible columns

Mobile shell:

- emergency fallback only
- stacked content
- reduced queue density

## 6. Navigation Design

### 6.1 Sidebar

Primary sections:

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

Rules:

- no overloaded nested nav at launch
- active state must be unmistakable
- dangerous actions like sign out should be visually separated

### 6.2 Header

Header contains:

- command search
- alert summary
- current admin identity
- role badge
- account/sign-out menu

### 6.3 Page Titles

Rules:

- titles must be human-readable
- avoid raw UUIDs in headers
- use concise references if needed
- keep headers compact and operational

## 7. Dashboard UX

### 7.1 Purpose

The dashboard is not the main work surface. It is the launchpad.

It must answer:

1. what needs attention now
2. what is aging
3. what is broken
4. where should I go next

### 7.2 Required Sections

- backlog strip
- oldest waiting strip
- exception alerts
- quick links
- search entry

### 7.3 Chart Rules

Allowed:

- one backlog trend
- one aging or throughput trend

Not allowed:

- chart wall
- vanity charts
- charts with no operational decision value

## 8. Queue UX

### 8.1 Queue Page Structure

Every queue page should contain:

1. page header
2. short explanatory subtitle
3. sticky filter/search bar
4. active filters row
5. dense data table or dense list
6. inline loading/empty/error states

### 8.2 Queue Behavior

- preserve filters during refresh
- preserve visible data during background refetch
- sort must be explicit
- searching should feel fast and deterministic
- clicking a row should clearly open the corresponding detail route

### 8.3 Shared Queue Columns

Use the following as the base column language where relevant:

- title/reference
- status
- actor
- linked entity
- created
- updated
- age
- action readiness

### 8.4 Status Visibility

Status must be scannable at 2 speeds:

- quick visual scan
- exact textual interpretation

So each state should combine:

- color
- badge/shape
- label

## 9. Detail Workspace UX

### 9.1 Standard Pattern

Every detail route should follow this sequence:

1. header
2. summary facts
3. preview or evidence section
4. timeline/history
5. linked entities
6. action rail
7. audit segment

### 9.2 Action Rail

Rules:

- one primary action at a time
- dangerous actions separated visually
- reason capture close to action
- loading and confirmation states explicit

### 9.3 Evidence And Files

File previews should:

- load inline where possible
- preserve aspect ratio
- avoid throwing users into unrelated browser views
- show useful metadata without clutter

## 10. Admin Governance UX

### 10.1 Admins Section

Admins should be a first-class section, not hidden inside generic user management.

At minimum:

- admin list
- role display
- active/inactive status
- invite action
- invitation list
- revoke/invalidate flow

### 10.2 Role UX

Exactly two roles:

- `Super Admin`
- `Ops Admin`

Rules:

- role labels should be plain and unambiguous
- role-changing UI should communicate impact before confirming
- `super_admin` actions should feel more guarded, not just visually identical buttons

### 10.3 Bootstrap And Safeguards

The UI must clearly communicate when actions are blocked because:

- the last active `super_admin` cannot be removed
- the current admin cannot perform that governance action
- recent step-up is required

## 11. Typography

Recommended family:

- `IBM Plex Sans` or `Inter`

Rules:

- use tabular numerals for money, counts, ages, and references
- keep page titles compact
- avoid oversized headings
- make metadata smaller, but still legible
- prefer alignment and weight over decorative typographic tricks

## 12. Color System

### 12.1 Base

- background: soft neutral
- surface: white/light neutral
- border: visible neutral
- text: dark neutral

### 12.2 Semantic

- primary: deep blue or blue-teal
- success: muted green
- warning: amber
- danger: red
- neutral/info: slate

### 12.3 Rules

- color is for state and emphasis, not decoration
- large blank areas should stay neutral
- dangerous states should stand out without becoming visually chaotic

## 13. Token System

The UI must use a three-layer token system:

1. primitive
2. semantic
3. component

Required token categories:

- colors
- typography
- spacing
- radius
- borders
- shadows
- motion
- status tokens

No raw hex values or arbitrary spacing values in feature components.

## 14. Components To Spec First

- sidebar
- header
- command search
- metric strip tile
- alert strip
- queue filter bar
- dense table
- status badge
- age/SLA badge
- action rail
- timeline panel
- file preview panel
- dialog
- form field set

Each component should define:

- default state
- hover
- focus
- active
- disabled
- loading where needed
- error where needed
- responsive behavior

## 15. Form UX

### 15.1 Rules

- visible labels always
- helper text for consequential fields
- validate on blur or submit
- focus first invalid field
- keep destructive forms explicit

### 15.2 Sensitive Forms

Important admin forms:

- reject payment proof
- reject verification document
- resolve dispute
- release payout
- invite admin
- change admin role
- deactivate admin
- edit settings

These must:

- make the consequence clear
- show loading state
- keep error state near the action
- use confirmation where needed

## 16. Read-State And Status Language

Use:

- `New` / `Seen`
- `Pending`
- `In review`
- `Approved`
- `Rejected`
- `Open`
- `In progress`
- `Waiting for user`
- `Resolved`
- `Closed`
- `Eligible`
- `Released`
- `Failed`
- `Setup required`

Avoid:

- using `Needs review` for unread
- using `Ready` for seen
- mixing setup state and review state

## 17. Responsive Behavior

### 17.1 Desktop

- full queue density
- wide table support
- two-column detail patterns where useful

### 17.2 Tablet

- reduced columns
- same IA
- collapsible sidebar

### 17.3 Mobile

- essential operations only
- simplified layouts
- reduced columns and stacked summaries

But:

- mobile must not become the primary design target

## 18. Accessibility

- visible focus states
- keyboard navigation across shell and queues
- sortable table semantics
- aria labels for icon-only actions
- dialogs restore focus
- color never the only signal
- accessible mutation feedback

## 19. Motion

- minimal
- 150-250ms
- use motion only for clarity
- no decorative dashboard motion

Allowed:

- panel reveal
- dialog open/close
- route content transition
- mutation feedback

## 20. Empty, Loading, And Error States

Rules:

- loading should preserve context
- empty states should explain why the area is empty
- errors should offer recovery
- queue states should not feel like hard resets

## 21. First Figma / Build Frames

1. shell
2. dashboard
3. payments queue
4. verification packet detail
5. support detail
6. admins management
7. settings

## 22. Definition Of Good UI Here

The admin UI is correct when:

- a reviewer can scan it fast
- a new ops person can learn it without guessing
- the product looks intentional and specific to FleetFill
- dangerous actions feel serious
- nothing feels like pasted dashboard template filler
