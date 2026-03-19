alter table public.routes
add column if not exists total_capacity_volume_m3 numeric;

create or replace function public.weekdays_are_valid(days integer[])
returns boolean
language sql
immutable
as $$
  select
    days is not null
    and cardinality(days) > 0
    and not exists (
      select 1
      from unnest(days) as day_value
      where day_value < 0 or day_value > 6
    )
    and cardinality(days) = (
      select count(distinct day_value)
      from unnest(days) as day_value
    );
$$;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'routes_positive_capacity_check'
  ) then
    alter table public.routes
    add constraint routes_positive_capacity_check
    check (total_capacity_kg > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'routes_non_negative_volume_check'
  ) then
    alter table public.routes
    add constraint routes_non_negative_volume_check
    check (total_capacity_volume_m3 is null or total_capacity_volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'routes_positive_price_check'
  ) then
    alter table public.routes
    add constraint routes_positive_price_check
    check (price_per_kg_dzd > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'routes_distinct_lane_check'
  ) then
    alter table public.routes
    add constraint routes_distinct_lane_check
    check (origin_commune_id <> destination_commune_id);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'routes_valid_weekdays_check'
  ) then
    alter table public.routes
    add constraint routes_valid_weekdays_check
    check (public.weekdays_are_valid(recurring_days_of_week));
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'oneoff_trips_positive_capacity_check'
  ) then
    alter table public.oneoff_trips
    add constraint oneoff_trips_positive_capacity_check
    check (total_capacity_kg > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'oneoff_trips_non_negative_volume_check'
  ) then
    alter table public.oneoff_trips
    add constraint oneoff_trips_non_negative_volume_check
    check (total_capacity_volume_m3 is null or total_capacity_volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'oneoff_trips_positive_price_check'
  ) then
    alter table public.oneoff_trips
    add constraint oneoff_trips_positive_price_check
    check (price_per_kg_dzd > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'oneoff_trips_distinct_lane_check'
  ) then
    alter table public.oneoff_trips
    add constraint oneoff_trips_distinct_lane_check
    check (origin_commune_id <> destination_commune_id);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_revisions_positive_capacity_check'
  ) then
    alter table public.route_revisions
    add constraint route_revisions_positive_capacity_check
    check (total_capacity_kg > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_revisions_non_negative_volume_check'
  ) then
    alter table public.route_revisions
    add constraint route_revisions_non_negative_volume_check
    check (total_capacity_volume_m3 is null or total_capacity_volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_revisions_positive_price_check'
  ) then
    alter table public.route_revisions
    add constraint route_revisions_positive_price_check
    check (price_per_kg_dzd > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_revisions_valid_weekdays_check'
  ) then
    alter table public.route_revisions
    add constraint route_revisions_valid_weekdays_check
    check (public.weekdays_are_valid(recurring_days_of_week));
  end if;
end;
$$;
