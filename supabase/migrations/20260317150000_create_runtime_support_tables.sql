do $$ begin
  create type public.upload_session_status as enum ('authorized', 'finalized', 'cancelled', 'expired');
exception
  when duplicate_object then null;
end $$;

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

create index if not exists upload_sessions_bucket_status_expires_at_idx
on public.upload_sessions (bucket_id, status, expires_at);

create index if not exists security_rate_limits_actor_action_window_idx
on public.security_rate_limits (actor_id, action_key, window_started_at desc);

create index if not exists security_abuse_events_actor_action_created_at_idx
on public.security_abuse_events (actor_id, action_key, created_at desc);
