do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'shipments_distinct_lane_check'
  ) then
    alter table public.shipments
    add constraint shipments_distinct_lane_check
    check (origin_commune_id <> destination_commune_id);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipments_positive_weight_check'
  ) then
    alter table public.shipments
    add constraint shipments_positive_weight_check
    check (total_weight_kg > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipments_non_negative_volume_check'
  ) then
    alter table public.shipments
    add constraint shipments_non_negative_volume_check
    check (total_volume_m3 is null or total_volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipments_pickup_window_order_check'
  ) then
    alter table public.shipments
    add constraint shipments_pickup_window_order_check
    check (pickup_window_end > pickup_window_start);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipment_items_positive_quantity_check'
  ) then
    alter table public.shipment_items
    add constraint shipment_items_positive_quantity_check
    check (quantity > 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipment_items_non_negative_weight_check'
  ) then
    alter table public.shipment_items
    add constraint shipment_items_non_negative_weight_check
    check (weight_kg is null or weight_kg >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'shipment_items_non_negative_volume_check'
  ) then
    alter table public.shipment_items
    add constraint shipment_items_non_negative_volume_check
    check (volume_m3 is null or volume_m3 >= 0);
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'bookings_route_date_required_check'
  ) then
    alter table public.bookings
    add constraint bookings_route_date_required_check
    check (
      (route_id is not null and route_departure_date is not null and oneoff_trip_id is null)
      or (route_id is null and route_departure_date is null and oneoff_trip_id is not null)
    );
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_departure_instances_non_negative_capacity_check'
  ) then
    alter table public.route_departure_instances
    add constraint route_departure_instances_non_negative_capacity_check
    check (
      total_capacity_kg >= 0
      and reserved_capacity_kg >= 0
      and remaining_capacity_kg >= 0
      and (total_capacity_volume_m3 is null or total_capacity_volume_m3 >= 0)
      and (reserved_volume_m3 is null or reserved_volume_m3 >= 0)
      and (remaining_volume_m3 is null or remaining_volume_m3 >= 0)
    );
  end if;

  if not exists (
    select 1 from pg_constraint where conname = 'route_departure_instances_capacity_balance_check'
  ) then
    alter table public.route_departure_instances
    add constraint route_departure_instances_capacity_balance_check
    check (
      remaining_capacity_kg = total_capacity_kg - reserved_capacity_kg
      and (
        total_capacity_volume_m3 is null
        or remaining_volume_m3 is null
        or reserved_volume_m3 is null
        or remaining_volume_m3 = total_capacity_volume_m3 - reserved_volume_m3
      )
    );
  end if;
end;
$$;

create unique index if not exists route_departure_instances_route_date_unique_idx
on public.route_departure_instances (route_id, departure_date);

create index if not exists shipments_lane_pickup_idx
on public.shipments (origin_commune_id, destination_commune_id, pickup_window_start, pickup_window_end);

create index if not exists bookings_route_active_lookup_idx
on public.bookings (route_id, route_departure_date)
where booking_status <> 'cancelled';

create index if not exists bookings_oneoff_active_lookup_idx
on public.bookings (oneoff_trip_id)
where booking_status <> 'cancelled';

create index if not exists route_revisions_route_effective_idx
on public.route_revisions (route_id, effective_from desc);
