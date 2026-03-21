create or replace function public.admin_set_profile_active(
  p_profile_id uuid,
  p_is_active boolean,
  p_reason text default null
)
returns public.profiles
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.profiles;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Profile activation changes require privileged execution';
  end if;

  perform public.require_recent_admin_step_up();

  if p_profile_id is null then
    raise exception 'Profile id is required';
  end if;

  if v_actor_id = p_profile_id and coalesce(p_is_active, true) = false then
    raise exception 'Admins cannot suspend their own account';
  end if;

  update public.profiles
  set is_active = coalesce(p_is_active, true),
      updated_at = now()
  where id = p_profile_id
  returning * into v_result;

  if not found then
    raise exception 'Profile not found';
  end if;

  perform public.write_admin_audit_log(
    case when v_result.is_active then 'profile_reactivated' else 'profile_suspended' end,
    'profile',
    v_result.id,
    'success',
    left(nullif(trim(p_reason), ''), 500),
    jsonb_build_object('is_active', v_result.is_active)
  );

  return v_result;
end;
$$;

revoke all on function public.admin_set_profile_active(uuid, boolean, text) from public, anon;
grant execute on function public.admin_set_profile_active(uuid, boolean, text) to authenticated, service_role;
