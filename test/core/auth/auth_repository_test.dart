import 'package:fleetfill/core/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hasValidResolvedProfile', () {
    test('returns false when the backend profile is missing', () {
      expect(hasValidResolvedProfile(null), isFalse);
    });

    test('returns true when the backend profile exists', () {
      const profile = AppProfile(
        id: 'user-1',
        email: 'user@example.com',
        preferredLocale: 'ar',
        role: AppUserRole.shipper,
        fullName: 'User Name',
        phoneNumber: '0550123456',
        companyName: null,
        avatarUrl: null,
        isActive: true,
        verificationStatus: AppVerificationState.pending,
        verificationRejectionReason: null,
        ratingAverage: null,
        ratingCount: 0,
      );

      expect(hasValidResolvedProfile(profile), isTrue);
    });
  });
}
