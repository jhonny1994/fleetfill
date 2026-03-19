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
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification document access requires privileged access';
  end if;

  return query
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
end;
$$;

create or replace function public.required_verification_documents_complete(
  p_owner_profile_id uuid
)
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_complete boolean;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification completeness requires privileged access';
  end if;

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
    )
  into v_complete;

  return coalesce(v_complete, false);
end;
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
  v_vehicle_docs_complete boolean := true;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification status refresh requires privileged access';
  end if;

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

  if p_entity_type = 'vehicle' and v_target_status = 'verified' then
    with effective_docs as (
      select *
      from public.current_effective_verification_documents(
        p_owner_profile_id,
        p_entity_type,
        p_entity_id
      )
    )
    select
      exists (
        select 1 from effective_docs where document_type = 'truck_registration'
      )
      and exists (
        select 1 from effective_docs where document_type = 'truck_insurance'
      )
      and exists (
        select 1 from effective_docs where document_type = 'truck_technical_inspection'
      )
      and exists (
        select 1 from effective_docs where document_type = 'transport_license'
      )
    into v_vehicle_docs_complete;

    if not coalesce(v_vehicle_docs_complete, false) then
      v_target_status := 'pending';
    end if;
  end if;

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

revoke all on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;

revoke all on function public.required_verification_documents_complete(uuid) from public, anon;
grant execute on function public.required_verification_documents_complete(uuid) to authenticated, service_role;

revoke all on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;
