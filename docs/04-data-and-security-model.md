# FleetFill Data And Security Model

## 1. Data Model Goals

The data model must support:

- one canonical source of truth for workflow state
- immutable commercial snapshots
- immutable financial ledger events
- auditable verification decisions
- private sensitive files
- future feature growth without schema rewrites

## 2. Core Tables

### 2.1 `profiles`

Purpose: one row per authenticated user.

Recommended fields:

- `id uuid pk`
- `role text check in ('shipper','carrier','admin')`
- `full_name text`
- `phone_number text null`
- `email text`
- `company_name text null`
- `avatar_url text null`
- `is_active boolean default true`
- `verification_status text check in ('pending','verified','rejected')`
- `verification_rejection_reason text null`
- `rating_average numeric null`
- `rating_count integer default 0`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.2 `vehicles`

Purpose: carrier truck records.

Recommended fields:

- `id uuid pk`
- `carrier_id uuid fk -> profiles.id`
- `plate_number text`
- `vehicle_type text`
- `capacity_weight_kg numeric`
- `capacity_volume_m3 numeric null`
- `verification_status text check in ('pending','verified','rejected')`
- `verification_rejection_reason text null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.3 `payout_accounts`

Purpose: carrier payout destination.

Supported `account_type` values:

- `ccp`
- `dahabia`
- `bank`

Recommended fields:

- `id uuid pk`
- `carrier_id uuid fk -> profiles.id`
- `account_type text`
- `account_holder_name text`
- `account_identifier text`
- `bank_or_ccp_name text null`
- `is_active boolean default true`
- `is_verified boolean default false`
- `verified_at timestamptz null`
- `created_at timestamptz`
- `updated_at timestamptz`

Only one active payout account should be used operationally at a time.

Recommended constraint:

- partial unique index enforcing at most one active payout account per carrier

### 2.3.1 `platform_payment_accounts`

Purpose: FleetFill-controlled inbound payment destinations shown to shippers.

Recommended fields:

- `id uuid pk`
- `payment_rail text check in ('ccp','dahabia','bank')`
- `display_name text`
- `account_identifier text`
- `account_holder_name text null`
- `environment text check in ('staging','production')`
- `is_active boolean default true`
- `instructions_text text null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.4 `verification_documents`

Purpose: auditable document store for profile and vehicle verification.

Recommended fields:

- `id uuid pk`
- `owner_profile_id uuid fk -> profiles.id`
- `entity_type text check in ('profile','vehicle')`
- `entity_id uuid`
- `document_type text`
- `storage_path text`
- `status text check in ('pending','verified','rejected')`
- `rejection_reason text null`
- `reviewed_by uuid null fk -> profiles.id`
- `reviewed_at timestamptz null`
- `expires_at timestamptz null`
- `version integer default 1`
- `created_at timestamptz`
- `updated_at timestamptz`

Required current document types:

- `driver_identity_or_license`
- `truck_registration`
- `truck_insurance`
- `truck_technical_inspection`
- `transport_license`

### 2.5 `routes`

Purpose: recurring carrier lanes.

Recommended fields:

- `id uuid pk`
- `carrier_id uuid fk -> profiles.id`
- `vehicle_id uuid fk -> vehicles.id`
- `origin_commune_id integer`
- `destination_commune_id integer`
- `total_capacity_kg numeric`
- `price_per_kg_dzd numeric`
- `default_departure_time time`
- `recurring_days_of_week integer[]`
- `effective_from timestamptz`
- `is_active boolean`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.6 `oneoff_trips`

Purpose: non-recurring trips.

Recommended fields:

- `id uuid pk`
- `carrier_id uuid fk -> profiles.id`
- `vehicle_id uuid fk -> vehicles.id`
- `origin_commune_id integer`
- `destination_commune_id integer`
- `departure_at timestamptz`
- `total_capacity_kg numeric`
- `total_capacity_volume_m3 numeric null`
- `price_per_kg_dzd numeric`
- `is_active boolean`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.6.1 `route_revisions`

Purpose: future-effective revisions for recurring routes without rewriting committed bookings.

Recommended fields:

- `id uuid pk`
- `route_id uuid fk -> routes.id`
- `vehicle_id uuid fk -> vehicles.id`
- `total_capacity_kg numeric`
- `total_capacity_volume_m3 numeric null`
- `price_per_kg_dzd numeric`
- `default_departure_time time`
- `recurring_days_of_week integer[]`
- `effective_from timestamptz`
- `created_by uuid null fk -> profiles.id`
- `created_at timestamptz`

### 2.7 `shipments`

Purpose: one customer shipment request.

Recommended fields:

- `id uuid pk`
- `shipper_id uuid fk -> profiles.id`
- `origin_commune_id integer`
- `destination_commune_id integer`
- `pickup_window_start timestamptz`
- `pickup_window_end timestamptz`
- `total_weight_kg numeric`
- `total_volume_m3 numeric null`
- `category text`
- `description text null`
- `status text check in ('draft','booked','cancelled')`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.8 `shipment_items`

Purpose: multiple boxes or item groups inside one shipment.

Recommended fields:

- `id uuid pk`
- `shipment_id uuid fk -> shipments.id`
- `label text`
- `quantity integer`
- `weight_kg numeric null`
- `volume_m3 numeric null`
- `notes text null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.9 `bookings`

Purpose: one shipment bound to one route-date or one-off trip.

Recommended fields:

- `id uuid pk`
- `shipment_id uuid unique fk -> shipments.id`
- `route_id uuid null fk -> routes.id`
- `route_departure_date date null`
- `oneoff_trip_id uuid null fk -> oneoff_trips.id`
- `shipper_id uuid fk -> profiles.id`
- `carrier_id uuid fk -> profiles.id`
- `vehicle_id uuid fk -> vehicles.id`
- `weight_kg numeric`
- `volume_m3 numeric null`
- `price_per_kg_dzd numeric`
- `base_price_dzd numeric`
- `platform_fee_dzd numeric`
- `carrier_fee_dzd numeric`
- `insurance_rate numeric null`
- `insurance_fee_dzd numeric default 0`
- `tax_fee_dzd numeric default 0`
- `shipper_total_dzd numeric`
- `carrier_payout_dzd numeric`
- `booking_status text`
- `payment_status text`
- `tracking_number text unique`
- `payment_reference text unique`
- `confirmed_at timestamptz null`
- `picked_up_at timestamptz null`
- `delivered_at timestamptz null`
- `delivery_confirmed_at timestamptz null`
- `completed_at timestamptz null`
- `cancelled_at timestamptz null`
- `disputed_at timestamptz null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.10 `payment_proofs`

Purpose: submitted evidence for external payment.

Recommended fields:

- `id uuid pk`
- `booking_id uuid fk -> bookings.id`
- `storage_path text`
- `payment_rail text check in ('ccp','dahabia','bank')`
- `submitted_reference text null`
- `submitted_amount_dzd numeric`
- `verified_amount_dzd numeric null`
- `verified_reference text null`
- `status text check in ('pending','verified','rejected')`
- `rejection_reason text null`
- `reviewed_by uuid null fk -> profiles.id`
- `submitted_at timestamptz`
- `reviewed_at timestamptz null`
- `decision_note text null`
- `version integer default 1`
- `created_at timestamptz`

Latest proof status should drive the booking payment review flow.

Amount verification rule:

- the verified payment amount must match the expected booking amount exactly
- underpayment and overpayment are both rejected with a reason in the canonical flow

### 2.11 `tracking_events`

Purpose: append-only shipment and settlement timeline.

Recommended fields:

- `id uuid pk`
- `booking_id uuid fk -> bookings.id`
- `event_type text`
- `visibility text check in ('internal','user_visible')`
- `note text null`
- `created_by uuid null fk -> profiles.id`
- `recorded_at timestamptz`
- `created_at timestamptz`

### 2.12 `carrier_reviews`

Purpose: one review per completed booking.

Recommended fields:

- `id uuid pk`
- `booking_id uuid unique fk -> bookings.id`
- `carrier_id uuid fk -> profiles.id`
- `shipper_id uuid fk -> profiles.id`
- `score integer`
- `comment text null`
- `created_at timestamptz`

### 2.13 `financial_ledger_entries`

Purpose: immutable money movement ledger.

Recommended fields:

- `id uuid pk`
- `booking_id uuid fk -> bookings.id`
- `entry_type text`
- `direction text check in ('debit','credit')`
- `amount_dzd numeric`
- `actor_type text`
- `reference text null`
- `notes text null`
- `created_by uuid null fk -> profiles.id`
- `occurred_at timestamptz`
- `created_at timestamptz`

Recommended `entry_type` values include:

- `payment_secured`
- `payment_rejected`
- `refund_sent`
- `carrier_payout_sent`
- `platform_fee_recorded`
- `insurance_fee_recorded`

### 2.13.1 `disputes`

Purpose: auditable case records for delivery review challenges.

Recommended fields:

- `id uuid pk`
- `booking_id uuid unique fk -> bookings.id`
- `opened_by uuid fk -> profiles.id`
- `reason text`
- `description text null`
- `status text check in ('open','resolved')`
- `resolution text null`
- `resolution_note text null`
- `resolved_by uuid null fk -> profiles.id`
- `resolved_at timestamptz null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.13.2 `refunds`

Purpose: auditable records of money returned to shippers.

Recommended fields:

- `id uuid pk`
- `booking_id uuid fk -> bookings.id`
- `dispute_id uuid null fk -> disputes.id`
- `amount_dzd numeric`
- `status text check in ('pending','sent','failed','cancelled')`
- `reason text`
- `external_reference text null`
- `processed_by uuid null fk -> profiles.id`
- `processed_at timestamptz null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.13.3 `payouts`

Purpose: auditable records of carrier settlement.

Recommended fields:

- `id uuid pk`
- `booking_id uuid unique fk -> bookings.id`
- `carrier_id uuid fk -> profiles.id`
- `payout_account_id uuid fk -> payout_accounts.id`
- `payout_account_snapshot jsonb`
- `amount_dzd numeric`
- `status text check in ('pending','sent','failed','cancelled')`
- `external_reference text null`
- `processed_by uuid null fk -> profiles.id`
- `processed_at timestamptz null`
- `failure_reason text null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.14 `generated_documents`

Purpose: immutable PDFs generated by FleetFill from canonical data.

Recommended fields:

- `id uuid pk`
- `booking_id uuid null fk -> bookings.id`
- `document_type text`
- `storage_path text`
- `version integer default 1`
- `generated_by uuid null fk -> profiles.id`
- `created_at timestamptz`

Recommended `document_type` values include:

- `booking_invoice`
- `payment_receipt`
- `payout_receipt`

### 2.15 `email_delivery_logs`

Purpose: audit and operational visibility for transactional email delivery.

Recommended fields:

- `id uuid pk`
- `profile_id uuid null fk -> profiles.id`
- `booking_id uuid null fk -> bookings.id`
- `template_key text`
- `locale text`
- `recipient_email text`
- `subject_preview text null`
- `provider_message_id text null`
- `status text`
- `provider text`
- `attempt_count integer default 0`
- `last_attempt_at timestamptz null`
- `next_retry_at timestamptz null`
- `last_error_at timestamptz null`
- `error_code text null`
- `error_message text null`
- `payload_snapshot jsonb null`
- `created_at timestamptz`
- `updated_at timestamptz`

This table is for operational logging, not marketing CRM behavior.

Recommended `status` values:

- `queued`
- `sending`
- `sent`
- `delivered`
- `opened`
- `clicked`
- `soft_failed`
- `hard_failed`
- `bounced`
- `suppressed`

Recommended usage:

- one row per provider-attempt or provider-event lifecycle item
- append new rows for meaningful provider state changes instead of mutating history away
- use `payload_snapshot` only for safe, non-secret rendered variables and metadata needed for troubleshooting

### 2.16 `email_outbox_jobs`

Purpose: durable queue for transactional email work before or during delivery attempts.

Recommended fields:

- `id uuid pk`
- `event_key text`
- `dedupe_key text unique`
- `profile_id uuid null fk -> profiles.id`
- `booking_id uuid null fk -> bookings.id`
- `template_key text`
- `locale text`
- `recipient_email text`
- `priority text`
- `status text`
- `attempt_count integer default 0`
- `max_attempts integer default 5`
- `available_at timestamptz`
- `locked_at timestamptz null`
- `locked_by text null`
- `last_error_code text null`
- `last_error_message text null`
- `payload_snapshot jsonb null`
- `created_at timestamptz`
- `updated_at timestamptz`

Recommended `status` values:

- `queued`
- `processing`
- `sent_to_provider`
- `retry_scheduled`
- `dead_letter`
- `cancelled`

Rules:

- the outbox is the durable source of pending email work
- `dedupe_key` prevents duplicate sends for the same logical email event
- workers must claim jobs atomically
- terminal failures move to `dead_letter` instead of infinite retry

### 2.17 `notifications`

Purpose: in-app delivery and notification history.

Recommended fields:

- `id uuid pk`
- `profile_id uuid fk -> profiles.id`
- `type text`
- `title text`
- `body text`
- `data jsonb null`
- `is_read boolean default false`
- `created_at timestamptz`
- `read_at timestamptz null`

### 2.18 `user_devices`

Purpose: device tokens for push notifications.

Recommended fields:

- `id uuid pk`
- `profile_id uuid fk -> profiles.id`
- `push_token text`
- `platform text`
- `locale text null`
- `last_seen_at timestamptz null`
- `created_at timestamptz`
- `updated_at timestamptz`

### 2.19 `platform_settings`

Purpose: internal settings source of truth.

Recommended fields:

- `key text pk`
- `value jsonb`
- `is_public boolean default false`
- `description text null`
- `updated_by uuid null fk -> profiles.id`
- `updated_at timestamptz`

### 2.20 `admin_audit_logs`

Purpose: immutable audit trail for sensitive admin actions.

Recommended fields:

- `id uuid pk`
- `actor_id uuid null fk -> profiles.id`
- `actor_role text`
- `action text`
- `target_type text`
- `target_id uuid null`
- `outcome text`
- `reason text null`
- `correlation_id text null`
- `metadata jsonb null`
- `created_at timestamptz`

### 2.21 `wilayas` and `communes`

Purpose: Algeria location seed tables sourced from `docs/wilayas-with-municipalities.json`.

Import rules:

- keep the source JSON unchanged
- import `nameFr` into the generic Latin display field `name`
- import `nameAr` into `name_ar`
- use database IDs and codes as the canonical references in shipments, routes, and trips
- client UI may choose between `name` and `name_ar` at render time based on locale

## 3. Data Integrity Rules

- one shipment can have only one booking
- one booking must reference exactly one route instance or one one-off trip
- booking commercial amounts are immutable after creation
- status fields never replace the ledger
- sensitive files are private
- proof and document history is retained
- append-only entities must be technically enforced, not only documented

Append-only entities:

- `payment_proofs`
- `verification_documents`
- `tracking_events`
- `financial_ledger_entries`
- `admin_audit_logs`

Recommended database constraints:

- check constraint enforcing exactly one of `route_id` or `oneoff_trip_id` on `bookings`
- partial unique constraint enforcing at most one active payout account per carrier
- immutable or append-only trigger protection on audit, ledger, tracking, proof, and verification history tables

## 4. Security Model

### 4.1 RLS Philosophy

Enable RLS on all public tables.

RLS must be deny-by-default. Every table and sensitive storage path must have explicit access rules.

### 4.2 Access Rules

Shippers:

- read and update own profile
- create and manage own shipments before booking
- read own bookings, proofs, notifications, and reviews they authored

Carriers:

- read and update own profile
- manage own vehicles, documents, payout accounts, routes, and one-off trips
- read own bookings and related tracking events

Admins:

- read and manage all operational entities required for review, payout, dispute, and audit workflows

Service-role and server-controlled rules:

- service-role credentials must never be shipped in the client
- service-role access is restricted to server-side functions, secure jobs, and controlled operational scripts
- critical financial and verification mutations must re-check authorization server-side even if the client UI is already role-gated

### 4.3 Sensitive File Access

- no public buckets
- no public signed URLs created directly by client
- access granted only through controlled signed URL generation

Signed URL rules:

- short expiry
- authorization checked at issuance time
- no persistent storage of signed URLs in app data or logs
- replacement or version rotation invalidates old file access paths where practical

### 4.4 Input Validation And Abuse Controls

- enforce centralized schema validation for server-controlled mutations
- allow only known enums, lengths, and numeric ranges
- normalize phone numbers, payment references, and plate values before persistence
- reject unknown fields in sensitive write payloads
- rate-limit high-risk flows such as login, booking creation, proof finalization, signed URL issuance, and dispute creation
- add abuse monitoring for repeated failed auth, repeated proof rejection, and suspicious dispute or upload activity

### 4.5 Error And Audit Rules

- external error messages must not leak raw database errors, storage paths, signed URLs, or privileged internals
- internal logs should use structured correlation IDs for support and incident tracing
- audit records should include actor, role, target entity, action, outcome, and reason where applicable

### 4.6 Email Security Rules

- transactional email provider API keys must remain server-side only
- outbound email payloads must be built from validated server data
- templates must avoid exposing internal-only identifiers or sensitive operational notes
- delivery logs must not store secrets or signed URLs
- bounced or failed addresses should be observable so support can react appropriately
- queue workers must treat the outbox as trusted internal data only and must not accept arbitrary client-supplied template instructions

## 5. Why Settings Should Not Be Raw Client Reads

The client should not depend on the internal storage shape of `platform_settings`.

Expose a typed settings response instead, with only public keys such as:

- search window
- fee settings needed by the client
- insurance minimum and rate
- platform maintenance state
- version rules per platform

## 6. Indexing Priorities

High-priority indexes:

- route origin/destination
- trip departure time/date
- bookings by shipper
- bookings by carrier
- bookings by booking status
- bookings by payment status
- proofs by booking and status
- documents by entity and status
- ledger by booking and occurred time
- email outbox by status and available time
- email logs by recipient, template, and provider status
