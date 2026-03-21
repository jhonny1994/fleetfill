import 'package:fleetfill/features/notifications/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppNotificationRecord', () {
    test('maps booking confirmation notification rows', () {
      final record = AppNotificationRecord.fromJson({
        'id': 'notification-1',
        'type': 'booking_confirmed',
        'title': 'Booking confirmed',
        'body': 'Your booking is recorded.',
        'data': {'booking_id': 'booking-1'},
        'is_read': false,
        'created_at': '2026-03-20T12:00:00Z',
        'read_at': null,
      });

      expect(record.id, 'notification-1');
      expect(record.type, 'booking_confirmed');
      expect(record.isRead, isFalse);
      expect(record.data['booking_id'], 'booking-1');
    });

    test('maps generated document notifications', () {
      final record = AppNotificationRecord.fromJson({
        'id': 'notification-2',
        'type': 'generated_document_ready',
        'title': 'generated_document_ready_title',
        'body': 'generated_document_ready_body',
        'data': {
          'booking_id': 'booking-1',
          'document_id': 'document-1',
          'document_type': 'booking_invoice',
        },
        'is_read': false,
        'created_at': '2026-03-20T12:00:00Z',
      });

      expect(record.type, 'generated_document_ready');
      expect(record.data['document_id'], 'document-1');
    });
  });
}
