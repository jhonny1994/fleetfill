import 'dart:ui';

import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLocaleRegistry {
  const AppLocaleRegistry({
    required this.installedLocales,
    required this.enabledLocales,
    required this.fallbackLocale,
  });

  factory AppLocaleRegistry.fromSettings({
    required Iterable<Locale> installedLocales,
    required LocalizationSettings settings,
  }) {
    final installed = installedLocales.toList(growable: false);
    final fallbackLocale = AppLocaleResolver.resolveLocaleCode(
      settings.fallbackLocale,
      supported: installed,
      fallbackLocale: AppLocaleResolver.defaultFallbackLocale,
    );
    final enabledLocaleCodes = settings.enabledLocaleCodes.toSet();
    final enabledLocales = installed
        .where(
          (locale) =>
              enabledLocaleCodes.isEmpty ||
              enabledLocaleCodes.contains(locale.languageCode),
        )
        .toList(growable: false);

    if (enabledLocales.isEmpty) {
      return AppLocaleRegistry(
        installedLocales: installed,
        enabledLocales: <Locale>[fallbackLocale],
        fallbackLocale: fallbackLocale,
      );
    }

    if (enabledLocales.any(
      (locale) => locale.languageCode == fallbackLocale.languageCode,
    )) {
      return AppLocaleRegistry(
        installedLocales: installed,
        enabledLocales: enabledLocales,
        fallbackLocale: fallbackLocale,
      );
    }

    return AppLocaleRegistry(
      installedLocales: installed,
      enabledLocales: <Locale>[fallbackLocale, ...enabledLocales],
      fallbackLocale: fallbackLocale,
    );
  }

  final List<Locale> installedLocales;
  final List<Locale> enabledLocales;
  final Locale fallbackLocale;
}

final localizationSettingsProvider = Provider<LocalizationSettings>((ref) {
  final bootstrap = ref.watch(appBootstrapControllerProvider).asData?.value;
  return bootstrap?.clientSettings.localization ??
      LocalizationSettings.fromJson(const <String, dynamic>{});
});

final localeRegistryProvider = Provider<AppLocaleRegistry>((ref) {
  return AppLocaleRegistry.fromSettings(
    installedLocales: AppLocaleResolver.installedLocales,
    settings: ref.watch(localizationSettingsProvider),
  );
});

final availableLocalesProvider = Provider<List<Locale>>((ref) {
  return ref.watch(localeRegistryProvider).enabledLocales;
});

final effectiveLocaleProvider = Provider<Locale>((ref) {
  final registry = ref.watch(localeRegistryProvider);
  return AppLocaleResolver.resolve(
    ref.watch(localeControllerProvider),
    supported: registry.enabledLocales,
    fallbackLocale: registry.fallbackLocale,
  );
});
