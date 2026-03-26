import 'dart:ui';

import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/localization/locale_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('shouldPersistLocalLocaleToProfile', () {
    test('prefers local onboarding locale over default profile locale', () {
      const auth = AuthSnapshot(
        status: AuthStatus.authenticated,
        profile: AppProfile(
          id: 'user-1',
          email: 'user@example.com',
          preferredLocale: 'ar',
          role: null,
          fullName: null,
          phoneNumber: null,
          companyName: null,
          avatarUrl: null,
          isActive: true,
          ratingAverage: null,
          ratingCount: 0,
        ),
      );

      expect(
        shouldPersistLocalLocaleToProfile(
          auth: auth,
          localLocale: const Locale('en'),
        ),
        isTrue,
      );
    });

    test('uses profile locale once onboarding is complete', () {
      const auth = AuthSnapshot(
        status: AuthStatus.authenticated,
        profile: AppProfile(
          id: 'user-1',
          email: 'user@example.com',
          preferredLocale: 'ar',
          role: AppUserRole.shipper,
          fullName: 'User Name',
          phoneNumber: '0550123456',
          companyName: null,
          avatarUrl: null,
          isActive: true,
          ratingAverage: null,
          ratingCount: 0,
        ),
        hasCompletedOnboarding: true,
      );

      expect(
        shouldPersistLocalLocaleToProfile(
          auth: auth,
          localLocale: const Locale('en'),
        ),
        isFalse,
      );
    });
  });
}
