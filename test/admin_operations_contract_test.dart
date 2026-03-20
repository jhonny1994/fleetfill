import 'dart:io';

import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 12 migration contracts', () {
    late String settingsSeedMigration;
    late String clientSettingsMigration;
    late String adminMigration;

    setUpAll(() {
      settingsSeedMigration = File(
        'supabase/migrations/20260320120900_seed_runtime_and_feature_flag_settings.sql',
      ).readAsStringSync();
      clientSettingsMigration = File(
        'supabase/migrations/20260320121000_create_typed_client_settings_rpc.sql',
      ).readAsStringSync();
      adminMigration = File(
        'supabase/migrations/20260320121100_create_admin_operations_rpc.sql',
      ).readAsStringSync();
    });

    test('seeds runtime and feature flag settings', () {
      expect(settingsSeedMigration.contains("'app_runtime'"), isTrue);
      expect(settingsSeedMigration.contains("'feature_flags'"), isTrue);
    });

    test('creates typed client settings and admin operational functions', () {
      expect(clientSettingsMigration.contains('create or replace function public.get_client_settings()'), isTrue);
      expect(adminMigration.contains('admin_get_operational_summary'), isTrue);
      expect(adminMigration.contains('admin_upsert_platform_setting'), isTrue);
      expect(adminMigration.contains('admin_set_profile_active'), isTrue);
      expect(adminMigration.contains('admin_retry_email_delivery'), isTrue);
    });
  });

  group('Phase 12 models', () {
    test('maps client settings response into typed models', () {
      final settings = ClientSettings.fromJson({
        'booking_pricing': {
          'platform_fee_rate': 0.05,
          'carrier_fee_rate': 0,
          'insurance_rate': 0.01,
          'insurance_min_fee_dzd': 100,
          'tax_rate': 0,
          'payment_resubmission_deadline_hours': 24,
        },
        'delivery_review': {'grace_window_hours': 48},
        'app_runtime': {
          'maintenance_mode': true,
          'force_update_required': false,
          'minimum_supported_android_version': 10,
          'minimum_supported_ios_version': 11,
        },
        'platform_payment_accounts': [
          {
            'id': 'account-1',
            'payment_rail': 'ccp',
            'display_name': 'CCP Main',
            'account_identifier': '123',
            'account_holder_name': 'FleetFill',
            'instructions_text': 'Pay at branch',
          },
        ],
      });

      expect(settings.bookingPricing.paymentResubmissionDeadlineHours, 24);
      expect(settings.deliveryReview.graceWindowHours, 48);
      expect(settings.appRuntime.maintenanceMode, isTrue);
      expect(settings.paymentAccounts.single.paymentRail, 'ccp');
    });

    test('maps admin operational summary counts', () {
      final summary = AdminOperationalSummary.fromJson({
        'verification_packets': 2,
        'pending_verification_documents': 6,
        'payment_proofs': 3,
        'disputes': 1,
        'eligible_payouts': 4,
        'email_backlog': 5,
        'email_dead_letter': 1,
        'audit_events_last_24h': 9,
        'overdue_delivery_reviews': 2,
        'overdue_payment_resubmissions': 1,
      });

      expect(summary.eligiblePayouts, 4);
      expect(summary.emailDeadLetter, 1);
      expect(summary.overdueDeliveryReviews, 2);
    });

    test('maps email delivery and outbox records', () {
      final deliveryLog = EmailDeliveryLogRecord.fromJson({
        'id': 'log-1',
        'profile_id': 'profile-1',
        'booking_id': 'booking-1',
        'template_key': 'payment_received',
        'locale': 'en',
        'recipient_email': 'user@example.com',
        'subject_preview': 'Subject',
        'provider_message_id': 'provider-1',
        'status': 'delivered',
        'provider': 'resend',
        'attempt_count': 1,
        'payload_snapshot': {'booking_id': 'booking-1'},
        'created_at': '2026-03-20T12:00:00Z',
        'updated_at': '2026-03-20T12:05:00Z',
      });
      final outboxJob = EmailOutboxJobRecord.fromJson({
        'id': 'job-1',
        'event_key': 'manual_resend',
        'dedupe_key': 'manual_resend:1',
        'profile_id': 'profile-1',
        'booking_id': 'booking-1',
        'template_key': 'payment_received',
        'locale': 'en',
        'recipient_email': 'user@example.com',
        'priority': 'high',
        'status': 'queued',
        'attempt_count': 0,
        'max_attempts': 5,
        'payload_snapshot': {'booking_id': 'booking-1'},
        'created_at': '2026-03-20T12:00:00Z',
        'updated_at': '2026-03-20T12:05:00Z',
      });

      expect(deliveryLog.status, 'delivered');
      expect(outboxJob.eventKey, 'manual_resend');
    });
  });
}
