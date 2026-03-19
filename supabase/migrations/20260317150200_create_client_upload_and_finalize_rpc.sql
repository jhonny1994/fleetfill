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
        'local'
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
