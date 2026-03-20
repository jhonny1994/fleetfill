insert into public.platform_settings (key, value, is_public, description)
values
  (
    'app_runtime',
    jsonb_build_object(
      'maintenance_mode', false,
      'force_update_required', false,
      'minimum_supported_android_version', 1,
      'minimum_supported_ios_version', 1
    ),
    true,
    'Admin-controlled runtime policy for maintenance and minimum supported versions'
  ),
  (
    'feature_flags',
    jsonb_build_object(
      'admin_email_resend_enabled', true
    ),
    false,
    'Admin-controlled feature flags'
  )
on conflict (key) do nothing;
