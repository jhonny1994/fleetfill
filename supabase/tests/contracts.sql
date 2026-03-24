begin;
select plan(17);

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
  exists (select 1 from pg_proc where proname = 'create_support_request'),
  'create_support_request exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'reply_to_support_request'),
  'reply_to_support_request exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'mark_support_request_read'),
  'mark_support_request_read exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'admin_set_support_request_status'),
  'admin_set_support_request_status exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'admin_assign_support_request'),
  'admin_assign_support_request exists'
);

select ok(
  exists (select 1 from pg_proc where proname = 'authorize_private_file_access_for_user'),
  'authorize_private_file_access_for_user exists'
);

select ok(
  exists (select 1 from pg_class where relname = 'support_requests'),
  'support_requests table exists'
);

select ok(
  exists (select 1 from pg_class where relname = 'support_messages'),
  'support_messages table exists'
);

select ok(
  exists (
    select 1
    from pg_trigger
    where tgname = 'support_messages_append_only_guard'
  ),
  'support_messages append-only trigger exists'
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
