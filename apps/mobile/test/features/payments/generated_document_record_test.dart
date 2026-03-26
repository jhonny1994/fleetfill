import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneratedDocumentRecord', () {
    test('maps payment receipt metadata', () {
      final document = GeneratedDocumentRecord.fromJson({
        'id': 'doc-1',
        'booking_id': 'booking-1',
        'document_type': 'payment_receipt',
        'storage_path': 'generated/receipt.pdf',
        'version': 1,
        'generated_by': 'admin-1',
        'status': 'ready',
        'content_type': 'application/pdf',
        'byte_size': 2048,
        'available_at': '2026-03-20T13:05:00Z',
        'failure_reason': null,
        'created_at': '2026-03-20T13:00:00Z',
      });

      expect(document.status, GeneratedDocumentStatus.ready);
      expect(document.documentType, 'payment_receipt');
      expect(document.isReady, isTrue);
      expect(document.byteSize, 2048);
    });

    test('exposes failed document state', () {
      final document = GeneratedDocumentRecord.fromJson({
        'id': 'doc-2',
        'booking_id': 'booking-1',
        'document_type': 'payout_receipt',
        'storage_path': 'generated/payout-receipt.pdf',
        'status': 'failed',
      });

      expect(document.isFailed, isTrue);
    });
  });
}
