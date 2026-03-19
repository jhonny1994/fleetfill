import 'dart:async';

import 'package:fleetfill/core/auth/auth_state.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/config/app_environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const authRedirectUri = 'fleetfill://auth-callback';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  return AuthRepository(environment: environment);
});

class AuthRepository {
  const AuthRepository({required this.environment});

  final AppEnvironmentConfig environment;

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

    final user = session.user;
    final userId = user.id;
    final email = user.email?.trim();
    final profile = await _fetchCurrentProfile(userId);
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
      isCarrierVerified: profile?.isCarrierVerified ?? false,
      hasPayoutAccount: hasPayoutAccount,
      hasRecentAdminStepUp: _hasRecentAdminStepUp(user),
      isPasswordRecovery: isPasswordRecovery,
      isSessionExpired: isSessionExpired,
    );
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<bool> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return response.session == null;
  }

  Future<void> signInWithGoogle() {
    if (!environment.googleAuthEnabled) {
      throw const AuthException('google_auth_disabled');
    }

    return _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: authRedirectUri,
    );
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _client.auth.resetPasswordForEmail(
      email,
      redirectTo: authRedirectUri,
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
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('authentication_required');
    }

    final payload = <String, Object?>{
      'id': user.id,
      'email': user.email?.trim() ?? '',
      'role': role.databaseValue,
      'full_name': _nullable(fullName),
      'company_name': _nullable(companyName),
      'phone_number': _nullable(phoneNumber),
    };

    await _client.from('profiles').upsert(payload, onConflict: 'id');
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('authentication_required');
    }

    await _client
        .from('profiles')
        .update({'phone_number': phoneNumber.trim()})
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
