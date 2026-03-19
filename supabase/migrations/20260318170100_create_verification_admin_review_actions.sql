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

revoke all on function public.admin_review_verification_document(uuid, public.verification_status, text) from public, anon;
grant execute on function public.admin_review_verification_document(uuid, public.verification_status, text) to authenticated, service_role;
