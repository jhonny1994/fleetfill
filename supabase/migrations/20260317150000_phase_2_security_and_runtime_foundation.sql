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

create or replace function public.protect_profile_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
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
  if public.is_service_role() and current_setting('app.trusted_operation', true) = 'true' then
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
stable
security definer
set search_path = public
as $$
begin
  perform public.assert_rate_limit('signed_url_generation', 30, 60);

  if public.is_admin() then
    return true;
  end if;

  if p_bucket_id = 'payment-proofs' then
    return exists (
      select 1
      from public.payment_proofs as pp
      join public.bookings as b on b.id = pp.booking_id
      where pp.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  if p_bucket_id = 'verification-documents' then
    return exists (
      select 1
      from public.verification_documents as vd
      where vd.storage_path = p_object_path
        and vd.owner_profile_id = (select auth.uid())
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return exists (
      select 1
      from public.generated_documents as gd
      join public.bookings as b on b.id = gd.booking_id
      where gd.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  return false;
end;
$$;

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
    where ppa.is_active = true
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
      'truck_technical_inspection',
      'transport_license'
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

insert into storage.buckets (id, name, public)
values
  ('payment-proofs', 'payment-proofs', false),
  ('verification-documents', 'verification-documents', false),
  ('generated-documents', 'generated-documents', false)
on conflict (id) do update
set public = excluded.public;

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
alter table public.shipment_items enable row level security;
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
alter table public.notifications enable row level security;
alter table public.user_devices enable row level security;
alter table public.platform_settings enable row level security;
alter table public.admin_audit_logs enable row level security;
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

drop policy if exists shipment_items_select_owner_or_admin on public.shipment_items;
create policy shipment_items_select_owner_or_admin
on public.shipment_items for select to authenticated
using (public.shipment_is_visible_to_current_user(shipment_id));

drop policy if exists shipment_items_modify_owner_or_admin on public.shipment_items;
drop policy if exists shipment_items_insert_owner_or_admin on public.shipment_items;
create policy shipment_items_insert_owner_or_admin
on public.shipment_items for insert to authenticated
with check (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists shipment_items_update_owner_or_admin on public.shipment_items;
create policy shipment_items_update_owner_or_admin
on public.shipment_items for update to authenticated
using (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
)
with check (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists shipment_items_delete_owner_or_admin on public.shipment_items;
create policy shipment_items_delete_owner_or_admin
on public.shipment_items for delete to authenticated
using (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists bookings_select_participant_or_admin on public.bookings;
create policy bookings_select_participant_or_admin
on public.bookings for select to authenticated
using (
  shipper_id = (select auth.uid())
  or carrier_id = (select auth.uid())
  or public.is_admin()
);

drop policy if exists payment_proofs_select_participant_or_admin on public.payment_proofs;
create policy payment_proofs_select_participant_or_admin
on public.payment_proofs for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

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

drop policy if exists notifications_select_owner on public.notifications;
create policy notifications_select_owner
on public.notifications for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists notifications_update_owner on public.notifications;
create policy notifications_update_owner
on public.notifications for update to authenticated
using (profile_id = (select auth.uid()) or public.is_admin())
with check (profile_id = (select auth.uid()) or public.is_admin());

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

create or replace trigger profiles_normalize_columns
before insert or update on public.profiles
for each row execute function public.normalize_profile_columns();

create or replace trigger profiles_protect_sensitive_columns
before update on public.profiles
for each row execute function public.protect_profile_sensitive_columns();

create or replace trigger vehicles_protect_sensitive_columns
before update on public.vehicles
for each row execute function public.protect_vehicle_sensitive_columns();

create or replace trigger payout_accounts_protect_sensitive_columns
before update on public.payout_accounts
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

revoke all on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) from public, anon, authenticated;
grant execute on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) to service_role;

revoke all on function public.get_client_settings() from public, anon;
grant execute on function public.get_client_settings() to authenticated, service_role;

revoke all on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) from public, anon;
grant execute on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) to authenticated, service_role;

revoke all on function public.finalize_payment_proof(uuid, numeric, text) from public, anon;
grant execute on function public.finalize_payment_proof(uuid, numeric, text) to authenticated, service_role;

revoke all on function public.finalize_verification_document(uuid) from public, anon;
grant execute on function public.finalize_verification_document(uuid) to authenticated, service_role;

revoke all on function public.authorize_private_file_access(text, text) from public, anon;
grant execute on function public.authorize_private_file_access(text, text) to authenticated, service_role;
