import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const preAuthOnboardingSeenStorageKey = 'fleetfill.pre_auth_onboarding_seen';

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
