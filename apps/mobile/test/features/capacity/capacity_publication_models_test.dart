import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Capacity publication models', () {
    test('uses Arabic commune name when locale is Arabic', () {
      final commune = AlgeriaCommune.fromJson({
        'id': 1601,
        'wilaya_id': 16,
        'name': 'Alger Centre',
        'name_ar': 'الجزائر الوسطى',
      });

      expect(commune.displayName(const Locale('ar')), 'الجزائر الوسطى');
      expect(commune.displayName(const Locale('fr')), 'Alger Centre');
      expect(commune.matchesQuery('1601'), isTrue);
      expect(commune.matchesQuery('centre'), isTrue);
    });

    test('computes utilization ratio from published and reserved capacity', () {
      const summary = CapacityPublicationSummary(
        activeRecurringRouteCount: 2,
        activeOneOffTripCount: 1,
        upcomingDepartureCount: 5,
        publishedCapacityKg: 1000,
        reservedCapacityKg: 250,
      );

      expect(summary.utilizationRatio, 0.25);
    });
  });
}
