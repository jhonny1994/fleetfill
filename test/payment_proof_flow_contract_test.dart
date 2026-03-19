import 'dart:io';

import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 8 migration contracts', () {
    late String paymentProofMigration;

    setUpAll(() {
      paymentProofMigration = File(
        'supabase/migrations/20260320120400_create_payment_proof_review_rpc.sql',
      ).readAsStringSync();
    });

    test('creates payment proof review and deadline expiry RPCs', () {
      expect(paymentProofMigration.contains('create or replace function public.admin_approve_payment_proof'), isTrue);
      expect(paymentProofMigration.contains('create or replace function public.admin_reject_payment_proof'), isTrue);
      expect(paymentProofMigration.contains('create or replace function public.expire_payment_resubmission_deadlines'), isTrue);
    });

    test('creates generated document records and ledger side effects', () {
      expect(paymentProofMigration.contains('create_generated_document_record'), isTrue);
      expect(paymentProofMigration.contains('insert into public.financial_ledger_entries'), isTrue);
      expect(paymentProofMigration.contains('booking_invoice'), isTrue);
      expect(paymentProofMigration.contains('payment_receipt'), isTrue);
    });
  });

  group('Payment proof models', () {
    test('maps proof and generated document records', () {
      final proof = PaymentProofRecord.fromJson({
        'id': 'proof-1',
        'booking_id': 'booking-1',
        'storage_path': 'payment/1.pdf',
        'payment_rail': 'ccp',
        'submitted_reference': 'ABC123',
        'submitted_amount_dzd': 1500,
        'verified_amount_dzd': 1500,
        'verified_reference': 'ABC123',
        'status': 'verified',
        'rejection_reason': null,
        'reviewed_by': 'admin-1',
        'submitted_at': '2026-03-20T12:00:00Z',
        'reviewed_at': '2026-03-20T13:00:00Z',
        'decision_note': 'ok',
        'version': 2,
      });

      final document = GeneratedDocumentRecord.fromJson({
        'id': 'doc-1',
        'booking_id': 'booking-1',
        'document_type': 'payment_receipt',
        'storage_path': 'generated/receipt.pdf',
        'version': 1,
        'generated_by': 'admin-1',
        'created_at': '2026-03-20T13:00:00Z',
      });

      expect(proof.status, 'verified');
      expect(proof.version, 2);
      expect(document.documentType, 'payment_receipt');
    });
  });
}
