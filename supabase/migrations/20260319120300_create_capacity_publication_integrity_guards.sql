create or replace function public.is_trusted_operation()
returns boolean
language sql
stable
as $$
  select current_setting('app.trusted_operation', true) = 'true';
$$;

create or replace function public.protect_route_revision_history()
returns trigger
language plpgsql
as $$
begin
  if public.is_trusted_operation() then
    return coalesce(new, old);
  end if;

  raise exception 'Route revision history is append-only';
end;
$$;

drop trigger if exists route_revisions_append_only on public.route_revisions;
create trigger route_revisions_append_only
before update or delete on public.route_revisions
for each row
execute function public.protect_route_revision_history();

create or replace function public.enforce_route_revision_writes()
returns trigger
language plpgsql
as $$
begin
  if public.is_trusted_operation() then
    return new;
  end if;

  if tg_op = 'INSERT' then
    raise exception 'Routes must be created through create_carrier_route';
  end if;

  if new.vehicle_id is distinct from old.vehicle_id
     or new.origin_commune_id is distinct from old.origin_commune_id
     or new.destination_commune_id is distinct from old.destination_commune_id
     or new.total_capacity_kg is distinct from old.total_capacity_kg
     or new.total_capacity_volume_m3 is distinct from old.total_capacity_volume_m3
     or new.price_per_kg_dzd is distinct from old.price_per_kg_dzd
     or new.default_departure_time is distinct from old.default_departure_time
     or new.recurring_days_of_week is distinct from old.recurring_days_of_week
     or new.effective_from is distinct from old.effective_from then
    raise exception 'Critical route changes must use update_route_with_revision';
  end if;

  return new;
end;
$$;

drop trigger if exists routes_revision_enforcement on public.routes;
create trigger routes_revision_enforcement
before insert or update on public.routes
for each row
execute function public.enforce_route_revision_writes();

create or replace function public.enforce_route_revision_history()
returns trigger
language plpgsql
as $$
begin
  if public.is_trusted_operation() then
    return coalesce(new, old);
  end if;

  raise exception 'Route revision history is append-only';
end;
$$;

drop trigger if exists route_revisions_append_only on public.route_revisions;
create trigger route_revisions_append_only
before insert or update or delete on public.route_revisions
for each row
execute function public.enforce_route_revision_history();

create or replace function public.prevent_capacity_publication_delete_when_booked()
returns trigger
language plpgsql
as $$
begin
  if tg_table_name = 'routes' then
    if exists (
      select 1 from public.bookings where route_id = old.id
    ) then
      raise exception 'Route has active bookings and cannot be deleted';
    end if;
  elsif tg_table_name = 'oneoff_trips' then
    if exists (
      select 1 from public.bookings where oneoff_trip_id = old.id
    ) then
      raise exception 'Trip has active bookings and cannot be deleted';
    end if;
  end if;

  return old;
end;
$$;

drop trigger if exists routes_delete_guard on public.routes;
create trigger routes_delete_guard
before delete on public.routes
for each row
execute function public.prevent_capacity_publication_delete_when_booked();

drop trigger if exists oneoff_trips_delete_guard on public.oneoff_trips;
create trigger oneoff_trips_delete_guard
before delete on public.oneoff_trips
for each row
execute function public.prevent_capacity_publication_delete_when_booked();

create or replace function public.enforce_oneoff_trip_writes()
returns trigger
language plpgsql
as $$
begin
  if public.is_trusted_operation() then
    return new;
  end if;

  if tg_op = 'INSERT' then
    raise exception 'One-off trips must be created through create_oneoff_trip';
  end if;

  raise exception 'One-off trip changes must use update_oneoff_trip';
end;
$$;

drop trigger if exists oneoff_trips_revision_enforcement on public.oneoff_trips;
create trigger oneoff_trips_revision_enforcement
before insert or update on public.oneoff_trips
for each row
execute function public.enforce_oneoff_trip_writes();
