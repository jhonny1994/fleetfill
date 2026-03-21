# FleetFill Implementation Plan

This file is the execution checklist for building FleetFill from the canonical docs.

Rules:

- Keep this file updated as work progresses.
- Mark tasks with `[x]` only when the work is complete and verified.
- If a task changes product or domain truth, update the canonical docs first.
- Do not skip foundational phases just to build UI faster.

## Phase 0 - Delivery Setup And Working Agreement

- [x] Confirm Flutter, Dart, Android, Supabase, and transactional email provider accounts/environments are accessible
- [x] Confirm package strategy for Flutter app, admin surface, and shared code boundaries
- [x] Confirm repository structure, branch strategy, and environment naming (`local`, `staging`, `production`)
- [x] Create ADRs for the most irreversible decisions already captured in the docs
- [x] Define naming conventions for tables, enums, files, routes, providers, and storage paths
- [x] Define secrets ownership and where each secret is stored for local, staging, and production
- [x] Define release responsibilities for app, backend, storage, and operations changes

## Phase 1 - Project Foundation

### Flutter App Foundation

- [x] Create the Flutter project with the agreed folder structure from `docs/03-technical-architecture.md`
- [x] Configure Flutter flavors or environment selection for local, staging, and production
- [x] Add core packages: Riverpod, Freezed, json_serializable, GoRouter, Supabase Flutter, flutter-intl, SharedPreferences, secure storage, notifications, PDF/viewer support as needed
- [x] Configure code generation for Freezed, JSON, and localization
- [x] Set up root app bootstrap flow for config loading, auth/session restoration, theme restoration, and locale restoration
- [x] Implement global error model and error presentation strategy
- [x] Implement app-wide logging hooks and crash reporting integration points
- [x] Define the final GoRouter route tree from `docs/08-screen-map-and-routing.md`
- [x] Define parent navigator keys, shell navigator keys, and route names for shared above-shell detail routes
- [x] Define guard providers for bootstrap, auth, onboarding, role, verification, payout-account, and admin step-up access
- [x] Define router redirect ordering, unknown-route handling, and redirect-loop protection strategy

### Design System Foundation

- [x] Create Material 3 theme foundation with `ColorScheme` for light and dark modes
- [x] Define design tokens for color, spacing, typography, radius, elevation, borders, icons, and motion
- [x] Create shared app scaffolds, section headers, list cards, money summary components, and status chips
- [x] Implement theme persistence with no-flash startup behavior
- [x] Define responsive layout breakpoints and role-shell layout behavior
- [x] Define reusable UI patterns for bottom sheets, dialogs, snackbars, and confirmation prompts so microflows do not become one-off screens

### Localization And Accessibility Foundation

- [x] Configure `flutter-intl` / ARB-based localization for Arabic, French, and English
- [x] Implement deterministic locale fallback to English when locale is unsupported
- [x] Define bidi-safe formatting helpers for phone numbers, tracking IDs, payment references, prices, and plates
- [x] Define global accessibility checklist for semantics, 48dp targets, focus order, and large-text resilience
- [x] Add baseline widget tests for localization and accessibility guidelines
- [x] Create shared page-state widgets for loading, error, empty, retry, offline, forbidden, not-found, and verification-gate states
- [x] Define reduced-motion policy and keyboard/focus traversal rules for forms, dialogs, sheets, and larger-device layouts
- [ ] Add a final cross-phase UX polish pass after most operational phases are complete, covering skeleton loading, progressive loading transitions, image optimization, accessibility release checks, and localization polish

Cross-phase UX note:

- immediate UX/perf foundations such as debounce, stale-result protection, lazy rendering, destructive confirmations, shared recovery states, and scroll-position preservation should be applied during the feature phases they affect
- end-of-product polish items such as skeleton loading, shimmer, broader transition refinement, media optimization, and final accessibility/localization sweeps should land in a coordinated pass after most major phases are implemented

## Phase 2 - Backend Schema And Security Foundation

### Database And Storage Foundation

- [x] Create Postgres enums and base tables from `docs/04-data-and-security-model.md` and `docs/09-supabase-implementation-notes.md`
- [x] Create `profiles`, `vehicles`, `payout_accounts`, `platform_payment_accounts`, `verification_documents`, `routes`, `route_revisions`, `oneoff_trips`, `shipments`, `shipment_items`, `bookings`, `payment_proofs`, `tracking_events`, `carrier_reviews`, `financial_ledger_entries`, `disputes`, `refunds`, `payouts`, `generated_documents`, `email_delivery_logs`, `email_outbox_jobs`, `notifications`, `user_devices`, `platform_settings`, and `admin_audit_logs`
- [x] Seed wilayas and communes from `docs/wilayas-with-municipalities.json`
- [x] Create indexes for search, booking, payment, document review, ledger, and email queue performance
- [x] Create private storage buckets for payment proofs, verification documents, and generated documents
- [x] Define canonical storage path patterns for each private file type
- [x] Implement DB constraints for one-of route vs one-off trip booking links and one-active-payout-account-per-carrier

### Security And Access Control

- [x] Enable RLS on all public tables
- [x] Implement deny-by-default RLS policies per table for shipper, carrier, and admin access
- [x] Enforce server-only access for service-role credentials and critical privileged mutations
- [x] Implement signed URL issuance rules for private file viewing
- [x] Implement upload-session model with type validation, size validation, and storage-key hardening
- [x] Implement append-only protections for tracking events, ledger, audit logs, proofs, and verification history
- [x] Implement centralized input validation for all server-controlled mutations
- [x] Implement rate limiting and abuse controls for auth, booking, proof upload, dispute creation, and signed URL generation
- [x] Implement structured audit logging with actor, target, action, outcome, and reason fields
- [x] Protect admin-only and sensitive columns from client-side mutation, including role, activation, verification, and payout verification fields
- [x] Implement immutable/append-only enforcement for ledger, audit, tracking, proof, and verification history tables

### Supabase Runtime And Automation Foundation

- [x] Confirm the actual Supabase scheduling mechanism, quotas, and reliability available on the target plan
- [x] Implement the chosen scheduled automation path from `docs/09-supabase-implementation-notes.md`
- [x] Define when FleetFill uses RPC, Edge Functions, triggers, `pg_cron`, `pg_net`, Vault, and Storage policies in concrete code structure
- [x] Validate secrets placement between Supabase project secrets and Vault

### Phase 2 Verification Coverage

- [x] Add backend foundation contract tests for schema/security migrations with feature-based test naming

## Phase 3 - Auth, Account, And Profile Systems

### Authentication

- [x] Configure Supabase Auth for email/password login, including local CLI auth config and redirect URL setup
- [x] Configure Google sign-in, including local `[auth.external.google]` provider config and callback setup
- [x] Implement secure session storage and restoration
- [x] Implement role-aware auth bootstrap and route guards
- [x] Implement password reset and auth error handling UX
- [x] Implement session invalidation / logout behavior
- [x] Implement blocked-account, forbidden, and session-expired handling using route guards and inline/dialog UX where appropriate

Current implementation notes:

- auth UI was upgraded to a trust-first card layout inspired by the provided reference image while keeping FleetFill product constraints
- extracted visual patterns include rounded auth panel, soft neutral background, semantic icon-led fields, stronger CTA emphasis, and optional wide-screen preview deck
- all newly introduced user-facing auth copy was moved into ARB localization keys (no hardcoded runtime strings)
- auth error mapping now includes explicit `authentication_required` handling instead of empty exception messages
- tests were renamed from phase-based naming to feature-based naming for maintainability (`foundation_localization_accessibility_test.dart`, `auth_routing_guard_test.dart`)

### Account Completion And Profiles

- [x] Build role selection and profile completion flow
- [x] Enforce mandatory phone number before operational actions
- [x] Build shipper profile edit flow
- [x] Build carrier profile edit flow
- [x] Build public carrier profile view with rating summary and comments
- [x] Add account suspension / inactive-state handling
- [x] Keep onboarding lean by using one role-aware `ProfileSetup` flow instead of fragmented setup screens

Verification notes:

- auth/onboarding/profile redirects and gates are covered by feature tests in `test/auth_routing_guard_test.dart`
- password recovery routes now preserve auth flow and enforce reset-password destination when recovery state is active
- session-expired, suspended, forbidden, verification, onboarding, and phone-completion gate handling are validated via guard tests and UI state wiring

## Phase 4 - Carrier Onboarding, Vehicles, And Verification

### Carrier Verification Domain

- [x] Implement verification document domain models and repositories
- [x] Build vehicle CRUD flows
- [x] Build document upload flow for driver identity/license and truck documents
- [x] Support document replacement with preserved history
- [x] Show verification status and rejection reasons in carrier UX
- [x] Implement carrier verification gates before route, booking, or payout-relevant operational actions

### Admin Verification Operations

- [x] Build grouped verification review packet for profile and vehicle
- [x] Build document-level review actions with reason capture
- [x] Build `Approve all` behavior with aggregate verification result and per-document audit entries
- [x] Build admin queue for pending verification packets

Verification notes:

- carrier verification now lives under the carrier profile branch with dedicated vehicle CRUD, verification center, document upload/replace flows, and visible rejection reasons in localized copy
- admin verification now uses privileged SQL review functions for document review and packet approval so append-only history and audit logging stay server-controlled
- verification packet aggregation now keeps the latest document version per document type while preserving older history records in `verification_documents`
- feature coverage was expanded in `test/verification_workflows_test.dart` for latest-document selection, carrier operational gates, and Phase 4 SQL contract safeguards
- validation passed with `dart analyze`, `flutter test`, `supabase db lint`, and `supabase db reset --yes`

## Phase 5 - Carrier Capacity Publication

### Routes And Trips

- [x] Build recurring route CRUD
- [x] Build one-off trip CRUD
- [x] Support vehicle assignment to routes and one-off trips
- [x] Enforce capacity and operational field validation
- [x] Support active/inactive toggling
- [x] Implement route revision model so future-effective changes do not rewrite existing commitments
- [x] Implement weight-first and optional-volume matching exactly as defined in the canonical docs

### Carrier Capacity UX

- [x] Build route list and trip list screens
- [x] Build reusable route/trip create-edit forms
- [x] Show upcoming capacity summary and booking utilization
- [x] Keep schedule, vehicle assignment, and capacity actions as sections or sheets where possible instead of separate routes

Phase 5 notes:

- carrier routes now support recurring routes and one-off trips with dedicated list, detail, create, edit, activate/deactivate, and delete flows inside the carrier routes branch
- recurring route writes now use trusted SQL publication functions so critical edits create append-only `route_revisions` instead of bypassing revision history
- recurring routes now store optional volume capacity in addition to required weight capacity, and SQL constraints enforce positive capacity, positive pricing, distinct lanes, valid weekday arrays, verified-carrier publication gates, and verified-vehicle assignment rules
- route and trip forms now use shared commune selection, vehicle assignment, localized validation, destructive-action confirmation, and bounded list loading while keeping create-type choice in a sheet instead of extra micro-routes
- carrier payout account management now exists as a real in-app CRUD flow so payout-related gates no longer dead-end at an empty screen
- shared route and one-off trip detail screens now resolve to actual read-only detail views instead of placeholders, keeping deep-link behavior aligned with the routing docs
- verification helper grants and support-email dispatch were tightened so Phase 0-5 production hardening stays consistent with the product and security model
- supporting coverage was added in `test/contracts/supabase/capacity_publication_contract_test.dart` and validation should include `dart analyze`, `flutter test`, `supabase db lint --debug`, and `supabase db reset --yes`

## Phase 6 - Shipment Creation And Search

### Shipment Domain

- [x] Build shipment CRUD for shipper drafts and active shipments
- [x] Support multiple shipment items inside one shipment
- [x] Enforce one shipment -> one booking rule in code and DB
- [x] Validate pickup window, weight, and required inputs

### Search Engine And Results

- [x] Build server-driven exact-lane search endpoint/function
- [x] Include recurring route expansion by date and one-off trips
- [x] Compute remaining capacity safely
- [x] Implement `Recommended` ranking logic
- [x] Implement same-route nearest-date fallback when same-day exact result is empty
- [x] Return redefine-search result when no exact route exists
- [x] Implement pagination/cursoring for search results and other long-running collections
- [x] Implement debounced/cancellable search requests and stale-result protection

### Search UX

- [x] Build shipment search form
- [x] Build search results list with lazy rendering
- [x] Build no-result and nearest-date fallback as inline page states, not separate routes
- [x] Build alternative sort options: `Top Rated`, `Lowest Price`, `Nearest Departure`
- [x] Build filters and sort controls as sheets instead of routed microflows

Phase 6 progress notes:

- shipper shipment drafts now support direct CRUD with multiple shipment items, shared validation, and shared detail rendering over the existing draft-safe RLS model
- shipment search is now server-driven through `search_exact_lane_capacity(...)`, using exact lane matching, recurring route expansion by requested date, one-off trip inclusion, server-side remaining-capacity checks, recommended ranking, nearest-date fallback, and redefine-search mode
- shipper search UI now lets users search from a selected shipment draft, review exact/nearest matches inline, debounce and invalidate stale searches, switch sort/filter controls from a bottom sheet, and hand off a selected result into booking review without routed micro-success pages
- shipment draft selection and the unique booking constraint now preserve the one-shipment -> one-booking model in both app flow and DB truth
- supporting migration and contract coverage was added in `supabase/migrations/20260320120000_add_shipment_domain_constraints.sql`, `supabase/migrations/20260320120100_create_exact_lane_search_rpc.sql`, and `test/contracts/supabase/shipment_search_contract_test.dart`

## Phase 7 - Booking And Pricing Flow

### Booking Domain

- [x] Build booking creation server flow with capacity enforcement and idempotency
- [x] Snapshot all commercial fields onto the booking
- [x] Generate tracking number and payment reference
- [x] Enforce booking and payment status transition rules
- [x] Implement transactional reservation/capacity protection for per-date bookable departures
- [x] Ensure booking, audit, and outbox side effects commit atomically

### Pricing Logic

- [x] Implement price-per-kg route/trip pricing resolution
- [x] Implement `base_price`, `platform_fee`, `carrier_fee`, `insurance_fee`, `tax_fee`, `shipper_total`, and `carrier_payout` calculations
- [x] Implement optional insurance percentage with minimum fee floor
- [x] Build pricing breakdown presentation in shipper UI

### Booking UX

- [x] Build booking confirmation screen
- [x] Show carrier reputation and trip details clearly before payment
- [x] Show total and detailed breakdown before payment proof step
- [x] Keep pricing breakdown and insurance choice as reusable sheets/sections inside the booking flow

Phase 7 progress notes:

- booking confirmation is now server-controlled through `create_booking_from_search_result(...)`, which resolves the selected route or one-off trip, enforces remaining capacity, snapshots commercial values, generates tracking/payment identifiers, updates route-day reservations, and writes notification/outbox/tracking side effects atomically
- booking and payment status transitions are now guarded by DB transition helpers and a bookings trigger so later phases cannot silently jump between invalid states
- the booking review screen now acts as the booking confirmation screen, showing carrier/trip context, insurance selection, and a reusable pricing breakdown sheet before the user continues to payment instructions
- payment flow now shows booking summary, payment reference, total, breakdown, and platform payment account instructions instead of a placeholder screen
- shared booking detail now resolves to a real booking summary view rather than a placeholder
- supporting migration and contract coverage was added in `supabase/migrations/20260320120200_create_booking_confirmation_rpc.sql`, `supabase/migrations/20260320120300_enforce_booking_status_transitions.sql`, and `test/booking_flow_contract_test.dart`

## Phase 8 - Payment Proof, Escrow, And Ledger

### Payment Proof Flow

- [x] Build payment instructions for CCP, Dahabia, and bank transfer
- [x] Build secure payment proof upload flow
- [x] Support resubmission after rejection with history retained
- [x] Enforce exact amount matching rule for verification
- [x] Show payment proof statuses and rejection reasons clearly
- [x] Implement payment as one coherent flow screen with internal sections/states instead of many success/result pages
- [x] Model and implement payment-resubmission deadline handling with automatic cancellation and capacity release

### Ledger And Escrow

- [x] Implement immutable ledger entry creation for secured payment, rejection, refund, and payout
- [x] Ensure booking/payment statuses never replace ledger truth
- [x] Generate payment receipt document when applicable
- [x] Generate invoice document when applicable

### Admin Payment Operations

- [x] Build payment proof review queue
- [x] Build payment approval flow
- [x] Build payment rejection flow with mandatory reason
- [x] Build admin visibility into proof history and money summary
- [x] Capture submitted amount, verified amount, verified reference, and decision notes for audit-quality proof reviews

Phase 8 progress notes:

- payment flow now includes platform payment instructions, secure proof upload, latest proof status, rejection visibility, generated document visibility, and resubmission support inside one coherent screen
- payment proof submission now updates booking payment state through `finalize_payment_proof(...)` instead of only storing files without workflow truth
- admin payment operations now include a real payment proof review queue with approval/rejection decisions, exact amount enforcement, verified references, and decision notes
- approval and rejection now create immutable ledger entries and generated document records while moving booking/payment states through the escrow flow
- scheduled automation now expires rejected bookings after the configured resubmission deadline and releases reserved capacity
- supporting migration and contract coverage was added in `supabase/migrations/20260320120400_create_payment_proof_review_rpc.sql`, `test/contracts/supabase/payment_contract_test.dart`, and `supabase/tests/runtime_security_test.sql`

## Phase 9 - Tracking, Delivery, And Completion

### Tracking Domain

- [x] Implement append-only tracking event creation
- [x] Derive visible booking progress from authoritative events/statuses
- [x] Support milestone events: payment under review, confirmed, picked up, in transit, delivered pending review, completed, cancelled, disputed

### Carrier Progress UX

- [x] Build carrier booking worklist
- [x] Build milestone update actions for `picked_up`, `in_transit`, and `delivered`
- [x] Add optional notes where allowed
- [x] Present milestone updates as sheets/actions from booking detail rather than separate standalone pages where possible

### Delivery Confirmation

- [x] Implement `delivered_pending_review` grace window handling
- [x] Build shipper confirm-delivery action
- [x] Build auto-complete after grace period expires with no dispute
- [x] Record delivery confirmation timestamps and audit trail
- [x] Keep delivery confirmation, dispute opening, and rating entry attached to booking/tracking detail rather than scattered success routes
- [x] Implement durable scheduled/background execution for grace-window expiry

Phase 9 progress notes:

- carrier booking worklists now exist and route into a real shared tracking detail instead of a placeholder branch screen
- tracking is now append-only through `append_tracking_event(...)`, and carrier milestone changes plus shipper delivery confirmation are server-controlled through dedicated RPCs
- shared tracking detail now exposes timeline history plus carrier milestone actions and shipper delivery confirmation in-context instead of separate success routes
- scheduled automation now auto-completes delivered bookings after the configured delivery-review grace window
- supporting migration and contract coverage was added in `supabase/migrations/20260320120500_create_tracking_and_delivery_rpc.sql`, `test/contracts/supabase/tracking_delivery_contract_test.dart`, and `supabase/tests/runtime_security_test.sql`

## Phase 10 - Disputes, Refunds, And Payouts

### Disputes

- [x] Build dispute creation flow from `delivered_pending_review`
- [x] Support evidence/notes attachment if included in scope
- [x] Build admin dispute review screen with booking, proof, tracking, and ledger context
- [x] Support dispute outcomes: complete, cancel, refund
- [x] Record all dispute outcomes in audit log and ledger where relevant
- [x] Build first-class dispute records with lifecycle, reason, notes, and resolution metadata

### Payouts

- [x] Build payout account CRUD for carriers
- [x] Validate only one active payout account is operationally used at a time
- [x] Build payout eligibility checks
- [x] Build payout release flow for admin/ops
- [x] Update `payment_status` to `released_to_carrier` when payout is completed
- [x] Generate payout receipt or payout statement document when applicable
- [x] Build first-class payout records with account snapshot, external reference, failure handling, and retry-safe operations
- [x] Build first-class refund records with external reference and processing lifecycle

Phase 10 progress notes:

- shippers can now open disputes only from `delivered_pending_review`, which moves the booking into `disputed` and appends a user-visible tracking event
- shippers can now attach private dispute evidence files during dispute creation, and admins can open those evidence files from the dispute-resolution surface
- admins now have dispute-resolution paths for complete and refund outcomes, with booking state, ledger, and tracking updates handled on the server
- refunds and payouts now use first-class records instead of relying on booking/payment status alone
- payout release now snapshots the chosen payout account, blocks on open disputes, writes payout ledger entries, and generates a payout receipt record
- the schema now enforces a single active payout account per carrier through a partial unique index
- supporting migration and contract coverage was added in `supabase/migrations/20260320120600_create_dispute_and_payout_rpc.sql`, `supabase/migrations/20260320120825_add_dispute_evidence_support.sql`, `test/contracts/supabase/dispute_payout_contract_test.dart`, and `supabase/tests/runtime_security_test.sql`

## Phase 11 - Ratings, Notifications, And Support

### Ratings

- [x] Allow one carrier review per completed booking
- [x] Build rating and comment submission flow
- [x] Recompute carrier rating aggregates safely
- [x] Surface public comments on carrier profile

### Notifications

- [x] Build in-app notifications table consumption
- [x] Register and normalize push device tokens through a server-controlled boundary
- [x] Trigger in-app notifications for critical lifecycle events
- [x] Deliver real push notifications for critical lifecycle events through the configured FCM worker path
- [x] Build notifications center UI
- [x] Open notifications from shared routes or home/profile entry points rather than dedicated shipper/carrier bottom tabs

### Email And Support

- [x] Integrate transactional email sending from secure server code with a provider-agnostic boundary
- [x] Build `email_outbox_jobs` processing worker
- [x] Build `email_delivery_logs` recording and update flow
- [x] Implement locale-aware template selection with English fallback
- [x] Build provider webhook/status handling for delivered, bounced, suppressed, and failed states where supported
- [x] Build support acknowledgement email flow
- [x] Expose support email entry points in app
- [x] Implement webhook authenticity verification, idempotency, and out-of-order event handling
- [x] Define and implement the full transactional email event set from the canonical docs, not support acknowledgement only

Phase 11 progress notes:

- shippers can now submit one carrier review per completed booking from shared tracking detail, and carrier rating aggregates are recomputed through a dedicated server function
- notifications now have real in-app table consumption, a notifications center, notification detail screens, and localized read-state updates instead of placeholders or raw notification keys
- support now has a real in-app email entry surface backed by the provider-agnostic support dispatch function, with visible support email guidance and structured issue-entry hints
- support dispatch now normalizes locale inputs and queues both acknowledgement and support-forward emails through the outbox path instead of sending inline in the user request
- generated document shared routes now resolve to secure signed-URL viewers instead of placeholders
- user-device registration and notification marking are now server-controlled RPCs, and notification inserts now feed a scheduled Firebase Cloud Messaging HTTP v1 worker so push and in-app delivery share one canonical event source
- the transactional email inventory now covers booking confirmation, payment proof receipt, payment rejection, payment secured, delivered-pending-review, dispute opened, dispute resolved, payout released, generated document availability, support acknowledgement, and support forwarding
- supporting migration and contract coverage was added in `supabase/migrations/20260320120700_create_carrier_review_rpc.sql`, `supabase/migrations/20260320120710_create_notification_device_rpc.sql`, `supabase/migrations/20260320120720_create_transactional_email_enqueue_rpc.sql`, `supabase/migrations/20260320120800_harden_notification_device_rules.sql`, `supabase/migrations/20260320120810_harden_email_delivery_rules.sql`, `supabase/migrations/20260320120820_create_support_request_email_rpc.sql`, `supabase/migrations/20260320120830_create_push_notification_runtime.sql`, and `test/contracts/supabase/engagement_support_contract_test.dart`

## Phase 12 - Admin Surface And Operations

### Admin Core

- [x] Build secure admin shell and route guards
- [x] Build dashboards/queues for payment proofs, verification packets, disputes, payouts, email failures, and audit events
- [x] Build platform settings editor or controlled operational surface
- [x] Build search/filter tools for bookings, users, proofs, documents, and email logs
- [x] Keep mobile admin lean: use one queues page with segmented sections instead of many top-level admin tabs
- [x] Build typed client-settings response/API from `platform_settings` rather than raw client table reads

### Admin Audit And Monitoring

- [x] Build admin audit log viewer
- [x] Build dead-letter email queue viewer and safe resend controls
- [x] Build monitoring views for payment review backlog, dispute backlog, payout backlog, and email backlog
- [x] Build monitoring for timed automations such as payment-resubmission expiry and delivery grace-window expiry

Phase 12 progress notes:

- admin now has a real shell with dashboard, segmented queues, users, settings, and audit log surfaces instead of placeholders, while keeping the mobile information architecture lean and operational
- admin queue coverage now includes searchable payment proof, verification, dispute, payout, booking, and email operations with dead-letter review, safe resend controls, and overdue automation fallback visibility
- sensitive admin mutations now run through privileged RPC with typed client settings, constrained setting keys, recent step-up checks, resend feature-flag enforcement, and audit-log invalidation across related workflows
- shipper/bootstrap settings consumption now uses the typed `get_client_settings()` contract instead of raw internal setting reads, keeping client runtime behavior aligned with the controlled platform settings model
- supporting migration and contract coverage was added in `supabase/migrations/20260320120900_seed_runtime_and_feature_flag_settings.sql`, `supabase/migrations/20260320121000_create_typed_client_settings_rpc.sql`, `supabase/migrations/20260320121100_create_admin_operational_summary_rpc.sql`, `supabase/migrations/20260320121110_create_admin_platform_settings_rpc.sql`, `supabase/migrations/20260320121120_create_admin_profile_activation_rpc.sql`, `supabase/migrations/20260320121130_create_admin_email_retry_rpc.sql`, `test/contracts/supabase/admin_operations_contract_test.dart`, and `supabase/tests/runtime_security_test.sql`

## Phase 13 - Generated Documents

 - [x] Build server-side PDF generation pipeline for booking invoices
 - [x] Build payment receipt generation where applicable
 - [x] Build payout receipt/statement generation where applicable
 - [x] Store generated documents in private storage
 - [x] Build secure in-app document viewing/downloading flow
 - [x] Ensure email references to documents do not expose insecure public links

Phase 13 progress notes:

- generated document records now carry processing state, availability metadata, worker locks, and failure reasons through `supabase/migrations/20260320121200_track_generated_document_processing.sql`, `supabase/migrations/20260320121210_update_generated_document_record_helper.sql`, `supabase/migrations/20260320121220_add_generated_document_processing_locks.sql`, and `supabase/migrations/20260320121230_create_generated_document_processing_rpc.sql`
- scheduled automation now invokes a service-role generated document worker that renders invoice and receipt PDFs from canonical booking and payout data, uploads them to the private `generated-documents` bucket, and marks records ready or failed
- generated document completion now emits in-app notifications and queues transactional email using secure app routes instead of exposing file URLs
- shipper payment flows now show generated document readiness clearly, block pending and failed documents from opening, and keep secure access inside the product flow
- shared generated document routes now render ready PDFs in-app with secure signed URLs while still offering explicit browser and download actions when needed
- localization, auth error mapping, and contract coverage were extended for generated document readiness states and notifications

## Phase 14 - Hardening, Testing, And Release Readiness

### Automated Testing

- [x] Add unit tests for pricing, insurance, status transitions, locale formatting, and validation helpers
- [x] Add repository tests for key remote/local data flows
- [x] Add widget tests for forms, money summaries, timelines, and accessibility guidelines
- [ ] Add device-backed integration tests for auth, shipment -> search -> booking -> payment proof, carrier progress updates, admin verification, dispute handling, and theme/locale restore

### Security And Reliability

- [x] Validate RLS policies with role-specific test scenarios
- [x] Validate file upload restrictions and signed URL issuance
- [x] Validate audit logging for all sensitive actions
- [x] Validate rate limiting and abuse controls on high-risk endpoints
- [x] Validate email outbox dedupe, retry, dead-letter, and webhook reconciliation behavior
- [x] Validate transaction boundaries for booking, payment, dispute, payout, and outbox enqueue workflows

### Performance And Quality Gates

- [ ] Profile the app on a representative Android device in profile mode
- [ ] Fix repeated jank in search lists, tracking timelines, and admin queues
- [ ] Validate long-list lazy rendering and scroll-state preservation
- [ ] Measure Android app size and investigate major regressions
- [ ] Run manual accessibility checks with TalkBack and large text
- [ ] Run manual Arabic/French/English localization QA
- [ ] Validate shell navigation, back-stack behavior, and deep links for shared above-shell detail routes
- [ ] Validate that microflows use sheets/dialogs/inline states instead of unnecessary full pages
- [ ] Validate pagination/cursoring behavior for search, notifications, timelines, reviews, and admin queues
- [x] Resolve CI-capable integration coverage for the documented critical flows

Phase 14 progress notes:

- pricing calculation and shared field validation helpers now live in reusable application/shared helpers with direct unit coverage instead of remaining embedded inside screens
- phase 14 test coverage now includes pricing, validation, repository mapping, executed Supabase runtime security and email tests, shared settings smoke coverage, and CI-capable critical workflow coverage in `test/critical_workflow_flows_test.dart`
- shared settings now expose support and production policy surfaces directly, keeping legal and support entry points reachable from one shared route cluster
- crash reporting now records through the existing logger path in both disabled and deferred modes so uncaught errors are still observable during release hardening
- notifications now load through explicit paged repository/controller state with refresh and load-more behavior instead of a single shallow bounded fetch
- CI-capable cross-feature flow coverage now exists in `test/critical_workflow_flows_test.dart` for startup theme-locale restoration, shipper booking-payment state, carrier milestone progression, and admin queue refresh behavior
- testers now have a real push-delivery path through Firebase client registration plus the scheduled FCM HTTP v1 worker, subject to environment secrets being configured
- dispute creation now supports private evidence attachments with secure signed access from admin review flows
- Android Firebase client wiring now prefers checked-in FlutterFire options while server push auth is handled separately through a service-account secret in the Edge runtime

## Phase 15 - Staging Launch And Production Readiness

- [ ] Set up staging Supabase project and transactional email provider staging/test configuration
- [ ] Seed staging reference data and platform settings
- [ ] Run end-to-end staging rehearsals for shipper, carrier, and admin flows
- [ ] Verify support email routing and operational playbooks
- [ ] Verify payout and refund operational procedure with test data
- [ ] Verify scheduled/background automation works reliably on the actual Supabase plan or document the operational fallback
- [ ] Review release checklist, monitoring checklist, and rollback plan
- [ ] Prepare Android production rollout
- [ ] Keep iOS config and version policy ready even if public rollout remains disabled

### CI/CD, GitHub, And Release Management

- [ ] Configure the single long-lived protected branch workflow in GitHub
- [ ] Define branch naming, tag naming, and changelog conventions
- [ ] Create GitHub Actions workflows for Flutter quality checks and build validation
- [ ] Create GitHub Actions workflows for controlled Supabase migration/function deployment validation
- [ ] Create staging deployment workflow and release-candidate workflow
- [ ] Ensure every release artifact is traceable to commit SHA and tag
- [ ] Define mobile versioning rules for app version, Android `versionCode`, and iOS `buildNumber`
- [ ] Define rollback procedure for app release and backend deployment failures
- [ ] Define user-facing GitHub README and GitHub Releases writing guidelines

### Compliance And Legal Surfaces

- [x] Implement user-facing Terms, Privacy, payment disclosure, and dispute policy surfaces before production launch

Phase 15 progress notes:

- GitHub Actions workflow scaffolding now covers Flutter quality gates, Supabase validation, and a manual staging or release-candidate verification entry point
- release operations are now documented in `docs/13-release-operations.md`, including branch/tag conventions, versioning rules, staging gates, release-candidate checks, monitoring, and rollback expectations
- Android release configuration now prefers explicit release signing credentials while still falling back to debug signing for local-only release runs until secrets are supplied
- README and environment example files now reflect the baseline production env shape more accurately, including required push/email worker secrets and optional FlutterFire override posture

## Phase 16 - Post-Launch Stabilization

- [ ] Monitor booking, payment, dispute, payout, and email health metrics daily after launch
- [ ] Triage dead-letter email jobs and bounced addresses
- [ ] Review carrier verification bottlenecks and payment review bottlenecks
- [ ] Review search quality and no-result patterns from real usage
- [ ] Review support contact patterns and update templates/copy where needed
- [ ] Schedule the first backlog of improvements without changing canonical domain truth casually

Phase 16 progress notes:

- post-launch stabilization cadence is now documented in `docs/14-post-launch-stabilization.md`, covering daily health review, weekly trend review, support/copy updates, and backlog discipline
- crash reporting hooks now emit structured logger output so post-launch investigations can inspect uncaught framework and platform failures even before a third-party sink is connected

## Cross-Phase Definition Of Done

A major feature area is only done when all are true:

- [ ] domain rules match the canonical docs
- [ ] UI matches the approved UX and localization rules
- [ ] security/RLS rules are implemented and verified
- [ ] auditability is in place for sensitive operations
- [ ] automated tests cover the critical path
- [ ] staging verification has been completed where applicable
