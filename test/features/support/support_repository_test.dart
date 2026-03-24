import 'package:fleetfill/features/support/infrastructure/support_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildAdminSupportSearchFilter', () {
    test('uses subject text search for normal free-text queries', () {
      expect(
        buildAdminSupportSearchFilter('payment issue'),
        'subject.ilike.%payment issue%',
      );
    });

    test('adds UUID equality filters for linked entity lookups', () {
      const id = '123e4567-e89b-42d3-a456-426614174000';

      expect(
        buildAdminSupportSearchFilter(id),
        allOf([
          contains('subject.ilike.%$id%'),
          contains('created_by.eq.$id'),
          contains('booking_id.eq.$id'),
          contains('shipment_id.eq.$id'),
          contains('payment_proof_id.eq.$id'),
          contains('dispute_id.eq.$id'),
        ]),
      );
    });
  });
}
