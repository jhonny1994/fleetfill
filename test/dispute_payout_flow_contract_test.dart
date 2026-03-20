import 'dart:io';

import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 10 migration contracts', () {
    late String disputePayoutMigration;

    setUpAll(() {
      disputePayoutMigration = File(
        'supabase/migrations/20260320120600_create_dispute_and_payout_rpc.sql',
      ).readAsStringSync();
    });

    test('creates dispute creation and resolution rpc', () {
      expect(disputePayoutMigration.contains('create_dispute_from_delivery'), isTrue);
      expect(disputePayoutMigration.contains('admin_resolve_dispute_complete'), isTrue);
      expect(disputePayoutMigration.contains('admin_resolve_dispute_refund'), isTrue);
    });

    test('creates payout release rpc and one-active-account guard index', () {
      expect(disputePayoutMigration.contains('admin_release_payout'), isTrue);
      expect(disputePayoutMigration.contains('payout_accounts_one_active_per_carrier_idx'), isTrue);
    });
  });

  group('Dispute and payout models', () {
    test('maps dispute and payout rows', () {
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
