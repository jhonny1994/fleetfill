import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:fleetfill/features/onboarding/onboarding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

enum AppRedirectTarget {
  none,
  maintenance,
  updateRequired,
  authenticatedEntry,
  welcome,
  signIn,
  resetPassword,
  home,
  roleSelection,
  profileSetup,
  phoneCompletion,
  notificationSetup,
  verificationGate,
  payoutAccountGate,
  forbidden,
  sessionExpired,
}

class RouteGuardDecision {
  const RouteGuardDecision({required this.target, this.reason});

  const RouteGuardDecision.none() : this(target: AppRedirectTarget.none);

  final AppRedirectTarget target;
  final String? reason;

  bool get hasRedirect => target != AppRedirectTarget.none;
}

class AppRouteGuards {
  const AppRouteGuards._();

  static bool _needsPhoneForOperationalAction(String location) {
    return location == AppRoutePath.shipperShipments ||
        location.startsWith('${AppRoutePath.shipperShipments}/') ||
        location == AppRoutePath.shipperSearch ||
        location.startsWith('${AppRoutePath.shipperSearch}/') ||
        location == AppRoutePath.shipperBookingReview ||
        location.startsWith('${AppRoutePath.shipperBookingReview}/') ||
        location == AppRoutePath.shipperPaymentFlow ||
        location.startsWith('${AppRoutePath.shipperPaymentFlow}/') ||
        location == AppRoutePath.carrierRoutes ||
        location.startsWith('${AppRoutePath.carrierRoutes}/') ||
        location == AppRoutePath.carrierBookings ||
        location.startsWith('${AppRoutePath.carrierBookings}/');
  }

  static bool _needsCarrierVerification(String location) {
    return location == AppRoutePath.carrierRoutes ||
        location.startsWith('${AppRoutePath.carrierRoutes}/') ||
        location == AppRoutePath.carrierBookings ||
        location.startsWith('${AppRoutePath.carrierBookings}/');
  }

  static bool _needsPayoutAccount(String location) {
    return location == AppRoutePath.carrierBookings ||
        location.startsWith('${AppRoutePath.carrierBookings}/');
  }

  static bool _isAdminLocation(String location) {
    return location.startsWith('/admin');
  }

  static bool _isShipperLocation(String location) {
    return location.startsWith('/shipper');
  }

  static bool _isCarrierLocation(String location) {
    return location.startsWith('/carrier');
  }

  static bool _isPublicSignedOutLocation(String location) {
    return location == AppRoutePath.welcome ||
        location == AppRoutePath.languageSelection ||
        location == AppRoutePath.sharedPolicies;
  }

  static bool _needsRecentAdminStepUp(String location) {
    return location.startsWith(AppRoutePath.adminQueues) ||
        location.startsWith(AppRoutePath.adminUsers) ||
        location.startsWith(AppRoutePath.adminAuditLog);
  }

  static RouteGuardDecision evaluate({
    required AppBootstrapState bootstrap,
    required AuthSnapshot auth,
    required String location,
    bool hasSeenPreAuthOnboarding = false,
    bool hasSeenNotificationOnboarding = true,
  }) {
    if (bootstrap.environment.maintenanceMode &&
        location != AppRoutePath.maintenance) {
      return const RouteGuardDecision(target: AppRedirectTarget.maintenance);
    }

    if (bootstrap.environment.forceUpdateRequired &&
        location != AppRoutePath.updateRequired) {
      return const RouteGuardDecision(target: AppRedirectTarget.updateRequired);
    }

    final inAuthFlow = location.startsWith('/auth');
    final inOnboarding = location.startsWith('/onboarding');
    final inPermissions = location.startsWith('/permissions');
    final inWelcome = location == AppRoutePath.welcome;
    final inPublicSignedOutLocation = _isPublicSignedOutLocation(location);

    if (auth.isSessionExpired && !inAuthFlow) {
      return const RouteGuardDecision(target: AppRedirectTarget.sessionExpired);
    }

    if (!auth.isAuthenticated &&
        auth.status != AuthStatus.unconfigured &&
        !inAuthFlow &&
        !inPublicSignedOutLocation) {
      return RouteGuardDecision(
        target: hasSeenPreAuthOnboarding
            ? AppRedirectTarget.signIn
            : AppRedirectTarget.welcome,
      );
    }

    if (!auth.isAuthenticated) {
      return const RouteGuardDecision.none();
    }

    if (auth.isSuspended) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'suspended',
      );
    }

    if (location == AppRoutePath.splash) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.authenticatedEntry,
      );
    }

    if (auth.isPasswordRecovery &&
        location != AppRoutePath.resetPassword &&
        location != AppRoutePath.signIn &&
        location != AppRoutePath.forgotPassword) {
      return const RouteGuardDecision(target: AppRedirectTarget.resetPassword);
    }

    if (inOnboarding &&
        location == AppRoutePath.roleSelection &&
        auth.role != null) {
      return const RouteGuardDecision(target: AppRedirectTarget.home);
    }

    if ((inAuthFlow || inWelcome) && !auth.isPasswordRecovery) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.authenticatedEntry,
      );
    }

    if (auth.role == null && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.roleSelection);
    }

    if (!auth.hasCompletedOnboarding && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.profileSetup);
    }

    if (auth.role != AppUserRole.admin &&
        auth.hasCompletedOnboarding &&
        auth.hasPhoneNumber &&
        !hasSeenNotificationOnboarding &&
        location != AppRoutePath.notificationSetup) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.notificationSetup,
      );
    }

    final needsPhoneForOperationalAction =
        _needsPhoneForOperationalAction(location) && !inPermissions;

    if (_isShipperLocation(location) && auth.role != AppUserRole.shipper) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'shipper_only',
      );
    }

    if (_isCarrierLocation(location) && auth.role != AppUserRole.carrier) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'carrier_only',
      );
    }

    if (needsPhoneForOperationalAction && !auth.hasPhoneNumber) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.phoneCompletion,
      );
    }

    final needsCarrierVerification = _needsCarrierVerification(location);
    if (needsCarrierVerification && !auth.isCarrierVerified) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.verificationGate,
      );
    }

    final needsPayoutAccount = _needsPayoutAccount(location);
    if (needsPayoutAccount && !auth.hasPayoutAccount) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.payoutAccountGate,
      );
    }

    final isAdminLocation = _isAdminLocation(location);
    if (isAdminLocation && auth.role != AppUserRole.admin) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'admin_only',
      );
    }

    if (_needsRecentAdminStepUp(location) && !auth.hasRecentAdminStepUp) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'admin_step_up_required',
      );
    }

    return const RouteGuardDecision.none();
  }

  static String? redirectLocation(
    RouteGuardDecision decision, {
    required AuthSnapshot auth,
  }) {
    switch (decision.target) {
      case AppRedirectTarget.none:
        return null;
      case AppRedirectTarget.maintenance:
        return AppRoutePath.maintenance;
      case AppRedirectTarget.updateRequired:
        return AppRoutePath.updateRequired;
      case AppRedirectTarget.authenticatedEntry:
        return AppRoutePath.authenticatedEntry;
      case AppRedirectTarget.welcome:
        return AppRoutePath.welcome;
      case AppRedirectTarget.signIn:
      case AppRedirectTarget.sessionExpired:
        return AppRoutePath.signIn;
      case AppRedirectTarget.resetPassword:
        return AppRoutePath.resetPassword;
      case AppRedirectTarget.home:
        return authenticatedEntryLocation(auth);
      case AppRedirectTarget.roleSelection:
        return AppRoutePath.roleSelection;
      case AppRedirectTarget.profileSetup:
        return AppRoutePath.profileSetup;
      case AppRedirectTarget.phoneCompletion:
        return AppRoutePath.phoneCompletion;
      case AppRedirectTarget.notificationSetup:
        return AppRoutePath.notificationSetup;
      case AppRedirectTarget.verificationGate:
      case AppRedirectTarget.payoutAccountGate:
        return AppRoutePath.carrierProfile;
      case AppRedirectTarget.forbidden:
        if (decision.reason == 'suspended') {
          return AppRoutePath.signIn;
        }

        return homeLocation(auth);
    }
  }

  static String homeLocation(AuthSnapshot auth) {
    return switch (auth.role) {
      AppUserRole.carrier => AppRoutePath.carrierHome,
      AppUserRole.admin => AppRoutePath.adminDashboard,
      _ => AppRoutePath.shipperHome,
    };
  }

  static String authenticatedEntryLocation(AuthSnapshot auth) {
    if (auth.role == null) {
      return AppRoutePath.roleSelection;
    }

    if (!auth.hasCompletedOnboarding) {
      return AppRoutePath.profileSetup;
    }

    if (!auth.hasPhoneNumber && auth.role != AppUserRole.admin) {
      return AppRoutePath.phoneCompletion;
    }

    return homeLocation(auth);
  }
}

final ProviderFamily<RouteGuardDecision, String> routeGuardDecisionProvider =
    Provider.family<RouteGuardDecision, String>(
      (ref, location) {
        final bootstrapState = ref.watch(appBootstrapControllerProvider);
        final authState = ref.watch(authSessionControllerProvider);
        final bootstrap = bootstrapState.hasValue
            ? bootstrapState.requireValue
            : null;
        final auth = authState.hasValue
            ? authState.requireValue
            : bootstrap?.auth;
        final hasSeenPreAuthOnboarding = ref.watch(
          preAuthOnboardingControllerProvider,
        );
        final hasSeenNotificationOnboarding = ref.watch(
          notificationOnboardingControllerProvider,
        );
        if (bootstrap == null || auth == null) {
          return const RouteGuardDecision.none();
        }

        final decision = AppRouteGuards.evaluate(
          bootstrap: bootstrap,
          auth: auth,
          location: location,
          hasSeenPreAuthOnboarding: hasSeenPreAuthOnboarding,
          hasSeenNotificationOnboarding: hasSeenNotificationOnboarding,
        );
        if (decision.hasRedirect) {
          return decision;
        }

        return const RouteGuardDecision.none();
      },
    );
