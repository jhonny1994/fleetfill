import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/carrier/presentation/carrier_screens.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('carrierNavigationBlockReasonForIndex', () {
    const verifiedCarrierWithoutPayout = AuthSnapshot(
      status: AuthStatus.authenticated,
      hasPhoneNumber: true,
      isCarrierVerified: true,
    );

    test('does not block bookings when payout setup is missing', () {
      expect(
        carrierNavigationBlockReasonForIndex(verifiedCarrierWithoutPayout, 2),
        isNull,
      );
    });

    test('still blocks routes when phone is missing', () {
      const auth = AuthSnapshot(
        status: AuthStatus.authenticated,
        isCarrierVerified: true,
      );

      expect(
        carrierNavigationBlockReasonForIndex(auth, 1),
        CarrierNavigationBlockReason.phone,
      );
    });

    test('still blocks bookings when verification is missing', () {
      const auth = AuthSnapshot(
        status: AuthStatus.authenticated,
        hasPhoneNumber: true,
      );

      expect(
        carrierNavigationBlockReasonForIndex(auth, 2),
        CarrierNavigationBlockReason.verification,
      );
    });
  });
}
