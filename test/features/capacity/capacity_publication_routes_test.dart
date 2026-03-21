import 'package:fleetfill/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Carrier route helpers', () {
    test('build centralized carrier route and trip paths', () {
      expect(AppRoutePath.carrierRouteCreate(), '/carrier/routes/new-route');
      expect(
        AppRoutePath.carrierRouteDetail('route-1'),
        '/carrier/routes/route/route-1',
      );
      expect(
        AppRoutePath.carrierOneOffTripCreate(),
        '/carrier/routes/new-trip',
      );
      expect(
        AppRoutePath.carrierOneOffTripDetail('trip-1'),
        '/carrier/routes/trip/trip-1',
      );
    });
  });
}
