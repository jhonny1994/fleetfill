-- Consolidated dev-phase layer migration: 20260317020000_create_verification_and_capacity_layer.sql
-- Generated from historical dev-only migrations during local rebaseline work.

-- >>> BEGIN 20260318130000_create_public_carrier_profile_rpc.sql
create or replace function public.get_public_carrier_profile(
  p_carrier_id uuid
)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'id', p.id,
    'full_name', p.full_name,
    'company_name', p.company_name,
    'verification_status', p.verification_status,
    'rating_average', p.rating_average,
    'rating_count', p.rating_count,
    'comments', coalesce(
      (
        select jsonb_agg(
          jsonb_build_object(
            'score', cr.score,
            'comment', cr.comment,
            'created_at', cr.created_at
          )
          order by cr.created_at desc
        )
        from (
          select score, comment, created_at
          from public.carrier_reviews
          where carrier_id = p.id
            and comment is not null
          order by created_at desc
          limit 5
        ) as cr
      ),
      '[]'::jsonb
    )
  )
  from public.profiles as p
  where p.id = p_carrier_id
    and p.role = 'carrier'
    and p.is_active = true;
$$;

revoke all on function public.get_public_carrier_profile(uuid) from public, anon;
grant execute on function public.get_public_carrier_profile(uuid) to authenticated, service_role;
-- <<< END 20260318130000_create_public_carrier_profile_rpc.sql

-- >>> BEGIN 20260318170000_create_verification_effective_document_helpers.sql
create or replace function public.current_effective_verification_documents(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type default null,
  p_entity_id uuid default null
)
returns table (
  id uuid,
  owner_profile_id uuid,
  entity_type public.verification_document_entity_type,
  entity_id uuid,
  document_type text,
  storage_path text,
  status public.verification_status,
  rejection_reason text,
  reviewed_by uuid,
  reviewed_at timestamptz,
  expires_at timestamptz,
  version integer,
  content_type text,
  byte_size bigint,
  checksum_sha256 text,
  uploaded_by uuid,
  upload_session_id uuid,
  created_at timestamptz,
  updated_at timestamptz
)
language sql
stable
security definer
set search_path = public
as $$
  with ranked as (
    select
      vd.*,
      row_number() over (
        partition by vd.entity_type, vd.entity_id, vd.document_type
        order by vd.version desc, vd.created_at desc, vd.id desc
      ) as position_rank
    from public.verification_documents as vd
    where vd.owner_profile_id = p_owner_profile_id
      and (p_entity_type is null or vd.entity_type = p_entity_type)
      and (p_entity_id is null or vd.entity_id = p_entity_id)
  )
  select
    ranked.id,
    ranked.owner_profile_id,
    ranked.entity_type,
    ranked.entity_id,
    ranked.document_type,
    ranked.storage_path,
    ranked.status,
    ranked.rejection_reason,
    ranked.reviewed_by,
    ranked.reviewed_at,
    ranked.expires_at,
    ranked.version,
    ranked.content_type,
    ranked.byte_size,
    ranked.checksum_sha256,
    ranked.uploaded_by,
    ranked.upload_session_id,
    ranked.created_at,
    ranked.updated_at
  from ranked
  where ranked.position_rank = 1;
$$;

create or replace function public.required_verification_documents_complete(
  p_owner_profile_id uuid
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  with effective_docs as (
    select *
    from public.current_effective_verification_documents(p_owner_profile_id)
  ),
  carrier_vehicles as (
    select v.id
    from public.vehicles as v
    where v.carrier_id = p_owner_profile_id
  )
  select
    exists (
      select 1
      from effective_docs as ed
      where ed.entity_type = 'profile'
        and ed.entity_id = p_owner_profile_id
        and ed.document_type = 'driver_identity_or_license'
    )
    and exists (select 1 from carrier_vehicles)
    and not exists (
      select 1
      from carrier_vehicles as cv
      where not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_registration'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_insurance'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_technical_inspection'
      )
    );
$$;

create or replace function public.refresh_verification_subject_status(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type,
  p_entity_id uuid
)
returns public.verification_status
language plpgsql
security definer
set search_path = public
as $$
declare
  v_target_status text := 'pending';
  v_target_reason text;
begin
  with effective_docs as (
    select *
    from public.current_effective_verification_documents(
      p_owner_profile_id,
      p_entity_type,
      p_entity_id
    )
  )
  select case
    when exists (
      select 1 from effective_docs as ed where ed.status = 'rejected'
    ) then 'rejected'
    when exists (
      select 1 from effective_docs as ed where ed.status = 'pending'
    ) then 'pending'
    when exists (select 1 from effective_docs) then 'verified'
    else 'pending'
  end,
  (
    select ed.rejection_reason
    from effective_docs as ed
    where ed.status = 'rejected'
    order by ed.reviewed_at desc nulls last, ed.updated_at desc, ed.created_at desc
    limit 1
  )
  into v_target_status, v_target_reason;

  if p_entity_type = 'profile' then
    update public.profiles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  else
    update public.vehicles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  end if;

  return v_target_status::public.verification_status;
end;
$$;

revoke all on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;

revoke all on function public.required_verification_documents_complete(uuid) from public, anon;
grant execute on function public.required_verification_documents_complete(uuid) to authenticated, service_role;

revoke all on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;
-- <<< END 20260318170000_create_verification_effective_document_helpers.sql

-- >>> BEGIN 20260318170100_create_verification_admin_review_actions.sql
create or replace function public.admin_review_verification_document(
  p_document_id uuid,
  p_status public.verification_status,
  p_reason text default null
)
returns public.verification_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_reason text := nullif(trim(coalesce(p_reason, '')), '');
  v_document public.verification_documents;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin verification review requires privileged access';
  end if;

  if p_status not in ('verified', 'rejected') then
    raise exception 'Verification review status must be verified or rejected';
  end if;

  if p_status = 'rejected' and v_reason is null then
    raise exception 'Verification rejection requires a reason';
  end if;

  select * into v_document
  from public.verification_documents
  where id = p_document_id;

  if not found then
    raise exception 'Verification document not found';
  end if;

  if v_document.status = p_status
    and coalesce(v_document.rejection_reason, '') = coalesce(v_reason, '') then
    return v_document;
  end if;

  perform set_config('app.trusted_operation', 'true', true);

  update public.verification_documents
  set status = p_status,
      rejection_reason = case when p_status = 'rejected' then v_reason else null end,
      reviewed_by = v_actor_id,
      reviewed_at = now(),
      updated_at = now()
  where id = p_document_id
  returning * into v_document;

  perform public.refresh_verification_subject_status(
    v_document.owner_profile_id,
    v_document.entity_type,
    v_document.entity_id
  );

  if p_status = 'rejected' then
    insert into public.notifications (profile_id, type, title, body, data)
    values (
      v_document.owner_profile_id,
      'verification_document_rejected',
      'verification_document_rejected_title',
      'verification_document_rejected_body',
      jsonb_build_object(
        'document_id', v_document.id,
        'document_type', v_document.document_type,
        'entity_type', v_document.entity_type,
        'entity_id', v_document.entity_id,
        'reason', v_reason
      )
    );
  end if;

  perform public.write_admin_audit_log(
    case
      when p_status = 'verified' then 'verification_document_approved'
      else 'verification_document_rejected'
    end,
    case
      when v_document.entity_type = 'profile' then 'profile_verification_document'
      else 'vehicle_verification_document'
    end,
    v_document.id,
    p_status::text,
    v_reason,
    jsonb_build_object(
      'entity_id', v_document.entity_id,
      'entity_type', v_document.entity_type,
      'document_type', v_document.document_type,
      'version', v_document.version
    )
  );

  perform set_config('app.trusted_operation', 'false', true);

  return v_document;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

revoke all on function public.admin_review_verification_document(uuid, public.verification_status, text) from public, anon;
grant execute on function public.admin_review_verification_document(uuid, public.verification_status, text) to authenticated, service_role;
-- <<< END 20260318170100_create_verification_admin_review_actions.sql

-- >>> BEGIN 20260318170200_create_verification_packet_approval.sql
create or replace function public.admin_approve_verification_packet(
  p_carrier_id uuid
)
returns table (
  action text,
  target_id uuid,
  outcome text
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_record public.profiles;
  v_document_id uuid;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin packet approval requires privileged access';
  end if;

  select * into v_profile_record
  from public.profiles
  where id = p_carrier_id;

  if not found then
    raise exception 'Carrier profile not found';
  end if;

  if v_profile_record.role is distinct from 'carrier'::public.app_role then
    raise exception 'Verification packet approval requires a carrier profile';
  end if;

  if not public.required_verification_documents_complete(p_carrier_id) then
    raise exception 'Verification packet is incomplete';
  end if;

  for v_document_id in
    select ed.id
    from public.current_effective_verification_documents(p_carrier_id) as ed
    where ed.status <> 'verified'
    order by ed.entity_type, ed.entity_id, ed.document_type
  loop
    perform public.admin_review_verification_document(v_document_id, 'verified');
    action := 'verification_document_approved';
    target_id := v_document_id;
    outcome := 'verified';
    return next;
  end loop;

  perform set_config('app.trusted_operation', 'true', true);

  perform public.refresh_verification_subject_status(
    p_carrier_id,
    'profile',
    p_carrier_id
  );

  perform public.refresh_verification_subject_status(
    p_carrier_id,
    'vehicle',
    v.id
  )
  from public.vehicles as v
  where v.carrier_id = p_carrier_id;

  perform public.write_admin_audit_log(
    'verification_packet_approved',
    'verification_packet',
    p_carrier_id,
    'verified',
    null,
    jsonb_build_object('carrier_id', p_carrier_id)
  );

  insert into public.notifications (profile_id, type, title, body, data)
  values (
    p_carrier_id,
    'verification_packet_approved',
    'verification_packet_approved_title',
    'verification_packet_approved_body',
    jsonb_build_object('carrier_id', p_carrier_id)
  );

  perform set_config('app.trusted_operation', 'false', true);

  action := 'verification_packet_approved';
  target_id := p_carrier_id;
  outcome := 'verified';
  return next;
exception
  when others then
    perform set_config('app.trusted_operation', 'false', true);
    raise;
end;
$$;

revoke all on function public.admin_approve_verification_packet(uuid) from public, anon;
grant execute on function public.admin_approve_verification_packet(uuid) to authenticated, service_role;
-- <<< END 20260318170200_create_verification_packet_approval.sql

-- >>> BEGIN 20260319120000_add_capacity_publication_constraints.sql
alter table public.routes
add column if not exists total_capacity_volume_m3 numeric;

create or replace function public.weekdays_are_valid(days integer[])
returns boolean
language sql
immutable
set search_path = public
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
-- <<< END 20260319120000_add_capacity_publication_constraints.sql

-- >>> BEGIN 20260319120100_backfill_route_revision_lane_history.sql
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
-- <<< END 20260319120100_backfill_route_revision_lane_history.sql

-- >>> BEGIN 20260319120200_create_capacity_publication_access_helpers.sql
create or replace function public.is_active_carrier(
  p_profile_id uuid default null
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = coalesce(p_profile_id, (select auth.uid()))
      and role = 'carrier'::public.app_role
      and is_active = true
  );
$$;

create or replace function public.is_verified_carrier(
  p_profile_id uuid default null
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = coalesce(p_profile_id, (select auth.uid()))
      and role = 'carrier'::public.app_role
      and is_active = true
      and verification_status = 'verified'::public.verification_status
  );
$$;

create or replace function public.assert_active_carrier_access()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if public.is_admin() or public.is_service_role() then
    return v_actor_id;
  end if;

  if not public.is_active_carrier(v_actor_id) then
    raise exception 'Only active carriers may manage vehicles or payout accounts';
  end if;

  return v_actor_id;
end;
$$;

create or replace function public.assert_verified_carrier_access()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if public.is_admin() or public.is_service_role() then
    return v_actor_id;
  end if;

  if not public.is_verified_carrier(v_actor_id) then
    raise exception 'Only active verified carriers may publish capacity';
  end if;

  return v_actor_id;
end;
$$;

create or replace function public.assert_carrier_vehicle_access(
  p_vehicle_id uuid,
  p_require_verified boolean default true
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid;
begin
  v_actor_id := case
    when p_require_verified then public.assert_verified_carrier_access()
    else public.assert_active_carrier_access()
  end;

  if not exists (
    select 1
    from public.vehicles
    where id = p_vehicle_id
      and (carrier_id = v_actor_id or public.is_admin() or public.is_service_role())
      and (
        not p_require_verified
        or verification_status = 'verified'::public.verification_status
      )
  ) then
    if p_require_verified then
      raise exception 'A verified vehicle is required for capacity publication';
    end if;

    raise exception 'Vehicle is unavailable for this carrier';
  end if;
end;
$$;
-- <<< END 20260319120200_create_capacity_publication_access_helpers.sql

-- >>> BEGIN 20260319120300_create_capacity_publication_integrity_guards.sql
create or replace function public.is_trusted_operation()
returns boolean
language sql
stable
set search_path = public
as $$
  select current_setting('app.trusted_operation', true) = 'true';
$$;

create or replace function public.protect_route_revision_history()
returns trigger
language plpgsql
set search_path = public
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
set search_path = public
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
set search_path = public
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
set search_path = public
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
set search_path = public
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
-- <<< END 20260319120300_create_capacity_publication_integrity_guards.sql

-- >>> BEGIN 20260319120400_create_capacity_publication_routes_rpc.sql
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
-- <<< END 20260319120400_create_capacity_publication_routes_rpc.sql

-- >>> BEGIN 20260319120500_create_capacity_publication_oneoff_trip_rpc.sql
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
-- <<< END 20260319120500_create_capacity_publication_oneoff_trip_rpc.sql

-- >>> BEGIN 20260319120600_enable_capacity_publication_policies.sql
drop policy if exists vehicles_insert_owner_or_admin on public.vehicles;
create policy vehicles_insert_owner_or_admin
on public.vehicles for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists vehicles_update_owner_or_admin on public.vehicles;
create policy vehicles_update_owner_or_admin
on public.vehicles for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists vehicles_delete_owner_or_admin on public.vehicles;
create policy vehicles_delete_owner_or_admin
on public.vehicles for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_insert_owner_or_admin on public.payout_accounts;
create policy payout_accounts_insert_owner_or_admin
on public.payout_accounts for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_update_owner_or_admin on public.payout_accounts;
create policy payout_accounts_update_owner_or_admin
on public.payout_accounts for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_delete_owner_or_admin on public.payout_accounts;
create policy payout_accounts_delete_owner_or_admin
on public.payout_accounts for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_insert_owner_or_admin on public.routes;
create policy routes_insert_owner_or_admin
on public.routes for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_update_owner_or_admin on public.routes;
create policy routes_update_owner_or_admin
on public.routes for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_delete_owner_or_admin on public.routes;
create policy routes_delete_owner_or_admin
on public.routes for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_insert_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_insert_owner_or_admin
on public.oneoff_trips for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_update_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_update_owner_or_admin
on public.oneoff_trips for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_delete_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_delete_owner_or_admin
on public.oneoff_trips for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);
-- <<< END 20260319120600_enable_capacity_publication_policies.sql

-- >>> BEGIN 20260319120700_harden_verification_helper_access.sql
create or replace function public.current_effective_verification_documents(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type default null,
  p_entity_id uuid default null
)
returns table (
  id uuid,
  owner_profile_id uuid,
  entity_type public.verification_document_entity_type,
  entity_id uuid,
  document_type text,
  storage_path text,
  status public.verification_status,
  rejection_reason text,
  reviewed_by uuid,
  reviewed_at timestamptz,
  expires_at timestamptz,
  version integer,
  content_type text,
  byte_size bigint,
  checksum_sha256 text,
  uploaded_by uuid,
  upload_session_id uuid,
  created_at timestamptz,
  updated_at timestamptz
)
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification document access requires privileged access';
  end if;

  return query
  with ranked as (
    select
      vd.*,
      row_number() over (
        partition by vd.entity_type, vd.entity_id, vd.document_type
        order by vd.version desc, vd.created_at desc, vd.id desc
      ) as position_rank
    from public.verification_documents as vd
    where vd.owner_profile_id = p_owner_profile_id
      and (p_entity_type is null or vd.entity_type = p_entity_type)
      and (p_entity_id is null or vd.entity_id = p_entity_id)
  )
  select
    ranked.id,
    ranked.owner_profile_id,
    ranked.entity_type,
    ranked.entity_id,
    ranked.document_type,
    ranked.storage_path,
    ranked.status,
    ranked.rejection_reason,
    ranked.reviewed_by,
    ranked.reviewed_at,
    ranked.expires_at,
    ranked.version,
    ranked.content_type,
    ranked.byte_size,
    ranked.checksum_sha256,
    ranked.uploaded_by,
    ranked.upload_session_id,
    ranked.created_at,
    ranked.updated_at
  from ranked
  where ranked.position_rank = 1;
end;
$$;

create or replace function public.required_verification_documents_complete(
  p_owner_profile_id uuid
)
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_complete boolean;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification completeness requires privileged access';
  end if;

  with effective_docs as (
    select *
    from public.current_effective_verification_documents(p_owner_profile_id)
  ),
  carrier_vehicles as (
    select v.id
    from public.vehicles as v
    where v.carrier_id = p_owner_profile_id
  )
  select
    exists (
      select 1
      from effective_docs as ed
      where ed.entity_type = 'profile'
        and ed.entity_id = p_owner_profile_id
        and ed.document_type = 'driver_identity_or_license'
    )
    and exists (select 1 from carrier_vehicles)
    and not exists (
      select 1
      from carrier_vehicles as cv
      where not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_registration'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_insurance'
      )
      or not exists (
        select 1
        from effective_docs as ed
        where ed.entity_type = 'vehicle'
          and ed.entity_id = cv.id
          and ed.document_type = 'truck_technical_inspection'
      )
    )
  into v_complete;

  return coalesce(v_complete, false);
end;
$$;

create or replace function public.refresh_verification_subject_status(
  p_owner_profile_id uuid,
  p_entity_type public.verification_document_entity_type,
  p_entity_id uuid
)
returns public.verification_status
language plpgsql
security definer
set search_path = public
as $$
declare
  v_target_status text := 'pending';
  v_target_reason text;
  v_vehicle_docs_complete boolean := true;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Verification status refresh requires privileged access';
  end if;

  with effective_docs as (
    select *
    from public.current_effective_verification_documents(
      p_owner_profile_id,
      p_entity_type,
      p_entity_id
    )
  )
  select case
    when exists (
      select 1 from effective_docs as ed where ed.status = 'rejected'
    ) then 'rejected'
    when exists (
      select 1 from effective_docs as ed where ed.status = 'pending'
    ) then 'pending'
    when exists (select 1 from effective_docs) then 'verified'
    else 'pending'
  end,
  (
    select ed.rejection_reason
    from effective_docs as ed
    where ed.status = 'rejected'
    order by ed.reviewed_at desc nulls last, ed.updated_at desc, ed.created_at desc
    limit 1
  )
  into v_target_status, v_target_reason;

  if p_entity_type = 'vehicle' and v_target_status = 'verified' then
    with effective_docs as (
      select *
      from public.current_effective_verification_documents(
        p_owner_profile_id,
        p_entity_type,
        p_entity_id
      )
    )
    select
      exists (
        select 1 from effective_docs where document_type = 'truck_registration'
      )
      and exists (
        select 1 from effective_docs where document_type = 'truck_insurance'
      )
      and exists (
        select 1 from effective_docs where document_type = 'truck_technical_inspection'
      )
    into v_vehicle_docs_complete;

    if not coalesce(v_vehicle_docs_complete, false) then
      v_target_status := 'pending';
    end if;
  end if;

  if p_entity_type = 'profile' then
    update public.profiles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  else
    update public.vehicles
    set verification_status = v_target_status::public.verification_status,
        verification_rejection_reason = case
          when v_target_status = 'rejected' then v_target_reason
          else null
        end,
        updated_at = now()
    where id = p_entity_id;
  end if;

  return v_target_status::public.verification_status;
end;
$$;

revoke all on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.current_effective_verification_documents(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;

revoke all on function public.required_verification_documents_complete(uuid) from public, anon;
grant execute on function public.required_verification_documents_complete(uuid) to authenticated, service_role;

revoke all on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) from public, anon;
grant execute on function public.refresh_verification_subject_status(uuid, public.verification_document_entity_type, uuid) to authenticated, service_role;
-- <<< END 20260319120700_harden_verification_helper_access.sql
