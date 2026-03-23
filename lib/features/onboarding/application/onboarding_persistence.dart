import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const preAuthOnboardingSeenStorageKey = 'fleetfill.pre_auth_onboarding_seen';
const notificationOnboardingSeenStorageKeyPrefix =
    'fleetfill.notification_onboarding_seen';

final preAuthOnboardingControllerProvider =
    NotifierProvider<PreAuthOnboardingController, bool>(
      PreAuthOnboardingController.new,
    );

class PreAuthOnboardingController extends Notifier<bool> {
  @override
  bool build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    return preferences.getBool(preAuthOnboardingSeenStorageKey) ?? false;
  }

  Future<void> markSeen() async {
    if (state) {
      return;
    }

    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(preAuthOnboardingSeenStorageKey, true);
  }

  Future<void> reset() async {
    state = false;
    await ref
        .read(sharedPreferencesProvider)
        .remove(preAuthOnboardingSeenStorageKey);
  }
}

final notificationOnboardingControllerProvider =
    NotifierProvider<NotificationOnboardingController, bool>(
      NotificationOnboardingController.new,
    );

class NotificationOnboardingController extends Notifier<bool> {
  @override
  bool build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final auth = ref.watch(authSessionControllerProvider).asData?.value;
    final userId = auth?.userId;
    if (userId == null) {
      return true;
    }
    return preferences.getBool(_storageKey(userId)) ?? false;
  }

  Future<void> markSeen() async {
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    final userId = auth?.userId;
    if (userId == null || state) {
      return;
    }

    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_storageKey(userId), true);
  }

  Future<void> reset() async {
    final auth = ref.read(authSessionControllerProvider).asData?.value;
    final userId = auth?.userId;
    if (userId == null) {
      state = true;
      return;
    }

    state = false;
    await ref.read(sharedPreferencesProvider).remove(_storageKey(userId));
  }

  String _storageKey(String userId) {
    return '$notificationOnboardingSeenStorageKeyPrefix.$userId';
  }
}
