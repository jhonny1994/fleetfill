enum AuthStatus {
  unconfigured,
  unauthenticated,
  authenticated,
}

enum AppUserRole {
  shipper,
  carrier,
  admin,
}

class AuthSnapshot {
  const AuthSnapshot({
    required this.status,
    this.userId,
    this.role,
    this.isSuspended = false,
    this.hasCompletedOnboarding = false,
    this.hasPhoneNumber = false,
    this.isCarrierVerified = false,
    this.hasPayoutAccount = false,
    this.hasRecentAdminStepUp = false,
  });

  final AuthStatus status;
  final String? userId;
  final AppUserRole? role;
  final bool isSuspended;
  final bool hasCompletedOnboarding;
  final bool hasPhoneNumber;
  final bool isCarrierVerified;
  final bool hasPayoutAccount;
  final bool hasRecentAdminStepUp;

  bool get isAuthenticated => status == AuthStatus.authenticated;
}
