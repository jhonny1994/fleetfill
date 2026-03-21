import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Booking and payment statuses', () {
    test('map database values to enums', () {
      expect(
        BookingStatus.fromDatabase('pending_payment'),
        BookingStatus.pendingPayment,
      );
      expect(
        PaymentStatus.fromDatabase('released_to_carrier'),
        PaymentStatus.releasedToCarrier,
      );
    });
  });
}
