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

  perform public.require_recent_admin_step_up();

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

revoke all on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) from public, anon;
grant execute on function public.admin_upsert_platform_setting(text, jsonb, boolean, text) to authenticated, service_role;
