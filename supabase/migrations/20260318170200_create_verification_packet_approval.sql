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

revoke all on function public.admin_approve_verification_packet(uuid) from public, anon;
grant execute on function public.admin_approve_verification_packet(uuid) to authenticated, service_role;
