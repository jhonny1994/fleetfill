import 'dart:ui';

import 'package:fleetfill/core/localization/locale_registry.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocaleRegistry', () {
    test(
      'keeps only enabled installed locales and preserves fallback locale',
      () {
        final registry = AppLocaleRegistry.fromSettings(
          installedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
          settings: const LocalizationSettings(
            fallbackLocale: 'ar',
            enabledLocaleCodes: ['fr', 'en'],
          ),
        );

        expect(registry.fallbackLocale.languageCode, 'ar');
        expect(
          registry.enabledLocales.map((locale) => locale.languageCode),
          ['ar', 'fr', 'en'],
        );
      },
    );

    test(
      'falls back to installed Arabic locale when runtime config is empty',
      () {
        final registry = AppLocaleRegistry.fromSettings(
          installedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
          settings: LocalizationSettings.fromJson(const <String, dynamic>{}),
        );

        expect(registry.fallbackLocale.languageCode, 'ar');
        expect(
          registry.enabledLocales.map((locale) => locale.languageCode),
          ['ar', 'fr', 'en'],
        );
      },
    );
  });
}
