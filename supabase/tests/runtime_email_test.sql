begin;

select plan(28);

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
    '12000000-0000-4000-8000-000000000001',
    'authenticated',
    'authenticated',
    'mail-shipper@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  ),
  (
    '12000000-0000-4000-8000-000000000002',
    'authenticated',
    'authenticated',
    'mail-admin@example.com',
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now()
  );

select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

insert into public.profiles (id, role, full_name, phone_number, email, preferred_locale, is_active)
values
  (
    '12000000-0000-4000-8000-000000000001',
    'shipper',
    'Mail Shipper',
    '0551000001',
    'mail-shipper@example.com',
    'fr',
    true
  ),
  (
    '12000000-0000-4000-8000-000000000002',
    'admin',
    'Mail Admin',
    '0771000002',
    'mail-admin@example.com',
    'ar',
    true
  );

insert into public.admin_accounts (profile_id, admin_role, is_active, activated_at)
values (
  '12000000-0000-4000-8000-000000000002',
  'ops_admin',
  true,
  now()
);

select ok(
  exists(
    select 1
    from public.email_templates
    where template_key = 'booking_confirmed'
      and language_code = 'ar'
      and is_enabled = true
  ),
  'Arabic booking confirmation template exists in the canonical registry'
);

select ok(
  exists(
    select 1
    from public.email_templates
    where template_key = 'booking_confirmed'
      and language_code = 'fr'
      and is_enabled = true
  ),
  'French booking confirmation template exists in the canonical registry'
);

select ok(
  exists(
    select 1
    from public.email_templates
    where template_key = 'booking_confirmed'
      and language_code = 'en'
      and is_enabled = true
  ),
  'English booking confirmation template exists in the canonical registry'
);

select ok(
  exists(
    select 1
    from public.email_templates
    where template_key = 'generated_document_available'
      and language_code = 'ar'
      and is_enabled = true
  ),
  'Arabic generated document notification template exists in the canonical registry'
);

select is(
  (
    select count(*)::int
    from public.email_templates
    where is_enabled = true
      and language_code in ('ar', 'fr', 'en')
  ),
  27,
  'transactional email template registry contains all active templates for Arabic, French, and English'
);

insert into public.user_devices (
  profile_id,
  push_token,
  platform,
  locale,
  last_seen_at
)
values (
  '12000000-0000-4000-8000-000000000001',
  'device-token-runtime-email',
  'android',
  'EN',
  now()
);

insert into public.email_outbox_jobs (
  id,
  event_key,
  dedupe_key,
  profile_id,
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
    'a1000000-0000-4000-8000-000000000001',
    'priority_critical',
    'priority-critical',
    '12000000-0000-4000-8000-000000000001',
    'priority_critical',
    'en',
    'mail-shipper@example.com',
    'critical',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000002',
    'priority_high',
    'priority-high',
    '12000000-0000-4000-8000-000000000001',
    'priority_high',
    'en',
    'mail-shipper@example.com',
    'high',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000003',
    'priority_normal',
    'priority-normal',
    '12000000-0000-4000-8000-000000000001',
    'priority_normal',
    'en',
    'mail-shipper@example.com',
    'normal',
    'queued',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000004',
    'retry_target',
    'retry-target',
    '12000000-0000-4000-8000-000000000001',
    'retry_target',
    'en',
    'mail-shipper@example.com',
    'normal',
    'processing',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000005',
    'dead_letter_target',
    'dead-letter-target',
    '12000000-0000-4000-8000-000000000001',
    'dead_letter_target',
    'en',
    'mail-shipper@example.com',
    'normal',
    'processing',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000006',
    'stale_processing',
    'stale-processing',
    '12000000-0000-4000-8000-000000000001',
    'stale_processing',
    'en',
    'mail-shipper@example.com',
    'normal',
    'processing',
    now() - interval '2 hours',
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000007',
    'dead_letter_blocked',
    'dead-letter-blocked',
    '12000000-0000-4000-8000-000000000001',
    'dead_letter_blocked',
    'en',
    'mail-shipper@example.com',
    'normal',
    'dead_letter',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000008',
    'dead_letter_retryable',
    'dead-letter-retryable',
    '12000000-0000-4000-8000-000000000001',
    'dead_letter_retryable',
    'en',
    'mail-shipper@example.com',
    'normal',
    'dead_letter',
    now(),
    '{}'::jsonb
  ),
  (
    'a1000000-0000-4000-8000-000000000009',
    'render_failure_target',
    'render-failure-target',
    '12000000-0000-4000-8000-000000000001',
    'booking_confirmed',
    'en',
    'mail-shipper@example.com',
    'normal',
    'processing',
    now(),
    '{"booking_reference":"FF-1001"}'::jsonb
  );

update public.email_outbox_jobs
set attempt_count = 1,
    max_attempts = 5,
    locked_at = now(),
    locked_by = 'worker-retry'
where id = 'a1000000-0000-4000-8000-000000000004';

update public.email_outbox_jobs
set attempt_count = 4,
    max_attempts = 5,
    locked_at = now(),
    locked_by = 'worker-dead'
where id = 'a1000000-0000-4000-8000-000000000005';

update public.email_outbox_jobs
set locked_at = now() - interval '2 hours',
    locked_by = 'worker-stale'
where id = 'a1000000-0000-4000-8000-000000000006';

update public.email_outbox_jobs
set last_error_code = 'hard_bounce'
where id = 'a1000000-0000-4000-8000-000000000007';

update public.email_outbox_jobs
set last_error_code = 'timeout'
where id = 'a1000000-0000-4000-8000-000000000008';

update public.email_outbox_jobs
set attempt_count = 1,
    max_attempts = 5,
    locked_at = now(),
    locked_by = 'worker-render'
where id = 'a1000000-0000-4000-8000-000000000009';

insert into public.email_delivery_logs (
  id,
  profile_id,
  template_key,
  locale,
  recipient_email,
  provider_message_id,
  status,
  provider,
  attempt_count,
  last_attempt_at,
  payload_snapshot
)
values
  (
    'b1000000-0000-4000-8000-000000000001',
    '12000000-0000-4000-8000-000000000001',
    'booking_confirmed',
    'en',
    'mail-shipper@example.com',
    'provider-soft-1',
    'soft_failed',
    'resend',
    1,
    now(),
    '{"kind":"soft"}'::jsonb
  ),
  (
    'b1000000-0000-4000-8000-000000000002',
    '12000000-0000-4000-8000-000000000001',
    'booking_confirmed',
    'en',
    'mail-shipper@example.com',
    'provider-soft-2',
    'soft_failed',
    'resend',
    1,
    now(),
    '{"kind":"soft-stale"}'::jsonb
  );

select set_config('request.jwt.claim.sub', '', true);
select set_config('request.jwt.claim.role', 'service_role', true);
select set_config('request.jwt.claim.email', '', true);
select set_config('request.jwt.claims', '{"role":"service_role"}', true);

select is(
  (
    select locale
    from public.enqueue_transactional_email(
      'runtime_locale',
      '12000000-0000-4000-8000-000000000001',
      'mail-shipper@example.com',
      null,
      'runtime_locale',
      '',
      '{}'::jsonb,
      'runtime-locale',
      'high'
    )
  ),
  'fr',
  'transactional email enqueue prefers profile locale over device locale'
);

select is(
  (
    select locale
    from public.enqueue_transactional_email(
      'runtime_locale_explicit_en',
      '12000000-0000-4000-8000-000000000001',
      'mail-shipper@example.com',
      null,
      'runtime_locale_explicit_en',
      'en',
      '{}'::jsonb,
      'runtime-locale-explicit-en',
      'high'
    )
  ),
  'en',
  'transactional email enqueue preserves an explicit supported locale'
);

select is(
  (
    select locale
    from public.enqueue_transactional_email(
      'runtime_locale_fallback_ar',
      '12000000-0000-4000-8000-000000000001',
      'mail-shipper@example.com',
      null,
      'runtime_locale_fallback_ar',
      'es',
      '{}'::jsonb,
      'runtime-locale-fallback-ar',
      'high'
    )
  ),
  'ar',
  'transactional email enqueue falls back to Arabic when an unsupported locale is requested'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.enqueue_transactional_email(
        'runtime_locale',
        '12000000-0000-4000-8000-000000000001',
        'mail-shipper@example.com',
        null,
        'runtime_locale',
        'fr',
        '{}'::jsonb,
        'runtime-locale',
        'high'
      )
    $$
  ),
  '.*duplicate key value violates unique constraint.*',
  'transactional email enqueue enforces dedupe keys'
);

select is(
  (select count(*)::int from public.claim_email_outbox_jobs('worker-a', 2)),
  2,
  'email outbox claim returns the requested batch size'
);

select is(
  (
    select count(*)::int
    from public.email_outbox_jobs
    where id in (
      'a1000000-0000-4000-8000-000000000001',
      'a1000000-0000-4000-8000-000000000002'
    )
      and status = 'processing'
      and locked_by = 'worker-a'
  ),
  2,
  'claim_email_outbox_jobs prioritizes critical and high jobs first'
);

select is(
  (
    select status::text
    from public.email_outbox_jobs
    where id = 'a1000000-0000-4000-8000-000000000003'
  ),
  'queued',
  'lower-priority queued jobs remain unclaimed when the batch is full'
);

select is(
  (
    select status::text
    from public.complete_email_outbox_job(
      'a1000000-0000-4000-8000-000000000001',
      'resend',
      'provider-msg-1',
      'Runtime subject',
      'ar'
    )
  ),
  'sent_to_provider',
  'complete_email_outbox_job marks the job as sent_to_provider'
);

select is(
  (
    select status::text
    from public.email_delivery_logs
    where provider_message_id = 'provider-msg-1'
    order by created_at desc, id desc
    limit 1
  ),
  'sent',
  'complete_email_outbox_job creates an email delivery log entry'
);

select is(
  (
    select template_language_code
    from public.email_delivery_logs
    where provider_message_id = 'provider-msg-1'
    order by created_at desc, id desc
    limit 1
  ),
  'ar',
  'complete_email_outbox_job stores the resolved template language on the delivery log'
);

select is(
  (
    select status::text
    from public.record_email_provider_event('provider-msg-1', 'delivered', null, null)
  ),
  'delivered',
  'provider event updates delivery logs forward to delivered'
);

select is(
  (
    select status::text
    from public.record_email_provider_event('provider-msg-1', 'sent', null, null)
  ),
  'delivered',
  'provider event reconciliation ignores out-of-order status regressions'
);

select is(
  (
    select status::text
    from public.release_retryable_email_job(
      'a1000000-0000-4000-8000-000000000004',
      'timeout',
      'Temporary provider timeout',
      120
    )
  ),
  'retry_scheduled',
  'retryable failures are rescheduled for later delivery'
);

select is(
  (
    select status::text
    from public.release_retryable_email_job(
      'a1000000-0000-4000-8000-000000000005',
      'timeout',
      'Too many attempts',
      120
    )
  ),
  'dead_letter',
  'retry scheduling dead-letters jobs that exhaust max attempts'
);

select is(
  (
    select status::text
    from public.release_retryable_email_job(
      'a1000000-0000-4000-8000-000000000009',
      'render_failed',
      'Missing placeholder value',
      120
    )
  ),
  'dead_letter',
  'render failures move jobs directly to dead_letter'
);

select is(
  (
    select status::text
    from public.record_email_dispatch_failure(
      'a1000000-0000-4000-8000-000000000009',
      'render_failed',
      'runtime',
      null,
      'render_failed',
      'Missing placeholder value',
      'ar'
    )
  ),
  'render_failed',
  'record_email_dispatch_failure stores render failures separately from provider failures'
);

select is(
  (
    select template_language_code
    from public.email_delivery_logs
    where template_key = 'booking_confirmed'
      and error_code = 'render_failed'
    order by created_at desc, id desc
    limit 1
  ),
  'ar',
  'record_email_dispatch_failure preserves template language metadata'
);

select is(
  public.recover_stale_email_outbox_jobs(300),
  1,
  'stale processing email jobs are recovered back to retry_scheduled'
);

set local role authenticated;
select pg_temp.set_claims(
  '12000000-0000-4000-8000-000000000002',
  'authenticated',
  'mail-admin@example.com'
);

select is(
  (
    select event_key
    from public.admin_retry_email_delivery('b1000000-0000-4000-8000-000000000001')
  ),
  'manual_resend',
  'admin resend creates a manual resend job for retryable delivery failures'
);

select is(
  (
    select count(*)::int
    from public.admin_audit_logs
    where action = 'email_delivery_resent'
      and metadata->>'delivery_log_id' = 'b1000000-0000-4000-8000-000000000001'
  ),
  1,
  'admin resend writes an audit log entry'
);

select pg_temp.set_claims(
  '12000000-0000-4000-8000-000000000002',
  'authenticated',
  'mail-admin@example.com',
  extract(epoch from now() - interval '2 hours')::bigint
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_retry_email_delivery('b1000000-0000-4000-8000-000000000002')
    $$
  ),
  '.*Recent admin step-up is required.*',
  'admin resend requires a recent step-up session'
);

select pg_temp.set_claims(
  '12000000-0000-4000-8000-000000000002',
  'authenticated',
  'mail-admin@example.com'
);

select matches(
  pg_temp.capture_error(
    $$
      select public.admin_retry_dead_letter_email_job('a1000000-0000-4000-8000-000000000007')
    $$
  ),
  '.*blocked for non-retryable delivery failures.*',
  'dead-letter resend blocks permanently non-retryable errors'
);

select is(
  (
    select event_key
    from public.admin_retry_dead_letter_email_job('a1000000-0000-4000-8000-000000000008')
  ),
  'manual_resend',
  'dead-letter resend creates a new retry job for retryable failures'
);

select * from finish();
rollback;
