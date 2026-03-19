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
