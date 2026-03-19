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
