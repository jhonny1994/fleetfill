do $$
begin
  if not exists (
    select 1 from pg_proc where proname = 'create_carrier_route'
  ) then
    raise exception 'Expected create_carrier_route to exist';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'create_oneoff_trip'
  ) then
    raise exception 'Expected create_oneoff_trip to exist';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'current_effective_verification_documents'
  ) then
    raise exception 'Expected current_effective_verification_documents to exist';
  end if;

  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'routes'
      and policyname = 'routes_insert_owner_or_admin'
  ) then
    raise exception 'Expected routes_insert_owner_or_admin policy to exist';
  end if;

  if not exists (
    select 1
    from pg_trigger
    where tgname = 'route_revisions_append_only'
  ) then
    raise exception 'Expected route_revisions_append_only trigger to exist';
  end if;
end;
$$;
