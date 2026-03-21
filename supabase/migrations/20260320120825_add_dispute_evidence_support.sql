insert into storage.buckets (id, name, public)
values ('dispute-evidence', 'dispute-evidence', false)
on conflict (id) do nothing;

create table if not exists public.dispute_evidence (
  id uuid primary key default gen_random_uuid(),
  dispute_id uuid not null references public.disputes (id) on delete cascade,
  storage_path text not null,
  note text,
  content_type text,
  byte_size bigint,
  checksum_sha256 text,
  uploaded_by uuid references public.profiles (id),
  upload_session_id uuid references public.upload_sessions (id),
  version integer not null default 1,
  created_at timestamptz not null default now()
);

create unique index if not exists dispute_evidence_dispute_version_idx
on public.dispute_evidence (dispute_id, version);

create index if not exists dispute_evidence_dispute_created_at_idx
on public.dispute_evidence (dispute_id, created_at desc);

alter table public.dispute_evidence enable row level security;

drop policy if exists dispute_evidence_select_participant_or_admin on public.dispute_evidence;
create policy dispute_evidence_select_participant_or_admin
on public.dispute_evidence for select to authenticated
using (
  exists (
    select 1
    from public.disputes as d
    join public.bookings as b on b.id = d.booking_id
    where d.id = dispute_id
      and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists dispute_evidence_upload_via_session on storage.objects;
create policy dispute_evidence_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'dispute-evidence'
  and public.can_upload_storage_object(bucket_id, name)
);

create or replace trigger dispute_evidence_append_only_guard
before update or delete on public.dispute_evidence
for each row execute function public.enforce_append_only_history();

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

  if p_bucket_id = 'dispute-evidence' then
    return format('%s/%s/file.%s', p_entity_id, p_version, v_extension);
  end if;

  raise exception 'Unsupported bucket %', p_bucket_id;
end;
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
        and b.shipper_id = (select auth.uid())
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

  if p_bucket_id = 'dispute-evidence' then
    return exists (
      select 1
      from public.dispute_evidence as de
      join public.disputes as d on d.id = de.dispute_id
      join public.bookings as b on b.id = d.booking_id
      where de.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  return false;
end;
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
  elsif trim(lower(p_upload_kind)) = 'dispute_evidence' then
    perform public.assert_rate_limit('dispute_evidence_upload', 20, 3600);
    v_bucket_id := 'dispute-evidence';

    if v_entity_type <> 'dispute' then
      raise exception 'Dispute evidence uploads must target a dispute';
    end if;

    select d.opened_by
    into v_owner_profile_id
    from public.disputes as d
    where d.id = p_entity_id
      and d.status = 'open'
      and d.opened_by = v_profile_id;

    if not found then
      raise exception 'You cannot upload evidence for this dispute';
    end if;

    select coalesce(max(de.version), 0) + 1
    into v_version
    from public.dispute_evidence as de
    where de.dispute_id = p_entity_id;

    v_document_type := 'evidence';
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

create or replace function public.finalize_dispute_evidence(
  p_upload_session_id uuid,
  p_note text default null
)
returns public.dispute_evidence
language plpgsql
security definer
set search_path = public
as $$
declare
  v_session public.upload_sessions;
  v_result public.dispute_evidence;
  v_object_exists boolean;
begin
  select * into v_session
  from public.upload_sessions
  where id = p_upload_session_id
    and profile_id = (select auth.uid())
    and bucket_id = 'dispute-evidence';

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
    raise exception 'Uploaded dispute evidence file is missing or metadata does not match the authorized session';
  end if;

  insert into public.dispute_evidence (
    dispute_id,
    storage_path,
    note,
    content_type,
    byte_size,
    checksum_sha256,
    uploaded_by,
    upload_session_id,
    version
  )
  values (
    v_session.entity_id,
    v_session.object_path,
    left(nullif(trim(p_note), ''), 500),
    v_session.content_type,
    v_session.byte_size,
    v_session.checksum_sha256,
    (select auth.uid()),
    v_session.id,
    (
      select coalesce(max(de.version), 0) + 1
      from public.dispute_evidence as de
      where de.dispute_id = v_session.entity_id
    )
  ) returning * into v_result;

  update public.upload_sessions
  set status = 'finalized', finalized_at = now(), updated_at = now()
  where id = v_session.id;

  return v_result;
end;
$$;

revoke all on function public.finalize_dispute_evidence(uuid, text) from public, anon;
grant execute on function public.finalize_dispute_evidence(uuid, text) to authenticated, service_role;
