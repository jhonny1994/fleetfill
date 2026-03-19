create or replace function public.current_effective_verification_documents(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type default null,
  p_entity_id uuid default null
)
returns table (
  id uuid,
  owner_profile_id uuid,
  entity_type public.verification_document_entity_type,
  entity_id uuid,
  document_type text,
  storage_path text,
  status public.verification_status,
  rejection_reason text,
  reviewed_by uuid,
  reviewed_at timestamptz,
  expires_at timestamptz,
  version integer,
  content_type text,
  byte_size bigint,
  checksum_sha256 text,
  uploaded_by uuid,
  upload_session_id uuid,
  created_at timestamptz,
  updated_at timestamptz
)
language sql
stable
security definer
set search_path = public
as $$
  with ranked as (
    select
      vd.*,
      row_number() over (
        partition by vd.entity_type, vd.entity_id, vd.document_type
        order by vd.version desc, vd.created_at desc, vd.id desc
      ) as position_rank
    from public.verification_documents as vd
    where vd.owner_profile_id = p_owner_profile_id
      and (p_entity_type is null or vd.entity_type = p_entity_type)
      and (p_entity_id is null or vd.entity_id = p_entity_id)
  )
  select
    ranked.id,
    ranked.owner_profile_id,
    ranked.entity_type,
    ranked.entity_id,
    ranked.document_type,
    ranked.storage_path,
    ranked.status,
    ranked.rejection_reason,
    ranked.reviewed_by,
    ranked.reviewed_at,
    ranked.expires_at,
    ranked.version,
    ranked.content_type,
    ranked.byte_size,
    ranked.checksum_sha256,
    ranked.uploaded_by,
    ranked.upload_session_id,
    ranked.created_at,
    ranked.updated_at
  from ranked
  where ranked.position_rank = 1;
$$;

create or replace function public.required_verification_documents_complete(
  p_owner_profile_id uuid
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  with effective_docs as (
    select *
    from public.current_effective_verification_documents(p_owner_profile_id)
  ),
  carrier_vehicles as (
    select v.id
    from public.vehicles as v
    where v.carrier_id = p_owner_profile_id
  )
  select
    exists (
      select 1
      from effective_docs as ed
      where ed.entity_type = 'profile'
        and ed.entity_id = p_owner_profile_id
        and ed.document_type = 'driver_identity_or_license'
    )
    and exists (select 1 from carrier_vehicles)
    and not exists (
      select 1
      from carrier_vehicles as cv
      where not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_registration'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_insurance'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_technical_inspection'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'transport_license'
      )
    );
$$;

create or replace function public.refresh_verification_subject_status(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type,
  p_entity_id uuid
)
returns public.verification_status
language plpgsql
security definer
set search_path = public
as $$
declare
  v_target_status text := 'pending';
  v_target_reason text;
begin
  with effective_docs as (
    select *
    from public.current_effective_verification_documents(
      p_owner_profile_id,
      p_entity_type,
      p_entity_id
    )
  )
  select case
    when exists (
      select 1 from effective_docs as ed where ed.status = 'rejected'
    ) then 'rejected'
    when exists (
      select 1 from effective_docs as ed where ed.status = 'pending'
    ) then 'pending'
    when exists (select 1 from effective_docs) then 'verified'
    else 'pending'
  end,
  (
    select ed.rejection_reason
    from effective_docs as ed
    where ed.status = 'rejected'
    order by ed.reviewed_at desc nulls last, ed.updated_at desc, ed.created_at desc
    limit 1
  )
  into v_target_status, v_target_reason;

  if p_entity_type = 'profile' then
    update public.profiles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  else
    update public.vehicles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  end if;

  return v_target_status::public.verification_status;
end;
$$;

create or replace function public.admin_review_verification_document(
  p_document_id uuid,
  p_status public.verification_status,
  p_reason text default null
)
returns public.verification_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_reason text := nullif(trim(coalesce(p_reason, '')), '');
  v_document public.verification_documents;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin verification review requires privileged access';
  end if;

  if p_status not in ('verified', 'rejected') then
    raise exception 'Verification review status must be verified or rejected';
  end if;

  if p_status = 'rejected' and v_reason is null then
    raise exception 'Verification rejection requires a reason';
  end if;

  select * into v_document
  from public.verification_documents
  where id = p_document_id;

  if not found then
    raise exception 'Verification document not found';
  end if;

  if v_document.status = p_status
    and coalesce(v_document.rejection_reason, '') = coalesce(v_reason, '') then
    return v_document;
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.verification_documents
  set status = p_status,
      rejection_reason = case when p_status = 'rejected' then v_reason else null end,
      reviewed_by = v_actor_id,
      reviewed_at = now(),
      updated_at = now()
  where id = p_document_id
  returning * into v_document;

  perform public.refresh_verification_subject_status(
    v_document.owner_profile_id,
    v_document.entity_type,
    v_document.entity_id
  );

  perform public.write_admin_audit_log(
    case
      when p_status = 'verified' then 'verification_document_approved'
      else 'verification_document_rejected'
    end,
    case
      when v_document.entity_type = 'profile' then 'profile_verification_document'
      else 'vehicle_verification_document'
    end,
    v_document.id,
    p_status::text,
    v_reason,
    jsonb_build_object(
      'entity_id', v_document.entity_id,
      'entity_type', v_document.entity_type,
      'document_type', v_document.document_type,
      'version', v_document.version
    )
  );

  perform set_config('app.trusted_operation', 'false', true);

  return v_document;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.admin_approve_verification_packet(
  p_carrier_id uuid
)
returns table (
  action text,
  target_id uuid,
  outcome text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_record public.profiles;
  v_document_id uuid;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin packet approval requires privileged access';
  end if;

  select * into v_profile_record
  from public.profiles
  where id = p_carrier_id;

  if not found then
    raise exception 'Carrier profile not found';
  end if;

  if v_profile_record.role is distinct from 'carrier'::public.app_role then
    raise exception 'Verification packet approval requires a carrier profile';
  end if;

  if not public.required_verification_documents_complete(p_carrier_id) then
    raise exception 'Verification packet is incomplete';
  end if;

  for v_document_id in
    select ed.id
    from public.current_effective_verification_documents(p_carrier_id) as ed
    where ed.status <> 'verified'
    order by ed.entity_type, ed.entity_id, ed.document_type
  loop
    perform public.admin_review_verification_document(v_document_id, 'verified');
    action := 'verification_document_approved';
    target_id := v_document_id;
    outcome := 'verified';
    return next;
  end loop;

  perform set_config('app.trusted_operation', 'true', true);

  perform public.refresh_verification_subject_status(
    p_carrier_id,
    'profile',
    p_carrier_id
  );

  perform public.refresh_verification_subject_status(
    p_carrier_id,
    'vehicle',
    v.id
  )
  from public.vehicles as v
  where v.carrier_id = p_carrier_id;

  perform public.write_admin_audit_log(
    'verification_packet_approved',
    'verification_packet',
    p_carrier_id,
    'verified',
    null,
    jsonb_build_object('carrier_id', p_carrier_id)
  );

  perform set_config('app.trusted_operation', 'false', true);

  action := 'verification_packet_approved';
  target_id := p_carrier_id;
  outcome := 'verified';
  return next;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

revoke all on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;

revoke all on function public.required_verification_documents_complete(uuid) from public, anon;
grant execute on function public.required_verification_documents_complete(uuid) to authenticated, service_role;

revoke all on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;

revoke all on function public.admin_review_verification_document(uuid, public.verification_status, text) from public, anon;
grant execute on function public.admin_review_verification_document(uuid, public.verification_status, text) to authenticated, service_role;

revoke all on function public.admin_approve_verification_packet(uuid) from public, anon;
grant execute on function public.admin_approve_verification_packet(uuid) to authenticated, service_role;
