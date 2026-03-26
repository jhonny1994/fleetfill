import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase dispute and payout contracts', () {
    late String disputePayoutMigration;

    setUpAll(() {
      disputePayoutMigration = File(
        '../../backend/supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
    });

    test('creates dispute creation and resolution rpc surface', () {
      expect(
        disputePayoutMigration.contains('create_dispute_from_delivery'),
        isTrue,
      );
      expect(
        disputePayoutMigration.contains('admin_resolve_dispute_complete'),
        isTrue,
      );
      expect(
        disputePayoutMigration.contains('admin_resolve_dispute_refund'),
        isTrue,
      );
      expect(disputePayoutMigration.contains('dispute_opened'), isTrue);
      expect(disputePayoutMigration.contains('dispute_resolved'), isTrue);
    });

    test('creates payout release rpc and payout audit/comms side effects', () {
      expect(disputePayoutMigration.contains('admin_release_payout'), isTrue);
      expect(
        disputePayoutMigration.contains(
          'payout_accounts_one_active_per_carrier_idx',
        ),
        isTrue,
      );
      expect(disputePayoutMigration.contains('payout_released'), isTrue);
      expect(disputePayoutMigration.contains('write_admin_audit_log'), isTrue);
    });
  });
}
