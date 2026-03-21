import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase admin operation contracts', () {
    late String settingsSeedMigration;
    late String clientSettingsMigration;
    late String adminSummaryMigration;
    late String adminSettingsMigration;
    late String adminProfileActivationMigration;
    late String adminEmailRetryMigration;

    setUpAll(() {
      settingsSeedMigration = File(
        'supabase/migrations/20260320120900_seed_runtime_and_feature_flag_settings.sql',
      ).readAsStringSync();
      clientSettingsMigration = File(
        'supabase/migrations/20260320121000_create_typed_client_settings_rpc.sql',
      ).readAsStringSync();
      adminSummaryMigration = File(
        'supabase/migrations/20260320121100_create_admin_operational_summary_rpc.sql',
      ).readAsStringSync();
      adminSettingsMigration = File(
        'supabase/migrations/20260320121110_create_admin_platform_settings_rpc.sql',
      ).readAsStringSync();
      adminProfileActivationMigration = File(
        'supabase/migrations/20260320121120_create_admin_profile_activation_rpc.sql',
      ).readAsStringSync();
      adminEmailRetryMigration = File(
        'supabase/migrations/20260320121130_create_admin_email_retry_rpc.sql',
      ).readAsStringSync();
    });

    test('keeps typed client settings and admin operational rpc surface', () {
      expect(settingsSeedMigration.contains('feature_flags'), isTrue);
      expect(clientSettingsMigration.contains('get_client_settings()'), isTrue);
      expect(
        adminSummaryMigration.contains('admin_get_operational_summary'),
        isTrue,
      );
      expect(
        adminSettingsMigration.contains('admin_upsert_platform_setting'),
        isTrue,
      );
      expect(
        adminProfileActivationMigration.contains('admin_set_profile_active'),
        isTrue,
      );
      expect(
        adminEmailRetryMigration.contains('admin_retry_email_delivery'),
        isTrue,
      );
      expect(
        adminEmailRetryMigration.contains('admin_retry_dead_letter_email_job'),
        isTrue,
      );
    });
  });
}
