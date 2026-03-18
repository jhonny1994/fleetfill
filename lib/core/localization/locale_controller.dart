import 'dart:ui';

import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/localization/locale_resolver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const localeStorageKey = 'fleetfill.locale';

final initialLocaleProvider = Provider<Locale?>((ref) => null);

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

final effectiveLocaleProvider = Provider<Locale>((ref) {
  return AppLocaleResolver.resolve(ref.watch(localeControllerProvider));
});

class LocaleController extends Notifier<Locale?> {
  static Locale? localeFromStorage(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return Locale(value);
  }

  @override
  Locale? build() => ref.watch(initialLocaleProvider);

  Future<void> setLocale(Locale? locale) async {
    state = locale == null ? null : AppLocaleResolver.resolve(locale);

    final preferences = ref.read(sharedPreferencesProvider);

    if (state == null) {
      await preferences.remove(localeStorageKey);
      return;
    }

    await preferences.setString(localeStorageKey, state!.languageCode);
  }

  Future<void> updateLocale(Locale locale) => setLocale(locale);
}
