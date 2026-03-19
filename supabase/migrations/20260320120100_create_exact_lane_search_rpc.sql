create or replace function public.search_exact_lane_capacity(
  p_origin_commune_id integer,
  p_destination_commune_id integer,
  p_requested_date date,
  p_total_weight_kg numeric,
  p_total_volume_m3 numeric default null,
  p_limit integer default 20,
  p_offset integer default 0
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_mode text := 'exact';
  v_requested_day integer := extract(dow from p_requested_date);
  v_normalized_limit integer := greatest(1, least(coalesce(p_limit, 20), 50));
  v_normalized_offset integer := greatest(coalesce(p_offset, 0), 0);
  v_results jsonb := '[]'::jsonb;
  v_total_count integer := 0;
  v_nearest_dates jsonb := '[]'::jsonb;
  v_exact_exists boolean := false;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if p_total_weight_kg <= 0 then
    raise exception 'Shipment weight must be greater than zero';
  end if;

  if not public.is_admin() and not public.is_service_role() then
    if not exists (
      select 1
      from public.profiles
      where id = v_actor_id
        and role = 'shipper'::public.app_role
        and is_active = true
    ) then
      raise exception 'Only active shippers may search exact lane capacity';
    end if;
  end if;

  with recurring_candidates as (
    select
      r.id as source_id,
      'route'::text as source_type,
      r.carrier_id,
      rr.vehicle_id,
      r.origin_commune_id,
      r.destination_commune_id,
      (p_requested_date::timestamp + rr.default_departure_time)::timestamptz as departure_at,
      rr.total_capacity_kg,
      rr.total_capacity_volume_m3,
      rr.price_per_kg_dzd,
      coalesce(rdi.remaining_capacity_kg, rr.total_capacity_kg - coalesce(rb.booked_weight_kg, 0)) as remaining_capacity_kg,
      case
        when rr.total_capacity_volume_m3 is null then null
        else coalesce(rdi.remaining_volume_m3, rr.total_capacity_volume_m3 - coalesce(rb.booked_volume_m3, 0))
      end as remaining_volume_m3,
      p_requested_date as departure_date
    from public.routes as r
    join lateral (
      select rv.*
      from public.route_revisions as rv
      where rv.route_id = r.id
        and rv.effective_from::date <= p_requested_date
      order by rv.effective_from desc, rv.created_at desc
      limit 1
    ) as rr on true
    left join public.route_departure_instances as rdi
      on rdi.route_id = r.id
     and rdi.departure_date = p_requested_date
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.route_id = r.id
        and b.route_departure_date = p_requested_date
        and b.booking_status <> 'cancelled'
    ) as rb on true
    where r.is_active = true
      and r.origin_commune_id = p_origin_commune_id
      and r.destination_commune_id = p_destination_commune_id
      and v_requested_day = any(rr.recurring_days_of_week)
      and (p_requested_date > current_date or (p_requested_date = current_date and rr.default_departure_time >= localtime))
  ),
  oneoff_candidates as (
    select
      t.id as source_id,
      'oneoff_trip'::text as source_type,
      t.carrier_id,
      t.vehicle_id,
      t.origin_commune_id,
      t.destination_commune_id,
      t.departure_at,
      t.total_capacity_kg,
      t.total_capacity_volume_m3,
      t.price_per_kg_dzd,
      t.total_capacity_kg - coalesce(tb.booked_weight_kg, 0) as remaining_capacity_kg,
      case
        when t.total_capacity_volume_m3 is null then null
        else t.total_capacity_volume_m3 - coalesce(tb.booked_volume_m3, 0)
      end as remaining_volume_m3,
      t.departure_at::date as departure_date
    from public.oneoff_trips as t
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.oneoff_trip_id = t.id
        and b.booking_status <> 'cancelled'
    ) as tb on true
    where t.is_active = true
      and t.origin_commune_id = p_origin_commune_id
      and t.destination_commune_id = p_destination_commune_id
      and t.departure_at::date = p_requested_date
      and t.departure_at >= now()
  ),
  exact_candidates as (
    select * from recurring_candidates
    union all
    select * from oneoff_candidates
  )
  select exists(select 1 from exact_candidates) into v_exact_exists;

  if not v_exact_exists then
    v_mode := 'nearest_date';
  end if;

  with recursive upcoming_dates as (
    select p_requested_date as departure_date
    union all
    select departure_date + 1
    from upcoming_dates
    where departure_date < p_requested_date + 7
  ),
  recurring_candidates as (
    select
      r.id as source_id,
      'route'::text as source_type,
      r.carrier_id,
      rr.vehicle_id,
      r.origin_commune_id,
      r.destination_commune_id,
      (d.departure_date::timestamp + rr.default_departure_time)::timestamptz as departure_at,
      rr.total_capacity_kg,
      rr.total_capacity_volume_m3,
      rr.price_per_kg_dzd,
      coalesce(rdi.remaining_capacity_kg, rr.total_capacity_kg - coalesce(rb.booked_weight_kg, 0)) as remaining_capacity_kg,
      case
        when rr.total_capacity_volume_m3 is null then null
        else coalesce(rdi.remaining_volume_m3, rr.total_capacity_volume_m3 - coalesce(rb.booked_volume_m3, 0))
      end as remaining_volume_m3,
      d.departure_date,
      abs(d.departure_date - p_requested_date) as day_distance
    from upcoming_dates as d
    join public.routes as r
      on r.is_active = true
     and r.origin_commune_id = p_origin_commune_id
     and r.destination_commune_id = p_destination_commune_id
    join lateral (
      select rv.*
      from public.route_revisions as rv
      where rv.route_id = r.id
        and rv.effective_from::date <= d.departure_date
      order by rv.effective_from desc, rv.created_at desc
      limit 1
    ) as rr on true
    left join public.route_departure_instances as rdi
      on rdi.route_id = r.id
     and rdi.departure_date = d.departure_date
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.route_id = r.id
        and b.route_departure_date = d.departure_date
        and b.booking_status <> 'cancelled'
    ) as rb on true
    where extract(dow from d.departure_date)::int = any(rr.recurring_days_of_week)
      and (d.departure_date > current_date or (d.departure_date = current_date and rr.default_departure_time >= localtime))
  ),
  oneoff_candidates as (
    select
      t.id as source_id,
      'oneoff_trip'::text as source_type,
      t.carrier_id,
      t.vehicle_id,
      t.origin_commune_id,
      t.destination_commune_id,
      t.departure_at,
      t.total_capacity_kg,
      t.total_capacity_volume_m3,
      t.price_per_kg_dzd,
      t.total_capacity_kg - coalesce(tb.booked_weight_kg, 0) as remaining_capacity_kg,
      case
        when t.total_capacity_volume_m3 is null then null
        else t.total_capacity_volume_m3 - coalesce(tb.booked_volume_m3, 0)
      end as remaining_volume_m3,
      t.departure_at::date as departure_date,
      abs((t.departure_at::date) - p_requested_date) as day_distance
    from public.oneoff_trips as t
    left join lateral (
      select
        coalesce(sum(b.weight_kg), 0) as booked_weight_kg,
        coalesce(sum(coalesce(b.volume_m3, 0)), 0) as booked_volume_m3
      from public.bookings as b
      where b.oneoff_trip_id = t.id
        and b.booking_status <> 'cancelled'
    ) as tb on true
    where t.is_active = true
      and t.origin_commune_id = p_origin_commune_id
      and t.destination_commune_id = p_destination_commune_id
      and t.departure_at::date between p_requested_date and p_requested_date + 7
      and t.departure_at >= now()
  ),
  combined as (
    select * from recurring_candidates
    union all
    select * from oneoff_candidates
  ),
  ranked as (
    select
      c.*,
      p.full_name,
      p.company_name,
      coalesce(p.rating_average, 0) as rating_average,
      coalesce(p.rating_count, 0) as rating_count,
      (p_total_weight_kg * c.price_per_kg_dzd) as estimated_total_dzd,
      case when c.remaining_capacity_kg >= p_total_weight_kg then 1 else 0 end as has_weight_capacity,
      case
        when p_total_volume_m3 is null or c.remaining_volume_m3 is null then 1
        when c.remaining_volume_m3 >= p_total_volume_m3 then 1
        else 0
      end as has_volume_capacity
    from combined as c
    join public.profiles as p on p.id = c.carrier_id
  ),
  filtered as (
    select *
    from ranked
    where has_weight_capacity = 1
      and has_volume_capacity = 1
      and (
        v_mode = 'nearest_date'
        or departure_date = p_requested_date
      )
  ),
  counted as (
    select count(*) as total_count from filtered
  ),
  paged as (
    select *
    from filtered
    order by
      day_distance asc,
      rating_average desc,
      estimated_total_dzd asc,
      departure_at asc,
      source_type asc,
      source_id asc
    offset v_normalized_offset
    limit v_normalized_limit
  )
  select
    coalesce((select total_count from counted), 0),
    coalesce(
      (
        select jsonb_agg(
          jsonb_build_object(
            'source_id', p.source_id,
            'source_type', p.source_type,
            'carrier_id', p.carrier_id,
            'carrier_name', coalesce(nullif(trim(p.company_name), ''), nullif(trim(p.full_name), ''), p.carrier_id::text),
            'vehicle_id', p.vehicle_id,
            'origin_commune_id', p.origin_commune_id,
            'destination_commune_id', p.destination_commune_id,
            'departure_at', p.departure_at,
            'departure_date', p.departure_date,
            'total_capacity_kg', p.total_capacity_kg,
            'total_capacity_volume_m3', p.total_capacity_volume_m3,
            'remaining_capacity_kg', p.remaining_capacity_kg,
            'remaining_volume_m3', p.remaining_volume_m3,
            'price_per_kg_dzd', p.price_per_kg_dzd,
            'estimated_total_dzd', p.estimated_total_dzd,
            'rating_average', p.rating_average,
            'rating_count', p.rating_count,
            'day_distance', p.day_distance
          )
        )
        from paged as p
      ),
      '[]'::jsonb
    ),
    coalesce(
      (
        select jsonb_agg(to_jsonb(nd.departure_date))
        from (
          select distinct departure_date
          from filtered
          order by departure_date asc
          limit 5
        ) as nd
      ),
      '[]'::jsonb
    )
  into v_total_count, v_results, v_nearest_dates;

  if v_total_count = 0 then
    v_mode := 'redefine_search';
  end if;

  return jsonb_build_object(
    'mode', v_mode,
    'results', v_results,
    'nearest_dates', v_nearest_dates,
    'next_offset', case when v_normalized_offset + v_normalized_limit < v_total_count then v_normalized_offset + v_normalized_limit else null end,
    'total_count', v_total_count
  );
end;
$$;

revoke all on function public.search_exact_lane_capacity(integer, integer, date, numeric, numeric, integer, integer) from public, anon;
grant execute on function public.search_exact_lane_capacity(integer, integer, date, numeric, numeric, integer, integer) to authenticated, service_role;
