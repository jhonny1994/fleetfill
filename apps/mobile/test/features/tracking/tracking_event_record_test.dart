import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrackingEventRecord', () {
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
