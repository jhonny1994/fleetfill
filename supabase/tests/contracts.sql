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
    select 1 from pg_proc where proname = 'enqueue_support_request_emails'
  ) then
    raise exception 'Expected enqueue_support_request_emails to exist';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'claim_generated_document_jobs'
  ) then
    raise exception 'Expected claim_generated_document_jobs to exist';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'complete_generated_document_processing'
  ) then
    raise exception 'Expected complete_generated_document_processing to exist';
  end if;

  if not exists (
    select 1 from pg_proc where proname = 'recover_stale_generated_document_jobs'
  ) then
    raise exception 'Expected recover_stale_generated_document_jobs to exist';
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
