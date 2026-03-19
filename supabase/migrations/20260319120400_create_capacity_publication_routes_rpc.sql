create or replace function public.create_carrier_route(
  p_vehicle_id uuid,
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_total_capacity_kg numeric,
  p_total_capacity_volume_m3 numeric,
  p_price_per_kg_dzd numeric,
  p_default_departure_time time,
  p_recurring_days_of_week integer[],
  p_effective_from timestamptz,
  p_is_active boolean
)
returns public.routes
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
  v_route public.routes;
begin
  v_actor_id := public.assert_verified_carrier_access();
  perform public.assert_carrier_vehicle_access(p_vehicle_id, true);

  if p_effective_from < now() - interval '5 minutes' then
    raise exception 'Route effective date must be now or later';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  insert into public.routes (
    carrier_id,
    vehicle_id,
    origin_commune_id,
    destination_commune_id,
    total_capacity_kg,
    total_capacity_volume_m3,
    price_per_kg_dzd,
    default_departure_time,
    recurring_days_of_week,
    effective_from,
    is_active
  ) values (
    v_actor_id,
    p_vehicle_id,
    p_origin_commune_id,
    p_destination_commune_id,
    p_total_capacity_kg,
    p_total_capacity_volume_m3,
    p_price_per_kg_dzd,
    p_default_departure_time,
    p_recurring_days_of_week,
    p_effective_from,
    p_is_active
  )
  returning * into v_route;

  insert into public.route_revisions (
    route_id,
    vehicle_id,
    origin_commune_id,
    destination_commune_id,
    total_capacity_kg,
    total_capacity_volume_m3,
    price_per_kg_dzd,
    default_departure_time,
    recurring_days_of_week,
    effective_from,
    created_by
  ) values (
    v_route.id,
    p_vehicle_id,
    p_origin_commune_id,
    p_destination_commune_id,
    p_total_capacity_kg,
    p_total_capacity_volume_m3,
    p_price_per_kg_dzd,
    p_default_departure_time,
    p_recurring_days_of_week,
    p_effective_from,
    v_actor_id
  );

  perform set_config('app.trusted_operation', 'false', true);
  return v_route;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.update_route_with_revision(
  p_route_id uuid,
  p_vehicle_id uuid,
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_total_capacity_kg numeric,
  p_total_capacity_volume_m3 numeric,
  p_price_per_kg_dzd numeric,
  p_default_departure_time time,
  p_recurring_days_of_week integer[],
  p_effective_from timestamptz,
  p_is_active boolean
)
returns public.routes
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
  v_route public.routes;
begin
  v_actor_id := public.assert_verified_carrier_access();
  perform public.assert_carrier_vehicle_access(p_vehicle_id, true);

  if p_effective_from < now() - interval '5 minutes' then
    raise exception 'Route effective date must be now or later';
  end if;

  select * into v_route
  from public.routes
  where id = p_route_id
    and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Route not found';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.routes
  set
    vehicle_id = p_vehicle_id,
    origin_commune_id = p_origin_commune_id,
    destination_commune_id = p_destination_commune_id,
    total_capacity_kg = p_total_capacity_kg,
    total_capacity_volume_m3 = p_total_capacity_volume_m3,
    price_per_kg_dzd = p_price_per_kg_dzd,
    default_departure_time = p_default_departure_time,
    recurring_days_of_week = p_recurring_days_of_week,
    effective_from = p_effective_from,
    is_active = p_is_active
  where id = p_route_id
  returning * into v_route;

  insert into public.route_revisions (
    route_id,
    vehicle_id,
    origin_commune_id,
    destination_commune_id,
    total_capacity_kg,
    total_capacity_volume_m3,
    price_per_kg_dzd,
    default_departure_time,
    recurring_days_of_week,
    effective_from,
    created_by
  ) values (
    p_route_id,
    p_vehicle_id,
    p_origin_commune_id,
    p_destination_commune_id,
    p_total_capacity_kg,
    p_total_capacity_volume_m3,
    p_price_per_kg_dzd,
    p_default_departure_time,
    p_recurring_days_of_week,
    p_effective_from,
    v_actor_id
  );

  perform set_config('app.trusted_operation', 'false', true);
  return v_route;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;
