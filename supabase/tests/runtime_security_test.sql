begin;

select plan(24);

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

create or replace function pg_temp.exercise_signed_url_limit(p_attempts integer)
returns void
language plpgsql
as $$
declare
  v_index integer;
begin
  for v_index in 1..p_attempts loop
    perform public.authorize_private_file_access(
      'payment-proofs',
      'payment-proofs/owned-proof.png'
    );
  end loop;
end;
$$;

create temp table pg_temp.fixture_lane as
select
  (select id from public.communes order by id limit 1) as origin_commune_id,
  (select id from public.communes order by id offset 1 limit 1) as destination_commune_id;

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
    '10000000-0000-4000-8000-000000000001',
    'authenticated',
    'authenticated',
    'shipper1@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    '10000000-0000-4000-8000-000000000002',
    'authenticated',
    'authenticated',
    'shipper2@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    '10000000-0000-4000-8000-000000000003',
    'authenticated',
    'authenticated',
    'carrier1@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    '10000000-0000-4000-8000-000000000004',
    'authenticated',
    'authenticated',
    'admin1@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  );

select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

insert into public.profiles (id, role, full_name, phone_number, email, is_active)
values
  (
    '10000000-0000-4000-8000-000000000001',
    'shipper',
    'Shipper One',
    '0550000001',
    'shipper1@example.com',
    true
  ),
  (
    '10000000-0000-4000-8000-000000000002',
    'shipper',
    'Shipper Two',
    '0550000002',
    'shipper2@example.com',
    true
  ),
  (
    '10000000-0000-4000-8000-000000000003',
    'carrier',
    'Carrier One',
    '0660000003',
    'carrier1@example.com',
    true
  ),
  (
    '10000000-0000-4000-8000-000000000004',
    'admin',
    'Admin One',
    '0770000004',
    'admin1@example.com',
    true
  );

update public.carrier_verification_packets
set status = 'verified', rejection_reason = null, updated_at = now()
where carrier_id = '10000000-0000-4000-8000-000000000003';

insert into public.admin_accounts (profile_id, admin_role, is_active, activated_at)
values (
  '10000000-0000-4000-8000-000000000004',
  'super_admin',
  true,
  now()
);

insert into public.vehicles (
  id,
  carrier_id,
  plate_number,
  vehicle_type,
  capacity_weight_kg,
  capacity_volume_m3,
  verification_status
)
values (
  '20000000-0000-4000-8000-000000000001',
  '10000000-0000-4000-8000-000000000003',
  '1234567890123',
  'flatbed',
  5000,
  30,
  'verified'
);

select set_config('app.trusted_operation', 'true', true);

insert into public.oneoff_trips (
  id,
  carrier_id,
  vehicle_id,
  origin_commune_id,
  destination_commune_id,
  departure_at,
  total_capacity_kg,
  total_capacity_volume_m3,
  price_per_kg_dzd,
  is_active
)
values (
  '30000000-0000-4000-8000-000000000001',
  '10000000-0000-4000-8000-000000000003',
  '20000000-0000-4000-8000-000000000001',
  (select origin_commune_id from pg_temp.fixture_lane),
  (select destination_commune_id from pg_temp.fixture_lane),
  '2030-01-15 10:00:00+00',
  5000,
  30,
  100,
  true
);

select set_config('app.trusted_operation', 'false', true);

insert into public.payout_accounts (
  id,
  carrier_id,
  account_type,
  account_holder_name,
  account_identifier,
  bank_or_ccp_name,
  is_active,
  is_verified,
  verified_at
)
values (
  '21000000-0000-4000-8000-000000000001',
  '10000000-0000-4000-8000-000000000003',
  'bank',
  'Carrier One',
  'DZ-ACCOUNT-001',
  'CPA',
  true,
  true,
  now()
);

insert into public.shipments (
  id,
  shipper_id,
  origin_commune_id,
  destination_commune_id,
  total_weight_kg,
  total_volume_m3,
  description,
  status
)
values
  (
    '40000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    100,
    1,
    'Owned booking fixture',
    'booked'
  ),
  (
    '40000000-0000-4000-8000-000000000002',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    10,
    1,
    'Approval success fixture',
    'booked'
  ),
  (
    '40000000-0000-4000-8000-000000000003',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    10,
    1,
    'Step-up fixture',
    'booked'
  ),
  (
    '40000000-0000-4000-8000-000000000004',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    25,
    1,
    'Booking conflict fixture',
    'draft'
  ),
  (
    '40000000-0000-4000-8000-000000000005',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    12,
    1,
    'Approval rollback fixture',
    'booked'
  ),
  (
    '40000000-0000-4000-8000-000000000006',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    15,
    1,
    'Dispute rollback fixture',
    'booked'
  ),
  (
    '40000000-0000-4000-8000-000000000007',
    '10000000-0000-4000-8000-000000000001',
    (select origin_commune_id from pg_temp.fixture_lane),
    (select destination_commune_id from pg_temp.fixture_lane),
    18,
    1,
    'Payout fixture',
    'booked'
  );

insert into public.bookings (
  id,
  shipment_id,
  route_id,
  route_departure_date,
  oneoff_trip_id,
  shipper_id,
  carrier_id,
  vehicle_id,
  weight_kg,
  volume_m3,
  price_per_kg_dzd,
  base_price_dzd,
  platform_fee_dzd,
  carrier_fee_dzd,
  insurance_rate,
  insurance_fee_dzd,
  tax_fee_dzd,
  shipper_total_dzd,
  carrier_payout_dzd,
  booking_status,
  payment_status,
  tracking_number,
  payment_reference,
  confirmed_at,
  delivered_at,
  completed_at
)
values
  (
    '50000000-0000-4000-8000-000000000001',
    '40000000-0000-4000-8000-000000000001',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    100,
    1,
    100,
    10000,
    500,
    0,
    null,
    0,
    0,
    10500,
    10000,
    'pending_payment',
    'unpaid',
    'TRK-OWNED',
    'PAY-OWNED',
    null,
    null,
    null
  ),
  (
    '50000000-0000-4000-8000-000000000002',
    '40000000-0000-4000-8000-000000000002',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    10,
    1,
    100,
    1000,
    50,
    0,
    null,
    0,
    0,
    1000,
    950,
    'payment_under_review',
    'under_verification',
    'TRK-APPROVE',
    'PAY-APPROVE',
    null,
    null,
    null
  ),
  (
    '50000000-0000-4000-8000-000000000003',
    '40000000-0000-4000-8000-000000000003',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    10,
    1,
    100,
    1000,
    50,
    0,
    null,
    0,
    0,
    1000,
    950,
    'payment_under_review',
    'under_verification',
    'TRK-STALE',
    'PAY-STALE',
    null,
    null,
    null
  ),
  (
    '50000000-0000-4000-8000-000000000005',
    '40000000-0000-4000-8000-000000000005',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    12,
    1,
    100,
    1200,
    60,
    0,
    null,
    0,
    0,
    1200,
    1140,
    'payment_under_review',
    'under_verification',
    'TRK-ROLLBACK',
    'PAY-ROLLBACK',
    null,
    null,
    null
  ),
  (
    '50000000-0000-4000-8000-000000000006',
    '40000000-0000-4000-8000-000000000006',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    15,
    1,
    100,
    1500,
    75,
    0,
    null,
    0,
    0,
    1500,
    1425,
    'disputed',
    'secured',
    'TRK-DISPUTE',
    'PAY-DISPUTE',
    '2030-01-15 11:00:00+00',
    '2030-01-15 12:00:00+00',
    null
  ),
  (
    '50000000-0000-4000-8000-000000000007',
    '40000000-0000-4000-8000-000000000007',
    null,
    null,
    '30000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000001',
    '10000000-0000-4000-8000-000000000003',
    '20000000-0000-4000-8000-000000000001',
    18,
    1,
    100,
    1800,
    90,
    0,
    null,
    0,
    0,
    1800,
    1710,
    'completed',
    'secured',
    'TRK-PAYOUT',
    'PAY-PAYOUT',
    '2030-01-15 11:00:00+00',
    '2030-01-15 12:00:00+00',
    '2030-01-15 13:00:00+00'
  );

insert into public.payment_proofs (
  id,
  booking_id,
  storage_path,
  payment_rail,
  submitted_reference,
  submitted_amount_dzd,
  status,
  submitted_at,
  version,
  content_type,
  byte_size,
  uploaded_by
)
values
  (
    '60000000-0000-4000-8000-000000000001',
    '50000000-0000-4000-8000-000000000001',
    'payment-proofs/owned-proof.png',
    'bank',
    'OWNED-REF',
    10500,
    'pending',
    now(),
    1,
    'image/png',
    123,
    '10000000-0000-4000-8000-000000000001'
  ),
  (
    '60000000-0000-4000-8000-000000000002',
    '50000000-0000-4000-8000-000000000002',
    'payment-proofs/approval-proof.png',
    'bank',
    'APPROVE-REF',
    1000,
    'pending',
    now(),
    1,
    'image/png',
    123,
    '10000000-0000-4000-8000-000000000001'
  ),
  (
    '60000000-0000-4000-8000-000000000003',
    '50000000-0000-4000-8000-000000000003',
    'payment-proofs/stale-proof.png',
    'bank',
    'STALE-REF',
    1000,
    'pending',
    now(),
    1,
    'image/png',
    123,
    '10000000-0000-4000-8000-000000000001'
  ),
  (
    '60000000-0000-4000-8000-000000000005',
    '50000000-0000-4000-8000-000000000005',
    'payment-proofs/rollback-proof.png',
    'bank',
    'ROLLBACK-REF',
    1200,
    'pending',
    now(),
    1,
    'image/png',
    123,
    '10000000-0000-4000-8000-000000000001'
  );

insert into public.disputes (
  id,
  booking_id,
  opened_by,
  reason,
  description,
  status
)
values (
  '80000000-0000-4000-8000-000000000001',
  '50000000-0000-4000-8000-000000000006',
  '10000000-0000-4000-8000-000000000001',
  'Damaged cargo',
  'Fixture dispute',
  'open'
);

insert into public.upload_sessions (
  id,
  profile_id,
  bucket_id,
  object_path,
  entity_type,
  entity_id,
  document_type,
  content_type,
  byte_size,
  status,
  expires_at
)
values (
  '70000000-0000-4000-8000-000000000001',
  '10000000-0000-4000-8000-000000000001',
  'payment-proofs',
  '50000000-0000-4000-8000-000000000001/1/upload.png',
  'booking',
  '50000000-0000-4000-8000-000000000001',
  'bank',
  'image/png',
  123,
  'authorized',
  now() + interval '10 minutes'
);

insert into public.email_outbox_jobs (
  id,
  event_key,
  dedupe_key,
  profile_id,
  booking_id,
  template_key,
  locale,
  recipient_email,
  priority,
  status,
  available_at,
  payload_snapshot
)
values
  (
    '90000000-0000-4000-8000-000000000001',
    'booking_confirmed',
    'booking_confirmed:conflict-key',
    '10000000-0000-4000-8000-000000000001',
    null,
    'booking_confirmed',
    'en',
    'shipper1@example.com',
    'high',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    '90000000-0000-4000-8000-000000000002',
    'payment_secured',
    'payment_secured:shipper:60000000-0000-4000-8000-000000000005',
    '10000000-0000-4000-8000-000000000001',
    '50000000-0000-4000-8000-000000000005',
    'payment_secured',
    'en',
    'shipper1@example.com',
    'high',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    '90000000-0000-4000-8000-000000000004',
    'payment_secured',
    'payment_secured:carrier:60000000-0000-4000-8000-000000000005',
    '10000000-0000-4000-8000-000000000003',
    '50000000-0000-4000-8000-000000000005',
    'payment_secured',
    'en',
    'carrier1@example.com',
    'high',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    '90000000-0000-4000-8000-000000000003',
    'dispute_resolved',
    'dispute_resolved:80000000-0000-4000-8000-000000000001:completed',
    '10000000-0000-4000-8000-000000000001',
    '50000000-0000-4000-8000-000000000006',
    'dispute_resolved',
    'en',
    'shipper1@example.com',
    'high',
    'queued',
    now(),
    '{}'::jsonb
  );

select set_config('request.jwt.claim.sub', '', true);
select set_config('request.jwt.claim.role', '', true);
select set_config('request.jwt.claim.email', '', true);
select set_config('request.jwt.claims', '{}', true);

set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000001',
  'authenticated',
  'shipper1@example.com'
);

select is(
  (select count(*)::integer from public.bookings where id = '50000000-0000-4000-8000-000000000001'),
  1,
  'shipper can select its own booking through RLS'
);

select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000002',
  'authenticated',
  'shipper2@example.com'
);

select is(
  (select count(*)::integer from public.bookings where id = '50000000-0000-4000-8000-000000000001'),
  0,
  'other shippers cannot select foreign bookings through RLS'
);

select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000001',
  'authenticated',
  'shipper1@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      insert into storage.objects (bucket_id, name)
      values ('payment-proofs', 'payment-proofs/missing-session.png')
    $$
  ),
  '.*new row violates row-level security policy.*',
  'storage upload is blocked without an authorized upload session'
);

select is(
  pg_temp.capture_error(
    $$
      insert into storage.objects (bucket_id, name, owner_id)
      values (
        'payment-proofs',
        '50000000-0000-4000-8000-000000000001/1/upload.png',
        '10000000-0000-4000-8000-000000000001'
      )
    $$
  ),
  null::text,
  'storage upload succeeds with a matching authorized upload session'
);

select ok(
  public.authorize_private_file_access('payment-proofs', 'payment-proofs/owned-proof.png'),
  'proof owner can authorize private file access'
);

select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000002',
  'authenticated',
  'shipper2@example.com'
);

select ok(
  not public.authorize_private_file_access('payment-proofs', 'payment-proofs/owned-proof.png'),
  'non-owners cannot authorize proof file access'
);

reset role;
delete from public.security_rate_limits
where actor_id = '10000000-0000-4000-8000-000000000001'
  and action_key = 'signed_url_generation';

set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000001',
  'authenticated',
  'shipper1@example.com'
);
select pg_temp.exercise_signed_url_limit(30);

select matches(
  pg_temp.capture_error(
    $$
      select public.authorize_private_file_access(
        'payment-proofs',
        'payment-proofs/owned-proof.png'
      )
    $$
  ),
  '.*Rate limit exceeded for signed_url_generation.*',
  'signed URL authorization is rate limited after the configured threshold'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000001',
  'authenticated',
  'shipper1@example.com'
);

select is(
  pg_temp.capture_error(
    $$
      select public.create_generated_document_record(
        '50000000-0000-4000-8000-000000000002',
        'payment_receipt',
        'generated/50000000-0000-4000-8000-000000000002/payment-receipt-v1.pdf'
      )
    $$
  ),
  'permission denied for function create_generated_document_record',
  'regular authenticated users cannot create generated document records'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000004',
  'authenticated',
  'admin1@example.com'
);

select is(
  pg_temp.capture_error(
    $$
      select public.admin_approve_payment_proof(
        '60000000-0000-4000-8000-000000000002',
        1000,
        'VERIFIED-APPROVE',
        'Approved in runtime test'
      )
    $$
  ),
  null::text,
  'admin payment approval succeeds with a fresh step-up'
);

select is(
  (
    select payment_status::text
    from public.bookings
    where id = '50000000-0000-4000-8000-000000000002'
  ),
  'secured',
  'payment approval moves the booking into secured status'
);

select is(
  (
    select count(*)::integer
    from public.admin_audit_logs
    where action = 'payment_proof_approved'
      and target_id = '60000000-0000-4000-8000-000000000002'
  ),
  1,
  'payment approval writes an admin audit log entry'
);

select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000004',
  'authenticated',
  'admin1@example.com',
  extract(epoch from now() - interval '2 hours')::bigint
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_reject_payment_proof(
        '60000000-0000-4000-8000-000000000003',
        'Too old',
        'Rejected in stale-session test'
      )
    $$
  ),
  '.*Recent admin step-up is required.*',
  'stale admin sessions cannot reject payment proofs'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000001',
  'authenticated',
  'shipper1@example.com'
);

select is(
  pg_temp.capture_error(
    $$
      select public.create_booking_from_search_result(
        '40000000-0000-4000-8000-000000000004',
        'oneoff_trip',
        '30000000-0000-4000-8000-000000000001',
        '2030-01-15',
        false,
        'conflict-key'
      )
    $$
  ),
  null::text,
  'booking creation no longer depends on premature email outbox side effects'
);

select is(
  (
    select count(*)::integer
    from public.bookings
    where shipment_id = '40000000-0000-4000-8000-000000000004'
  ),
  1,
  'booking creation persists the booking row without outbox side effects'
);

select is(
  (
    select status::text
    from public.shipments
    where id = '40000000-0000-4000-8000-000000000004'
  ),
  'booked',
  'booking creation updates the shipment status to booked'
);

reset role;
set local role authenticated;
select pg_temp.set_claims(
  '10000000-0000-4000-8000-000000000004',
  'authenticated',
  'admin1@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_approve_payment_proof(
        '60000000-0000-4000-8000-000000000005',
        1200,
        'VERIFIED-ROLLBACK',
        'Approval should rollback'
      )
    $$
  ),
  '.*duplicate key value violates unique constraint.*',
  'payment approval surfaces outbox dedupe conflicts'
);

select is(
  (
    select status::text
    from public.payment_proofs
    where id = '60000000-0000-4000-8000-000000000005'
  ),
  'pending',
  'payment approval rollback leaves the proof pending'
);

select is(
  (
    select payment_status::text
    from public.bookings
    where id = '50000000-0000-4000-8000-000000000005'
  ),
  'under_verification',
  'payment approval rollback leaves the booking payment state unchanged'
);

select is(
  (
    select count(*)::integer
    from public.admin_audit_logs
    where action = 'payment_proof_approved'
      and target_id = '60000000-0000-4000-8000-000000000005'
  ),
  0,
  'payment approval rollback does not leave a partial audit log'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_resolve_dispute_complete(
        '80000000-0000-4000-8000-000000000001',
        'Complete the booking'
      )
    $$
  ),
  '.*duplicate key value violates unique constraint.*',
  'dispute resolution surfaces outbox dedupe conflicts'
);

select is(
  (
    select status::text
    from public.disputes
    where id = '80000000-0000-4000-8000-000000000001'
  ),
  'open',
  'dispute resolution rollback leaves the dispute open'
);

select is(
  pg_temp.capture_error(
    $$
      select public.admin_release_payout(
        '50000000-0000-4000-8000-000000000007',
        'PAYOUT-EXT-001',
        'Released in runtime test'
      )
    $$
  ),
  null::text,
  'payout release succeeds for completed secured bookings'
);

select is(
  (
    select payment_status::text
    from public.bookings
    where id = '50000000-0000-4000-8000-000000000007'
  ),
  'released_to_carrier',
  'payout release updates the booking payment status'
);

select is(
  (
    select count(*)::integer
    from public.admin_audit_logs
    where action = 'payout_released'
      and metadata->>'booking_id' = '50000000-0000-4000-8000-000000000007'
  ),
  1,
  'payout release writes an admin audit log entry'
);

select * from finish();
rollback;
