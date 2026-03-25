import 'dart:async';

import 'package:fleetfill/core/auth/auth_state.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/config/app_environment.dart';
import 'package:fleetfill/core/utils/input_sanitizers.dart';
import 'package:fleetfill/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const authRedirectUri = 'fleetfill://auth-callback';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  return AuthRepository(
    environment: environment,
    googleAuthClient: const NativeGoogleAuthClient(),
  );
});

class AuthRepository {
  const AuthRepository({
    required this.environment,
    required this.googleAuthClient,
  });

  final AppEnvironmentConfig environment;
  final NativeGoogleAuthClient googleAuthClient;

  SupabaseClient get _client => Supabase.instance.client;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Session? get currentSession => _client.auth.currentSession;

  Future<AuthSnapshot> buildSnapshot({
    required bool isPasswordRecovery,
    required bool isSessionExpired,
  }) async {
    if (!environment.hasSupabaseConfig) {
      return const AuthSnapshot(status: AuthStatus.unconfigured);
    }

    final session = currentSession;
    if (session == null) {
      return AuthSnapshot(
        status: AuthStatus.unauthenticated,
        isSessionExpired: isSessionExpired,
      );
    }

    final user = await _resolveCurrentUser(session);
    if (user == null) {
      await _safeSignOut();
      return const AuthSnapshot(status: AuthStatus.unauthenticated);
    }

    final userId = user.id;
    final email = user.email?.trim();
    final profile = await _fetchCurrentProfile(userId);
    final carrierVerification = await _fetchCarrierVerificationPacket(profile);
    final hasPayoutAccount = await _fetchHasPayoutAccount(profile);

    return AuthSnapshot(
      status: AuthStatus.authenticated,
      userId: userId,
      email: email,
      role: profile?.role,
      profile: profile,
      isSuspended: profile != null && !profile.isActive,
      hasCompletedOnboarding: profile?.hasCompletedOnboarding ?? false,
      hasPhoneNumber: profile?.hasPhoneNumber ?? false,
      isCarrierVerified:
          carrierVerification?.status == AppVerificationState.verified,
      carrierVerificationStatus: carrierVerification?.status,
      carrierVerificationRejectionReason: carrierVerification?.rejectionReason,
      hasPayoutAccount: hasPayoutAccount,
      hasRecentAdminStepUp: _hasRecentAdminStepUp(user),
      isPasswordRecovery: isPasswordRecovery,
      isSessionExpired: isSessionExpired,
    );
  }

  Future<User?> _resolveCurrentUser(Session session) async {
    try {
      final response = await _client.auth.getUser(session.accessToken);
      return response.user;
    } on AuthException {
      return null;
    }
  }

  Future<void> _safeSignOut() async {
    try {
      await _client.auth.signOut();
    } on Object {
      // Best-effort cleanup for invalid cached sessions.
    }
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<bool> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: authRedirectUri,
    );
    return response.session == null;
  }

  Future<void> resendSignUpConfirmationEmail(String email) {
    return _client.auth.resend(
      email: email,
      type: OtpType.signup,
      emailRedirectTo: authRedirectUri,
    );
  }

  Future<void> signInWithGoogle() {
    final nativeConfig = _resolveGoogleSignInConfig();
    if (nativeConfig == null) {
      throw const AuthException('google_auth_disabled');
    }

    return _signInWithNativeGoogle(nativeConfig);
  }

  Future<void> _signInWithNativeGoogle(_GoogleSignInConfig config) async {
    try {
      final tokens = await googleAuthClient.authenticate(
        clientId: config.clientId,
        serverClientId: config.serverClientId,
      );

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: tokens.idToken,
        accessToken: tokens.accessToken,
      );
    } on AuthException {
      rethrow;
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const AuthException('user_cancelled');
      }
      throw AuthException('google_sign_in_failed: ${error.description}');
    } on Object catch (error) {
      final message = error.toString().toLowerCase();
      if (message.contains('cancel')) {
        throw const AuthException('user_cancelled');
      }

      throw AuthException('google_sign_in_failed: $error');
    }
  }

  _GoogleSignInConfig? _resolveGoogleSignInConfig() {
    final serverClientId = environment.googleWebClientId.trim();
    if (serverClientId.isEmpty) {
      return null;
    }

    return _GoogleSignInConfig(
      serverClientId: serverClientId,
      clientId: _resolveIosGoogleClientId(),
    );
  }

  String? _resolveIosGoogleClientId() {
    final configuredValue = environment.googleIosClientId.trim();
    if (configuredValue.isNotEmpty) {
      return configuredValue;
    }

    final firebaseValue = DefaultFirebaseOptions.ios.iosClientId?.trim();
    if (firebaseValue == null || firebaseValue.isEmpty) {
      return null;
    }

    return firebaseValue;
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _client.auth.resetPasswordForEmail(
      email,
      redirectTo: authRedirectUri,
    );
  }

  Future<void> resendPasswordResetEmail(String email) {
    return _client.auth.resend(
      email: email,
      type: OtpType.recovery,
      emailRedirectTo: authRedirectUri,
    );
  }

  Future<void> updatePassword(String newPassword) {
    return _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }

  Future<void> upsertProfile({
    required AppUserRole role,
    String? fullName,
    String? companyName,
    String? phoneNumber,
    String? preferredLocale,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('authentication_required');
    }

    final existingProfile = await _fetchCurrentProfile(user.id);
    final existingRole = existingProfile?.role;
    if (existingRole != null && existingRole != role) {
      throw const AuthException('role_already_assigned');
    }

    final payload = <String, Object?>{
      'id': user.id,
      'email': user.email?.trim() ?? '',
      'role': (existingRole ?? role).databaseValue,
      'preferred_locale':
          _nullable(preferredLocale) ??
          existingProfile?.preferredLocale ??
          'ar',
      'full_name': _sanitizePersonName(fullName) ?? existingProfile?.fullName,
      'company_name':
          existingRole == AppUserRole.carrier || role == AppUserRole.carrier
          ? _sanitizeCompanyName(companyName) ?? existingProfile?.companyName
          : null,
      'phone_number':
          _sanitizeAlgerianPhoneNumber(phoneNumber) ??
          existingProfile?.phoneNumber,
    };

    await _client.from('profiles').upsert(payload, onConflict: 'id');
  }

  Future<void> updatePreferredLocale(String localeCode) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('authentication_required');
    }

    await _client
        .from('profiles')
        .update({'preferred_locale': localeCode.trim().toLowerCase()})
        .eq('id', user.id);
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('authentication_required');
    }

    await _client
        .from('profiles')
        .update({
          'phone_number':
              _sanitizeAlgerianPhoneNumber(phoneNumber) ?? phoneNumber.trim(),
        })
        .eq('id', user.id);
  }

  Future<CarrierPublicProfileView> fetchCarrierPublicProfile(
    String carrierId,
  ) async {
    final profileResponse = await _client.rpc<Map<String, dynamic>?>(
      'get_public_carrier_profile',
      params: {'p_carrier_id': carrierId},
    );

    if (profileResponse == null) {
      throw const PostgrestException(message: 'carrier_profile_not_found');
    }

    return CarrierPublicProfileView.fromJson(profileResponse);
  }

  Future<AppProfile?> _fetchCurrentProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AppProfile.fromJson(response);
  }

  Future<bool> _fetchHasPayoutAccount(AppProfile? profile) async {
    if (profile?.role != AppUserRole.carrier) {
      return false;
    }

    final response = await _client
        .from('payout_accounts')
        .select('id')
        .eq('carrier_id', profile!.id)
        .eq('is_active', true)
        .limit(1);

    return (response as List<dynamic>).isNotEmpty;
  }

  Future<CarrierVerificationPacketView?> _fetchCarrierVerificationPacket(
    AppProfile? profile,
  ) async {
    if (profile?.role != AppUserRole.carrier) {
      return null;
    }

    final response = await _client
        .from('carrier_verification_packets')
        .select()
        .eq('carrier_id', profile!.id)
        .maybeSingle();

    return response == null
        ? null
        : CarrierVerificationPacketView.fromJson(response);
  }

  bool _hasRecentAdminStepUp(User user) {
    final rawValue = user.toJson()['last_sign_in_at'] as String?;
    final lastSignInAt = rawValue == null ? null : DateTime.tryParse(rawValue);
    if (lastSignInAt == null) {
      return false;
    }

    return DateTime.now().difference(lastSignInAt.toUtc()) <=
        const Duration(minutes: 15);
  }

  String? _nullable(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  String? _sanitizePersonName(String? value) {
    return InputSanitizers.normalizePersonName(value);
  }

  String? _sanitizeCompanyName(String? value) {
    return InputSanitizers.normalizeCompanyName(value);
  }

  String? _sanitizeAlgerianPhoneNumber(String? value) {
    return InputSanitizers.normalizeAlgerianPhoneNumber(value);
  }
}

class _GoogleSignInConfig {
  const _GoogleSignInConfig({
    required this.serverClientId,
    required this.clientId,
  });

  final String serverClientId;
  final String? clientId;
}

class NativeGoogleAuthClient {
  const NativeGoogleAuthClient();

  static const List<String> _defaultScopes = <String>[
    'openid',
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static bool _initialized = false;
  static ({String? clientId, String? serverClientId})? _configuredIds;

  Future<NativeGoogleAuthTokens> authenticate({
    String? clientId,
    String? serverClientId,
  }) async {
    await _initializeIfNeeded(
      clientId: clientId,
      serverClientId: serverClientId,
    );

    final googleSignIn = GoogleSignIn.instance;
    if (!googleSignIn.supportsAuthenticate()) {
      throw const AuthException('google_auth_disabled');
    }

    final account = await googleSignIn.authenticate(scopeHint: _defaultScopes);
    final idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw const AuthException('google_id_token_missing');
    }

    final authorization =
        await account.authorizationClient.authorizationForScopes(
          _defaultScopes,
        ) ??
        await account.authorizationClient.authorizeScopes(_defaultScopes);
    final accessToken = authorization.accessToken;
    if (accessToken.isEmpty) {
      throw const AuthException('google_access_token_missing');
    }

    return NativeGoogleAuthTokens(
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> _initializeIfNeeded({
    String? clientId,
    String? serverClientId,
  }) async {
    final requestedConfig = (
      clientId: clientId?.trim(),
      serverClientId: serverClientId?.trim(),
    );
    if (_initialized) {
      if (_configuredIds != requestedConfig) {
        throw const AuthException('google_auth_configuration_changed');
      }
      return;
    }

    await GoogleSignIn.instance.initialize(
      clientId: requestedConfig.clientId,
      serverClientId: requestedConfig.serverClientId,
    );
    _configuredIds = requestedConfig;
    _initialized = true;
  }
}

class NativeGoogleAuthTokens {
  const NativeGoogleAuthTokens({
    required this.idToken,
    required this.accessToken,
  });

  final String idToken;
  final String accessToken;
}

class CarrierPublicProfileView {
  const CarrierPublicProfileView({
    required this.id,
    required this.displayName,
    required this.companyName,
    required this.verificationStatus,
    required this.ratingAverage,
    required this.ratingCount,
    required this.comments,
  });

  factory CarrierPublicProfileView.fromJson(Map<String, dynamic> json) {
    final fullName = (json['full_name'] as String?)?.trim();
    final companyName = (json['company_name'] as String?)?.trim();

    return CarrierPublicProfileView(
      id: json['id'] as String,
      displayName: companyName ?? fullName ?? '',
      companyName: companyName,
      verificationStatus: AppVerificationState.fromDatabase(
        json['verification_status'],
      ),
      ratingAverage: (json['rating_average'] as num?)?.toDouble(),
      ratingCount: json['rating_count'] as int? ?? 0,
      comments: (json['comments'] as List<dynamic>? ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(CarrierReviewComment.fromJson)
          .toList(growable: false),
    );
  }

  final String id;
  final String displayName;
  final String? companyName;
  final AppVerificationState verificationStatus;
  final double? ratingAverage;
  final int ratingCount;
  final List<CarrierReviewComment> comments;
}

class CarrierVerificationPacketView {
  const CarrierVerificationPacketView({
    required this.carrierId,
    required this.status,
    required this.rejectionReason,
  });

  factory CarrierVerificationPacketView.fromJson(Map<String, dynamic> json) {
    return CarrierVerificationPacketView(
      carrierId: json['carrier_id'] as String,
      status: AppVerificationState.fromDatabase(json['status']),
      rejectionReason: (json['rejection_reason'] as String?)?.trim(),
    );
  }

  final String carrierId;
  final AppVerificationState status;
  final String? rejectionReason;
}

class CarrierReviewComment {
  const CarrierReviewComment({
    required this.score,
    required this.comment,
    required this.createdAt,
  });

  factory CarrierReviewComment.fromJson(Map<String, dynamic> json) {
    return CarrierReviewComment(
      score: json['score'] as int? ?? 0,
      comment: (json['comment'] as String?)?.trim() ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  final int score;
  final String comment;
  final DateTime? createdAt;
}
