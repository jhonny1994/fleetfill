insert into public.route_revisions (
  route_id,
  vehicle_id,
  total_capacity_kg,
  total_capacity_volume_m3,
  price_per_kg_dzd,
  default_departure_time,
  recurring_days_of_week,
  effective_from,
  created_by,
  created_at
)
select
  r.id,
  r.vehicle_id,
  r.total_capacity_kg,
  r.total_capacity_volume_m3,
  r.price_per_kg_dzd,
  r.default_departure_time,
  r.recurring_days_of_week,
  r.effective_from,
  r.carrier_id,
  r.created_at
from public.routes as r
where not exists (
  select 1
  from public.route_revisions as rr
  where rr.route_id = r.id
);

alter table public.route_revisions
add column if not exists origin_commune_id integer references public.communes (id),
add column if not exists destination_commune_id integer references public.communes (id);

update public.route_revisions as rr
set
  origin_commune_id = r.origin_commune_id,
  destination_commune_id = r.destination_commune_id
from public.routes as r
where rr.route_id = r.id
  and (rr.origin_commune_id is null or rr.destination_commune_id is null);

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'route_revisions_distinct_lane_check'
  ) then
    alter table public.route_revisions
    add constraint route_revisions_distinct_lane_check
    check (origin_commune_id is null or destination_commune_id is null or origin_commune_id <> destination_commune_id);
  end if;
end;
$$;
