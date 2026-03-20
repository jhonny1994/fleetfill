import 'dart:io';

import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 9 migration contracts', () {
    late String trackingMigration;

    setUpAll(() {
      trackingMigration = File(
        'supabase/migrations/20260320120500_create_tracking_and_delivery_rpc.sql',
      ).readAsStringSync();
    });

    test('creates carrier milestone and delivery confirmation rpc', () {
      expect(trackingMigration.contains('carrier_record_booking_milestone'), isTrue);
      expect(trackingMigration.contains('shipper_confirm_delivery'), isTrue);
      expect(trackingMigration.contains('auto_complete_delivered_bookings'), isTrue);
      expect(trackingMigration.contains('append_tracking_event'), isTrue);
    });
  });

  group('Tracking event model', () {
    test('maps tracking event rows', () {
      final event = TrackingEventRecord.fromJson({
        'id': 'event-1',
        'booking_id': 'booking-1',
        'event_type': 'in_transit',
        'visibility': 'user_visible',
        'note': 'Reached relay point',
        'created_by': 'carrier-1',
        'recorded_at': '2026-03-20T12:00:00Z',
        'created_at': '2026-03-20T12:00:00Z',
      });

      expect(event.eventType, 'in_transit');
      expect(event.note, 'Reached relay point');
    });
  });
}
