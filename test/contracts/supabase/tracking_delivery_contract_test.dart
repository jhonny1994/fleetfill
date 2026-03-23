import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase tracking and delivery contracts', () {
    late String trackingMigration;

    setUpAll(() {
      trackingMigration = File(
        'supabase/migrations/20260317030000_create_operational_workflows_layer.sql',
      ).readAsStringSync();
    });

    test(
      'creates milestone, delivery confirmation, and auto-complete rpc surface',
      () {
        expect(
          trackingMigration.contains('carrier_record_booking_milestone'),
          isTrue,
        );
        expect(trackingMigration.contains('shipper_confirm_delivery'), isTrue);
        expect(
          trackingMigration.contains('auto_complete_delivered_bookings'),
          isTrue,
        );
        expect(trackingMigration.contains('append_tracking_event'), isTrue);
      },
    );

    test('hardens tracking event authorization and delivery review comms', () {
      expect(
        trackingMigration.contains('Unsupported tracking event type'),
        isTrue,
      );
      expect(
        trackingMigration.contains('Tracking events require booking access'),
        isTrue,
      );
      expect(trackingMigration.contains('delivered_pending_review'), isTrue);
    });
  });
}
