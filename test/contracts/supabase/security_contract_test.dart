import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _extractLastSqlBlock(String source, String marker) {
  final start = source.lastIndexOf(marker);
  if (start == -1) {
    return '';
  }

  const sqlBlockTerminator = '\n\$\$;';
  final end = source.indexOf(sqlBlockTerminator, start);
  if (end == -1) {
    return source.substring(start);
  }

  return source.substring(start, end + sqlBlockTerminator.length);
}

void main() {
  group('Supabase security contracts', () {
    late String securityHelpersMigration;
    late String uploadMigration;
    late String grantsMigration;
    late String trackingFunction;
    late String generatedDocumentFunction;
    late String paymentApprovalFunction;
    late String paymentRejectionFunction;
    late String disputeCompleteFunction;
    late String disputeRefundFunction;
    late String payoutReleaseFunction;
    late String adminRetryDeadLetterFunction;
    late String workflowLayer;
    late String auditTracker;

    setUpAll(() {
      securityHelpersMigration = File(
        'supabase/migrations/20260317010000_create_foundation_layer.sql',
      ).readAsStringSync();
      uploadMigration = File(
        'supabase/migrations/20260317010000_create_foundation_layer.sql',
      ).readAsStringSync();
      grantsMigration = File(
        'supabase/migrations/20260317010000_create_foundation_layer.sql',
      ).readAsStringSync();
      workflowLayer = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      trackingFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.append_tracking_event(',
      );
      generatedDocumentFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.create_generated_document_record(',
      );
      paymentApprovalFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_approve_payment_proof(',
      );
      paymentRejectionFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_reject_payment_proof(',
      );
      disputeCompleteFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_resolve_dispute_complete(',
      );
      disputeRefundFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_resolve_dispute_refund(',
      );
      payoutReleaseFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_release_payout(',
      );
      adminRetryDeadLetterFunction = _extractLastSqlBlock(
        workflowLayer,
        'create or replace function public.admin_retry_dead_letter_email_job(',
      );
      auditTracker = File(
        'docs/working/production-readiness-audit.md',
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
        generatedDocumentFunction.contains(
          'Generated document creation requires privileged access',
        ),
        isTrue,
      );
      expect(
        generatedDocumentFunction.contains(
          'Generated document path does not match canonical format',
        ),
        isTrue,
      );
      expect(
        workflowLayer.contains(
          'grant execute on function public.create_generated_document_record(uuid, text, text) to service_role;',
        ),
        isTrue,
      );
    });

    test(
      'enforces tracking event authorization and allowlisted event types',
      () {
        expect(
          trackingFunction.contains('Unsupported tracking event type'),
          isTrue,
        );
        expect(
          trackingFunction.contains('Tracking events require booking access'),
          isTrue,
        );
        expect(
          trackingFunction.contains(
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
          paymentApprovalFunction.contains(
            'perform public.require_recent_admin_step_up();',
          ),
          isTrue,
        );
        expect(
          disputeCompleteFunction.contains('payment_proof_approved'),
          isFalse,
        );
        expect(
          paymentApprovalFunction.contains('payment_proof_approved'),
          isTrue,
        );
        expect(
          paymentRejectionFunction.contains('payment_proof_rejected'),
          isTrue,
        );
        expect(
          disputeCompleteFunction.contains('dispute_resolved_complete'),
          isTrue,
        );
        expect(
          disputeRefundFunction.contains('dispute_resolved_refund'),
          isTrue,
        );
        expect(payoutReleaseFunction.contains("'payout_released'"), isTrue);
      },
    );

    test(
      'keeps dispute abuse controls and dead-letter resend safety in place',
      () {
        expect(
          workflowLayer.contains("'dispute_creation:' || v_actor_id::text"),
          isTrue,
        );
        expect(
          adminRetryDeadLetterFunction.contains(
            "v_error_code := lower(coalesce(v_job.last_error_code, ''));",
          ),
          isTrue,
        );
        expect(
          adminRetryDeadLetterFunction.contains(
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
