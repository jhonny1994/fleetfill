import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase engagement and support contracts', () {
    late String carrierReviewMigration;
    late String notificationDeviceMigration;
    late String emailEnqueueMigration;
    late String notificationDeviceHardeningMigration;
    late String emailHardeningMigration;
    late String supportRuntimeMigration;

    setUpAll(() {
      carrierReviewMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      notificationDeviceMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      emailEnqueueMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      notificationDeviceHardeningMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      emailHardeningMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      supportRuntimeMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
    });

    test('exposes carrier review and notification device rpc surface', () {
      expect(carrierReviewMigration.contains('submit_carrier_review'), isTrue);
      expect(
        carrierReviewMigration.contains('refresh_carrier_rating_aggregates'),
        isTrue,
      );
      expect(
        notificationDeviceMigration.contains('register_user_device'),
        isTrue,
      );
      expect(
        notificationDeviceMigration.contains('mark_notification_read'),
        isTrue,
      );
      expect(
        emailEnqueueMigration.contains('enqueue_transactional_email'),
        isTrue,
      );
    });

    test('hardens locale-aware notification and support request handling', () {
      expect(
        notificationDeviceHardeningMigration.contains(
          'normalize_supported_locale',
        ),
        isTrue,
      );
      expect(
        notificationDeviceHardeningMigration.contains(
          'get_profile_preferred_locale',
        ),
        isTrue,
      );
      expect(
        notificationDeviceHardeningMigration.contains(
          'notifications_update_admin_only',
        ),
        isTrue,
      );
      expect(emailHardeningMigration.contains("when 'opened' then 3"), isTrue);
      expect(emailHardeningMigration.contains("when 'clicked' then 4"), isTrue);
      expect(
        supportRuntimeMigration.contains('create_support_request'),
        isTrue,
      );
      expect(
        supportRuntimeMigration.contains('reply_to_support_request'),
        isTrue,
      );
      expect(
        supportRuntimeMigration.contains('admin_set_support_request_status'),
        isTrue,
      );
    });
  });
}
