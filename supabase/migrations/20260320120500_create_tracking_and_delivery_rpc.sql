insert into public.platform_settings (key, value, is_public, description)
values (
  'delivery_review',
  jsonb_build_object('grace_window_hours', 24),
  true,
  'Delivery review grace window configuration'
)
on conflict (key) do nothing;

create or replace function public.current_delivery_review_grace_window_hours()
returns integer
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((value->>'grace_window_hours')::integer, 24)
  from public.platform_settings
  where key = 'delivery_review'
    and is_public = true;
$$;

create or replace function public.append_tracking_event(
  p_booking_id uuid,
  p_event_type text,
  p_visibility public.tracking_event_visibility,
  p_note text default null,
  p_created_by uuid default null
)
returns public.tracking_events
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.tracking_events;
begin
  insert into public.tracking_events (
    booking_id,
    event_type,
    visibility,
    note,
    created_by,
    recorded_at
  ) values (
    p_booking_id,
    left(trim(p_event_type), 120),
    p_visibility,
    left(nullif(trim(p_note), ''), 500),
    coalesce(p_created_by, (select auth.uid())),
    now()
  ) returning * into v_result;

  return v_result;
end;
$$;

create or replace function public.carrier_record_booking_milestone(
  p_booking_id uuid,
  p_milestone text,
  p_note text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_milestone text := lower(trim(coalesce(p_milestone, '')));
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_milestone = 'picked_up' then
    update public.bookings
    set booking_status = 'picked_up',
        picked_up_at = now(),
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  elsif v_milestone = 'in_transit' then
    update public.bookings
    set booking_status = 'in_transit',
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  elsif v_milestone = 'delivered_pending_review' then
    update public.bookings
    set booking_status = 'delivered_pending_review',
        delivered_at = now(),
        updated_at = now()
    where id = p_booking_id
    returning * into v_booking;
  else
    raise exception 'Unsupported carrier milestone';
  end if;

  perform public.append_tracking_event(
    p_booking_id,
    v_milestone,
    'user_visible',
    p_note,
    v_actor_id
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.shipper_id,
    'booking_milestone_updated',
    'booking_milestone_updated_title',
    'booking_milestone_updated_body',
    jsonb_build_object('booking_id', v_booking.id, 'milestone', v_milestone)
  );

  return v_booking;
end;
$$;

create or replace function public.shipper_confirm_delivery(
  p_booking_id uuid,
  p_note text default null
)
returns public.bookings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (shipper_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'delivered_pending_review' then
    raise exception 'Only delivered bookings can be confirmed';
  end if;

  update public.bookings
  set booking_status = 'completed',
      delivery_confirmed_at = now(),
      completed_at = now(),
      updated_at = now()
  where id = p_booking_id
  returning * into v_booking;

  perform public.append_tracking_event(
    p_booking_id,
    'completed',
    'user_visible',
    p_note,
    v_actor_id
  );

  return v_booking;
end;
$$;

create or replace function public.auto_complete_delivered_bookings()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_grace_hours integer := public.current_delivery_review_grace_window_hours();
  v_count integer := 0;
begin
  if not public.is_service_role() then
    raise exception 'Auto completion requires service role access';
  end if;

  with eligible as (
    select id
    from public.bookings
    where booking_status = 'delivered_pending_review'
      and delivered_at is not null
      and delivered_at <= now() - make_interval(hours => v_grace_hours)
    for update
  ),
  completed as (
    update public.bookings as b
    set booking_status = 'completed',
        completed_at = now(),
        updated_at = now()
    where b.id in (select id from eligible)
    returning b.id
  )
  select count(*) into v_count from completed;

  insert into public.tracking_events (
    booking_id, event_type, visibility, note, recorded_at
  )
  select
    b.id,
    'completed',
    'user_visible',
    'Booking auto-completed after delivery review grace window.',
    now()
  from public.bookings as b
  where b.booking_status = 'completed'
    and b.completed_at >= now() - interval '1 minute';

  return v_count;
end;
$$;

revoke all on function public.append_tracking_event(uuid, text, public.tracking_event_visibility, text, uuid) from public, anon;
grant execute on function public.append_tracking_event(uuid, text, public.tracking_event_visibility, text, uuid) to authenticated, service_role;

revoke all on function public.carrier_record_booking_milestone(uuid, text, text) from public, anon;
grant execute on function public.carrier_record_booking_milestone(uuid, text, text) to authenticated, service_role;

revoke all on function public.shipper_confirm_delivery(uuid, text) from public, anon;
grant execute on function public.shipper_confirm_delivery(uuid, text) to authenticated, service_role;

revoke all on function public.auto_complete_delivered_bookings() from public, anon, authenticated;
grant execute on function public.auto_complete_delivered_bookings() to service_role;
