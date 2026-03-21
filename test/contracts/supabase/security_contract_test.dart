import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase security contracts', () {
    late String securityHelpersMigration;
    late String uploadMigration;
    late String grantsMigration;
    late String trackingMigration;
    late String paymentMigration;
    late String disputeMigration;
    late String adminRetryMigration;
    late String auditTracker;

    setUpAll(() {
      securityHelpersMigration = File(
        'supabase/migrations/20260317150100_create_security_and_storage_helpers.sql',
      ).readAsStringSync();
      uploadMigration = File(
        'supabase/migrations/20260317150200_create_client_upload_and_finalize_rpc.sql',
      ).readAsStringSync();
      grantsMigration = File(
        'supabase/migrations/20260317150700_grant_runtime_function_access.sql',
      ).readAsStringSync();
      trackingMigration = File(
        'supabase/migrations/20260320120500_create_tracking_and_delivery_rpc.sql',
      ).readAsStringSync();
      paymentMigration = File(
        'supabase/migrations/20260320120400_create_payment_proof_review_rpc.sql',
      ).readAsStringSync();
      disputeMigration = File(
        'supabase/migrations/20260320120600_create_dispute_and_payout_rpc.sql',
      ).readAsStringSync();
      adminRetryMigration = File(
        'supabase/migrations/20260320121130_create_admin_email_retry_rpc.sql',
      ).readAsStringSync();
      auditTracker = File(
        'docs/15-audit-phases-0-to-14.md',
      ).readAsStringSync();
    });

    test(
      'keeps signed file authorization and upload rate limiting server-side',
      () {
        expect(
          securityHelpersMigration.contains(
            'create or replace function public.assert_rate_limit',
          ),
          isTrue,
        );
        expect(
          securityHelpersMigration.contains(
            'create or replace function public.authorize_private_file_access',
          ),
          isTrue,
        );
        expect(
          uploadMigration.contains(
            "perform public.assert_rate_limit('proof_upload', 10, 3600);",
          ),
          isTrue,
        );
        expect(
          uploadMigration.contains(
            "perform public.assert_rate_limit('verification_document_upload', 20, 3600);",
          ),
          isTrue,
        );
        expect(
          grantsMigration.contains(
            'grant execute on function public.authorize_private_file_access(text, text) to authenticated, service_role;',
          ),
          isTrue,
        );
      },
    );

    test('locks down generated document creation to privileged callers', () {
      expect(
        paymentMigration.contains(
          'Generated document creation requires privileged access',
        ),
        isTrue,
      );
      expect(
        paymentMigration.contains(
          'Generated document path does not match canonical format',
        ),
        isTrue,
      );
      expect(
        paymentMigration.contains(
          'grant execute on function public.create_generated_document_record(uuid, text, text) to service_role;',
        ),
        isTrue,
      );
    });

    test(
      'enforces tracking event authorization and allowlisted event types',
      () {
        expect(
          trackingMigration.contains('Unsupported tracking event type'),
          isTrue,
        );
        expect(
          trackingMigration.contains('Tracking events require booking access'),
          isTrue,
        );
        expect(
          trackingMigration.contains(
            'Internal tracking events require privileged access',
          ),
          isTrue,
        );
      },
    );

    test(
      'requires audit logging and step-up for money-moving admin actions',
      () {
        expect(
          disputeMigration.contains(
            'perform public.require_recent_admin_step_up();',
          ),
          isTrue,
        );
        expect(disputeMigration.contains('payment_proof_approved'), isFalse);
        expect(paymentMigration.contains('payment_proof_approved'), isTrue);
        expect(paymentMigration.contains('payment_proof_rejected'), isTrue);
        expect(disputeMigration.contains('dispute_resolved_complete'), isTrue);
        expect(disputeMigration.contains('dispute_resolved_refund'), isTrue);
        expect(disputeMigration.contains("'payout_released'"), isTrue);
      },
    );

    test(
      'keeps dispute abuse controls and dead-letter resend safety in place',
      () {
        expect(
          disputeMigration.contains("'dispute_creation:' || v_actor_id::text"),
          isTrue,
        );
        expect(
          adminRetryMigration.contains(
            "v_error_code := lower(coalesce(v_job.last_error_code, ''));",
          ),
          isTrue,
        );
        expect(
          adminRetryMigration.contains(
            'Email resend is blocked for non-retryable delivery failures',
          ),
          isTrue,
        );
      },
    );

    test('tracks remaining manual-only work in the audit doc', () {
      expect(
        auditTracker.contains(
          'Manual Or User-Intervention Validation Still Required',
        ),
        isTrue,
      );
      expect(
        auditTracker.contains(
          'Profile the app on a representative Android device in profile mode',
        ),
        isTrue,
      );
    });
  });
}
