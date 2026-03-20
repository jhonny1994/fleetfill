create or replace function public.get_client_settings()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  with booking_pricing as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'booking_pricing'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'platform_fee_rate', 0.05,
        'carrier_fee_rate', 0,
        'insurance_rate', 0.01,
        'insurance_min_fee_dzd', 100,
        'tax_rate', 0,
        'payment_resubmission_deadline_hours', 24
      )
    ) as value
  ),
  delivery_review as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'delivery_review'
          and ps.is_public = true
      ),
      jsonb_build_object('grace_window_hours', 24)
    ) as value
  ),
  app_runtime as (
    select coalesce(
      (
        select ps.value
        from public.platform_settings as ps
        where ps.key = 'app_runtime'
          and ps.is_public = true
      ),
      jsonb_build_object(
        'maintenance_mode', false,
        'force_update_required', false,
        'minimum_supported_android_version', 1,
        'minimum_supported_ios_version', 1
      )
    ) as value
  ),
  payment_accounts as (
    with current_environment as (
      select coalesce(
        nullif(current_setting('app.settings.environment', true), ''),
        'staging'
      )::public.platform_environment as environment
    )
    select coalesce(
      jsonb_agg(
        jsonb_build_object(
          'id', ppa.id,
          'payment_rail', ppa.payment_rail,
          'display_name', ppa.display_name,
          'account_identifier', ppa.account_identifier,
          'account_holder_name', ppa.account_holder_name,
          'instructions_text', ppa.instructions_text
        )
        order by ppa.display_name
      ),
      '[]'::jsonb
    ) as value
    from public.platform_payment_accounts as ppa
    cross join current_environment as ce
    where ppa.is_active = true
      and ppa.environment = ce.environment
  )
  select jsonb_build_object(
    'booking_pricing', booking_pricing.value,
    'delivery_review', delivery_review.value,
    'app_runtime', app_runtime.value,
    'platform_payment_accounts', payment_accounts.value
  )
  from booking_pricing, delivery_review, app_runtime, payment_accounts;
$$;

revoke all on function public.get_client_settings() from public;
grant execute on function public.get_client_settings() to anon, authenticated, service_role;
