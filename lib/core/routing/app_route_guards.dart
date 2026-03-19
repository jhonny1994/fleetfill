import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppRedirectTarget {
  none,
  maintenance,
  updateRequired,
  signIn,
  resetPassword,
  home,
  roleSelection,
  profileSetup,
  phoneCompletion,
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
    return location == AppRoutePath.shipperSearch ||
        location.startsWith('${AppRoutePath.shipperSearch}/') ||
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

  static RouteGuardDecision evaluate({
    required AppBootstrapState bootstrap,
    required AuthSnapshot auth,
    required String location,
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

    if (auth.isSessionExpired && !inAuthFlow) {
      return const RouteGuardDecision(target: AppRedirectTarget.sessionExpired);
    }

    if (!auth.isAuthenticated &&
        auth.status != AuthStatus.unconfigured &&
        !inAuthFlow) {
      return const RouteGuardDecision(target: AppRedirectTarget.signIn);
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

    if (auth.isPasswordRecovery &&
        location != AppRoutePath.resetPassword &&
        location != AppRoutePath.signIn &&
        location != AppRoutePath.forgotPassword) {
      return const RouteGuardDecision(target: AppRedirectTarget.resetPassword);
    }

    if (inAuthFlow && !auth.isPasswordRecovery) {
      return const RouteGuardDecision(target: AppRedirectTarget.home);
    }

    if (auth.role == null && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.roleSelection);
    }

    if (!auth.hasCompletedOnboarding && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.profileSetup);
    }

    final needsPhoneForOperationalAction =
        _needsPhoneForOperationalAction(location) && !inPermissions;

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

final routeGuardDecisionProvider = Provider.family<RouteGuardDecision, String>(
  (ref, location) {
    final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    if (bootstrap == null || auth == null) {
      return const RouteGuardDecision.none();
    }

    final decision = AppRouteGuards.evaluate(
      bootstrap: bootstrap,
      auth: auth,
      location: location,
    );
    if (decision.hasRedirect) {
      return decision;
    }

    final needsRecentAdminStepUp = location.startsWith(
      AppRoutePath.adminAuditLog,
    );
    if (needsRecentAdminStepUp && !auth.hasRecentAdminStepUp) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'admin_step_up_required',
      );
    }

    return const RouteGuardDecision.none();
  },
);
