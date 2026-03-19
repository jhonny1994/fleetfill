create or replace function public.current_user_id()
returns uuid
language sql
stable
set search_path = public
as $$
  select auth.uid();
$$;

create or replace function public.current_user_role()
returns public.app_role
language sql
stable
security definer
set search_path = public
as $$
  select p.role
  from public.profiles as p
  where p.id = (select auth.uid());
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(public.current_user_role() = 'admin', false);
$$;

create or replace function public.is_service_role()
returns boolean
language sql
stable
set search_path = public
as $$
  select current_setting('request.jwt.claim.role', true) = 'service_role';
$$;

create or replace function public.booking_is_visible_to_current_user(p_booking_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.bookings as b
    where b.id = p_booking_id
      and (
        b.shipper_id = (select auth.uid())
        or b.carrier_id = (select auth.uid())
        or public.is_admin()
      )
  );
$$;

create or replace function public.shipment_is_visible_to_current_user(p_shipment_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.shipments as s
    where s.id = p_shipment_id
      and (s.shipper_id = (select auth.uid()) or public.is_admin())
  );
$$;

create or replace function public.booking_owned_by_current_shipper(p_booking_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.bookings as b
    where b.id = p_booking_id
      and b.shipper_id = (select auth.uid())
  );
$$;

create or replace function public.vehicle_owned_by_current_carrier(p_vehicle_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.vehicles as v
    where v.id = p_vehicle_id
      and v.carrier_id = (select auth.uid())
  );
$$;

create or replace function public.normalize_plate_number(p_value text)
returns text
language sql
immutable
set search_path = public
as $$
  select nullif(regexp_replace(upper(trim(coalesce(p_value, ''))), '\s+', '', 'g'), '');
$$;

create or replace function public.normalize_reference_value(p_value text)
returns text
language sql
immutable
set search_path = public
as $$
  select nullif(trim(coalesce(p_value, '')), '');
$$;

create or replace function public.record_abuse_event(
  p_action_key text,
  p_reason text,
  p_metadata jsonb default '{}'::jsonb
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.security_abuse_events (actor_id, action_key, reason, metadata)
  values ((select auth.uid()), p_action_key, p_reason, p_metadata);
end;
$$;

create or replace function public.consume_rate_limit(
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_window_started_at timestamptz;
  v_hit_count integer;
begin
  if v_actor_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_limit <= 0 or p_window_seconds <= 0 then
    raise exception 'Rate-limit configuration must be positive';
  end if;

  v_window_started_at := to_timestamp(
    floor(extract(epoch from now()) / p_window_seconds) * p_window_seconds
  );

  insert into public.security_rate_limits (
    actor_id,
    action_key,
    window_started_at,
    hit_count
  )
  values (v_actor_id, p_action_key, v_window_started_at, 1)
  on conflict (actor_id, action_key, window_started_at)
  do update
  set
    hit_count = public.security_rate_limits.hit_count + 1,
    updated_at = now()
  returning hit_count into v_hit_count;

  if v_hit_count > p_limit then
    perform public.record_abuse_event(
      p_action_key,
      'rate_limit_exceeded',
      jsonb_build_object(
        'limit', p_limit,
        'window_seconds', p_window_seconds,
        'hit_count', v_hit_count
      )
    );
    return false;
  end if;

  return true;
end;
$$;

create or replace function public.assert_rate_limit(
  p_action_key text,
  p_limit integer,
  p_window_seconds integer
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.consume_rate_limit(p_action_key, p_limit, p_window_seconds) then
    raise exception 'Rate limit exceeded for %', p_action_key;
  end if;
end;
$$;

create or replace function public.protect_profile_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.email := lower(trim(new.email));
    return new;
  end if;

  if tg_op = 'INSERT' then
    if new.role = 'admin' then
      raise exception 'Creating admin profiles directly is not allowed';
    end if;

    new.is_active := true;
    new.verification_status := 'pending';
    new.verification_rejection_reason := null;
    new.rating_average := null;
    new.rating_count := 0;
    new.email := lower(trim(new.email));
    return new;
  end if;

  if new.role is distinct from old.role
    or new.is_active is distinct from old.is_active
    or new.verification_status is distinct from old.verification_status
    or new.verification_rejection_reason is distinct from old.verification_rejection_reason
    or new.rating_average is distinct from old.rating_average
    or new.rating_count is distinct from old.rating_count then
    raise exception 'Updating protected profile columns is not allowed';
  end if;

  return new;
end;
$$;

create or replace function public.protect_vehicle_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.plate_number := public.normalize_plate_number(new.plate_number);
    return new;
  end if;

  if tg_op = 'INSERT' then
    new.verification_status := 'pending';
    new.verification_rejection_reason := null;
    new.plate_number := public.normalize_plate_number(new.plate_number);
    return new;
  end if;

  if new.verification_status is distinct from old.verification_status
    or new.verification_rejection_reason is distinct from old.verification_rejection_reason then
    raise exception 'Updating protected vehicle columns is not allowed';
  end if;

  new.plate_number := public.normalize_plate_number(new.plate_number);
  return new;
end;
$$;

create or replace function public.protect_payout_account_sensitive_columns()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_admin() or public.is_service_role() then
    new.account_identifier := public.normalize_reference_value(new.account_identifier);
    return new;
  end if;

  if tg_op = 'INSERT' then
    new.is_verified := false;
    new.verified_at := null;
    new.account_identifier := public.normalize_reference_value(new.account_identifier);
    return new;
  end if;

  if new.is_verified is distinct from old.is_verified
    or new.verified_at is distinct from old.verified_at then
    raise exception 'Updating protected payout account columns is not allowed';
  end if;

  new.account_identifier := public.normalize_reference_value(new.account_identifier);
  return new;
end;
$$;

create or replace function public.normalize_profile_columns()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.phone_number := public.normalize_reference_value(new.phone_number);
  new.email := lower(trim(new.email));
  return new;
end;
$$;

create or replace function public.enforce_append_only_history()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if public.is_service_role() and current_setting('app.trusted_operation', true) = 'true' then
    return case when tg_op = 'DELETE' then old else new end;
  end if;

  raise exception '% is append-only and cannot be %d directly', tg_table_name, tg_op;
end;
$$;

create or replace function public.build_upload_object_path(
  p_bucket_id text,
  p_entity_type text,
  p_entity_id uuid,
  p_document_type text,
  p_version integer,
  p_file_extension text
)
returns text
language plpgsql
immutable
set search_path = public
as $$
declare
  v_extension text := lower(trim(coalesce(p_file_extension, 'bin')));
begin
  if p_bucket_id = 'payment-proofs' then
    return format('%s/%s/upload.%s', p_entity_id, p_version, v_extension);
  end if;

  if p_bucket_id = 'verification-documents' then
    return format(
      '%s/%s/%s/%s/upload.%s',
      p_entity_type,
      p_entity_id,
      p_document_type,
      p_version,
      v_extension
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return format('%s/%s/%s/file.%s', p_entity_id, p_document_type, p_version, v_extension);
  end if;

  raise exception 'Unsupported bucket %', p_bucket_id;
end;
$$;

create or replace function public.can_upload_storage_object(
  p_bucket_id text,
  p_object_path text
)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.upload_sessions as s
    where s.profile_id = (select auth.uid())
      and s.bucket_id = p_bucket_id
      and s.object_path = p_object_path
      and s.status = 'authorized'
      and s.expires_at > now()
  );
$$;

create or replace function public.authorize_private_file_access(
  p_bucket_id text,
  p_object_path text
)
returns boolean
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  perform public.assert_rate_limit('signed_url_generation', 30, 60);

  if public.is_admin() then
    return true;
  end if;

  if p_bucket_id = 'payment-proofs' then
    return exists (
      select 1
      from public.payment_proofs as pp
      join public.bookings as b on b.id = pp.booking_id
      where pp.storage_path = p_object_path
        and b.shipper_id = (select auth.uid())
    );
  end if;

  if p_bucket_id = 'verification-documents' then
    return exists (
      select 1
      from public.verification_documents as vd
      where vd.storage_path = p_object_path
        and vd.owner_profile_id = (select auth.uid())
    );
  end if;

  if p_bucket_id = 'generated-documents' then
    return exists (
      select 1
      from public.generated_documents as gd
      join public.bookings as b on b.id = gd.booking_id
      where gd.storage_path = p_object_path
        and (b.shipper_id = (select auth.uid()) or b.carrier_id = (select auth.uid()))
    );
  end if;

  return false;
end;
$$;
