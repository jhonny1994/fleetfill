import 'package:fleetfill/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const environment = AppEnvironmentConfig(environment: AppEnvironment.local);

  AppBootstrapState bootstrap(AuthSnapshot auth) {
    return AppBootstrapState(
      status: BootstrapStateStatus.ready,
      environment: environment,
      auth: auth,
    );
  }

  AuthSnapshot authSnapshot({
    required AuthStatus status,
    AppUserRole? role,
    bool hasCompletedOnboarding = false,
    bool hasPhoneNumber = false,
    bool isSuspended = false,
    bool isCarrierVerified = false,
    bool hasPayoutAccount = false,
    bool hasRecentAdminStepUp = false,
    bool isPasswordRecovery = false,
    bool isSessionExpired = false,
  }) {
    return AuthSnapshot(
      status: status,
      userId: status == AuthStatus.authenticated ? 'user-1' : null,
      email: status == AuthStatus.authenticated ? 'user@example.com' : null,
      role: role,
      isSuspended: isSuspended,
      hasCompletedOnboarding: hasCompletedOnboarding,
      hasPhoneNumber: hasPhoneNumber,
      isCarrierVerified: isCarrierVerified,
      hasPayoutAccount: hasPayoutAccount,
      hasRecentAdminStepUp: hasRecentAdminStepUp,
      isPasswordRecovery: isPasswordRecovery,
      isSessionExpired: isSessionExpired,
    );
  }

  group('Auth entry routing', () {
    test('routes authenticated users through onboarding gates in order', () {
      expect(
        AppRouteGuards.authenticatedEntryLocation(
          authSnapshot(status: AuthStatus.authenticated),
        ),
        AppRoutePath.roleSelection,
      );

      expect(
        AppRouteGuards.authenticatedEntryLocation(
          authSnapshot(
            status: AuthStatus.authenticated,
            role: AppUserRole.shipper,
          ),
        ),
        AppRoutePath.profileSetup,
      );

      expect(
        AppRouteGuards.authenticatedEntryLocation(
          authSnapshot(
            status: AuthStatus.authenticated,
            role: AppUserRole.carrier,
            hasCompletedOnboarding: true,
          ),
        ),
        AppRoutePath.phoneCompletion,
      );

      expect(
        AppRouteGuards.authenticatedEntryLocation(
          authSnapshot(
            status: AuthStatus.authenticated,
            role: AppUserRole.shipper,
            hasCompletedOnboarding: true,
            hasPhoneNumber: true,
          ),
        ),
        AppRoutePath.shipperHome,
      );
    });

    test('allows admin users to skip phone gate', () {
      expect(
        AppRouteGuards.authenticatedEntryLocation(
          authSnapshot(
            status: AuthStatus.authenticated,
            role: AppUserRole.admin,
            hasCompletedOnboarding: true,
          ),
        ),
        AppRoutePath.adminDashboard,
      );
    });
  });

  group('Auth guard decisions', () {
    test('keeps suspended accounts on the sign-in holding route', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isSuspended: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperHome,
      );

      expect(decision.target, AppRedirectTarget.forbidden);
      expect(decision.reason, 'suspended');
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.signIn,
      );
    });

    test('redirects non-admin users away from admin surfaces', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.adminSettings,
      );

      expect(decision.target, AppRedirectTarget.forbidden);
      expect(decision.reason, 'admin_only');
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.shipperHome,
      );
    });

    test('keeps non-operational profile access open without phone number', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperProfile,
      );

      expect(decision.target, AppRedirectTarget.none);
    });

    test('gates shipper shipments behind phone completion', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperShipments,
      );

      expect(decision.target, AppRedirectTarget.phoneCompletion);
    });

    test('gates operational shipper search behind phone completion', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperSearch,
      );

      expect(decision.target, AppRedirectTarget.phoneCompletion);
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.phoneCompletion,
      );
    });

    test('redirects carriers away from shipper-only surfaces', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.carrier,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isCarrierVerified: true,
        hasPayoutAccount: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperHome,
      );

      expect(decision.target, AppRedirectTarget.forbidden);
      expect(decision.reason, 'shipper_only');
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.carrierHome,
      );
    });

    test('redirects shippers away from carrier-only surfaces', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.carrierHome,
      );

      expect(decision.target, AppRedirectTarget.forbidden);
      expect(decision.reason, 'carrier_only');
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.shipperHome,
      );
    });

    test('redirects users away from role selection once role is assigned', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.roleSelection,
      );

      expect(decision.target, AppRedirectTarget.home);
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.shipperHome,
      );
    });

    test(
      'routes unverified carriers away from operational booking surfaces',
      () {
        final auth = authSnapshot(
          status: AuthStatus.authenticated,
          role: AppUserRole.carrier,
          hasCompletedOnboarding: true,
          hasPhoneNumber: true,
        );

        final decision = AppRouteGuards.evaluate(
          bootstrap: bootstrap(auth),
          auth: auth,
          location: AppRoutePath.carrierBookings,
        );

        expect(decision.target, AppRedirectTarget.verificationGate);
        expect(
          AppRouteGuards.redirectLocation(decision, auth: auth),
          AppRoutePath.carrierProfile,
        );
      },
    );

    test('redirects expired sessions back to sign-in', () {
      final auth = authSnapshot(
        status: AuthStatus.unauthenticated,
        isSessionExpired: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.shipperHome,
      );

      expect(decision.target, AppRedirectTarget.sessionExpired);
      expect(
        AppRouteGuards.redirectLocation(decision, auth: auth),
        AppRoutePath.signIn,
      );
    });

    test('keeps password-recovery users on auth routes', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isPasswordRecovery: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.resetPassword,
      );

      expect(decision.target, AppRedirectTarget.none);
      expect(AppRouteGuards.redirectLocation(decision, auth: auth), isNull);
    });

    test('keeps password-recovery users on sign-in route', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isPasswordRecovery: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.signIn,
      );

      expect(decision.target, AppRedirectTarget.none);
    });

    test('keeps password-recovery users on forgot-password route', () {
      final auth = authSnapshot(
        status: AuthStatus.authenticated,
        role: AppUserRole.shipper,
        hasCompletedOnboarding: true,
        hasPhoneNumber: true,
        isPasswordRecovery: true,
      );

      final decision = AppRouteGuards.evaluate(
        bootstrap: bootstrap(auth),
        auth: auth,
        location: AppRoutePath.forgotPassword,
      );

      expect(decision.target, AppRedirectTarget.none);
    });

    test(
      'redirects password-recovery users to reset route from non-auth pages',
      () {
        final auth = authSnapshot(
          status: AuthStatus.authenticated,
          role: AppUserRole.shipper,
          hasCompletedOnboarding: true,
          hasPhoneNumber: true,
          isPasswordRecovery: true,
        );

        final decision = AppRouteGuards.evaluate(
          bootstrap: bootstrap(auth),
          auth: auth,
          location: AppRoutePath.shipperHome,
        );

        expect(decision.target, AppRedirectTarget.resetPassword);
        expect(
          AppRouteGuards.redirectLocation(decision, auth: auth),
          AppRoutePath.resetPassword,
        );
      },
    );
  });
}
