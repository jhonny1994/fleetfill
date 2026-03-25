begin;

select plan(8);

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
    '81000000-0000-4000-8000-000000000001',
    'authenticated',
    'authenticated',
    'carrier-verify@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    '81000000-0000-4000-8000-000000000002',
    'authenticated',
    'authenticated',
    'carrier-approve@example.com',
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
  is_active
)
values
  (
    '81000000-0000-4000-8000-000000000001',
    'carrier',
    'Carrier Verify',
    '0661000001',
    'carrier-verify@example.com',
    true
  ),
  (
    '81000000-0000-4000-8000-000000000002',
    'carrier',
    'Carrier Approve',
    '0661000002',
    'carrier-approve@example.com',
    true
  );

insert into public.vehicles (
  id,
  carrier_id,
  plate_number,
  vehicle_type,
  capacity_weight_kg,
  verification_status
)
values
  (
    '82000000-0000-4000-8000-000000000001',
    '81000000-0000-4000-8000-000000000001',
    '1234567890001',
    'gmc',
    10000,
    'pending'
  ),
  (
    '82000000-0000-4000-8000-000000000002',
    '81000000-0000-4000-8000-000000000002',
    '1234567890002',
    'gmc',
    10000,
    'pending'
  );

insert into public.verification_documents (
  id,
  owner_profile_id,
  entity_type,
  entity_id,
  document_type,
  storage_path,
  status
)
values
  (
    '83000000-0000-4000-8000-000000000001',
    '81000000-0000-4000-8000-000000000001',
    'profile',
    '81000000-0000-4000-8000-000000000001',
    'driver_identity_or_license',
    'profile/81000000-0000-4000-8000-000000000001/driver_identity_or_license/1/upload.png',
    'pending'
  ),
  (
    '83000000-0000-4000-8000-000000000002',
    '81000000-0000-4000-8000-000000000002',
    'profile',
    '81000000-0000-4000-8000-000000000002',
    'driver_identity_or_license',
    'profile/81000000-0000-4000-8000-000000000002/driver_identity_or_license/1/upload.png',
    'pending'
  ),
  (
    '83000000-0000-4000-8000-000000000003',
    '81000000-0000-4000-8000-000000000002',
    'vehicle',
    '82000000-0000-4000-8000-000000000002',
    'truck_registration',
    'vehicle/82000000-0000-4000-8000-000000000002/truck_registration/1/upload.png',
    'pending'
  ),
  (
    '83000000-0000-4000-8000-000000000004',
    '81000000-0000-4000-8000-000000000002',
    'vehicle',
    '82000000-0000-4000-8000-000000000002',
    'truck_insurance',
    'vehicle/82000000-0000-4000-8000-000000000002/truck_insurance/1/upload.png',
    'pending'
  ),
  (
    '83000000-0000-4000-8000-000000000005',
    '81000000-0000-4000-8000-000000000002',
    'vehicle',
    '82000000-0000-4000-8000-000000000002',
    'truck_technical_inspection',
    'vehicle/82000000-0000-4000-8000-000000000002/truck_technical_inspection/1/upload.png',
    'pending'
  );

select lives_ok(
  $$ select public.admin_review_verification_document(
    '83000000-0000-4000-8000-000000000001',
    'rejected',
    'Image is unclear'
  ) $$,
  'admin_review_verification_document accepts rejected reviews'
);

select is(
  (
    select type
    from public.notifications
    where profile_id = '81000000-0000-4000-8000-000000000001'
    order by created_at desc
    limit 1
  ),
  'verification_document_rejected',
  'document rejection creates a notification'
);

select is(
  (
    select data->>'reason'
    from public.notifications
    where profile_id = '81000000-0000-4000-8000-000000000001'
    order by created_at desc
    limit 1
  ),
  'Image is unclear',
  'document rejection notification includes reason'
);

select is(
  (
    select count(*)
    from public.push_outbox_jobs
    where event_key = 'verification_document_rejected'
  ),
  1::bigint,
  'document rejection notification enqueues a push job'
);

select lives_ok(
  $$ select public.admin_approve_verification_packet('81000000-0000-4000-8000-000000000002') $$,
  'admin_approve_verification_packet approves a complete packet'
);

select is(
  (
    select type
    from public.notifications
    where profile_id = '81000000-0000-4000-8000-000000000002'
    order by created_at desc
    limit 1
  ),
  'verification_packet_approved',
  'packet approval creates one carrier notification'
);

select is(
  (
    select count(*)
    from public.notifications
    where profile_id = '81000000-0000-4000-8000-000000000002'
      and type = 'verification_packet_approved'
  ),
  1::bigint,
  'packet approval creates a single packet notification'
);

select is(
  (
    select count(*)
    from public.push_outbox_jobs
    where event_key = 'verification_packet_approved'
  ),
  1::bigint,
  'packet approval notification enqueues one push job'
);

select * from finish();
rollback;
