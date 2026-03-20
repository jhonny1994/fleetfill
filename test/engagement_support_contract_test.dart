import 'dart:io';

import 'package:fleetfill/features/notifications/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 11 migration contracts', () {
    late String engagementMigration;
    late String hardeningMigration;

    setUpAll(() {
      engagementMigration = File(
        'supabase/migrations/20260320120700_create_carrier_review_and_notification_rpc.sql',
      ).readAsStringSync();
      hardeningMigration = File(
        'supabase/migrations/20260320120800_harden_notification_and_email_delivery_rules.sql',
      ).readAsStringSync();
    });

    test('creates ratings, notifications, and support rpc surface', () {
      expect(engagementMigration.contains('submit_carrier_review'), isTrue);
      expect(engagementMigration.contains('refresh_carrier_rating_aggregates'), isTrue);
      expect(engagementMigration.contains('register_user_device'), isTrue);
      expect(engagementMigration.contains('mark_notification_read'), isTrue);
      expect(engagementMigration.contains('enqueue_transactional_email'), isTrue);
    });

    test('hardens notification integrity and email locale handling', () {
      expect(hardeningMigration.contains('normalize_supported_locale'), isTrue);
      expect(hardeningMigration.contains('get_profile_preferred_locale'), isTrue);
      expect(hardeningMigration.contains('notifications_update_admin_only'), isTrue);
      expect(hardeningMigration.contains("when 'opened' then 3"), isTrue);
      expect(hardeningMigration.contains("when 'clicked' then 4"), isTrue);
    });
  });

  group('Notification model', () {
    test('maps notification rows', () {
      final record = AppNotificationRecord.fromJson({
        'id': 'notification-1',
        'type': 'booking_created',
        'title': 'Booking created',
        'body': 'Your booking is waiting for payment proof.',
        'data': {'booking_id': 'booking-1'},
        'is_read': false,
        'created_at': '2026-03-20T12:00:00Z',
        'read_at': null,
      });

      expect(record.id, 'notification-1');
      expect(record.type, 'booking_created');
      expect(record.isRead, isFalse);
    });
  });
}
