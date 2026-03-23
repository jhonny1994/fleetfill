begin;
select plan(9);

select ok(
  exists (select 1 from pg_proc where proname = 'create_carrier_route'),
  'create_carrier_route exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'create_oneoff_trip'),
  'create_oneoff_trip exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'current_effective_verification_documents'),
  'current_effective_verification_documents exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'enqueue_support_request_emails'),
  'enqueue_support_request_emails exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'claim_generated_document_jobs'),
  'claim_generated_document_jobs exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'complete_generated_document_processing'),
  'complete_generated_document_processing exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'recover_stale_generated_document_jobs'),
  'recover_stale_generated_document_jobs exists'
);

select ok(
  exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'routes'
      and policyname = 'routes_insert_owner_or_admin'
  ),
  'routes_insert_owner_or_admin policy exists'
);

select ok(
  exists (
    select 1
    from pg_trigger
    where tgname = 'route_revisions_append_only'
  ),
  'route_revisions_append_only trigger exists'
);

select * from finish();
rollback;
