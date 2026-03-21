# FleetFill Technical Architecture

## 1. Architecture Summary

FleetFill uses Flutter on the client and Supabase on the backend.

Primary stack:

- Flutter for Android and iOS clients
- Riverpod for application state
- Freezed and json_serializable for domain models and immutable states
- GoRouter for navigation and route guards
- flutter-intl for UI localization workflow and ARB generation
- SharedPreferences for persisted local app preferences such as theme mode
- Supabase Auth for identity
- Postgres for data and policies
- Supabase Storage for private files
- transactional email provider API for operational email delivery
- Firebase Cloud Messaging plus in-app notifications for operational delivery

## 2. Client Architecture

Recommended app structure:

```text
lib/
  core/
    auth/
    config/
    errors/
    localization/
    permissions/
    routing/
    theme/
    utils/
  shared/
    models/
    widgets/
    providers/
  features/
    onboarding/
    profile/
    shipper/
    carrier/
    admin/
    support/
    notifications/
```

Recommended layer split inside features:

- `presentation/`
- `application/`
- `domain/`
- `infrastructure/`

### 2.1 Layer Contract

- `presentation` owns widgets, screen composition, navigation hooks, and view-state rendering only
- `application` owns feature controllers, orchestration, and use cases when business logic spans multiple repositories or sensitive transitions
- `domain` owns immutable entities, value objects, repository contracts, and domain rules
- `infrastructure` owns Supabase integrations, DTOs, mappers, storage services, and local persistence implementations

### 2.2 State Management Contract

FleetFill uses unidirectional data flow.

Rules:

- repositories are the app-level single source of truth for mutable business data
- Riverpod `Provider` is used for pure dependencies and configuration
- Riverpod `Notifier` is used for synchronous feature state and form orchestration
- Riverpod `AsyncNotifier` is used for async app state and remote workflows
- `StreamProvider` is used for realtime and subscription-driven data
- widget-local ephemeral state is allowed only for transient UI concerns such as local field visibility, current tab animation state, or temporary expansion toggles
- widgets must never own booking, payment, route, verification, or profile business rules

Provider lifecycle rules:

- use provider families for parameterized entities such as booking by id, carrier by id, route by id, shipment by id, and notification by id
- use `autoDispose` for short-lived detail and search providers unless user experience requires retained state
- retain shell-root list providers only when preserving tab state or cached list context is valuable
- debounce and cancel in-flight search requests to avoid stale result races
- use derived providers and selective watching patterns to reduce unnecessary rebuilds in dense screens and lists

### 2.3 Repository, Service, And Use-Case Boundaries

- repositories expose domain-facing methods and coordinate remote/local data sources
- services and data sources are stateless wrappers around Supabase, storage, PDF generation, email-provider, or local persistence APIs
- use cases are added only where orchestration or policy becomes too complex for a repository method alone
- controllers do not call Supabase or storage APIs directly; they talk to repositories or use cases

### 2.4 Routing Shell Architecture

Routing should use `GoRouter` with explicit shell boundaries.

Recommended route model:

- bootstrap route for splash / app initialization
- auth shell for sign-in and account recovery
- onboarding / profile-completion flow before operational access
- permission education and permission recovery routes for notification and storage/media access where needed
- shared above-shell routes for notifications center, settings, support, and canonical entity details
- role-specific app shells after authorization

Recommended shell behavior:

- shipper and carrier sections should use `StatefulShellRoute.indexedStack` or equivalent indexed-stack shell behavior so tab state and scroll position survive tab switches
- shipper and carrier shells should stay lean with four primary tabs each
- notifications should open as shared routes or home/profile entry points instead of permanent bottom tabs
- admin navigation should use a simpler authenticated `ShellRoute` with segmented queue views and stacked detail routes
- detail pages such as booking detail, proof viewer, dispute detail, and payout detail should sit above the role shell, not replace it
- deep links must resolve only after auth and authorization checks
- back-button behavior must preserve tab history correctly instead of bouncing users out of their role shell unexpectedly
- avoid route-per-microstep flows; prefer sheets, dialogs, and inline states for pickers, confirmations, and short success states

Permissions policy:

- use in-app pre-permission explanation screens before OS prompts when the permission has a clear user-value explanation
- notification permission should be requested contextually after the user understands booking and tracking updates value
- storage/media access should only be requested when the user is actively uploading proof or documents
- permanently denied permissions should route users to a recovery/help screen with system-settings guidance

Redirect and error-handling rules:

- redirects should read from a small deterministic gate provider instead of broad app state
- redirects must never perform network I/O directly
- guard evaluation order should be stable: bootstrap -> maintenance/update -> auth -> onboarding/profile completion -> role/operational gate -> entity access
- unknown routes should resolve to a not-found experience instead of crashing or looping
- redirect loops must be explicitly prevented in router configuration and tested

### 2.5 Local Persistence And Cache Rules

- `SharedPreferences` is only for small user preferences such as theme mode, locale override, and lightweight onboarding flags
- secure token/session material must use OS-backed secure storage rather than plain preferences
- local relational cache is allowed only when there is a clear offline or performance need and explicit ownership/invalidation rules exist
- local cache must never become the source of truth for payment, payout, dispute, or booking-authority decisions
- good cache candidates include location reference data, safe read models, draft forms, and previously viewed lists with clear staleness handling

### 2.6 Reusable Page-State Components

Use shared reusable components for common state handling instead of creating separate loading/error/empty screens for each feature.

Recommended shared widgets:

- `AppAsyncStateView`
- `AppSliverAsyncStateView`
- `AppEmptyState`
- `AppErrorState`
- `AppRetryCard`
- `AppOfflineBanner`
- `AppNoExactResultsState`
- `AppPermissionHelpCard`
- `AppNotFoundState`
- `AppForbiddenState`
- `AppSuspendedAccountState`
- `AppVerificationGateState`

### 2.7 Pagination And List Loading Policy

- unbounded collections must use explicit pagination, cursoring, or windowed loading
- search results, notifications, timelines, reviews, and admin queues must not assume full-table loads
- pagination state should be owned by feature controllers or repositories, not ad hoc widget code
- pull-to-refresh should preserve existing visible data where possible instead of blanking the page

### 2.8 Large Payload And Background Work

- JSON parsing that risks blocking the UI should move off the main isolate when payload size or profiling justifies it
- PDF generation, large response parsing, and bulk local transforms must not block interactive UI frames
- if a task regularly exceeds the frame budget, move it to background execution or restructure the payload

## 3. Authentication And Session Handling

### 3.1 Auth Providers

- email and password
- Google sign-in

### 3.2 Operational Gate

Before a user can perform operational actions, the app must confirm:

- role is selected
- phone number is present
- profile minimum data is complete
- required verification or payout-account gates are satisfied for the relevant role and action

### 3.3 Role Access

One account has one role. Route guards and data access must enforce that model consistently.

Recommended guard families:

- bootstrap guards
- auth guards
- onboarding/profile completion guards
- role guards
- carrier verification and payout-account gates
- admin recent-sign-in / step-up guards for sensitive actions
- not-found and forbidden handling for deep links and entity access

### 3.4 Session Security

- use Supabase session management with refresh-token rotation and revocation capabilities enabled where supported
- store auth session material only in secure storage
- force reauthentication after sensitive account changes such as password or primary email changes
- support remote logout and session invalidation as part of account security operations
- require recent sign-in for sensitive admin actions such as payout release, dispute resolution, user suspension, and sensitive settings changes
- production admin accounts should use MFA or equivalent step-up protection as soon as operationally available

### 3.5 Email Ownership Rules

- FleetFill uses a server-controlled transactional email provider for outbound email
- email sending is server-controlled only; the client never talks to the provider directly
- template selection must be event-driven and locale-aware
- email content must be generated from canonical booking, profile, payout, and support data rather than ad hoc client payloads
- authentication emails that belong to Supabase Auth may remain on Supabase-managed auth flows unless intentionally replaced later
- sender identities and final provider template IDs can remain placeholder configuration until business email domains are finalized

## 4. Server Control Strategy

FleetFill should not push every action into Edge Functions. Use the lightest safe server boundary.

### 4.1 Direct Client CRUD Is Acceptable For

- profile updates
- vehicle updates
- payout account updates
- route and one-off trip CRUD
- notification read states
- review creation when RLS and constraints are sufficient

### 4.2 Server-Controlled Operations Are Required For

- trip search aggregation and ranking
- booking creation with capacity enforcement
- payment proof submission finalization
- payment approval and rejection
- signed URL generation for private files
- status transitions that must enforce workflow rules
- dispute resolution
- payout release
- platform settings response shaping
- generated PDF document creation when the source data must be immutable and auditable
- any workflow that must commit business state, audit data, and outbox work atomically

These server-controlled flows may use Edge Functions or secure SQL/RPC functions depending on implementation complexity. The rule is to centralize critical logic, not to force every workflow through Edge Functions unnecessarily.

Critical transaction rule:

- booking creation, payment approval/rejection, dispute resolution, payout release, and email outbox enqueueing must write their business state changes, audit records, and related side-effect records inside one database transaction

## 5. Search Architecture

Search should be server-driven because it combines:

- exact route matching
- recurring route expansion by date
- one-off trip inclusion
- remaining capacity calculation
- reputation signals
- recommended ranking

Recommended implementation:

- one search endpoint/function for exact same-day results
- the same function returns nearest allowed exact-lane dates when same-day is empty

Capacity safety rule:

- overbooking protection requires a transactional reservation model per bookable departure instance, not only route-level reads
- recurring routes should materialize or lock against a concrete per-date capacity record before a booking is confirmed

## 6. File Storage Architecture

Private buckets:

- payment proofs
- verification documents
- generated documents

Recommended file flow:

1. client requests a controlled upload session
2. client uploads to private storage using a signed upload path or equivalent secure flow
3. server records metadata entry
4. private file viewing always uses a server-generated signed URL

The product must retain document and proof history for audit purposes.

Upload security requirements:

- validate content type using both MIME and file signature where practical
- enforce size and extension allowlists server-side
- bind upload sessions to actor, entity, and intended document type
- use randomized storage keys instead of user-controlled file names
- keep signed URLs short-lived and re-check authorization before issuance
- store file metadata needed for audit and tamper detection such as content type, byte size, and checksum where feasible

## 7. Settings Architecture

`platform_settings` is the internal source of truth, but mobile clients should consume a controlled settings response rather than reading the raw table directly.

Benefits:

- validation
- typed response contract
- selective exposure of public values only
- safer future changes

Settings should also support controlled feature flags for operational rollouts without forcing app releases.

Examples:

- maintenance mode
- platform version gates
- iOS rollout readiness
- insurance visibility or availability
- temporary operational switches for support and risk controls

The client settings response should be an explicit typed contract served by secure backend logic rather than raw table reads.

## 8. Time And Timezone Rules

- database timestamps use `timestamptz`
- timestamps are persisted in UTC
- business rules are evaluated in Algeria local time
- client display is localized, but operational deadlines follow Algeria business time

This rule must be applied consistently for:

- search windows
- route recurrence expansion
- payment cutoff logic
- dispute windows
- support SLAs
- release policy timing

## 9. Release And Versioning Architecture

### 9.1 Platform Readiness

- Android is production-first
- iOS config keys must exist even if public rollout is deferred

### 9.2 Version Policy

Settings should support:

- minimum supported version per platform
- latest available version per platform
- update URL or store URL per platform
- maintenance mode switch
- delivery review grace window
- payment proof resubmission window
- active FleetFill inbound payment account references per rail and environment

### 9.3 Versioning And Release Policy

Recommended application versioning:

- use semantic-ish application versions such as `major.minor.patch`
- keep Android `versionCode` and iOS `buildNumber` strictly increasing
- tie each mobile release to a Git tag and changelog entry
- keep staging and production builds traceable back to a commit SHA

Recommended branch and release posture:

- if the team intentionally stays on a single long-lived branch workflow, protect that branch and rely on commit discipline plus CI gates
- if pull requests are used, require CI to pass before merge
- create release tags only after staging validation

### 9.4 CI/CD Architecture

Recommended delivery workflow:

1. push or approved integration step triggers GitHub Actions
2. CI runs formatting, static analysis, code generation validation, tests, and build checks
3. approved release workflows deploy non-production backend assets to staging
4. tagged releases produce signed release artifacts and production deployment candidates
5. production rollout happens only after staging verification and rollback readiness review

Recommended CI checks:

- Flutter format/lint/analyze
- codegen verification
- unit/widget/integration tests as appropriate
- migration and SQL validation checks
- Supabase function checks where applicable
- app build sanity checks

Recommended deployment scope by pipeline:

- app code and release artifacts through GitHub Actions
- Supabase migrations, functions, and config through controlled deployment jobs
- explicit human approval before production changes that affect money, data, or auth

## 10. Notifications Architecture

Notifications should be event-driven and channel-agnostic.

Current channels:

- push notifications
- in-app notifications
- email via transactional provider

Current push posture:

- device tokens are registered and normalized through a server-controlled boundary
- a scheduled push worker dispatches notification rows to Firebase Cloud Messaging HTTP v1 using a service account secret
- tapping a delivered push can route users back into the matching shared in-app notification detail flow

Future channels can be added later without replacing the event model.

### 10.1 Initial Transactional Email Events

Recommended email events:

- support request acknowledgement
- booking confirmed
- payment proof received
- payment rejected
- payment secured
- delivered pending review
- dispute opened
- dispute resolved
- payout released
- generated invoice or receipt available

### 10.2 Email Template Strategy

- one logical template per event
- one localized content variant per supported locale where needed
- supported locales: Arabic, French, English
- template variables must come from validated server-side payloads
- keep email templates operational and text-first, not marketing-heavy
- locale fallback is deterministic: Arabic -> Arabic template, French -> French template, English -> English template, otherwise fallback to English
- invoice data should render inside the email body as structured HTML content when needed, not as an email attachment by default

### 10.3 Email Delivery And Events

- provider API calls should happen from secure server-controlled code
- delivery failures, bounces, and suppression signals should be capturable for later operational handling
- retries should be controlled and idempotent for critical events

Recommended send flow:

1. canonical business event occurs
2. server builds a normalized email job payload
3. server chooses locale, template key, and recipient
4. server calls the configured transactional email provider
5. server stores delivery log state
6. retry worker or scheduled job re-attempts eligible transient failures

Recommended reliability rules:

- do not block the user-facing transaction on non-critical email delivery success
- critical workflows should commit business state first, then enqueue or trigger email dispatch
- email dispatch must be idempotent per event key and target recipient
- retries should only happen for transient failures, not permanent invalid-address failures

### 10.4 High-Volume Email Strategy

If FleetFill grows into heavy transactional email volume, email delivery must move through an explicit outbox/queue model instead of direct inline sending from every workflow.

Recommended pattern:

1. business transaction commits
2. transactional email job is written to an outbox table
3. background worker claims queued jobs in small batches
4. worker sends through the configured provider with rate-aware throttling
5. worker updates delivery log and queue state
6. webhook events update final delivery outcomes asynchronously

Required controls:

- deduplication key per logical event and recipient
- priority levels for critical emails versus informational emails
- bounded batch size to avoid spikes and timeouts
- provider-aware throttling to avoid rate-limit cascades
- dead-letter or terminal-failure handling for jobs that should stop retrying

Recommended backend handling by scale:

- low to moderate volume: server writes to outbox table and one scheduled worker processes queued jobs every short interval
- sustained higher volume: multiple workers claim jobs concurrently using atomic row locking and `SKIP LOCKED` style semantics
- very high burst volume: split work by priority and schedule, keep critical lifecycle mail on a fast lane and delay non-critical mail to a slower lane

Worker rules:

- claim jobs in small batches such as 25 to 100 at a time
- update claimed rows immediately with lock owner and timestamp
- stop sending when provider throttling or error rate crosses a safety threshold
- release retryable jobs back to the queue with exponential backoff
- move poison jobs to dead-letter after bounded attempts

Webhook rules:

- verify provider webhook authenticity before ingesting status updates where applicable
- treat webhook events as idempotent and possibly out of order
- keep provider event references so duplicate deliveries do not corrupt final state

Supabase-compatible implementation path:

- transactional write inserts business state and outbox row in the same database transaction
- scheduled Edge Function or secure worker polls `email_outbox_jobs`
- worker updates `email_delivery_logs` and queue state after each attempt
- provider webhooks update final states like delivered, bounced, or suppressed when available
- if load outgrows scheduled functions, move the worker loop to a dedicated background service without changing the outbox contract

Initial production deployment for current budget constraints:

- on Supabase Free, start with one scheduled worker and small bounded batches
- keep the full outbox, dedupe, retry, and dead-letter contract from day one
- scale to multiple workers or a dedicated background service only when queue depth and backlog age justify it

Operational constraint note:

- validate the chosen scheduling mechanism, quotas, and reliability on the actual Supabase plan before depending on automated timed workflows in production

Important rule:

- the app should never send large bursts synchronously from the request path if queued background delivery is available

## 11. Generated Documents Architecture

System-generated PDFs should be produced from canonical booking and ledger data, not handcrafted in the client from mutable UI state.

Initial generated document scope:

- booking invoice
- payment receipt where applicable
- payout receipt or payout statement where applicable

These documents should be reproducible from immutable snapshots and stored in private storage when retention is required.

## 12. Testing Strategy

FleetFill requires a layered testing strategy.

### 12.1 Unit Tests

Unit tests should cover:

- repository logic
- pricing and insurance calculation helpers
- booking and payment status transition rules
- locale and formatting helpers
- document and proof validation helpers

### 12.2 Widget Tests

Widget tests should cover:

- shipment and route forms
- payment proof upload states
- money breakdown cards
- status timeline components
- empty, loading, and error states
- accessibility guidelines such as labeled tap targets and text contrast
- router guard fallback experiences such as forbidden, not-found, verification gate, and suspended-account states

### 12.3 Integration Tests

Integration tests should cover the critical cross-feature flows:

- auth and operational gating
- create shipment -> search -> create booking -> upload payment proof
- carrier route creation -> view bookings -> pickup -> transit -> delivered
- admin payment verification
- dispute creation and resolution
- theme and locale restoration at app startup
- deep links into shared above-shell detail routes
- router redirect ordering and loop prevention

Critical release candidates should not ship until the essential integration flows pass on a representative Android test device.

## 13. Performance And Bundle Discipline

Performance must be measured in profile mode, not debug mode.

Rules:

- establish a profile-mode baseline before release on a representative Android device
- investigate repeated frame jank above the 16ms frame budget in critical flows
- use lazy builders and slivers for long collections such as search results, notifications, timelines, and admin queues
- preserve scroll position intentionally for tabbed long lists using restoration or `PageStorageKey` patterns where appropriate
- avoid expensive paint operations and unnecessary rebuilds in frequently updated screens
- measure Android bundle size with `--analyze-size` before major release candidates and investigate large regressions
- avoid route churn for microstates that are better represented inline or with sheets/dialogs

## 14. Observability

Baseline observability:

- server logs for critical workflows
- admin audit log for sensitive actions
- crash reporting for mobile app
- business events for search, booking, proof upload, review, payout, and dispute milestones

## 15. Offline And Reliability Principles

Because the app targets inconsistent connectivity:

- allow safe local draft behavior for non-final forms
- do not fake success for transactional actions
- show explicit pending states for proof submission and verification
- always prefer clarity over aggressive offline automation for financial or booking-critical operations
- preserve locally entered form data when safe, but revalidate all authoritative booking and payment actions against the server before final confirmation
- if background automation depends on hosted scheduling, define an operational fallback for missed runs or delayed execution on constrained infrastructure
