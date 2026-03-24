# PRD: FleetFill Admin Web Console

## 1. Introduction / Overview

FleetFill needs a dedicated internal admin web console that becomes the primary operations surface for FleetFill staff.

The current Flutter admin is useful as a temporary internal tool, but it is not sufficient as the long-term operational workspace. Admin work in FleetFill is desktop-shaped: payment proof review, carrier verification, disputes, support, payout release, user controls, runtime settings, delivery health, and auditability all require denser layouts, stronger queue workflows, and clearer operational context than a mobile-first admin surface can provide.

This feature creates a production-ready internal admin web console with full FleetFill admin functionality, including admin identity and governance. The web console must not be limited by what is already complete in the Flutter admin. If backend or schema support is missing, this feature includes defining and implementing the missing admin capabilities needed to make the admin product fully operational.

Key decisions already locked:

- Primary admin surface: separate internal web console
- Flutter admin: lightweight companion for emergency/mobile use, not the main admin workspace
- Admin roles: exactly two roles
  - `super_admin`
  - `ops_admin`
- No public admin signup
- The product must support a safe first-admin bootstrap path
- `super_admin` must be able to invite and manage other admins

## 2. Goals

1. Build a production-ready internal web admin console for FleetFill staff.
2. Provide full operational admin coverage for FleetFill, not only parity with the currently exposed Flutter admin UI.
3. Make the admin web console the primary day-to-day operational workspace.
4. Introduce a complete admin identity and governance model, including:
   - first-admin bootstrap
   - admin invitations
   - admin lifecycle management
   - role-based admin permissions
5. Preserve Supabase as the single source of business truth and workflow enforcement.
6. Keep all sensitive admin actions auditable and server-controlled.
7. Deliver an admin UI that feels serious, operational, and intentionally designed rather than generic or template-based.

## 3. User Stories

- As a FleetFill admin, I want to open one internal web console and immediately see what needs attention so I can start operations work quickly.
- As a payment reviewer, I want to review proof, booking context, and decision actions in one workspace so I can approve or reject safely.
- As a verification reviewer, I want to see a carrier’s full verification packet in one place so I can make consistent decisions.
- As a dispute operator, I want booking, payment, timeline, and evidence context together so I can resolve disputes confidently.
- As a support operator, I want a real queue and full thread context so I can reply without switching tools.
- As a payout operator, I want to see payout readiness, booking context, and payout account details before releasing funds.
- As a super admin, I want to invite new admins, manage admin roles, and deactivate admins safely.
- As a super admin, I want safeguards that prevent FleetFill from losing administrative control of the platform.
- As an admin on mobile, I want the existing Flutter admin to remain available for urgent light-touch actions when I am away from a desktop.

## 4. Functional Requirements

### 4.1 Platform And Access

1. The system must provide a separate internal web application for FleetFill admin operations.
2. The system must use the existing Supabase project as the backend for the admin web console.
3. The system must enforce admin-only access through authenticated sessions and backend authorization.
4. The system must not expose service-role credentials in the browser.
5. The system must support Arabic, French, and English in the admin web console, with Arabic fallback when required by FleetFill locale policy.
6. The system must support desktop-first responsive behavior, while remaining functional on tablet and usable in limited form on mobile.

### 4.2 Admin Identity, Bootstrap, And Governance

7. The system must support exactly two admin roles:
   - `super_admin`
   - `ops_admin`
8. The system must not allow public admin signup through the normal authentication flow.
9. The system must provide a safe first-admin bootstrap mechanism for the initial `super_admin` account.
10. The first-admin bootstrap mechanism must be controlled and non-public.
11. The system must allow a `super_admin` to invite additional admins.
12. The system must support invitation states including at minimum:
   - pending
   - accepted
   - expired
   - revoked
13. The system must allow a `super_admin` to assign either `super_admin` or `ops_admin` role during invitation or management flows.
14. The system must allow a `super_admin` to deactivate or reactivate other admins.
15. The system must prevent unsafe platform lockout scenarios, including removal or deactivation of the last active `super_admin`.
16. The system must prevent an admin from performing self-destructive actions that would orphan platform administration.
17. The system must audit invitation, acceptance, revocation, activation, deactivation, and role-change events.

### 4.3 Admin Shell And Navigation

18. The system must provide a persistent desktop sidebar for primary admin navigation.
19. The system must provide a global header containing search access, admin identity controls, and alert visibility.
20. The system must support canonical deep links to major admin pages and detail views.
21. The system must visually indicate the active admin location at all times.
22. The system must avoid raw UUIDs as page-level titles when a human-readable title or compact reference is available.

### 4.4 Dashboard / Control Tower

23. The system must provide a dashboard that shows queue backlog counts for key admin workflows.
24. The dashboard must show oldest waiting or aging indicators for major queues.
25. The dashboard must show exception or failure alerts that require operational attention.
26. The dashboard must provide quick links into the main queues.
27. The dashboard must provide access to global search.
28. The dashboard must not rely on chart-heavy or decorative analytics as the primary interface.

### 4.5 Payments Queue

29. The system must provide a payments queue for reviewing submitted payment proofs.
30. Each payments queue row must show booking context, proof status, amount, and aging information.
31. The system must provide a payment detail workspace that includes booking summary, proof preview, payment metadata, decision actions, and audit history.
32. The system must allow admins to approve payment proofs through the existing or extended server-controlled workflow.
33. The system must allow admins to reject payment proofs with a reason through the existing or extended server-controlled workflow.

### 4.6 Verification Queue

34. The system must provide a verification queue for carrier verification packets.
35. Each verification queue row must show carrier identity, packet status, missing documents summary, and aging information.
36. The system must provide a verification packet workspace that groups driver and vehicle documents together.
37. The verification packet workspace must show document previews and current document states.
38. The system must allow document-level approve actions through the existing or extended server-controlled workflow.
39. The system must allow document-level reject actions with a reason through the existing or extended server-controlled workflow.
40. The system must allow full packet approval through the existing or extended server-controlled workflow.
41. The system must show missing required documents when a packet is incomplete.

### 4.7 Disputes Queue

42. The system must provide a disputes queue.
43. Each disputes queue row must show dispute reason, linked booking, current state, and aging information.
44. The system must provide a dispute detail workspace containing booking context, payment context, evidence preview, tracking/timeline context, and decision actions.
45. The system must allow admins to resolve disputes through the existing or extended server-controlled workflow.
46. The system must preserve auditability for all dispute decisions.

### 4.8 Payouts Queue

47. The system must provide a payouts queue for eligible payouts and payout history visibility.
48. Each payouts queue row must show booking reference, carrier, payout amount, and readiness/age information.
49. The system must provide a payout detail workspace with booking commercial context, payout account context, payout action controls, and audit history.
50. The system must allow payout release only through the existing or extended server-controlled workflow.

### 4.9 Support Queue

51. The system must provide a support queue backed by the support request and support message model.
52. Each support queue row must show subject, requester, status, linked context, unread/new state, and last reply age.
53. The system must provide a support thread workspace that shows the full thread history and linked operational context.
54. The system must allow admins to reply to support requests.
55. The system must allow admins to update support request status.
56. The system must use clear read-state language such as `New` and `Seen`, not confusing workflow-state labels.

### 4.10 Users

57. The system must provide a user search and listing surface.
58. The system must provide user detail workspaces showing profile details, role/status, verification summary, vehicles where relevant, and related operational context.
59. The system must allow authorized admins to suspend and reactivate users through controlled admin workflows.

### 4.11 Settings

60. The system must provide runtime settings management for platform operations.
61. The settings surface must include maintenance mode, minimum app version settings, locale enablement, and operational flags already supported or newly required by the backend.
62. The settings surface must preserve auditability for sensitive changes.

### 4.12 Audit And Health

63. The system must provide an admin audit log view.
64. The system must provide email log and dead-letter visibility.
65. The system must provide safe resend controls where supported by the backend.
66. The system must surface operational failures or exception states relevant to admin action.
67. The system must include admin-governance audit events such as invites, role changes, activation/deactivation, and bootstrap actions.

### 4.13 Global Search

68. The system must provide global search accessible from the admin shell.
69. Global search must support lookup by human-readable terms and exact references/IDs.
70. Global search must return grouped results across bookings, shipments, users, payment proofs, verification packets, disputes, payouts, support requests, and admins where appropriate.
71. Selecting a search result must open the canonical admin detail page for that entity.

### 4.14 Shared UX And Layout Behavior

72. The system must use a shared queue pattern across major admin modules.
73. The system must use a shared detail-workspace pattern across major admin modules.
74. The system must preserve queue context during refresh rather than blanking whole pages.
75. The system must provide clear loading, empty, and error states for each major route.
76. The system must support keyboard navigation and visible focus states across the shell, tables, dialogs, and detail workspaces.
77. The system must use color as a supporting signal only, never the only indicator of state.
78. The system must keep motion minimal and functional rather than decorative.

### 4.15 Flutter Admin Relationship

79. The system must keep the existing Flutter admin available as a lightweight companion for emergency/mobile admin actions during rollout and early adoption.
80. The system must not require the Flutter admin to remain the primary day-to-day operations surface once the web console is ready.

## 5. Non-Goals (Out of Scope)

- Building a native Windows desktop admin app
- Making Flutter Web the primary long-term admin implementation
- Creating a separate custom backend for admin workflows
- Rewriting existing Supabase business rules into web-only logic
- Building a large BI or data-warehouse reporting suite for v1
- Building a dispatch map or telematics-heavy control tower for v1
- Building a custom report builder for v1
- Replacing the customer-facing Flutter app
- Designing the admin as a public-facing product surface
- Introducing more than two admin roles in this phase

## 6. Design Considerations

- The admin web console must feel like a serious transport operations desk, not a generic SaaS template.
- The visual direction should be light-first, restrained, table-first, and queue-first.
- The dashboard must be a control tower, not a chart wall.
- The primary design pattern on desktop should be dense queues and clear detail workspaces, not large stacks of cards.
- Shared patterns should be reused across modules:
  - one queue pattern
  - one filter bar pattern
  - one detail workspace pattern
  - one badge/status language system
  - one action rail pattern
- Raw UUIDs should not be used in top-level titles when a human-readable alternative exists.
- Status and read-state language must remain consistent across modules.

Reference docs already created for this direction:

- [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-master-spec.md](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-master-spec.md)
- [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-console-plan.md](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-console-plan.md)
- [C:\Users\raouf\projects\fleetfill\docs\adr\ADR-005-admin-web-console.md](C:\Users\raouf\projects\fleetfill\docs\adr\ADR-005-admin-web-console.md)

## 7. Technical Considerations

- Frontend stack should be:
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
- Hosting should use Vercel for the admin web console.
- The admin web app should live in `admin-web/` inside the same repository.
- The admin web app must use the same Supabase backend as the Flutter app.
- Auth should use `@supabase/ssr` with cookie-based session handling.
- Sensitive actions must continue using RPCs and Edge Functions rather than duplicated browser logic.
- The system will likely require backend additions beyond the current Flutter admin support, including admin governance tables, functions, and policies.
- Server Components should be the default in Next.js, with narrow Client Component boundaries for interactive features.
- The app should use route-level `loading.tsx`, `error.tsx`, and `not-found.tsx` patterns for major route groups.
- Queue pages should be treated as dynamic operational pages rather than aggressively cached static views.
- Internationalization should support Arabic, French, and English using locale path routing and server-loaded dictionaries.
- The app must not expose service-role credentials in the browser bundle.

## 8. Success Metrics

1. Admin staff can complete core daily operations from the web console without relying on the Flutter admin as the primary workspace.
2. The web console provides full functional admin coverage for the FleetFill admin domain, including governance and admin management.
3. Core high-risk workflows remain fully auditable and continue to be executed through server-controlled paths.
4. Admin users can navigate from queue to detail to action with less ambiguity and less context switching than in the mobile-heavy admin flow.
5. Internal adoption shifts toward the web console for normal operations, while the Flutter admin is used mainly for emergency/mobile cases.
6. The v1 admin web UI is perceived internally as operationally clear and non-generic, rather than as a template dashboard.
7. FleetFill can safely bootstrap the first admin and safely manage future admins without public signup.

## 9. Open Questions

1. Should `ops_admin` be allowed to manage some admin-adjacent settings, or should all admin management remain `super_admin` only?
2. Should admin invitation acceptance create a new auth account only, or also support linking to a pre-existing account email if it exists?
3. Should admin management live under `Users`, `Settings`, or a dedicated `Admins` section in the final IA?
4. Which admin-governance events should also generate notifications or email alerts internally?
