import 'dart:ui';

import 'package:fleetfill/l10n/generated/l10n.dart';

class AppLocaleResolver {
  static const Locale fallbackLocale = Locale('en');

  static List<Locale> get supportedLocales => S.delegate.supportedLocales;

  static Locale resolve(Locale? locale) {
    return resolveFromList(
      locale == null ? null : <Locale>[locale],
      supportedLocales,
    );
  }

  static Locale resolveFromList(
    List<Locale>? locales,
    Iterable<Locale> supported,
  ) {
    if (locales == null || locales.isEmpty) {
      return fallbackLocale;
    }

    final supportedLocales = supported.toList(growable: false);

    for (final locale in locales) {
      for (final supportedLocale in supportedLocales) {
        final exactMatch =
            supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode &&
            supportedLocale.scriptCode == locale.scriptCode;

        if (exactMatch) {
          return supportedLocale;
        }
      }

      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == fallbackLocale.languageCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }
}
