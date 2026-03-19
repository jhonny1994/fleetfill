create or replace function public.booking_status_transition_allowed(
  p_old public.booking_status,
  p_new public.booking_status
)
returns boolean
language sql
immutable
as $$
  select case p_old
    when 'pending_payment' then p_new in ('pending_payment', 'payment_under_review', 'cancelled')
    when 'payment_under_review' then p_new in ('payment_under_review', 'confirmed', 'cancelled')
    when 'confirmed' then p_new in ('confirmed', 'picked_up', 'cancelled')
    when 'picked_up' then p_new in ('picked_up', 'in_transit')
    when 'in_transit' then p_new in ('in_transit', 'delivered_pending_review')
    when 'delivered_pending_review' then p_new in ('delivered_pending_review', 'completed', 'disputed')
    when 'completed' then p_new = 'completed'
    when 'cancelled' then p_new = 'cancelled'
    when 'disputed' then p_new in ('disputed', 'completed', 'cancelled')
  end;
$$;

create or replace function public.payment_status_transition_allowed(
  p_old public.payment_status,
  p_new public.payment_status
)
returns boolean
language sql
immutable
as $$
  select case p_old
    when 'unpaid' then p_new in ('unpaid', 'proof_submitted')
    when 'proof_submitted' then p_new in ('proof_submitted', 'under_verification')
    when 'under_verification' then p_new in ('under_verification', 'secured', 'rejected')
    when 'secured' then p_new in ('secured', 'refunded', 'released_to_carrier')
    when 'rejected' then p_new in ('rejected', 'proof_submitted')
    when 'refunded' then p_new = 'refunded'
    when 'released_to_carrier' then p_new = 'released_to_carrier'
  end;
$$;

create or replace function public.enforce_booking_state_transitions()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if tg_op <> 'UPDATE' then
    return new;
  end if;

  if not public.booking_status_transition_allowed(old.booking_status, new.booking_status) then
    raise exception 'Invalid booking status transition from % to %', old.booking_status, new.booking_status;
  end if;

  if not public.payment_status_transition_allowed(old.payment_status, new.payment_status) then
    raise exception 'Invalid payment status transition from % to %', old.payment_status, new.payment_status;
  end if;

  return new;
end;
$$;

drop trigger if exists bookings_state_transition_guard on public.bookings;
create trigger bookings_state_transition_guard
before update on public.bookings
for each row
execute function public.enforce_booking_state_transitions();
