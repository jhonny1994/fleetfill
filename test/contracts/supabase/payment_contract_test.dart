import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase payment and generated document contracts', () {
    late String paymentProofMigration;
    late String generatedDocumentSchemaMigration;
    late String generatedDocumentHelperMigration;
    late String generatedDocumentLockMigration;
    late String generatedDocumentWorkerMigration;

    setUpAll(() {
      paymentProofMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      generatedDocumentSchemaMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      generatedDocumentHelperMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      generatedDocumentLockMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
      generatedDocumentWorkerMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
    });

    test('creates payment review rpc and related email events', () {
      expect(
        paymentProofMigration.contains('admin_approve_payment_proof'),
        isTrue,
      );
      expect(
        paymentProofMigration.contains('admin_reject_payment_proof'),
        isTrue,
      );
      expect(
        paymentProofMigration.contains('expire_payment_resubmission_deadlines'),
        isTrue,
      );
      expect(
        paymentProofMigration.contains("'payment_proof_received'"),
        isTrue,
      );
      expect(paymentProofMigration.contains("'payment_secured'"), isTrue);
      expect(paymentProofMigration.contains("'payment_rejected'"), isTrue);
    });

    test('tracks generated document processing, locks, and worker rpc', () {
      expect(
        generatedDocumentSchemaMigration.contains("default 'pending'"),
        isTrue,
      );
      expect(
        generatedDocumentSchemaMigration.contains('failure_reason text'),
        isTrue,
      );
      expect(generatedDocumentLockMigration.contains('locked_at'), isTrue);
      expect(generatedDocumentLockMigration.contains('locked_by'), isTrue);
      expect(
        generatedDocumentHelperMigration.contains(
          'create_generated_document_record',
        ),
        isTrue,
      );
      expect(
        generatedDocumentWorkerMigration.contains(
          'claim_generated_document_jobs',
        ),
        isTrue,
      );
      expect(
        generatedDocumentWorkerMigration.contains(
          'complete_generated_document_processing',
        ),
        isTrue,
      );
      expect(
        generatedDocumentWorkerMigration.contains(
          'recover_stale_generated_document_jobs',
        ),
        isTrue,
      );
    });
  });
}
