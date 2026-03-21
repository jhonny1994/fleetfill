import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShipmentSearchResponse', () {
    test('maps response mode and nearest dates', () {
      final response = ShipmentSearchResponse.fromJson({
        'mode': 'nearest_date',
        'results': const <dynamic>[],
        'nearest_dates': ['2026-03-21', '2026-03-22'],
        'next_offset': 20,
        'total_count': 2,
      });

      expect(response.mode, SearchResultMode.nearestDate);
      expect(response.nearestDates, hasLength(2));
      expect(response.nextOffset, 20);
    });
  });
}
