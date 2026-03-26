import 'dart:async';

import 'package:fleetfill/core/auth/auth_repository.dart';
import 'package:fleetfill/core/auth/auth_state.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authSessionControllerProvider =
    AsyncNotifierProvider<AuthSessionController, AuthSnapshot>(
      AuthSessionController.new,
    );

class AuthSessionController extends AsyncNotifier<AuthSnapshot> {
  StreamSubscription<AuthState>? _subscription;
  bool _passwordRecoveryActive = false;
  bool _sessionExpired = false;
  bool _manualSignOut = false;

  @override
  Future<AuthSnapshot> build() async {
    final repository = ref.watch(authRepositoryProvider);

    if (!repository.environment.hasSupabaseConfig ||
        !AppBootstrapController.supabaseInitialized) {
      return repository.buildSnapshot(
        isPasswordRecovery: _passwordRecoveryActive,
        isSessionExpired: _sessionExpired,
      );
    }

    _subscription ??= repository.authStateChanges.listen(
      _handleAuthStateChange,
    );
    ref.onDispose(() => _subscription?.cancel());

    return repository.buildSnapshot(
      isPasswordRecovery: _passwordRecoveryActive,
      isSessionExpired: _sessionExpired,
    );
  }

  Future<void> refresh() async {
    final repository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(
      () => repository.buildSnapshot(
        isPasswordRecovery: _passwordRecoveryActive,
        isSessionExpired: _sessionExpired,
      ),
    );
  }

  Future<void> signOut() async {
    _manualSignOut = true;
    _sessionExpired = false;
    _passwordRecoveryActive = false;

    try {
      await ref.read(authRepositoryProvider).signOut();
    } finally {
      await refresh();
    }
  }

  void clearSessionExpiredNotice() {
    if (!_sessionExpired) {
      return;
    }

    _sessionExpired = false;
    final value = state.asData?.value;
    if (value != null) {
      state = AsyncData(value.copyWith(isSessionExpired: false));
    }
  }

  void clearPasswordRecovery() {
    if (!_passwordRecoveryActive) {
      return;
    }

    _passwordRecoveryActive = false;
    final value = state.asData?.value;
    if (value != null) {
      state = AsyncData(value.copyWith(isPasswordRecovery: false));
    }
  }

  Future<void> _handleAuthStateChange(AuthState authState) async {
    final event = authState.event;

    if (event == AuthChangeEvent.passwordRecovery) {
      _passwordRecoveryActive = true;
      _sessionExpired = false;
    } else if (event == AuthChangeEvent.signedOut) {
      final wasAuthenticated = state.asData?.value.isAuthenticated ?? false;
      _sessionExpired = wasAuthenticated && !_manualSignOut;
      _passwordRecoveryActive = false;
      _manualSignOut = false;
    } else if (event == AuthChangeEvent.signedIn ||
        event == AuthChangeEvent.initialSession ||
        event == AuthChangeEvent.tokenRefreshed ||
        event == AuthChangeEvent.userUpdated) {
      _sessionExpired = false;
      _manualSignOut = false;
    }

    await refresh();
  }
}
