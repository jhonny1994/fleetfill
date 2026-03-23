import 'dart:async';
import 'dart:ui';

import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/localization/locale_resolver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const localeStorageKey = 'fleetfill.locale';

final initialLocaleProvider = Provider<Locale?>((ref) => null);

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  static Locale? localeFromStorage(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return Locale(value);
  }

  @override
  Locale? build() {
    ref.listen<AsyncValue<AuthSnapshot>>(authSessionControllerProvider, (
      _,
      next,
    ) {
      final profileLocale = next.asData?.value.profile?.preferredLocale;
      if (profileLocale == null || profileLocale.trim().isEmpty) {
        return;
      }
      unawaited(syncProfileLocale(profileLocale));
    });

    return ref.watch(initialLocaleProvider);
  }

  Future<void> setLocale(
    Locale? locale, {
    bool syncProfile = false,
  }) async {
    state = locale == null ? null : AppLocaleResolver.resolve(locale);

    final preferences = ref.read(sharedPreferencesProvider);

    if (state == null) {
      await preferences.remove(localeStorageKey);
      return;
    }

    await preferences.setString(localeStorageKey, state!.languageCode);

    if (!syncProfile) {
      return;
    }

    final auth = ref.read(authSessionControllerProvider).asData?.value;
    if (auth == null ||
        !auth.isAuthenticated ||
        auth.profile == null ||
        auth.profile!.preferredLocale == state!.languageCode) {
      return;
    }

    await ref
        .read(authRepositoryProvider)
        .updatePreferredLocale(state!.languageCode);
    await ref.read(authSessionControllerProvider.notifier).refresh();
  }

  Future<void> updateLocale(Locale locale) =>
      setLocale(locale, syncProfile: true);

  Future<void> syncProfileLocale(String? localeCode) async {
    final normalized = localeCode == null || localeCode.trim().isEmpty
        ? null
        : Locale(localeCode.trim().toLowerCase());

    if (normalized == null && state == null) {
      return;
    }

    if (normalized != null &&
        state?.languageCode ==
            AppLocaleResolver.resolve(normalized).languageCode) {
      return;
    }

    await setLocale(normalized);
  }
}
