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
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      clientSettingsMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      adminSummaryMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      adminSettingsMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      adminProfileActivationMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      adminEmailRetryMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
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
