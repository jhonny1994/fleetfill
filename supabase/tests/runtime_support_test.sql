begin;

select plan(16);

create or replace function pg_temp.set_claims(
  p_user_id uuid,
  p_jwt_role text,
  p_email text,
  p_iat bigint default extract(epoch from now())::bigint
)
returns void
language plpgsql
as $$
begin
  perform set_config('request.jwt.claim.sub', p_user_id::text, true);
  perform set_config('request.jwt.claim.role', p_jwt_role, true);
  perform set_config('request.jwt.claim.email', p_email, true);
  perform set_config(
    'request.jwt.claims',
    jsonb_build_object(
      'sub', p_user_id::text,
      'role', p_jwt_role,
      'email', p_email,
      'iat', p_iat
    )::text,
    true
  );
end;
$$;

create or replace function pg_temp.capture_error(p_sql text)
returns text
language plpgsql
as $$
begin
  execute p_sql;
  return null;
exception
  when others then
    return sqlerrm;
end;
$$;

create temp table pg_temp.fixture_ids as
select
  gen_random_uuid() as shipper_id,
  gen_random_uuid() as other_shipper_id,
  gen_random_uuid() as admin_id;

grant select on table pg_temp.fixture_ids to authenticated;

insert into auth.users (
  id,
  aud,
  role,
  email,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at
)
values
  (
    (select shipper_id from pg_temp.fixture_ids),
    'authenticated',
    'authenticated',
    'support-shipper@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    (select other_shipper_id from pg_temp.fixture_ids),
    'authenticated',
    'authenticated',
    'support-other@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    (select admin_id from pg_temp.fixture_ids),
    'authenticated',
    'authenticated',
    'support-admin@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  );

select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

insert into public.profiles (
  id,
  role,
  full_name,
  phone_number,
  email,
  preferred_locale,
  is_active,
  verification_status
)
values
  (
    (select shipper_id from pg_temp.fixture_ids),
    'shipper',
    'Support Shipper',
    '0557000001',
    'support-shipper@example.com',
    'en',
    true,
    'verified'
  ),
  (
    (select other_shipper_id from pg_temp.fixture_ids),
    'shipper',
    'Support Other',
    '0557000002',
    'support-other@example.com',
    'fr',
    true,
    'verified'
  ),
  (
    (select admin_id from pg_temp.fixture_ids),
    'admin',
    'Support Admin',
    '0777000003',
    'support-admin@example.com',
    'ar',
    true,
    'verified'
  );

insert into public.admin_accounts (profile_id, admin_role, is_active, activated_at)
values (
  (select admin_id from pg_temp.fixture_ids),
  'ops_admin',
  true,
  now()
);

truncate table public.security_rate_limits;

set local role authenticated;
select pg_temp.set_claims(
  (select shipper_id from pg_temp.fixture_ids),
  'authenticated',
  'support-shipper@example.com'
);

create temp table pg_temp.created_support_request as
select *
from public.create_support_request(
  'Payment issue',
  'I need help with my payment.',
  'en',
  null,
  null,
  null,
  null
);

select ok(
  exists (select 1 from pg_temp.created_support_request),
  'create_support_request creates a support request'
);

select is(
  (
    select count(*)::int
    from public.support_messages
    where request_id = (select id from pg_temp.created_support_request limit 1)
  ),
  1,
  'create_support_request creates the first support message'
);

reset role;
select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

select is(
  (
    select count(*)::int
    from public.notifications
    where type = 'support_request_created'
      and profile_id = (select admin_id from pg_temp.fixture_ids)
      and data->>'support_request_id' = (
        select id::text from pg_temp.created_support_request limit 1
      )
  ),
  1,
  'create_support_request notifies admins about the new ticket'
);

set local role authenticated;
select pg_temp.set_claims(
  (select shipper_id from pg_temp.fixture_ids),
  'authenticated',
  'support-shipper@example.com'
);

select is(
  (
    select count(*)::int
    from public.support_requests
    where id = (select id from pg_temp.created_support_request limit 1)
  ),
  1,
  'requester can read their own support request through RLS'
);

select pg_temp.set_claims(
  (select other_shipper_id from pg_temp.fixture_ids),
  'authenticated',
  'support-other@example.com'
);

select is(
  (
    select count(*)::int
    from public.support_requests
    where id = (select id from pg_temp.created_support_request limit 1)
  ),
  0,
  'other users cannot read a foreign support request through RLS'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.reply_to_support_request(
        (select id from pg_temp.created_support_request limit 1),
        'This should not be allowed.'
      )
    $$
  ),
  '.*Support request access denied.*',
  'other users cannot reply to a support request they do not own'
);

select pg_temp.set_claims(
  (select admin_id from pg_temp.fixture_ids),
  'authenticated',
  'support-admin@example.com'
);

select is(
  (
    select sender_type::text
    from public.reply_to_support_request(
      (select id from pg_temp.created_support_request limit 1),
      'We are reviewing your payment now.'
    )
  ),
  'admin',
  'admins can reply to support requests'
);

select is(
  (
    select status::text
    from public.support_requests
    where id = (select id from pg_temp.created_support_request limit 1)
  ),
  'open',
  'admin reply keeps an open ticket open while updating the thread'
);

select is(
  (
    select count(*)::int
    from public.notifications
    where type = 'support_reply_received'
      and profile_id = (select shipper_id from pg_temp.fixture_ids)
      and data->>'support_request_id' = (
        select id::text from pg_temp.created_support_request limit 1
      )
  ),
  1,
  'admin reply notifies the requester'
);

select pg_temp.set_claims(
  (select shipper_id from pg_temp.fixture_ids),
  'authenticated',
  'support-shipper@example.com'
);

select is(
  (
    select user_last_read_at is not null
    from public.mark_support_request_read(
      (select id from pg_temp.created_support_request limit 1)
    )
  )::text,
  'true',
  'requesters can mark their support request thread as read'
);

select pg_temp.set_claims(
  (select admin_id from pg_temp.fixture_ids),
  'authenticated',
  'support-admin@example.com'
);

select is(
  (
    select status::text
    from public.admin_set_support_request_status(
      (select id from pg_temp.created_support_request limit 1),
      'waiting_for_user',
      null
    )
  ),
  'waiting_for_user',
  'admins can move a support request into waiting_for_user'
);

select pg_temp.set_claims(
  (select shipper_id from pg_temp.fixture_ids),
  'authenticated',
  'support-shipper@example.com'
);

select is(
  (
    select sender_type::text
    from public.reply_to_support_request(
      (select id from pg_temp.created_support_request limit 1),
      'Here is the extra information you asked for.'
    )
  ),
  'user',
  'requesters can continue the support thread'
);

select is(
  (
    select status::text
    from public.support_requests
    where id = (select id from pg_temp.created_support_request limit 1)
  ),
  'open',
  'user reply reopens a waiting ticket'
);

select pg_temp.set_claims(
  (select admin_id from pg_temp.fixture_ids),
  'authenticated',
  'support-admin@example.com'
);

select is(
  (
    select assigned_admin_id::text
    from public.admin_assign_support_request(
      (select id from pg_temp.created_support_request limit 1),
      (select admin_id from pg_temp.fixture_ids)
    )
  ),
  (select admin_id::text from pg_temp.fixture_ids),
  'admins can assign a support request to themselves'
);

select is(
  (
    select (public.admin_get_operational_summary()->>'support_needs_reply')::int
  ),
  1,
  'admin operational summary counts support requests that need an admin reply'
);

reset role;
select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

select matches(
  pg_temp.capture_error(
    $$
      update public.support_messages
      set body = 'tampered'
      where request_id = (select id from pg_temp.created_support_request limit 1)
    $$
  ),
  '.*append-only.*',
  'support messages remain append-only'
);

select * from finish();
rollback;
