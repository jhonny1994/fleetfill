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
