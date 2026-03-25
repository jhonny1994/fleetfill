enum AuthStatus {
  unconfigured,
  unauthenticated,
  authenticated,
}

enum AppUserRole {
  shipper,
  carrier,
  admin
  ;

  static AppUserRole? fromDatabase(Object? value) {
    return switch (value) {
      'shipper' => AppUserRole.shipper,
      'carrier' => AppUserRole.carrier,
      'admin' => AppUserRole.admin,
      _ => null,
    };
  }

  String get databaseValue => name;
}

enum AppVerificationState {
  pending,
  verified,
  rejected
  ;

  static AppVerificationState fromDatabase(Object? value) {
    return switch (value) {
      'verified' => AppVerificationState.verified,
      'rejected' => AppVerificationState.rejected,
      _ => AppVerificationState.pending,
    };
  }
}

class AppProfile {
  const AppProfile({
    required this.id,
    required this.email,
    required this.preferredLocale,
    required this.role,
    required this.fullName,
    required this.phoneNumber,
    required this.companyName,
    required this.avatarUrl,
    required this.isActive,
    required this.ratingAverage,
    required this.ratingCount,
  });

  factory AppProfile.fromJson(Map<String, dynamic> json) {
    return AppProfile(
      id: json['id'] as String,
      email: (json['email'] as String?)?.trim() ?? '',
      preferredLocale: (json['preferred_locale'] as String?)?.trim() ?? 'ar',
      role: AppUserRole.fromDatabase(json['role']),
      fullName: (json['full_name'] as String?)?.trim(),
      phoneNumber: (json['phone_number'] as String?)?.trim(),
      companyName: (json['company_name'] as String?)?.trim(),
      avatarUrl: (json['avatar_url'] as String?)?.trim(),
      isActive: json['is_active'] as bool? ?? true,
      ratingAverage: (json['rating_average'] as num?)?.toDouble(),
      ratingCount: json['rating_count'] as int? ?? 0,
    );
  }

  final String id;
  final String email;
  final String preferredLocale;
  final AppUserRole? role;
  final String? fullName;
  final String? phoneNumber;
  final String? companyName;
  final String? avatarUrl;
  final bool isActive;
  final double? ratingAverage;
  final int ratingCount;

  bool get hasPhoneNumber => (phoneNumber ?? '').trim().isNotEmpty;

  bool get hasCompletedOnboarding {
    final hasName = (fullName ?? '').trim().isNotEmpty;
    if (!hasName || role == null) {
      return false;
    }

    if (role == AppUserRole.carrier) {
      return (companyName ?? '').trim().isNotEmpty;
    }

    return true;
  }
}

class AuthSnapshot {
  const AuthSnapshot({
    required this.status,
    this.userId,
    this.email,
    this.role,
    this.profile,
    this.isSuspended = false,
    this.hasCompletedOnboarding = false,
    this.hasPhoneNumber = false,
    this.isCarrierVerified = false,
    this.carrierVerificationStatus,
    this.carrierVerificationRejectionReason,
    this.hasPayoutAccount = false,
    this.hasRecentAdminStepUp = false,
    this.isPasswordRecovery = false,
    this.isSessionExpired = false,
  });

  final AuthStatus status;
  final String? userId;
  final String? email;
  final AppUserRole? role;
  final AppProfile? profile;
  final bool isSuspended;
  final bool hasCompletedOnboarding;
  final bool hasPhoneNumber;
  final bool isCarrierVerified;
  final AppVerificationState? carrierVerificationStatus;
  final String? carrierVerificationRejectionReason;
  final bool hasPayoutAccount;
  final bool hasRecentAdminStepUp;
  final bool isPasswordRecovery;
  final bool isSessionExpired;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthSnapshot copyWith({
    AuthStatus? status,
    String? userId,
    String? email,
    AppUserRole? role,
    AppProfile? profile,
    bool? isSuspended,
    bool? hasCompletedOnboarding,
    bool? hasPhoneNumber,
    bool? isCarrierVerified,
    AppVerificationState? carrierVerificationStatus,
    String? carrierVerificationRejectionReason,
    bool? hasPayoutAccount,
    bool? hasRecentAdminStepUp,
    bool? isPasswordRecovery,
    bool? isSessionExpired,
    bool clearRole = false,
    bool clearProfile = false,
  }) {
    return AuthSnapshot(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: clearRole ? null : role ?? this.role,
      profile: clearProfile ? null : profile ?? this.profile,
      isSuspended: isSuspended ?? this.isSuspended,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      hasPhoneNumber: hasPhoneNumber ?? this.hasPhoneNumber,
      isCarrierVerified: isCarrierVerified ?? this.isCarrierVerified,
      carrierVerificationStatus:
          carrierVerificationStatus ?? this.carrierVerificationStatus,
      carrierVerificationRejectionReason:
          carrierVerificationRejectionReason ??
          this.carrierVerificationRejectionReason,
      hasPayoutAccount: hasPayoutAccount ?? this.hasPayoutAccount,
      hasRecentAdminStepUp: hasRecentAdminStepUp ?? this.hasRecentAdminStepUp,
      isPasswordRecovery: isPasswordRecovery ?? this.isPasswordRecovery,
      isSessionExpired: isSessionExpired ?? this.isSessionExpired,
    );
  }
}
