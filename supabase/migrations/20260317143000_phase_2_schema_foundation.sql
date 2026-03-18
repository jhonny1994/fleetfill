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

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  role public.app_role,
  full_name text,
  phone_number text,
  email text not null,
  company_name text,
  avatar_url text,
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
  pickup_window_start timestamptz not null,
  pickup_window_end timestamptz not null,
  total_weight_kg numeric not null,
  total_volume_m3 numeric,
  category text not null,
  description text,
  status public.shipment_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.shipment_items (
  id uuid primary key default gen_random_uuid(),
  shipment_id uuid not null references public.shipments (id) on delete cascade,
  label text not null,
  quantity integer not null,
  weight_kg numeric,
  volume_m3 numeric,
  notes text,
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

create table if not exists public.email_delivery_logs (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references public.profiles (id) on delete set null,
  booking_id uuid references public.bookings (id) on delete set null,
  template_key text not null,
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

create index if not exists shipment_items_shipment_id_idx
on public.shipment_items (shipment_id);

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

create or replace trigger shipment_items_set_updated_at
before update on public.shipment_items
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

create or replace trigger user_devices_set_updated_at
before update on public.user_devices
for each row execute function public.set_updated_at();

create or replace trigger platform_settings_set_updated_at
before update on public.platform_settings
for each row execute function public.set_updated_at();
