-- Consolidated dev-phase layer migration: 20260317010000_create_foundation_layer.sql
-- Generated from historical dev-only migrations during local rebaseline work.

-- >>> BEGIN 20260317143000_create_base_types_and_triggers.sql
create extension if not exists pgcrypto;

do $$ begin
  create type public.app_role as enum ('shipper', 'carrier', 'admin');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.verification_status as enum ('pending', 'verified', 'rejected');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.payment_rail as enum ('ccp', 'dahabia', 'bank');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.platform_environment as enum ('staging', 'production');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.verification_document_entity_type as enum ('profile', 'vehicle');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.shipment_status as enum ('draft', 'booked', 'cancelled');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.booking_status as enum (
    'pending_payment',
    'payment_under_review',
    'confirmed',
    'picked_up',
    'in_transit',
    'delivered_pending_review',
    'completed',
    'cancelled',
    'disputed'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.payment_status as enum (
    'unpaid',
    'proof_submitted',
    'under_verification',
    'secured',
    'rejected',
    'refunded',
    'released_to_carrier'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.tracking_event_visibility as enum ('internal', 'user_visible');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.ledger_direction as enum ('debit', 'credit');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.dispute_status as enum ('open', 'resolved');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.transfer_status as enum ('pending', 'sent', 'failed', 'cancelled');
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.email_delivery_status as enum (
    'queued',
    'sending',
    'sent',
    'delivered',
    'opened',
    'clicked',
    'render_failed',
    'soft_failed',
    'hard_failed',
    'bounced',
    'suppressed'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.email_outbox_status as enum (
    'queued',
    'processing',
    'sent_to_provider',
    'retry_scheduled',
    'dead_letter',
    'cancelled'
  );
exception
  when duplicate_object then null;
end $$;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
-- <<< END 20260317143000_create_base_types_and_triggers.sql

-- >>> BEGIN 20260317143100_create_reference_location_tables.sql
create table if not exists public.wilayas (
  id integer primary key,
  name text not null,
  name_ar text not null
);

create table if not exists public.communes (
  id integer primary key,
  wilaya_id integer not null references public.wilayas (id),
  name text not null,
  name_ar text not null
);
-- <<< END 20260317143100_create_reference_location_tables.sql

-- >>> BEGIN 20260317143200_create_marketplace_core_tables.sql
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  role public.app_role,
  full_name text,
  phone_number text,
  email text not null,
  company_name text,
  avatar_url text,
  preferred_locale text not null default 'ar',
  is_active boolean not null default true,
  verification_status public.verification_status not null default 'pending',
  verification_rejection_reason text,
  rating_average numeric,
  rating_count integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.vehicles (
  id uuid primary key default gen_random_uuid(),
  carrier_id uuid not null references public.profiles (id) on delete cascade,
  plate_number text not null,
  vehicle_type text not null,
  capacity_weight_kg numeric not null,
  capacity_volume_m3 numeric,
  verification_status public.verification_status not null default 'pending',
  verification_rejection_reason text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payout_accounts (
  id uuid primary key default gen_random_uuid(),
  carrier_id uuid not null references public.profiles (id) on delete cascade,
  account_type public.payment_rail not null,
  account_holder_name text not null,
  account_identifier text not null,
  bank_or_ccp_name text,
  is_active boolean not null default true,
  is_verified boolean not null default false,
  verified_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.platform_payment_accounts (
  id uuid primary key default gen_random_uuid(),
  payment_rail public.payment_rail not null,
  display_name text not null,
  account_identifier text not null,
  account_holder_name text,
  environment public.platform_environment not null,
  is_active boolean not null default true,
  instructions_text text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.verification_documents (
  id uuid primary key default gen_random_uuid(),
  owner_profile_id uuid not null references public.profiles (id) on delete cascade,
  entity_type public.verification_document_entity_type not null,
  entity_id uuid not null,
  document_type text not null,
  storage_path text not null,
  status public.verification_status not null default 'pending',
  rejection_reason text,
  reviewed_by uuid references public.profiles (id),
  reviewed_at timestamptz,
  expires_at timestamptz,
  version integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.routes (
  id uuid primary key default gen_random_uuid(),
  carrier_id uuid not null references public.profiles (id) on delete cascade,
  vehicle_id uuid not null references public.vehicles (id),
  origin_commune_id integer not null references public.communes (id),
  destination_commune_id integer not null references public.communes (id),
  total_capacity_kg numeric not null,
  price_per_kg_dzd numeric not null,
  default_departure_time time not null,
  recurring_days_of_week integer[] not null,
  effective_from timestamptz not null,
  is_active boolean not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.route_departure_instances (
  id uuid primary key default gen_random_uuid(),
  route_id uuid not null references public.routes (id) on delete cascade,
  departure_date date not null,
  vehicle_id uuid not null references public.vehicles (id),
  total_capacity_kg numeric not null,
  reserved_capacity_kg numeric not null default 0,
  remaining_capacity_kg numeric not null,
  total_capacity_volume_m3 numeric,
  reserved_volume_m3 numeric,
  remaining_volume_m3 numeric,
  status text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.oneoff_trips (
  id uuid primary key default gen_random_uuid(),
  carrier_id uuid not null references public.profiles (id) on delete cascade,
  vehicle_id uuid not null references public.vehicles (id),
  origin_commune_id integer not null references public.communes (id),
  destination_commune_id integer not null references public.communes (id),
  departure_at timestamptz not null,
  total_capacity_kg numeric not null,
  total_capacity_volume_m3 numeric,
  price_per_kg_dzd numeric not null,
  is_active boolean not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.route_revisions (
  id uuid primary key default gen_random_uuid(),
  route_id uuid not null references public.routes (id) on delete cascade,
  vehicle_id uuid not null references public.vehicles (id),
  total_capacity_kg numeric not null,
  total_capacity_volume_m3 numeric,
  price_per_kg_dzd numeric not null,
  default_departure_time time not null,
  recurring_days_of_week integer[] not null,
  effective_from timestamptz not null,
  created_by uuid references public.profiles (id),
  created_at timestamptz not null default now()
);

create table if not exists public.shipments (
  id uuid primary key default gen_random_uuid(),
  shipper_id uuid not null references public.profiles (id) on delete cascade,
  origin_commune_id integer not null references public.communes (id),
  destination_commune_id integer not null references public.communes (id),
  total_weight_kg numeric not null,
  total_volume_m3 numeric,
  description text,
  status public.shipment_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  shipment_id uuid not null unique references public.shipments (id) on delete cascade,
  route_id uuid references public.routes (id),
  route_departure_date date,
  oneoff_trip_id uuid references public.oneoff_trips (id),
  shipper_id uuid not null references public.profiles (id),
  carrier_id uuid not null references public.profiles (id),
  vehicle_id uuid not null references public.vehicles (id),
  weight_kg numeric not null,
  volume_m3 numeric,
  price_per_kg_dzd numeric not null,
  base_price_dzd numeric not null,
  platform_fee_dzd numeric not null,
  carrier_fee_dzd numeric not null,
  insurance_rate numeric,
  insurance_fee_dzd numeric not null default 0,
  tax_fee_dzd numeric not null default 0,
  shipper_total_dzd numeric not null,
  carrier_payout_dzd numeric not null,
  booking_status public.booking_status not null default 'pending_payment',
  payment_status public.payment_status not null default 'unpaid',
  tracking_number text not null unique,
  payment_reference text not null unique,
  confirmed_at timestamptz,
  picked_up_at timestamptz,
  delivered_at timestamptz,
  delivery_confirmed_at timestamptz,
  completed_at timestamptz,
  cancelled_at timestamptz,
  disputed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.bookings
drop constraint if exists bookings_exactly_one_capacity_source;

alter table public.bookings
add constraint bookings_exactly_one_capacity_source
check (
  ((route_id is not null)::integer + (oneoff_trip_id is not null)::integer) = 1
);

create table if not exists public.payment_proofs (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  storage_path text not null,
  payment_rail public.payment_rail not null,
  submitted_reference text,
  submitted_amount_dzd numeric not null,
  verified_amount_dzd numeric,
  verified_reference text,
  status public.verification_status not null default 'pending',
  rejection_reason text,
  reviewed_by uuid references public.profiles (id),
  submitted_at timestamptz not null,
  reviewed_at timestamptz,
  decision_note text,
  version integer not null default 1,
  created_at timestamptz not null default now()
);

create table if not exists public.tracking_events (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  event_type text not null,
  visibility public.tracking_event_visibility not null,
  note text,
  created_by uuid references public.profiles (id),
  recorded_at timestamptz not null,
  created_at timestamptz not null default now()
);

create table if not exists public.carrier_reviews (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null unique references public.bookings (id) on delete cascade,
  carrier_id uuid not null references public.profiles (id),
  shipper_id uuid not null references public.profiles (id),
  score integer not null,
  comment text,
  created_at timestamptz not null default now()
);
-- <<< END 20260317143200_create_marketplace_core_tables.sql

-- >>> BEGIN 20260317143300_create_finance_and_disputes_tables.sql
create table if not exists public.financial_ledger_entries (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  entry_type text not null,
  direction public.ledger_direction not null,
  amount_dzd numeric not null,
  actor_type text not null,
  reference text,
  notes text,
  created_by uuid references public.profiles (id),
  occurred_at timestamptz not null,
  created_at timestamptz not null default now()
);

create table if not exists public.disputes (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null unique references public.bookings (id) on delete cascade,
  opened_by uuid not null references public.profiles (id),
  reason text not null,
  description text,
  status public.dispute_status not null default 'open',
  resolution text,
  resolution_note text,
  resolved_by uuid references public.profiles (id),
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.refunds (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null references public.bookings (id) on delete cascade,
  dispute_id uuid references public.disputes (id) on delete set null,
  amount_dzd numeric not null,
  status public.transfer_status not null default 'pending',
  reason text not null,
  external_reference text,
  processed_by uuid references public.profiles (id),
  processed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payouts (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid not null unique references public.bookings (id) on delete cascade,
  carrier_id uuid not null references public.profiles (id),
  payout_account_id uuid not null references public.payout_accounts (id),
  payout_account_snapshot jsonb not null,
  amount_dzd numeric not null,
  status public.transfer_status not null default 'pending',
  external_reference text,
  processed_by uuid references public.profiles (id),
  processed_at timestamptz,
  failure_reason text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.generated_documents (
  id uuid primary key default gen_random_uuid(),
  booking_id uuid references public.bookings (id) on delete cascade,
  document_type text not null,
  storage_path text not null,
  version integer not null default 1,
  generated_by uuid references public.profiles (id),
  created_at timestamptz not null default now()
);
-- <<< END 20260317143300_create_finance_and_disputes_tables.sql

-- >>> BEGIN 20260317143400_create_communications_and_platform_tables.sql
create table if not exists public.email_delivery_logs (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references public.profiles (id) on delete set null,
  booking_id uuid references public.bookings (id) on delete set null,
  template_key text not null,
  template_language_code text,
  locale text not null,
  recipient_email text not null,
  subject_preview text,
  provider_message_id text,
  status public.email_delivery_status not null default 'queued',
  provider text not null,
  attempt_count integer not null default 0,
  last_attempt_at timestamptz,
  next_retry_at timestamptz,
  last_error_at timestamptz,
  error_code text,
  error_message text,
  payload_snapshot jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.email_outbox_jobs (
  id uuid primary key default gen_random_uuid(),
  event_key text not null,
  dedupe_key text not null unique,
  profile_id uuid references public.profiles (id) on delete set null,
  booking_id uuid references public.bookings (id) on delete set null,
  template_key text not null,
  template_language_code text,
  locale text not null,
  recipient_email text not null,
  priority text not null,
  status public.email_outbox_status not null default 'queued',
  attempt_count integer not null default 0,
  max_attempts integer not null default 5,
  available_at timestamptz not null,
  locked_at timestamptz,
  locked_by text,
  last_error_code text,
  last_error_message text,
  payload_snapshot jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.email_templates (
  id uuid primary key default gen_random_uuid(),
  template_key text not null,
  language_code text not null,
  subject_template text not null,
  html_template text not null,
  text_template text not null,
  sample_payload jsonb not null default '{}'::jsonb,
  description text,
  is_enabled boolean not null default true,
  updated_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint email_templates_language_code_check
    check (char_length(trim(language_code)) > 0),
  constraint email_templates_key_language_unique
    unique (template_key, language_code)
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  type text not null,
  title text not null,
  body text not null,
  data jsonb,
  is_read boolean not null default false,
  created_at timestamptz not null default now(),
  read_at timestamptz
);

create table if not exists public.user_devices (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  push_token text not null,
  platform text not null,
  locale text,
  last_seen_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.platform_settings (
  key text primary key,
  value jsonb not null,
  is_public boolean not null default false,
  description text,
  updated_by uuid references public.profiles (id),
  updated_at timestamptz not null default now()
);

create table if not exists public.admin_audit_logs (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles (id),
  actor_role public.app_role,
  action text not null,
  target_type text not null,
  target_id uuid,
  outcome text not null,
  reason text,
  correlation_id text,
  metadata jsonb,
  created_at timestamptz not null default now()
);

create unique index if not exists payout_accounts_one_active_per_carrier_idx
on public.payout_accounts (carrier_id)
where is_active;

create index if not exists communes_wilaya_id_idx
on public.communes (wilaya_id);

create index if not exists profiles_role_idx
on public.profiles (role);

create index if not exists profiles_verification_status_idx
on public.profiles (verification_status);

create index if not exists vehicles_carrier_id_idx
on public.vehicles (carrier_id);

create index if not exists vehicles_verification_status_idx
on public.vehicles (verification_status);

create index if not exists payout_accounts_carrier_id_idx
on public.payout_accounts (carrier_id);

create index if not exists payout_accounts_is_active_idx
on public.payout_accounts (is_active);

create index if not exists platform_payment_accounts_environment_is_active_idx
on public.platform_payment_accounts (environment, is_active);

create index if not exists verification_documents_owner_profile_id_idx
on public.verification_documents (owner_profile_id);

create index if not exists verification_documents_entity_lookup_idx
on public.verification_documents (entity_type, entity_id);

create index if not exists verification_documents_status_idx
on public.verification_documents (status);

create index if not exists routes_lane_lookup_idx
on public.routes (origin_commune_id, destination_commune_id);

create index if not exists routes_carrier_id_idx
on public.routes (carrier_id);

create index if not exists routes_vehicle_id_idx
on public.routes (vehicle_id);

create index if not exists oneoff_trips_lane_departure_idx
on public.oneoff_trips (origin_commune_id, destination_commune_id, departure_at);

create index if not exists oneoff_trips_carrier_id_idx
on public.oneoff_trips (carrier_id);

create index if not exists route_departure_instances_route_date_idx
on public.route_departure_instances (route_id, departure_date);

create index if not exists shipments_shipper_id_idx
on public.shipments (shipper_id);

create index if not exists shipments_status_idx
on public.shipments (status);

create index if not exists bookings_shipper_id_idx
on public.bookings (shipper_id);

create index if not exists bookings_carrier_id_idx
on public.bookings (carrier_id);

create index if not exists bookings_booking_status_idx
on public.bookings (booking_status);

create index if not exists bookings_payment_status_idx
on public.bookings (payment_status);

create index if not exists bookings_route_lookup_idx
on public.bookings (route_id, route_departure_date)
where route_id is not null;

create index if not exists bookings_oneoff_trip_id_idx
on public.bookings (oneoff_trip_id)
where oneoff_trip_id is not null;

create index if not exists payment_proofs_booking_id_status_idx
on public.payment_proofs (booking_id, status);

create index if not exists tracking_events_booking_recorded_at_idx
on public.tracking_events (booking_id, recorded_at desc);

create index if not exists carrier_reviews_carrier_id_idx
on public.carrier_reviews (carrier_id);

create index if not exists financial_ledger_entries_booking_occurred_at_idx
on public.financial_ledger_entries (booking_id, occurred_at desc);

create index if not exists disputes_status_idx
on public.disputes (status);

create index if not exists refunds_booking_id_idx
on public.refunds (booking_id);

create index if not exists payouts_carrier_id_status_idx
on public.payouts (carrier_id, status);

create index if not exists generated_documents_booking_id_idx
on public.generated_documents (booking_id);

create index if not exists email_delivery_logs_recipient_template_status_idx
on public.email_delivery_logs (recipient_email, template_key, status);

create index if not exists email_outbox_jobs_status_available_at_idx
on public.email_outbox_jobs (status, available_at);

create index if not exists email_templates_lookup_idx
on public.email_templates (template_key, language_code, is_enabled);

create index if not exists notifications_profile_id_created_at_idx
on public.notifications (profile_id, created_at desc);

create index if not exists user_devices_profile_id_idx
on public.user_devices (profile_id);

create index if not exists platform_settings_is_public_idx
on public.platform_settings (is_public);

create index if not exists admin_audit_logs_actor_id_created_at_idx
on public.admin_audit_logs (actor_id, created_at desc);

create or replace trigger profiles_set_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

create or replace trigger vehicles_set_updated_at
before update on public.vehicles
for each row execute function public.set_updated_at();

create or replace trigger payout_accounts_set_updated_at
before update on public.payout_accounts
for each row execute function public.set_updated_at();

create or replace trigger platform_payment_accounts_set_updated_at
before update on public.platform_payment_accounts
for each row execute function public.set_updated_at();

create or replace trigger verification_documents_set_updated_at
before update on public.verification_documents
for each row execute function public.set_updated_at();

create or replace trigger routes_set_updated_at
before update on public.routes
for each row execute function public.set_updated_at();

create or replace trigger route_departure_instances_set_updated_at
before update on public.route_departure_instances
for each row execute function public.set_updated_at();

create or replace trigger oneoff_trips_set_updated_at
before update on public.oneoff_trips
for each row execute function public.set_updated_at();

create or replace trigger shipments_set_updated_at
before update on public.shipments
for each row execute function public.set_updated_at();

create or replace trigger bookings_set_updated_at
before update on public.bookings
for each row execute function public.set_updated_at();

create or replace trigger disputes_set_updated_at
before update on public.disputes
for each row execute function public.set_updated_at();

create or replace trigger refunds_set_updated_at
before update on public.refunds
for each row execute function public.set_updated_at();

create or replace trigger payouts_set_updated_at
before update on public.payouts
for each row execute function public.set_updated_at();

create or replace trigger email_delivery_logs_set_updated_at
before update on public.email_delivery_logs
for each row execute function public.set_updated_at();

create or replace trigger email_outbox_jobs_set_updated_at
before update on public.email_outbox_jobs
for each row execute function public.set_updated_at();

create or replace trigger email_templates_set_updated_at
before update on public.email_templates
for each row execute function public.set_updated_at();

create or replace trigger user_devices_set_updated_at
before update on public.user_devices
for each row execute function public.set_updated_at();

create or replace trigger platform_settings_set_updated_at
before update on public.platform_settings
for each row execute function public.set_updated_at();
-- <<< END 20260317143400_create_communications_and_platform_tables.sql

-- >>> BEGIN 20260317150000_create_runtime_support_tables.sql
do $$ begin
  create type public.support_request_status as enum (
    'open',
    'in_progress',
    'waiting_for_user',
    'resolved',
    'closed'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.support_request_priority as enum (
    'normal',
    'high',
    'urgent'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.support_message_sender_type as enum (
    'user',
    'admin',
    'system'
  );
exception
  when duplicate_object then null;
end $$;

do $$ begin
  create type public.upload_session_status as enum ('authorized', 'finalized', 'cancelled', 'expired');
exception
  when duplicate_object then null;
end $$;

create table if not exists public.support_requests (
  id uuid primary key default gen_random_uuid(),
  created_by uuid not null references public.profiles (id) on delete cascade,
  requester_role public.app_role not null,
  subject text not null,
  status public.support_request_status not null default 'open',
  priority public.support_request_priority not null default 'normal',
  shipment_id uuid references public.shipments (id) on delete set null,
  booking_id uuid references public.bookings (id) on delete set null,
  payment_proof_id uuid references public.payment_proofs (id) on delete set null,
  dispute_id uuid references public.disputes (id) on delete set null,
  assigned_admin_id uuid references public.profiles (id) on delete set null,
  last_message_preview text,
  last_message_sender_type public.support_message_sender_type not null default 'user',
  last_message_at timestamptz not null default now(),
  user_last_read_at timestamptz,
  admin_last_read_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.support_messages (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.support_requests (id) on delete cascade,
  sender_profile_id uuid references public.profiles (id) on delete set null,
  sender_type public.support_message_sender_type not null,
  body text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.upload_sessions (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  bucket_id text not null,
  object_path text not null unique,
  entity_type text not null,
  entity_id uuid not null,
  document_type text,
  content_type text not null,
  byte_size bigint not null,
  checksum_sha256 text,
  status public.upload_session_status not null default 'authorized',
  expires_at timestamptz not null,
  finalized_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.security_rate_limits (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid not null references public.profiles (id) on delete cascade,
  action_key text not null,
  window_started_at timestamptz not null,
  hit_count integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (actor_id, action_key, window_started_at)
);

create table if not exists public.security_abuse_events (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles (id) on delete set null,
  action_key text not null,
  reason text not null,
  metadata jsonb,
  created_at timestamptz not null default now()
);

alter table public.verification_documents
add column if not exists content_type text,
add column if not exists byte_size bigint,
add column if not exists checksum_sha256 text,
add column if not exists uploaded_by uuid references public.profiles (id),
add column if not exists upload_session_id uuid references public.upload_sessions (id);

alter table public.payment_proofs
add column if not exists content_type text,
add column if not exists byte_size bigint,
add column if not exists checksum_sha256 text,
add column if not exists uploaded_by uuid references public.profiles (id),
add column if not exists upload_session_id uuid references public.upload_sessions (id);

alter table public.generated_documents
add column if not exists content_type text,
add column if not exists byte_size bigint,
add column if not exists checksum_sha256 text;

create index if not exists upload_sessions_profile_id_idx
on public.upload_sessions (profile_id);

create index if not exists support_requests_created_by_last_message_at_idx
on public.support_requests (created_by, last_message_at desc);

create index if not exists support_requests_status_last_message_at_idx
on public.support_requests (status, last_message_at desc);

create index if not exists support_requests_assigned_admin_last_message_at_idx
on public.support_requests (assigned_admin_id, last_message_at desc);

create index if not exists support_messages_request_id_created_at_idx
on public.support_messages (request_id, created_at asc);

create index if not exists upload_sessions_bucket_status_expires_at_idx
on public.upload_sessions (bucket_id, status, expires_at);

create index if not exists security_rate_limits_actor_action_window_idx
on public.security_rate_limits (actor_id, action_key, window_started_at desc);

create index if not exists security_abuse_events_actor_action_created_at_idx
on public.security_abuse_events (actor_id, action_key, created_at desc);
-- <<< END 20260317150000_create_runtime_support_tables.sql

-- >>> BEGIN 20260317150100_create_security_and_storage_helpers.sql
create or replace function public.current_user_id()
returns uuid
language sql
stable
set search_path = public
as $$
  select auth.uid();
$$;

create or replace function public.current_user_role()
returns public.app_role
language sql
stable
security definer
set search_path = public
as $$
  select p.role
  from public.profiles as p
  where p.id = (select auth.uid());
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(public.current_user_role() = 'admin', false);
$$;

create or replace function public.is_service_role()
returns boolean
language sql
stable
set search_path = public
as $$
  select current_setting('request.jwt.claim.role', true) = 'service_role';
$$;

create or replace function public.booking_is_visible_to_current_user(p_booking_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.bookings as b
    where b.id = p_booking_id
      and (
        b.shipper_id = (select auth.uid())
        or b.carrier_id = (select auth.uid())
        or public.is_admin()
      )
  );
$$;

create or replace function public.shipment_is_visible_to_current_user(p_shipment_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.shipments as s
    where s.id = p_shipment_id
      and (s.shipper_id = (select auth.uid()) or public.is_admin())
  );
$$;

create or replace function public.booking_owned_by_current_shipper(p_booking_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.bookings as b
    where b.id = p_booking_id
      and b.shipper_id = (select auth.uid())
  );
$$;

create or replace function public.vehicle_owned_by_current_carrier(p_vehicle_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.vehicles as v
    where v.id = p_vehicle_id
      and v.carrier_id = (select auth.uid())
  );
$$;

create or replace function public.normalize_plate_number(p_value text)
returns text
language sql
immutable
set search_path = public
as $$
  select nullif(regexp_replace(upper(trim(coalesce(p_value, ''))), '\s+', '', 'g'), '');
$$;

create or replace function public.normalize_reference_value(p_value text)
returns text
language sql
immutable
set search_path = public
as $$
  select nullif(trim(coalesce(p_value, '')), '');
$$;

create or replace function public.record_abuse_event(
  p_action_key text,
  p_reason text,
  p_metadata jsonb default '{}'::jsonb
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.security_abuse_events (actor_id, action_key, reason, metadata)
  values ((select auth.uid()), p_action_key, p_reason, p_metadata);
end;
$$;

create or replace function public.consume_rate_limit(
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_window_started_at timestamptz;
  v_hit_count integer;
begin
  if v_actor_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_limit <= 0 or p_window_seconds <= 0 then
    raise exception 'Rate-limit configuration must be positive';
  end if;

  v_window_started_at := to_timestamp(
    floor(extract(epoch from now()) / p_window_seconds) * p_window_seconds
  );

  insert into public.security_rate_limits (
    actor_id,
    action_key,
    window_started_at,
    hit_count
  )
  values (v_actor_id, p_action_key, v_window_started_at, 1)
  on conflict (actor_id, action_key, window_started_at)
  do update
  set
    hit_count = public.security_rate_limits.hit_count + 1,
    updated_at = now()
  returning hit_count into v_hit_count;

  if v_hit_count > p_limit then
    perform public.record_abuse_event(
      p_action_key,
      'rate_limit_exceeded',
      jsonb_build_object(
        'limit', p_limit,
        'window_seconds', p_window_seconds,
        'hit_count', v_hit_count
      )
    );
    return false;
  end if;

  return true;
end;
$$;

create or replace function public.consume_rate_limit_for_actor(
  p_actor_id uuid,
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_window_started_at timestamptz;
  v_hit_count integer;
begin
  if p_actor_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_limit <= 0 or p_window_seconds <= 0 then
    raise exception 'Rate-limit configuration must be positive';
  end if;

  v_window_started_at := to_timestamp(
    floor(extract(epoch from now()) / p_window_seconds) * p_window_seconds
  );

  insert into public.security_rate_limits (
    actor_id,
    action_key,
    window_started_at,
    hit_count
  )
  values (p_actor_id, p_action_key, v_window_started_at, 1)
  on conflict (actor_id, action_key, window_started_at)
  do update
  set
    hit_count = public.security_rate_limits.hit_count + 1,
    updated_at = now()
  returning hit_count into v_hit_count;

  if v_hit_count > p_limit then
    perform public.record_abuse_event(
      p_action_key,
      'rate_limit_exceeded',
      jsonb_build_object(
        'limit', p_limit,
        'window_seconds', p_window_seconds,
        'hit_count', v_hit_count,
        'actor_id', p_actor_id
      )
    );
    return false;
  end if;

  return true;
end;
$$;

create or replace function public.assert_rate_limit(
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.consume_rate_limit(p_action_key, p_limit, p_window_seconds) then
    raise exception 'Rate limit exceeded for %', p_action_key;
  end if;
end;
$$;

create or replace function public.assert_rate_limit_for_actor(
  p_actor_id uuid,
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.consume_rate_limit_for_actor(
    p_actor_id,
    p_action_key,
    p_limit,
    p_window_seconds
  ) then
    raise exception 'Rate limit exceeded for %', p_action_key;
  end if;
end;
$$;

create or replace function public.protect_profile_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.email := lower(trim(new.email));
    return new;
  end if;

  if tg_op = 'INSERT' then
    if new.role = 'admin' then
      raise exception 'Creating admin profiles directly is not allowed';
    end if;

    new.is_active := true;
    new.verification_status := 'pending';
    new.verification_rejection_reason := null;
    new.rating_average := null;
    new.rating_count := 0;
    new.email := lower(trim(new.email));
    return new;
  end if;

  if new.role is distinct from old.role
    or new.is_active is distinct from old.is_active
    or new.verification_status is distinct from old.verification_status
    or new.verification_rejection_reason is distinct from old.verification_rejection_reason
    or new.rating_average is distinct from old.rating_average
    or new.rating_count is distinct from old.rating_count then
    raise exception 'Updating protected profile columns is not allowed';
  end if;

  return new;
end;
$$;

create or replace function public.protect_vehicle_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.plate_number := public.normalize_plate_number(new.plate_number);
    return new;
  end if;

  if tg_op = 'INSERT' then
    new.verification_status := 'pending';
    new.verification_rejection_reason := null;
    new.plate_number := public.normalize_plate_number(new.plate_number);
    return new;
  end if;

  if new.verification_status is distinct from old.verification_status
    or new.verification_rejection_reason is distinct from old.verification_rejection_reason then
    raise exception 'Updating protected vehicle columns is not allowed';
  end if;

  new.plate_number := public.normalize_plate_number(new.plate_number);
  return new;
end;
$$;

create or replace function public.protect_payout_account_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.account_identifier := public.normalize_reference_value(new.account_identifier);
    return new;
  end if;

  if tg_op = 'INSERT' then
    new.is_verified := false;
    new.verified_at := null;
    new.account_identifier := public.normalize_reference_value(new.account_identifier);
    return new;
  end if;

  if new.is_verified is distinct from old.is_verified
    or new.verified_at is distinct from old.verified_at then
    raise exception 'Updating protected payout account columns is not allowed';
  end if;

  new.account_identifier := public.normalize_reference_value(new.account_identifier);
  return new;
end;
$$;

create or replace function public.normalize_profile_columns()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.phone_number := public.normalize_reference_value(new.phone_number);
  new.email := lower(trim(new.email));
  return new;
end;
$$;

create or replace function public.enforce_append_only_history()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if current_setting('app.trusted_operation', true) = 'true'
     and (public.is_admin() or public.is_service_role()) then
    return case when tg_op = 'DELETE' then old else new end;
  end if;

  raise exception '% is append-only and cannot be %d directly', tg_table_name, tg_op;
end;
$$;

create or replace function public.build_upload_object_path(
  p_bucket_id text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_version integer,
  p_file_extension text
)
returns text
language plpgsql
immutable
set search_path = public
as $$
declare
  v_extension text := lower(trim(coalesce(p_file_extension, 'bin')));
begin
  if p_bucket_id = 'payment-proofs' then
    return format('%s/%s/upload.%s', p_entity_id, p_version, v_extension);
  end if;

  if p_bucket_id = 'verification-documents' then
    return format(
      '%s/%s/%s/%s/upload.%s',
      p_entity_type,
      p_entity_id,
      p_document_type,
      p_version,
      v_extension
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return format('%s/%s/%s/file.%s', p_entity_id, p_document_type, p_version, v_extension);
  end if;

  raise exception 'Unsupported bucket %', p_bucket_id;
end;
$$;

create or replace function public.can_upload_storage_object(
  p_bucket_id text,
  p_object_path text
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.upload_sessions as s
    where s.profile_id = (select auth.uid())
      and s.bucket_id = p_bucket_id
      and s.object_path = p_object_path
      and s.status = 'authorized'
      and s.expires_at > now()
  );
$$;

create or replace function public.authorize_private_file_access(
  p_bucket_id text,
  p_object_path text
)
returns boolean
language plpgsql
volatile
security definer
set search_path = public
as $$
begin
  return public.authorize_private_file_access_for_user(
    (select auth.uid()),
    p_bucket_id,
    p_object_path
  );
end;
$$;

create or replace function public.authorize_private_file_access_for_user(
  p_actor_id uuid,
  p_bucket_id text,
  p_object_path text
)
returns boolean
language plpgsql
volatile
security definer
set search_path = public
as $$
begin
  perform public.assert_rate_limit_for_actor(
    p_actor_id,
    'signed_url_generation',
    30,
    60
  );

  if exists (
    select 1
    from public.profiles as p
    where p.id = p_actor_id
      and p.role = 'admin'
  ) then
    return true;
  end if;

  if p_bucket_id = 'payment-proofs' then
    return exists (
      select 1
      from public.payment_proofs as pp
      join public.bookings as b on b.id = pp.booking_id
      where pp.storage_path = p_object_path
        and b.shipper_id = p_actor_id
    );
  end if;

  if p_bucket_id = 'verification-documents' then
    return exists (
      select 1
      from public.verification_documents as vd
      where vd.storage_path = p_object_path
        and vd.owner_profile_id = p_actor_id
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return exists (
      select 1
      from public.generated_documents as gd
      join public.bookings as b on b.id = gd.booking_id
      where gd.storage_path = p_object_path
        and (b.shipper_id = p_actor_id or b.carrier_id = p_actor_id)
    );
  end if;

  return false;
end;
$$;
-- <<< END 20260317150100_create_security_and_storage_helpers.sql

-- >>> BEGIN 20260317150200_create_client_upload_and_finalize_rpc.sql
create or replace function public.get_client_settings()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  with settings as (
    select coalesce(jsonb_object_agg(ps.key, ps.value), '{}'::jsonb) as value
    from public.platform_settings as ps
    where ps.is_public = true
  ),
  payment_accounts as (
    with current_environment as (
      select coalesce(
        nullif(current_setting('app.settings.environment', true), ''),
        'staging'
      )::public.platform_environment as environment
    )
    select coalesce(
      jsonb_agg(
        jsonb_build_object(
          'id', ppa.id,
          'payment_rail', ppa.payment_rail,
          'display_name', ppa.display_name,
          'account_identifier', ppa.account_identifier,
          'account_holder_name', ppa.account_holder_name,
          'instructions_text', ppa.instructions_text
        )
        order by ppa.display_name
      ),
      '[]'::jsonb
    ) as value
    from public.platform_payment_accounts as ppa
    cross join current_environment as ce
    where ppa.is_active = true
      and ppa.environment = ce.environment
  )
  select settings.value || jsonb_build_object('platform_payment_accounts', payment_accounts.value)
  from settings, payment_accounts;
$$;

create or replace function public.create_upload_session(
  p_upload_kind text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_file_extension text,
  p_content_type text,
  p_byte_size bigint,
  p_checksum_sha256 text default null
)
returns table (
  upload_session_id uuid,
  bucket_id text,
  object_path text,
  expires_at timestamptz,
  max_file_size_bytes bigint
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := (select auth.uid());
  v_bucket_id text;
  v_entity_type text := trim(lower(p_entity_type));
  v_document_type text := trim(lower(coalesce(p_document_type, '')));
  v_version integer;
  v_object_path text;
  v_session_id uuid := gen_random_uuid();
  v_expires_at timestamptz := now() + interval '15 minutes';
  v_owner_profile_id uuid;
  v_max_file_size bigint := 10485760;
begin
  if v_profile_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_content_type not in ('image/jpeg', 'image/png', 'application/pdf') then
    raise exception 'Unsupported content type';
  end if;

  if p_byte_size <= 0 or p_byte_size > v_max_file_size then
    raise exception 'File size exceeds the allowed limit';
  end if;

  if trim(lower(p_upload_kind)) = 'payment_proof' then
    perform public.assert_rate_limit('proof_upload', 10, 3600);
    v_bucket_id := 'payment-proofs';

    if v_entity_type <> 'booking' then
      raise exception 'Payment proof uploads must target a booking';
    end if;

    if not public.booking_owned_by_current_shipper(p_entity_id) then
      raise exception 'You cannot upload proof for this booking';
    end if;

    if v_document_type not in ('ccp', 'dahabia', 'bank') then
      raise exception 'Payment proof document type must be a payment rail';
    end if;

    select coalesce(max(pp.version), 0) + 1
    into v_version
    from public.payment_proofs as pp
    where pp.booking_id = p_entity_id;

    v_owner_profile_id := v_profile_id;
  elsif trim(lower(p_upload_kind)) = 'verification_document' then
    perform public.assert_rate_limit('verification_document_upload', 20, 3600);
    v_bucket_id := 'verification-documents';

    if v_document_type not in (
      'driver_identity_or_license',
      'truck_registration',
      'truck_insurance',
      'truck_technical_inspection'
    ) then
      raise exception 'Unsupported verification document type';
    end if;

    if v_entity_type = 'profile' then
      if p_entity_id <> v_profile_id then
        raise exception 'Profile verification documents must target the current user';
      end if;
      v_owner_profile_id := v_profile_id;
    elsif v_entity_type = 'vehicle' then
      if not public.vehicle_owned_by_current_carrier(p_entity_id) then
        raise exception 'Vehicle verification documents must target your own vehicle';
      end if;
      select v.carrier_id into v_owner_profile_id
      from public.vehicles as v
      where v.id = p_entity_id;
    else
      raise exception 'Unsupported verification entity type';
    end if;

    select coalesce(max(vd.version), 0) + 1
    into v_version
    from public.verification_documents as vd
    where vd.entity_type::text = v_entity_type
      and vd.entity_id = p_entity_id
      and vd.document_type = v_document_type;
  else
    raise exception 'Unsupported upload kind';
  end if;

  v_object_path := public.build_upload_object_path(
    v_bucket_id,
    v_entity_type,
    p_entity_id,
    v_document_type,
    v_version,
    p_file_extension
  );

  insert into public.upload_sessions (
    id,
    profile_id,
    bucket_id,
    object_path,
    entity_type,
    entity_id,
    document_type,
    content_type,
    byte_size,
    checksum_sha256,
    expires_at
  )
  values (
    v_session_id,
    v_owner_profile_id,
    v_bucket_id,
    v_object_path,
    v_entity_type,
    p_entity_id,
    v_document_type,
    p_content_type,
    p_byte_size,
    p_checksum_sha256,
    v_expires_at
  );

  return query
  select v_session_id, v_bucket_id, v_object_path, v_expires_at, v_max_file_size;
end;
$$;

create or replace function public.finalize_payment_proof(
  p_upload_session_id uuid,
  p_submitted_amount_dzd numeric,
  p_submitted_reference text default null
)
returns public.payment_proofs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session public.upload_sessions;
  v_result public.payment_proofs;
  v_object_exists boolean;
begin
  select * into v_session
  from public.upload_sessions
  where id = p_upload_session_id
    and profile_id = (select auth.uid())
    and bucket_id = 'payment-proofs';

  if not found then
    raise exception 'Upload session not found';
  end if;

  if v_session.status <> 'authorized' or v_session.expires_at <= now() then
    raise exception 'Upload session is no longer valid';
  end if;

  select exists (
    select 1
    from storage.objects as so
    where so.bucket_id = v_session.bucket_id
      and so.name = v_session.object_path
      and coalesce((so.metadata->>'size')::bigint, -1) = v_session.byte_size
      and lower(coalesce(so.metadata->>'mimetype', '')) = lower(v_session.content_type)
  ) into v_object_exists;

  if not v_object_exists then
    raise exception 'Uploaded proof file is missing or metadata does not match the authorized session';
  end if;

  insert into public.payment_proofs (
    booking_id,
    storage_path,
    payment_rail,
    submitted_reference,
    submitted_amount_dzd,
    status,
    submitted_at,
    version,
    content_type,
    byte_size,
    checksum_sha256,
    uploaded_by,
    upload_session_id
  )
  values (
    v_session.entity_id,
    v_session.object_path,
    v_session.document_type::public.payment_rail,
    public.normalize_reference_value(p_submitted_reference),
    p_submitted_amount_dzd,
    'pending',
    now(),
    (
      select coalesce(max(pp.version), 0) + 1
      from public.payment_proofs as pp
      where pp.booking_id = v_session.entity_id
    ),
    v_session.content_type,
    v_session.byte_size,
    v_session.checksum_sha256,
    (select auth.uid()),
    v_session.id
  )
  returning * into v_result;

  update public.upload_sessions
  set status = 'finalized', finalized_at = now(), updated_at = now()
  where id = v_session.id;

  return v_result;
end;
$$;

create or replace function public.finalize_verification_document(
  p_upload_session_id uuid
)
returns public.verification_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session public.upload_sessions;
  v_owner_profile_id uuid;
  v_result public.verification_documents;
  v_object_exists boolean;
begin
  select * into v_session
  from public.upload_sessions
  where id = p_upload_session_id
    and profile_id = (select auth.uid())
    and bucket_id = 'verification-documents';

  if not found then
    raise exception 'Upload session not found';
  end if;

  if v_session.status <> 'authorized' or v_session.expires_at <= now() then
    raise exception 'Upload session is no longer valid';
  end if;

  select exists (
    select 1
    from storage.objects as so
    where so.bucket_id = v_session.bucket_id
      and so.name = v_session.object_path
      and coalesce((so.metadata->>'size')::bigint, -1) = v_session.byte_size
      and lower(coalesce(so.metadata->>'mimetype', '')) = lower(v_session.content_type)
  ) into v_object_exists;

  if not v_object_exists then
    raise exception 'Uploaded verification file is missing or metadata does not match the authorized session';
  end if;

  if v_session.entity_type = 'profile' then
    v_owner_profile_id := (select auth.uid());
  else
    select v.carrier_id into v_owner_profile_id
    from public.vehicles as v
    where v.id = v_session.entity_id;
  end if;

  insert into public.verification_documents (
    owner_profile_id,
    entity_type,
    entity_id,
    document_type,
    storage_path,
    status,
    version,
    content_type,
    byte_size,
    checksum_sha256,
    uploaded_by,
    upload_session_id
  )
  values (
    v_owner_profile_id,
    v_session.entity_type::public.verification_document_entity_type,
    v_session.entity_id,
    v_session.document_type,
    v_session.object_path,
    'pending',
    (
      select coalesce(max(vd.version), 0) + 1
      from public.verification_documents as vd
      where vd.entity_type::text = v_session.entity_type
        and vd.entity_id = v_session.entity_id
        and vd.document_type = v_session.document_type
    ),
    v_session.content_type,
    v_session.byte_size,
    v_session.checksum_sha256,
    (select auth.uid()),
    v_session.id
  )
  returning * into v_result;

  update public.upload_sessions
  set status = 'finalized', finalized_at = now(), updated_at = now()
  where id = v_session.id;

  return v_result;
end;
$$;
-- <<< END 20260317150200_create_client_upload_and_finalize_rpc.sql

-- >>> BEGIN 20260317150300_create_privileged_runtime_rpc.sql
create or replace function public.write_admin_audit_log(
  p_action text,
  p_target_type text,
  p_target_id uuid,
  p_outcome text,
  p_reason text default null,
  p_metadata jsonb default '{}'::jsonb
)
returns public.admin_audit_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.admin_audit_logs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin audit log writes require privileged execution';
  end if;

  insert into public.admin_audit_logs (
    actor_id,
    actor_role,
    action,
    target_type,
    target_id,
    outcome,
    reason,
    correlation_id,
    metadata
  )
  values (
    (select auth.uid()),
    public.current_user_role(),
    p_action,
    p_target_type,
    p_target_id,
    p_outcome,
    p_reason,
    gen_random_uuid()::text,
    p_metadata
  )
  returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.require_recent_admin_step_up()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_service_role() then
    return;
  end if;

  if not public.is_admin() then
    raise exception 'Privileged execution requires admin access';
  end if;

  if (
    extract(epoch from now()) - coalesce((auth.jwt()->>'iat')::bigint, 0)
  ) > 900 then
    raise exception 'Recent admin step-up is required for this action';
  end if;
end;
$$;

create or replace function public.claim_email_outbox_jobs(
  p_worker_id text,
  p_batch_size integer default 10
)
returns setof public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_limit integer := greatest(1, least(coalesce(p_batch_size, 10), 50));
begin
  if not public.is_service_role() then
    raise exception 'Email outbox claims require service role access';
  end if;

  return query
  with claimed as (
    update public.email_outbox_jobs as jobs
    set status = 'processing',
        locked_at = now(),
        locked_by = p_worker_id,
        updated_at = now()
    where jobs.id in (
      select candidate.id
      from public.email_outbox_jobs as candidate
      where candidate.status in ('queued', 'retry_scheduled')
        and candidate.available_at <= now()
      order by
        case candidate.priority
          when 'critical' then 0
          when 'high' then 1
          when 'normal' then 2
          else 3
        end,
        candidate.available_at,
        candidate.created_at
      limit v_limit
      for update skip locked
    )
    returning jobs.*
  )
  select * from claimed;
end;
$$;

create or replace function public.release_retryable_email_job(
  p_job_id uuid,
  p_error_code text,
  p_error_message text,
  p_retry_delay_seconds integer default 300
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_outbox_jobs;
  v_delay integer := greatest(60, least(coalesce(p_retry_delay_seconds, 300), 86400));
begin
  if not public.is_service_role() then
    raise exception 'Retry scheduling requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = case
        when lower(coalesce(p_error_code, '')) = 'render_failed' then 'dead_letter'::public.email_outbox_status
        when attempt_count + 1 >= max_attempts then 'dead_letter'::public.email_outbox_status
        else 'retry_scheduled'::public.email_outbox_status
      end,
      attempt_count = attempt_count + 1,
      available_at = case
        when lower(coalesce(p_error_code, '')) = 'render_failed' then available_at
        when attempt_count + 1 >= max_attempts then available_at
        else now() + make_interval(secs => v_delay)
      end,
      locked_at = null,
      locked_by = null,
      last_error_code = left(coalesce(p_error_code, 'unknown_error'), 120),
      last_error_message = left(coalesce(p_error_message, 'Unknown email provider failure'), 500),
      updated_at = now()
  where id = p_job_id
  returning * into v_result;

  if not found then
    raise exception 'Email outbox job not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.complete_email_outbox_job(
  p_job_id uuid,
  p_provider text,
  p_provider_message_id text default null,
  p_subject_preview text default null,
  p_template_language_code text default null
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.email_outbox_jobs;
begin
  if not public.is_service_role() then
    raise exception 'Email outbox completion requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = 'sent_to_provider',
      attempt_count = attempt_count + 1,
      template_language_code = coalesce(nullif(trim(p_template_language_code), ''), template_language_code),
      locked_at = null,
      locked_by = null,
      last_error_code = null,
      last_error_message = null,
      updated_at = now()
  where id = p_job_id
  returning * into v_job;

  if not found then
    raise exception 'Email outbox job not found';
  end if;

  insert into public.email_delivery_logs (
    profile_id,
    booking_id,
    template_key,
    template_language_code,
    locale,
    recipient_email,
    subject_preview,
    provider_message_id,
    status,
    provider,
    attempt_count,
    last_attempt_at,
    payload_snapshot
  )
  values (
    v_job.profile_id,
    v_job.booking_id,
    v_job.template_key,
    coalesce(nullif(trim(p_template_language_code), ''), v_job.template_language_code),
    v_job.locale,
    v_job.recipient_email,
    p_subject_preview,
    p_provider_message_id,
    'sent',
    left(coalesce(p_provider, 'provider'), 120),
    v_job.attempt_count,
    now(),
    v_job.payload_snapshot
  )
  on conflict do nothing
  ;

  return v_job;
end;
$$;

create or replace function public.record_email_dispatch_failure(
  p_job_id uuid,
  p_status public.email_delivery_status,
  p_provider text,
  p_subject_preview text default null,
  p_error_code text default null,
  p_error_message text default null,
  p_template_language_code text default null
)
returns public.email_delivery_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_job public.email_outbox_jobs;
  v_result public.email_delivery_logs;
begin
  if not public.is_service_role() then
    raise exception 'Email dispatch failure recording requires service role access';
  end if;

  if p_status not in ('render_failed', 'soft_failed', 'hard_failed', 'bounced', 'suppressed') then
    raise exception 'Unsupported dispatch failure status';
  end if;

  select * into v_job
  from public.email_outbox_jobs
  where id = p_job_id;

  if not found then
    raise exception 'Email outbox job not found';
  end if;

  insert into public.email_delivery_logs (
    profile_id,
    booking_id,
    template_key,
    template_language_code,
    locale,
    recipient_email,
    subject_preview,
    provider_message_id,
    status,
    provider,
    attempt_count,
    last_attempt_at,
    next_retry_at,
    last_error_at,
    error_code,
    error_message,
    payload_snapshot
  )
  values (
    v_job.profile_id,
    v_job.booking_id,
    v_job.template_key,
    coalesce(nullif(trim(p_template_language_code), ''), v_job.template_language_code),
    v_job.locale,
    v_job.recipient_email,
    p_subject_preview,
    null,
    p_status,
    left(coalesce(nullif(trim(p_provider), ''), 'runtime'), 120),
    greatest(v_job.attempt_count + 1, 1),
    now(),
    case when p_status = 'soft_failed' then now() else null end,
    now(),
    left(coalesce(p_error_code, 'unknown_error'), 120),
    left(coalesce(p_error_message, 'Unknown email dispatch failure'), 500),
    v_job.payload_snapshot
  )
  returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.record_email_provider_event(
  p_provider_message_id text,
  p_status public.email_delivery_status,
  p_error_code text default null,
  p_error_message text default null
)
returns public.email_delivery_logs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.email_delivery_logs;
  v_current_rank integer;
  v_next_rank integer;
begin
  if not public.is_service_role() then
    raise exception 'Email provider events require service role access';
  end if;

  v_next_rank := case p_status
    when 'queued' then 0
    when 'sent' then 1
    when 'delivered' then 2
    when 'opened' then 3
    when 'clicked' then 4
    when 'soft_failed' then 5
    when 'hard_failed' then 6
    when 'bounced' then 7
    when 'suppressed' then 8
    when 'render_failed' then 9
    else 0
  end;

  select case status
    when 'queued' then 0
    when 'sent' then 1
    when 'delivered' then 2
    when 'opened' then 3
    when 'clicked' then 4
    when 'soft_failed' then 5
    when 'hard_failed' then 6
    when 'bounced' then 7
    when 'suppressed' then 8
    when 'render_failed' then 9
    else 0
  end
  into v_current_rank
  from public.email_delivery_logs
  where provider_message_id = p_provider_message_id;

  if v_current_rank is null then
    raise exception 'Email delivery log not found for provider message';
  end if;

  if v_next_rank < v_current_rank then
    select * into v_result
    from public.email_delivery_logs
    where provider_message_id = p_provider_message_id;
    return v_result;
  end if;

  update public.email_delivery_logs
  set status = p_status,
      error_code = case when p_status in ('render_failed', 'soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_code, 120) else null end,
      error_message = case when p_status in ('render_failed', 'soft_failed', 'hard_failed', 'bounced', 'suppressed') then left(p_error_message, 500) else null end,
      last_error_at = case when p_status in ('render_failed', 'soft_failed', 'hard_failed', 'bounced', 'suppressed') then now() else last_error_at end,
      updated_at = now()
  where provider_message_id = p_provider_message_id
  returning * into v_result;

  if not found then
    raise exception 'Email delivery log not found for provider message';
  end if;

  return v_result;
end;
$$;

create or replace function public.recover_stale_email_outbox_jobs(
  p_lock_age_seconds integer default 900
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_recovered_count integer := 0;
  v_lock_age integer := greatest(60, least(coalesce(p_lock_age_seconds, 900), 86400));
begin
  if not public.is_service_role() then
    raise exception 'Outbox recovery requires service role access';
  end if;

  update public.email_outbox_jobs
  set status = 'retry_scheduled',
      locked_at = null,
      locked_by = null,
      available_at = now(),
      updated_at = now()
  where status = 'processing'
    and locked_at is not null
    and locked_at < now() - make_interval(secs => v_lock_age);

  get diagnostics v_recovered_count = row_count;
  return v_recovered_count;
end;
$$;
-- <<< END 20260317150300_create_privileged_runtime_rpc.sql

-- >>> BEGIN 20260317150400_create_storage_buckets.sql
insert into storage.buckets (id, name, public)
values
  ('payment-proofs', 'payment-proofs', false),
  ('verification-documents', 'verification-documents', false),
  ('generated-documents', 'generated-documents', false)
on conflict (id) do update
set public = excluded.public;
-- <<< END 20260317150400_create_storage_buckets.sql

-- >>> BEGIN 20260317150500_enable_rls_and_create_table_policies.sql
alter table public.wilayas enable row level security;
alter table public.communes enable row level security;
alter table public.profiles enable row level security;
alter table public.vehicles enable row level security;
alter table public.payout_accounts enable row level security;
alter table public.platform_payment_accounts enable row level security;
alter table public.verification_documents enable row level security;
alter table public.routes enable row level security;
alter table public.route_departure_instances enable row level security;
alter table public.oneoff_trips enable row level security;
alter table public.route_revisions enable row level security;
alter table public.shipments enable row level security;
alter table public.bookings enable row level security;
alter table public.payment_proofs enable row level security;
alter table public.tracking_events enable row level security;
alter table public.carrier_reviews enable row level security;
alter table public.financial_ledger_entries enable row level security;
alter table public.disputes enable row level security;
alter table public.refunds enable row level security;
alter table public.payouts enable row level security;
alter table public.generated_documents enable row level security;
alter table public.email_delivery_logs enable row level security;
alter table public.email_outbox_jobs enable row level security;
alter table public.email_templates enable row level security;
alter table public.notifications enable row level security;
alter table public.user_devices enable row level security;
alter table public.platform_settings enable row level security;
alter table public.admin_audit_logs enable row level security;
alter table public.support_requests enable row level security;
alter table public.support_messages enable row level security;
alter table public.upload_sessions enable row level security;
alter table public.security_rate_limits enable row level security;
alter table public.security_abuse_events enable row level security;

drop policy if exists wilayas_read_authenticated on public.wilayas;
create policy wilayas_read_authenticated
on public.wilayas for select to authenticated
using (true);

drop policy if exists communes_read_authenticated on public.communes;
create policy communes_read_authenticated
on public.communes for select to authenticated
using (true);

drop policy if exists profiles_select_self_or_admin on public.profiles;
create policy profiles_select_self_or_admin
on public.profiles for select to authenticated
using (id = (select auth.uid()) or public.is_admin());

drop policy if exists profiles_insert_self_or_admin on public.profiles;
create policy profiles_insert_self_or_admin
on public.profiles for insert to authenticated
with check (id = (select auth.uid()) or public.is_admin());

drop policy if exists profiles_update_self_or_admin on public.profiles;
create policy profiles_update_self_or_admin
on public.profiles for update to authenticated
using (id = (select auth.uid()) or public.is_admin())
with check (id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_select_owner_or_admin on public.vehicles;
create policy vehicles_select_owner_or_admin
on public.vehicles for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_modify_owner_or_admin on public.vehicles;
drop policy if exists vehicles_insert_owner_or_admin on public.vehicles;
create policy vehicles_insert_owner_or_admin
on public.vehicles for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_update_owner_or_admin on public.vehicles;
create policy vehicles_update_owner_or_admin
on public.vehicles for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_delete_owner_or_admin on public.vehicles;
create policy vehicles_delete_owner_or_admin
on public.vehicles for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_select_owner_or_admin on public.payout_accounts;
create policy payout_accounts_select_owner_or_admin
on public.payout_accounts for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_modify_owner_or_admin on public.payout_accounts;
drop policy if exists payout_accounts_insert_owner_or_admin on public.payout_accounts;
create policy payout_accounts_insert_owner_or_admin
on public.payout_accounts for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_update_owner_or_admin on public.payout_accounts;
create policy payout_accounts_update_owner_or_admin
on public.payout_accounts for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_delete_owner_or_admin on public.payout_accounts;
create policy payout_accounts_delete_owner_or_admin
on public.payout_accounts for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists platform_payment_accounts_admin_only on public.platform_payment_accounts;
create policy platform_payment_accounts_admin_only
on public.platform_payment_accounts for all to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists verification_documents_select_owner_or_admin on public.verification_documents;
create policy verification_documents_select_owner_or_admin
on public.verification_documents for select to authenticated
using (owner_profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists verification_documents_admin_update on public.verification_documents;
create policy verification_documents_admin_update
on public.verification_documents for update to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists routes_select_owner_or_admin on public.routes;
create policy routes_select_owner_or_admin
on public.routes for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_modify_owner_or_admin on public.routes;
drop policy if exists routes_insert_owner_or_admin on public.routes;
create policy routes_insert_owner_or_admin
on public.routes for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_update_owner_or_admin on public.routes;
create policy routes_update_owner_or_admin
on public.routes for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_delete_owner_or_admin on public.routes;
create policy routes_delete_owner_or_admin
on public.routes for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists route_departure_instances_select_owner_or_admin on public.route_departure_instances;
create policy route_departure_instances_select_owner_or_admin
on public.route_departure_instances for select to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_departure_instances.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists oneoff_trips_select_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_select_owner_or_admin
on public.oneoff_trips for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_modify_owner_or_admin on public.oneoff_trips;
drop policy if exists oneoff_trips_insert_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_insert_owner_or_admin
on public.oneoff_trips for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_update_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_update_owner_or_admin
on public.oneoff_trips for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_delete_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_delete_owner_or_admin
on public.oneoff_trips for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists route_revisions_select_owner_or_admin on public.route_revisions;
create policy route_revisions_select_owner_or_admin
on public.route_revisions for select to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_modify_owner_or_admin on public.route_revisions;
drop policy if exists route_revisions_insert_owner_or_admin on public.route_revisions;
create policy route_revisions_insert_owner_or_admin
on public.route_revisions for insert to authenticated
with check (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_update_owner_or_admin on public.route_revisions;
create policy route_revisions_update_owner_or_admin
on public.route_revisions for update to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
)
with check (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_delete_owner_or_admin on public.route_revisions;
create policy route_revisions_delete_owner_or_admin
on public.route_revisions for delete to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists shipments_select_owner_or_admin on public.shipments;
create policy shipments_select_owner_or_admin
on public.shipments for select to authenticated
using (shipper_id = (select auth.uid()) or public.is_admin());

drop policy if exists shipments_insert_owner_or_admin on public.shipments;
create policy shipments_insert_owner_or_admin
on public.shipments for insert to authenticated
with check ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists shipments_update_draft_owner_or_admin on public.shipments;
create policy shipments_update_draft_owner_or_admin
on public.shipments for update to authenticated
using ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin())
with check ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists shipments_delete_draft_owner_or_admin on public.shipments;
create policy shipments_delete_draft_owner_or_admin
on public.shipments for delete to authenticated
using ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists bookings_select_participant_or_admin on public.bookings;
create policy bookings_select_participant_or_admin
on public.bookings for select to authenticated
using (
  shipper_id = (select auth.uid())
  or carrier_id = (select auth.uid())
  or public.is_admin()
);

drop policy if exists payment_proofs_select_shipper_or_admin on public.payment_proofs;
drop policy if exists payment_proofs_select_participant_or_admin on public.payment_proofs;
create policy payment_proofs_select_shipper_or_admin
on public.payment_proofs for select to authenticated
using (
  exists (
    select 1
    from public.bookings as b
    where b.id = payment_proofs.booking_id
      and (b.shipper_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists tracking_events_select_participant_or_admin on public.tracking_events;
create policy tracking_events_select_participant_or_admin
on public.tracking_events for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists carrier_reviews_select_participant_or_admin on public.carrier_reviews;
create policy carrier_reviews_select_participant_or_admin
on public.carrier_reviews for select to authenticated
using (
  shipper_id = (select auth.uid())
  or carrier_id = (select auth.uid())
  or public.is_admin()
);

drop policy if exists carrier_reviews_insert_shipper_or_admin on public.carrier_reviews;
create policy carrier_reviews_insert_shipper_or_admin
on public.carrier_reviews for insert to authenticated
with check (shipper_id = (select auth.uid()) or public.is_admin());

drop policy if exists financial_ledger_entries_select_participant_or_admin on public.financial_ledger_entries;
create policy financial_ledger_entries_select_participant_or_admin
on public.financial_ledger_entries for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists disputes_select_participant_or_admin on public.disputes;
create policy disputes_select_participant_or_admin
on public.disputes for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists refunds_select_participant_or_admin on public.refunds;
create policy refunds_select_participant_or_admin
on public.refunds for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id) or public.is_admin());

drop policy if exists payouts_select_participant_or_admin on public.payouts;
create policy payouts_select_participant_or_admin
on public.payouts for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists generated_documents_select_participant_or_admin on public.generated_documents;
create policy generated_documents_select_participant_or_admin
on public.generated_documents for select to authenticated
using (
  booking_id is not null
  and public.booking_is_visible_to_current_user(booking_id)
);

drop policy if exists email_delivery_logs_admin_only on public.email_delivery_logs;
create policy email_delivery_logs_admin_only
on public.email_delivery_logs for select to authenticated
using (public.is_admin());

drop policy if exists email_outbox_jobs_admin_only on public.email_outbox_jobs;
create policy email_outbox_jobs_admin_only
on public.email_outbox_jobs for select to authenticated
using (public.is_admin());

drop policy if exists email_templates_admin_only on public.email_templates;
create policy email_templates_admin_only
on public.email_templates for select to authenticated
using (public.is_admin());

drop policy if exists notifications_select_owner on public.notifications;
create policy notifications_select_owner
on public.notifications for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists notifications_update_owner on public.notifications;
create policy notifications_update_owner
on public.notifications for update to authenticated
using (profile_id = (select auth.uid()) or public.is_admin())
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists support_requests_select_participant_or_admin on public.support_requests;
create policy support_requests_select_participant_or_admin
on public.support_requests for select to authenticated
using (created_by = (select auth.uid()) or public.is_admin());

drop policy if exists support_messages_select_participant_or_admin on public.support_messages;
create policy support_messages_select_participant_or_admin
on public.support_messages for select to authenticated
using (
  exists (
    select 1
    from public.support_requests as sr
    where sr.id = request_id
      and (sr.created_by = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists user_devices_owner_or_admin on public.user_devices;
drop policy if exists user_devices_select_owner_or_admin on public.user_devices;
create policy user_devices_select_owner_or_admin
on public.user_devices for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_insert_owner_or_admin on public.user_devices;
create policy user_devices_insert_owner_or_admin
on public.user_devices for insert to authenticated
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_update_owner_or_admin on public.user_devices;
create policy user_devices_update_owner_or_admin
on public.user_devices for update to authenticated
using (profile_id = (select auth.uid()) or public.is_admin())
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_delete_owner_or_admin on public.user_devices;
create policy user_devices_delete_owner_or_admin
on public.user_devices for delete to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists platform_settings_admin_only on public.platform_settings;
create policy platform_settings_admin_only
on public.platform_settings for all to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists admin_audit_logs_admin_read_only on public.admin_audit_logs;
create policy admin_audit_logs_admin_read_only
on public.admin_audit_logs for select to authenticated
using (public.is_admin());

drop policy if exists upload_sessions_select_owner_or_admin on public.upload_sessions;
create policy upload_sessions_select_owner_or_admin
on public.upload_sessions for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists security_rate_limits_admin_only on public.security_rate_limits;
create policy security_rate_limits_admin_only
on public.security_rate_limits for select to authenticated
using (public.is_admin());

drop policy if exists security_abuse_events_admin_only on public.security_abuse_events;
create policy security_abuse_events_admin_only
on public.security_abuse_events for select to authenticated
using (public.is_admin());

drop policy if exists payment_proofs_upload_via_session on storage.objects;
-- <<< END 20260317150500_enable_rls_and_create_table_policies.sql

-- >>> BEGIN 20260317150600_create_storage_policies_and_security_triggers.sql
create policy payment_proofs_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'payment-proofs'
  and public.can_upload_storage_object(bucket_id, name)
);

drop policy if exists verification_documents_upload_via_session on storage.objects;
create policy verification_documents_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'verification-documents'
  and public.can_upload_storage_object(bucket_id, name)
);

create or replace trigger upload_sessions_set_updated_at
before update on public.upload_sessions
for each row execute function public.set_updated_at();

create or replace trigger security_rate_limits_set_updated_at
before update on public.security_rate_limits
for each row execute function public.set_updated_at();

create or replace trigger support_requests_set_updated_at
before update on public.support_requests
for each row execute function public.set_updated_at();

create or replace trigger profiles_normalize_columns
before insert or update on public.profiles
for each row execute function public.normalize_profile_columns();

create or replace trigger profiles_protect_sensitive_columns
before insert or update on public.profiles
for each row execute function public.protect_profile_sensitive_columns();

create or replace trigger vehicles_protect_sensitive_columns
before insert or update on public.vehicles
for each row execute function public.protect_vehicle_sensitive_columns();

create or replace trigger payout_accounts_protect_sensitive_columns
before insert or update on public.payout_accounts
for each row execute function public.protect_payout_account_sensitive_columns();

create or replace trigger payment_proofs_append_only_guard
before update or delete on public.payment_proofs
for each row execute function public.enforce_append_only_history();

create or replace trigger verification_documents_append_only_guard
before update or delete on public.verification_documents
for each row execute function public.enforce_append_only_history();

create or replace trigger tracking_events_append_only_guard
before update or delete on public.tracking_events
for each row execute function public.enforce_append_only_history();

create or replace trigger financial_ledger_entries_append_only_guard
before update or delete on public.financial_ledger_entries
for each row execute function public.enforce_append_only_history();

create or replace trigger admin_audit_logs_append_only_guard
before update or delete on public.admin_audit_logs
for each row execute function public.enforce_append_only_history();

create or replace trigger support_messages_append_only_guard
before update or delete on public.support_messages
for each row execute function public.enforce_append_only_history();
-- <<< END 20260317150600_create_storage_policies_and_security_triggers.sql

-- >>> BEGIN 20260317150700_grant_runtime_function_access.sql
revoke all on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) from public, anon, authenticated;
grant execute on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) to service_role;

revoke all on function public.require_recent_admin_step_up() from public, anon, authenticated;
grant execute on function public.require_recent_admin_step_up() to service_role;

revoke all on function public.get_client_settings() from public, anon;
grant execute on function public.get_client_settings() to authenticated, service_role;

revoke all on function public.claim_email_outbox_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_email_outbox_jobs(text, integer) to service_role;

revoke all on function public.release_retryable_email_job(uuid, text, text, integer) from public, anon, authenticated;
grant execute on function public.release_retryable_email_job(uuid, text, text, integer) to service_role;

revoke all on function public.complete_email_outbox_job(uuid, text, text, text, text) from public, anon, authenticated;
grant execute on function public.complete_email_outbox_job(uuid, text, text, text, text) to service_role;

revoke all on function public.record_email_dispatch_failure(uuid, public.email_delivery_status, text, text, text, text, text) from public, anon, authenticated;
grant execute on function public.record_email_dispatch_failure(uuid, public.email_delivery_status, text, text, text, text, text) to service_role;

revoke all on function public.record_email_provider_event(text, public.email_delivery_status, text, text) from public, anon, authenticated;
grant execute on function public.record_email_provider_event(text, public.email_delivery_status, text, text) to service_role;

revoke all on function public.recover_stale_email_outbox_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_email_outbox_jobs(integer) to service_role;

revoke all on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) from public, anon;
grant execute on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) to authenticated, service_role;

revoke all on function public.finalize_payment_proof(uuid, numeric, text) from public, anon;
grant execute on function public.finalize_payment_proof(uuid, numeric, text) to authenticated, service_role;

revoke all on function public.finalize_verification_document(uuid) from public, anon;
grant execute on function public.finalize_verification_document(uuid) to authenticated, service_role;

revoke all on function public.authorize_private_file_access(text, text) from public, anon;
grant execute on function public.authorize_private_file_access(text, text) to authenticated, service_role;

revoke all on function public.consume_rate_limit_for_actor(uuid, text, integer, integer) from public, anon;
grant execute on function public.consume_rate_limit_for_actor(uuid, text, integer, integer) to service_role;

revoke all on function public.assert_rate_limit_for_actor(uuid, text, integer, integer) from public, anon;
grant execute on function public.assert_rate_limit_for_actor(uuid, text, integer, integer) to service_role;

revoke all on function public.authorize_private_file_access_for_user(uuid, text, text) from public, anon;
grant execute on function public.authorize_private_file_access_for_user(uuid, text, text) to service_role;
-- <<< END 20260317150700_grant_runtime_function_access.sql
