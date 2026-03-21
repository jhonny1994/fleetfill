import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase engagement and support contracts', () {
    late String carrierReviewMigration;
    late String notificationDeviceMigration;
    late String emailEnqueueMigration;
    late String notificationDeviceHardeningMigration;
    late String emailHardeningMigration;
    late String supportRequestMigration;

    setUpAll(() {
      carrierReviewMigration = File(
        'supabase/migrations/20260320120700_create_carrier_review_rpc.sql',
      ).readAsStringSync();
      notificationDeviceMigration = File(
        'supabase/migrations/20260320120710_create_notification_device_rpc.sql',
      ).readAsStringSync();
      emailEnqueueMigration = File(
        'supabase/migrations/20260320120720_create_transactional_email_enqueue_rpc.sql',
      ).readAsStringSync();
      notificationDeviceHardeningMigration = File(
        'supabase/migrations/20260320120800_harden_notification_device_rules.sql',
      ).readAsStringSync();
      emailHardeningMigration = File(
        'supabase/migrations/20260320120810_harden_email_delivery_rules.sql',
      ).readAsStringSync();
      supportRequestMigration = File(
        'supabase/migrations/20260320120820_create_support_request_email_rpc.sql',
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

    test('hardens locale-aware notification and support email handling', () {
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
        supportRequestMigration.contains('enqueue_support_request_emails'),
        isTrue,
      );
      expect(
        supportRequestMigration.contains('support_acknowledgement'),
        isTrue,
      );
    });
  });
}
