import 'dart:ui';

import 'package:fleetfill/l10n/generated/l10n.dart';

class AppLocaleResolver {
  static const Locale defaultFallbackLocale = Locale('ar');

  static List<Locale> get installedLocales => S.delegate.supportedLocales;

  static Locale resolve(
    Locale? locale, {
    Iterable<Locale>? supported,
    Locale? fallbackLocale,
  }) {
    return resolveFromList(
      locale == null ? null : <Locale>[locale],
      supported ?? installedLocales,
      fallbackLocale: fallbackLocale,
    );
  }

  static Locale resolveLocaleCode(
    String? localeCode, {
    required Iterable<Locale> supported,
    Locale? fallbackLocale,
  }) {
    final trimmedCode = localeCode?.trim();
    if (trimmedCode == null || trimmedCode.isEmpty) {
      return resolve(
        null,
        supported: supported,
        fallbackLocale: fallbackLocale,
      );
    }

    return resolve(
      _localeFromCode(trimmedCode),
      supported: supported,
      fallbackLocale: fallbackLocale,
    );
  }

  static Locale resolveFromList(
    List<Locale>? locales,
    Iterable<Locale> supported, {
    Locale? fallbackLocale,
  }) {
    final resolvedFallback = fallbackLocale ?? defaultFallbackLocale;
    if (locales == null || locales.isEmpty) {
      return _resolveFallback(supported, resolvedFallback);
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

    return _resolveFallback(supportedLocales, resolvedFallback);
  }

  static Locale _resolveFallback(
    Iterable<Locale> supported,
    Locale fallbackLocale,
  ) {
    final supportedLocales = supported.toList(growable: false);
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == fallbackLocale.languageCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }

  static Locale _localeFromCode(String localeCode) {
    final canonicalCode = localeCode.replaceAll('-', '_');
    final segments = canonicalCode.split('_');
    return Locale.fromSubtags(
      languageCode: segments.first.toLowerCase(),
      scriptCode: segments.length == 2 && segments[1].length == 4
          ? segments[1]
          : segments.length > 2 && segments[1].length == 4
          ? segments[1]
          : null,
      countryCode: segments.length == 2 && segments[1].length != 4
          ? segments[1].toUpperCase()
          : segments.length > 2
          ? segments.last.toUpperCase()
          : null,
    );
  }
}
