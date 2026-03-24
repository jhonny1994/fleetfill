begin;

select plan(17);

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
    '13000000-0000-4000-8000-000000000001',
    'authenticated',
    'authenticated',
    'bootstrap-admin@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{"full_name":"Bootstrap Admin"}'::jsonb,
    now(),
    now()
  ),
  (
    '13000000-0000-4000-8000-000000000002',
    'authenticated',
    'authenticated',
    'ops-admin@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{"full_name":"Ops Admin"}'::jsonb,
    now(),
    now()
  ),
  (
    '13000000-0000-4000-8000-000000000003',
    'authenticated',
    'authenticated',
    'second-admin@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{"full_name":"Second Admin"}'::jsonb,
    now(),
    now()
  );

select set_config('request.jwt.claim.sub', '', true);
select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claim.email', '', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

select is(
  (
    select admin_role::text
    from public.bootstrap_first_super_admin(
      '13000000-0000-4000-8000-000000000001',
      'Bootstrap Admin',
      '0771000001'
    )
  ),
  'super_admin',
  'service role can bootstrap the first super admin'
);

select is(
  (
    select role::text
    from public.profiles
    where id = '13000000-0000-4000-8000-000000000001'
  ),
  'admin',
  'bootstrap creates an admin profile'
);

select is(
  (
    select count(*)::int
    from public.admin_audit_logs
    where action = 'admin_bootstrap_completed'
      and target_id = '13000000-0000-4000-8000-000000000001'
  ),
  1,
  'bootstrap writes an admin audit event'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.bootstrap_first_super_admin(
        '13000000-0000-4000-8000-000000000002',
        'Should Fail',
        '0771000002'
      )
    $$
  ),
  '.*only available before any admin exists.*',
  'bootstrap cannot run after the first admin exists'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000001',
  'authenticated',
  'bootstrap-admin@example.com'
);

create temp table pg_temp.ops_invitation as
select public.create_admin_invitation(
  'ops-admin@example.com',
  'ops_admin',
  48
) as payload;

select is(
  (
    select payload->>'role'
    from pg_temp.ops_invitation
  ),
  'ops_admin',
  'super admin can create an ops admin invitation'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000002',
  'authenticated',
  'ops-admin@example.com'
);

select is(
  (
    select admin_role::text
    from public.accept_admin_invitation(
      (select payload->>'token' from pg_temp.ops_invitation),
      'Ops Admin',
      '0771000002'
    )
  ),
  'ops_admin',
  'matching invited user can accept an admin invitation'
);

reset role;
select set_config('request.jwt.claim.sub', '', true);
select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claim.email', '', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

select is(
  (
    select status::text
    from public.admin_invitations
    where id = ((select payload->>'id' from pg_temp.ops_invitation))::uuid
  ),
  'accepted',
  'accepted invitation moves to accepted state'
);

select is(
  (
    select count(*)::int
    from public.admin_audit_logs
    where action = 'admin_invitation_accepted'
      and target_id = ((select payload->>'id' from pg_temp.ops_invitation))::uuid
  ),
  1,
  'accepting an invitation writes an audit log'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000002',
  'authenticated',
  'ops-admin@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.create_admin_invitation(
        'second-admin@example.com',
        'ops_admin',
        24
      )
    $$
  ),
  '.*super admin access.*',
  'ops admins cannot create admin invitations'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_upsert_platform_setting(
        'feature_flags',
        jsonb_build_object('admin_email_resend_enabled', false),
        false,
        'Attempted by ops admin'
      )
    $$
  ),
  '.*super admin access.*',
  'ops admins cannot change runtime platform settings'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000001',
  'authenticated',
  'bootstrap-admin@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_update_admin_role(
        '13000000-0000-4000-8000-000000000001',
        'ops_admin',
        'Attempt to remove last super admin'
      )
    $$
  ),
  '.*At least one active super admin must remain.*',
  'the last active super admin cannot be demoted'
);

select is(
  (
    select admin_role::text
    from public.admin_update_admin_role(
      '13000000-0000-4000-8000-000000000002',
      'super_admin',
      'Promote second admin'
    )
  ),
  'super_admin',
  'super admin can promote another admin to super admin'
);

select is(
  (
    select admin_role::text
    from public.admin_update_admin_role(
      '13000000-0000-4000-8000-000000000001',
      'ops_admin',
      'Hand off super admin'
    )
  ),
  'ops_admin',
  'a super admin can demote themselves once another super admin exists'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000002',
  'authenticated',
  'ops-admin@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_set_admin_account_active(
        '13000000-0000-4000-8000-000000000002',
        false,
        'Attempt to deactivate last super admin'
      )
    $$
  ),
  '.*last active super admin cannot be deactivated.*',
  'the last active super admin cannot be deactivated'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '13000000-0000-4000-8000-000000000002',
  'authenticated',
  'ops-admin@example.com'
);

create temp table pg_temp.second_invitation as
select public.create_admin_invitation(
  'second-admin@example.com',
  'ops_admin',
  24
) as payload;

select is(
  (
    select status::text
    from public.revoke_admin_invitation(
      ((select payload->>'id' from pg_temp.second_invitation))::uuid,
      'No longer needed'
    )
  ),
  'revoked',
  'super admin can revoke a pending invitation'
);

select is(
  (
    select count(*)::int
    from public.admin_audit_logs
    where action = 'admin_invitation_revoked'
      and target_id = ((select payload->>'id' from pg_temp.second_invitation))::uuid
  ),
  1,
  'revoking an invitation writes an audit log'
);

select is(
  (
    select (value->>'admin_email_resend_enabled')::boolean
    from public.admin_upsert_platform_setting(
      'feature_flags',
      jsonb_build_object('admin_email_resend_enabled', false),
      false,
      'Disable resend feature'
    )
  ),
  false,
  'super admin can update platform settings'
);

select * from finish();
rollback;
