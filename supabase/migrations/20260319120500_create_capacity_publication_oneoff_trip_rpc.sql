create or replace function public.create_oneoff_trip(
  p_vehicle_id uuid,
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_departure_at timestamptz,
  p_total_capacity_kg numeric,
  p_total_capacity_volume_m3 numeric,
  p_price_per_kg_dzd numeric,
  p_is_active boolean
)
returns public.oneoff_trips
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
  v_trip public.oneoff_trips;
begin
  v_actor_id := public.assert_verified_carrier_access();
  perform public.assert_carrier_vehicle_access(p_vehicle_id, true);

  if p_departure_at <= now() then
    raise exception 'One-off trip departure must be in the future';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  insert into public.oneoff_trips (
    carrier_id,
    vehicle_id,
    origin_commune_id,
    destination_commune_id,
    departure_at,
    total_capacity_kg,
    total_capacity_volume_m3,
    price_per_kg_dzd,
    is_active
  ) values (
    v_actor_id,
    p_vehicle_id,
    p_origin_commune_id,
    p_destination_commune_id,
    p_departure_at,
    p_total_capacity_kg,
    p_total_capacity_volume_m3,
    p_price_per_kg_dzd,
    p_is_active
  )
  returning * into v_trip;

  perform set_config('app.trusted_operation', 'false', true);
  return v_trip;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

create or replace function public.update_oneoff_trip(
  p_trip_id uuid,
  p_vehicle_id uuid,
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_departure_at timestamptz,
  p_total_capacity_kg numeric,
  p_total_capacity_volume_m3 numeric,
  p_price_per_kg_dzd numeric,
  p_is_active boolean
)
returns public.oneoff_trips
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
  v_trip public.oneoff_trips;
begin
  v_actor_id := public.assert_verified_carrier_access();
  perform public.assert_carrier_vehicle_access(p_vehicle_id, true);

  if p_departure_at <= now() then
    raise exception 'One-off trip departure must be in the future';
  end if;

  select * into v_trip
  from public.oneoff_trips
  where id = p_trip_id
    and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'One-off trip not found';
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.oneoff_trips
  set
    vehicle_id = p_vehicle_id,
    origin_commune_id = p_origin_commune_id,
    destination_commune_id = p_destination_commune_id,
    departure_at = p_departure_at,
    total_capacity_kg = p_total_capacity_kg,
    total_capacity_volume_m3 = p_total_capacity_volume_m3,
    price_per_kg_dzd = p_price_per_kg_dzd,
    is_active = p_is_active
  where id = p_trip_id
  returning * into v_trip;

  perform set_config('app.trusted_operation', 'false', true);
  return v_trip;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;
