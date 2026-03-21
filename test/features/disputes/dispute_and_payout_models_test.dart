import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DisputeRecord and PayoutRecord', () {
    test('map dispute and payout rows', () {
      final dispute = DisputeRecord.fromJson({
        'id': 'dispute-1',
        'booking_id': 'booking-1',
        'opened_by': 'shipper-1',
        'reason': 'Damaged goods',
        'description': 'Boxes were damaged',
        'status': 'open',
        'resolution': null,
        'resolution_note': null,
        'resolved_by': null,
        'resolved_at': null,
        'created_at': '2026-03-20T12:00:00Z',
        'updated_at': '2026-03-20T12:00:00Z',
      });
      final payout = PayoutRecord.fromJson({
        'id': 'payout-1',
        'booking_id': 'booking-1',
        'carrier_id': 'carrier-1',
        'payout_account_id': 'account-1',
        'payout_account_snapshot': {'account_type': 'ccp'},
        'amount_dzd': 1200,
        'status': 'sent',
        'external_reference': 'PAYOUT-1',
        'processed_by': 'admin-1',
        'processed_at': '2026-03-20T14:00:00Z',
        'failure_reason': null,
        'created_at': '2026-03-20T14:00:00Z',
        'updated_at': '2026-03-20T14:00:00Z',
      });

      expect(dispute.reason, 'Damaged goods');
      expect(payout.status, 'sent');
    });
  });
}
