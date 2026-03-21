create or replace function public.refresh_carrier_rating_aggregates(
  p_carrier_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_average numeric;
  v_count integer;
begin
  select avg(score)::numeric, count(*)::integer
  into v_average, v_count
  from public.carrier_reviews
  where carrier_id = p_carrier_id;

  update public.profiles
  set rating_average = v_average,
      rating_count = coalesce(v_count, 0),
      updated_at = now()
  where id = p_carrier_id;
end;
$$;

create or replace function public.submit_carrier_review(
  p_booking_id uuid,
  p_score integer,
  p_comment text default null
)
returns public.carrier_reviews
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_review public.carrier_reviews;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if p_score < 1 or p_score > 5 then
    raise exception 'Carrier review score must be between 1 and 5';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
    and (shipper_id = v_actor_id or public.is_admin() or public.is_service_role())
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_booking.booking_status <> 'completed' then
    raise exception 'Only completed bookings may be reviewed';
  end if;

  insert into public.carrier_reviews (
    booking_id,
    carrier_id,
    shipper_id,
    score,
    comment,
    created_at
  ) values (
    p_booking_id,
    v_booking.carrier_id,
    v_actor_id,
    p_score,
    left(nullif(trim(p_comment), ''), 1000),
    now()
  )
  returning * into v_review;

  perform public.refresh_carrier_rating_aggregates(v_booking.carrier_id);

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    v_booking.carrier_id,
    'carrier_review_submitted',
    'carrier_review_submitted_title',
    'carrier_review_submitted_body',
    jsonb_build_object('booking_id', p_booking_id)
  );

  return v_review;
end;
$$;

revoke all on function public.submit_carrier_review(uuid, integer, text) from public, anon;
grant execute on function public.submit_carrier_review(uuid, integer, text) to authenticated, service_role;
