create or replace function public.admin_get_operational_summary()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_delivery_grace_hours integer := public.current_delivery_review_grace_window_hours();
  v_payment_deadline_hours integer := public.current_payment_resubmission_deadline_hours();
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin summary access requires privileged execution';
  end if;

  return jsonb_build_object(
    'verification_packets', (
      select count(*)
      from public.profiles as p
      where p.role = 'carrier'::public.app_role
        and p.is_active = true
        and p.verification_status in ('pending', 'rejected')
    ),
    'pending_verification_documents', (
      select count(*)
      from public.verification_documents as vd
      where vd.status = 'pending'
    ),
    'payment_proofs', (
      select count(*)
      from public.payment_proofs as pp
      where pp.status = 'pending'
    ),
    'disputes', (
      select count(*)
      from public.disputes as d
      where d.status = 'open'
    ),
    'eligible_payouts', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'completed'
        and b.payment_status = 'secured'
        and not exists (
          select 1
          from public.disputes as d
          where d.booking_id = b.id
            and d.status = 'open'
        )
        and not exists (
          select 1
          from public.payouts as p
          where p.booking_id = b.id
        )
    ),
    'email_backlog', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status in ('queued', 'retry_scheduled', 'processing')
    ),
    'email_dead_letter', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status = 'dead_letter'
    ),
    'audit_events_last_24h', (
      select count(*)
      from public.admin_audit_logs as logs
      where logs.created_at >= now() - interval '24 hours'
    ),
    'overdue_delivery_reviews', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'delivered_pending_review'
        and b.delivered_at is not null
        and b.delivered_at <= now() - make_interval(hours => v_delivery_grace_hours)
    ),
    'overdue_payment_resubmissions', (
      with latest_rejection as (
        select pp.booking_id, max(pp.reviewed_at) as reviewed_at
        from public.payment_proofs as pp
        where pp.status = 'rejected'
        group by pp.booking_id
      )
      select count(*)
      from public.bookings as b
      inner join latest_rejection as lr on lr.booking_id = b.id
      where b.payment_status = 'rejected'
        and lr.reviewed_at is not null
        and lr.reviewed_at <= now() - make_interval(hours => v_payment_deadline_hours)
    )
  );
end;
$$;

create or replace function public.admin_upsert_platform_setting(
  p_key text,
  p_value jsonb,
  p_is_public boolean default false,
  p_description text default null
)
returns public.platform_settings
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.platform_settings;
  v_key text := nullif(trim(p_key), '');
  v_maintenance_mode boolean;
  v_force_update_required boolean;
  v_android_version integer;
  v_ios_version integer;
  v_platform_fee_rate numeric;
  v_carrier_fee_rate numeric;
  v_insurance_rate numeric;
  v_insurance_min_fee_dzd numeric;
  v_tax_rate numeric;
  v_payment_deadline_hours integer;
  v_delivery_grace_hours integer;
  v_admin_email_resend_enabled boolean;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Platform setting updates require privileged execution';
  end if;

  if not public.is_service_role() and (
    extract(epoch from now()) - coalesce((auth.jwt()->>'iat')::bigint, 0)
  ) > 900 then
    raise exception 'Recent admin step-up is required for this action';
  end if;

  if v_key is null then
    raise exception 'Platform setting key is required';
  end if;

  if jsonb_typeof(coalesce(p_value, '{}'::jsonb)) <> 'object' then
    raise exception 'Platform setting value must be a JSON object';
  end if;

  case v_key
    when 'app_runtime' then
      v_maintenance_mode := coalesce((p_value->>'maintenance_mode')::boolean, false);
      v_force_update_required := coalesce((p_value->>'force_update_required')::boolean, false);
      v_android_version := greatest(coalesce((p_value->>'minimum_supported_android_version')::integer, 1), 1);
      v_ios_version := greatest(coalesce((p_value->>'minimum_supported_ios_version')::integer, 1), 1);
      p_value := jsonb_build_object(
        'maintenance_mode', v_maintenance_mode,
        'force_update_required', v_force_update_required,
        'minimum_supported_android_version', v_android_version,
        'minimum_supported_ios_version', v_ios_version
      );
    when 'booking_pricing' then
      v_platform_fee_rate := coalesce((p_value->>'platform_fee_rate')::numeric, 0.05);
      v_carrier_fee_rate := coalesce((p_value->>'carrier_fee_rate')::numeric, 0);
      v_insurance_rate := coalesce((p_value->>'insurance_rate')::numeric, 0.01);
      v_insurance_min_fee_dzd := coalesce((p_value->>'insurance_min_fee_dzd')::numeric, 100);
      v_tax_rate := coalesce((p_value->>'tax_rate')::numeric, 0);
      v_payment_deadline_hours := coalesce((p_value->>'payment_resubmission_deadline_hours')::integer, 24);

      if v_platform_fee_rate < 0 or v_carrier_fee_rate < 0 or v_insurance_rate < 0 or v_insurance_min_fee_dzd < 0 or v_tax_rate < 0 then
        raise exception 'Pricing values must be non-negative';
      end if;

      if v_payment_deadline_hours < 1 then
        raise exception 'Payment resubmission deadline must be at least one hour';
      end if;

      p_value := jsonb_build_object(
        'platform_fee_rate', v_platform_fee_rate,
        'carrier_fee_rate', v_carrier_fee_rate,
        'insurance_rate', v_insurance_rate,
        'insurance_min_fee_dzd', v_insurance_min_fee_dzd,
        'tax_rate', v_tax_rate,
        'payment_resubmission_deadline_hours', v_payment_deadline_hours
      );
    when 'delivery_review' then
      v_delivery_grace_hours := coalesce((p_value->>'grace_window_hours')::integer, 24);
      if v_delivery_grace_hours < 1 then
        raise exception 'Delivery grace window must be at least one hour';
      end if;
      p_value := jsonb_build_object('grace_window_hours', v_delivery_grace_hours);
    when 'feature_flags' then
      v_admin_email_resend_enabled := coalesce((p_value->>'admin_email_resend_enabled')::boolean, true);
      p_value := jsonb_build_object(
        'admin_email_resend_enabled',
        v_admin_email_resend_enabled
      );
    else
      raise exception 'Unsupported platform setting key';
  end case;

  insert into public.platform_settings (
    key,
    value,
    is_public,
    description,
    updated_by,
    updated_at
  ) values (
    v_key,
    coalesce(p_value, '{}'::jsonb),
    coalesce(p_is_public, false),
    left(nullif(trim(p_description), ''), 500),
    (select auth.uid()),
    now()
  )
  on conflict (key) do update
  set value = excluded.value,
      is_public = excluded.is_public,
      description = coalesce(excluded.description, public.platform_settings.description),
      updated_by = excluded.updated_by,
      updated_at = excluded.updated_at
  returning * into v_result;

  perform public.write_admin_audit_log(
    'platform_setting_updated',
    'platform_setting',
    null,
    'success',
    null,
    jsonb_build_object(
      'key', v_result.key,
      'is_public', v_result.is_public
    )
  );

  return v_result;
end;
$$;

create or replace function public.admin_set_profile_active(
  p_profile_id uuid,
  p_is_active boolean,
  p_reason text default null
)
returns public.profiles
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.profiles;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Profile activation changes require privileged execution';
  end if;

  if not public.is_service_role() and (
    extract(epoch from now()) - coalesce((auth.jwt()->>'iat')::bigint, 0)
  ) > 900 then
    raise exception 'Recent admin step-up is required for this action';
  end if;

  if p_profile_id is null then
    raise exception 'Profile id is required';
  end if;

  if v_actor_id = p_profile_id and coalesce(p_is_active, true) = false then
    raise exception 'Admins cannot suspend their own account';
  end if;

  update public.profiles
  set is_active = coalesce(p_is_active, true),
      updated_at = now()
  where id = p_profile_id
  returning * into v_result;

  if not found then
    raise exception 'Profile not found';
  end if;

  perform public.write_admin_audit_log(
    case when v_result.is_active then 'profile_reactivated' else 'profile_suspended' end,
    'profile',
    v_result.id,
    'success',
    left(nullif(trim(p_reason), ''), 500),
    jsonb_build_object('is_active', v_result.is_active)
  );

  return v_result;
end;
$$;

create or replace function public.admin_retry_email_delivery(
  p_delivery_log_id uuid
)
returns public.email_outbox_jobs
language plpgsql
security definer
set search_path = public
as $$
declare
  v_log public.email_delivery_logs;
  v_job public.email_outbox_jobs;
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Email resend requires privileged execution';
  end if;

  if not public.is_service_role() and (
    extract(epoch from now()) - coalesce((auth.jwt()->>'iat')::bigint, 0)
  ) > 900 then
    raise exception 'Recent admin step-up is required for this action';
  end if;

  select * into v_log
  from public.email_delivery_logs
  where id = p_delivery_log_id;

  if not found then
    raise exception 'Email delivery log not found';
  end if;

  if v_log.status <> 'soft_failed' then
    raise exception 'Email resend is only available for retryable delivery failures';
  end if;

  insert into public.email_outbox_jobs (
    event_key,
    dedupe_key,
    profile_id,
    booking_id,
    template_key,
    locale,
    recipient_email,
    priority,
    status,
    attempt_count,
    max_attempts,
    available_at,
    payload_snapshot
  ) values (
    'manual_resend',
    format('manual_resend:%s:%s', v_log.id, gen_random_uuid()),
    v_log.profile_id,
    v_log.booking_id,
    v_log.template_key,
    v_log.locale,
    v_log.recipient_email,
    'high',
    'queued',
    0,
    5,
    now(),
    v_log.payload_snapshot
  )
  returning * into v_job;

  perform public.write_admin_audit_log(
    'email_delivery_resent',
    'email_delivery_log',
    null,
    'success',
    null,
    jsonb_build_object(
      'delivery_log_id', v_log.id,
      'email_outbox_job_id', v_job.id,
      'template_key', v_log.template_key,
      'recipient_email', v_log.recipient_email
    )
  );

  return v_job;
end;
$$;

revoke all on function public.admin_get_operational_summary() from public, anon;
grant execute on function public.admin_get_operational_summary() to authenticated, service_role;

revoke all on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) from public, anon;
grant execute on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) to authenticated, service_role;

revoke all on function public.admin_set_profile_active(uuid, boolean, text) from public, anon;
grant execute on function public.admin_set_profile_active(uuid, boolean, text) to authenticated, service_role;

revoke all on function public.admin_retry_email_delivery(uuid) from public, anon;
grant execute on function public.admin_retry_email_delivery(uuid) to authenticated, service_role;
