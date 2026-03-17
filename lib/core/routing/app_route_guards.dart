import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppRedirectTarget {
  none,
  maintenance,
  updateRequired,
  signIn,
  roleSelection,
  profileSetup,
  phoneCompletion,
  verificationGate,
  payoutAccountGate,
  forbidden,
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

  static RouteGuardDecision evaluate({
    required AppBootstrapState bootstrap,
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

    final auth = bootstrap.auth;
    final inAuthFlow = location.startsWith('/auth');
    final inOnboarding = location.startsWith('/onboarding');
    final inPermissions = location.startsWith('/permissions');

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

    if (auth.role == null && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.roleSelection);
    }

    if (!auth.hasCompletedOnboarding && !inOnboarding) {
      return const RouteGuardDecision(target: AppRedirectTarget.profileSetup);
    }

    final needsPhoneForOperationalAction =
        (location.startsWith('/shipper') || location.startsWith('/carrier')) &&
        !inPermissions;

    if (needsPhoneForOperationalAction && !auth.hasPhoneNumber) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.phoneCompletion,
      );
    }

    final needsCarrierVerification =
        location.startsWith('/carrier/routes') ||
        location.startsWith('/carrier/bookings');
    if (needsCarrierVerification && !auth.isCarrierVerified) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.verificationGate,
      );
    }

    final needsPayoutAccount = location.startsWith('/carrier/bookings');
    if (needsPayoutAccount && !auth.hasPayoutAccount) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.payoutAccountGate,
      );
    }

    final isAdminLocation = location.startsWith('/admin');
    if (isAdminLocation && auth.role != AppUserRole.admin) {
      return const RouteGuardDecision(
        target: AppRedirectTarget.forbidden,
        reason: 'admin_only',
      );
    }

    return const RouteGuardDecision.none();
  }

  static String? redirectLocation(RouteGuardDecision decision) {
    switch (decision.target) {
      case AppRedirectTarget.none:
        return null;
      case AppRedirectTarget.maintenance:
        return AppRoutePath.maintenance;
      case AppRedirectTarget.updateRequired:
        return AppRoutePath.updateRequired;
      case AppRedirectTarget.signIn:
        return AppRoutePath.signIn;
      case AppRedirectTarget.roleSelection:
        return AppRoutePath.roleSelection;
      case AppRedirectTarget.profileSetup:
        return AppRoutePath.profileSetup;
      case AppRedirectTarget.phoneCompletion:
        return AppRoutePath.phoneCompletion;
      case AppRedirectTarget.verificationGate:
        return AppRoutePath.carrierProfile;
      case AppRedirectTarget.payoutAccountGate:
        return AppRoutePath.carrierProfile;
      case AppRedirectTarget.forbidden:
        return null;
    }
  }
}

final bootstrapGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null) {
    return const RouteGuardDecision.none();
  }

  if (bootstrap.environment.maintenanceMode &&
      location != AppRoutePath.maintenance) {
    return const RouteGuardDecision(target: AppRedirectTarget.maintenance);
  }

  if (bootstrap.environment.forceUpdateRequired &&
      location != AppRoutePath.updateRequired) {
    return const RouteGuardDecision(target: AppRedirectTarget.updateRequired);
  }

  return const RouteGuardDecision.none();
});

final authGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  final inAuthFlow = location.startsWith('/auth');

  if (!auth.isAuthenticated &&
      auth.status != AuthStatus.unconfigured &&
      !inAuthFlow) {
    return const RouteGuardDecision(target: AppRedirectTarget.signIn);
  }

  return const RouteGuardDecision.none();
});

final onboardingGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null || !bootstrap.auth.isAuthenticated) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  final inOnboarding = location.startsWith('/onboarding');

  if (auth.role == null && !inOnboarding) {
    return const RouteGuardDecision(target: AppRedirectTarget.roleSelection);
  }

  if (!auth.hasCompletedOnboarding && !inOnboarding) {
    return const RouteGuardDecision(target: AppRedirectTarget.profileSetup);
  }

  return const RouteGuardDecision.none();
});

final roleGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null || !bootstrap.auth.isAuthenticated) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  if (auth.isSuspended) {
    return const RouteGuardDecision(
      target: AppRedirectTarget.forbidden,
      reason: 'suspended',
    );
  }

  if (location.startsWith('/admin') && auth.role != AppUserRole.admin) {
    return const RouteGuardDecision(
      target: AppRedirectTarget.forbidden,
      reason: 'admin_only',
    );
  }

  return const RouteGuardDecision.none();
});

final verificationGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null || !bootstrap.auth.isAuthenticated) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  final inPermissions = location.startsWith('/permissions');
  final needsPhoneForOperationalAction =
      (location.startsWith('/shipper') || location.startsWith('/carrier')) &&
      !inPermissions;

  if (needsPhoneForOperationalAction && !auth.hasPhoneNumber) {
    return const RouteGuardDecision(target: AppRedirectTarget.phoneCompletion);
  }

  final needsCarrierVerification =
      location.startsWith('/carrier/routes') ||
      location.startsWith('/carrier/bookings');
  if (needsCarrierVerification && !auth.isCarrierVerified) {
    return const RouteGuardDecision(target: AppRedirectTarget.verificationGate);
  }

  return const RouteGuardDecision.none();
});

final payoutAccountGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null || !bootstrap.auth.isAuthenticated) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  final needsPayoutAccount = location.startsWith('/carrier/bookings');
  if (needsPayoutAccount && !auth.hasPayoutAccount) {
    return const RouteGuardDecision(target: AppRedirectTarget.payoutAccountGate);
  }

  return const RouteGuardDecision.none();
});

final adminStepUpGuardProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  if (bootstrap == null || !bootstrap.auth.isAuthenticated) {
    return const RouteGuardDecision.none();
  }

  final auth = bootstrap.auth;
  final needsRecentAdminStepUp = location.startsWith(AppRoutePath.adminAuditLog);

  if (needsRecentAdminStepUp && !auth.hasRecentAdminStepUp) {
    return const RouteGuardDecision(
      target: AppRedirectTarget.forbidden,
      reason: 'admin_step_up_required',
    );
  }

  return const RouteGuardDecision.none();
});

final routeGuardDecisionProvider = Provider.family<RouteGuardDecision, String>((
  ref,
  location,
) {
  final decisions = <RouteGuardDecision>[
    ref.watch(bootstrapGuardProvider(location)),
    ref.watch(authGuardProvider(location)),
    ref.watch(onboardingGuardProvider(location)),
    ref.watch(roleGuardProvider(location)),
    ref.watch(verificationGuardProvider(location)),
    ref.watch(payoutAccountGuardProvider(location)),
    ref.watch(adminStepUpGuardProvider(location)),
  ];

  return decisions.firstWhere(
    (decision) => decision.hasRedirect,
    orElse: RouteGuardDecision.none,
  );
});
