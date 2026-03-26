import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentProofRecord', () {
    test('maps verified proof metadata', () {
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

      expect(proof.status, 'verified');
      expect(proof.version, 2);
      expect(proof.verifiedReference, 'ABC123');
    });
  });
}
