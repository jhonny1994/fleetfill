create or replace function public.is_active_carrier(
  p_profile_id uuid default null
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = coalesce(p_profile_id, (select auth.uid()))
      and role = 'carrier'::public.app_role
      and is_active = true
  );
$$;

create or replace function public.is_verified_carrier(
  p_profile_id uuid default null
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = coalesce(p_profile_id, (select auth.uid()))
      and role = 'carrier'::public.app_role
      and is_active = true
      and verification_status = 'verified'::public.verification_status
  );
$$;

create or replace function public.assert_active_carrier_access()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if public.is_admin() or public.is_service_role() then
    return v_actor_id;
  end if;

  if not public.is_active_carrier(v_actor_id) then
    raise exception 'Only active carriers may manage vehicles or payout accounts';
  end if;

  return v_actor_id;
end;
$$;

create or replace function public.assert_verified_carrier_access()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if public.is_admin() or public.is_service_role() then
    return v_actor_id;
  end if;

  if not public.is_verified_carrier(v_actor_id) then
    raise exception 'Only active verified carriers may publish capacity';
  end if;

  return v_actor_id;
end;
$$;

create or replace function public.assert_carrier_vehicle_access(
  p_vehicle_id uuid,
  p_require_verified boolean default true
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
begin
  v_actor_id := case
    when p_require_verified then public.assert_verified_carrier_access()
    else public.assert_active_carrier_access()
  end;

  if not exists (
    select 1
    from public.vehicles
    where id = p_vehicle_id
      and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
      and (
        not p_require_verified
        or verification_status = 'verified'::public.verification_status
      )
  ) then
    if p_require_verified then
      raise exception 'A verified vehicle is required for capacity publication';
    end if;

    raise exception 'Vehicle is unavailable for this carrier';
  end if;
end;
$$;
