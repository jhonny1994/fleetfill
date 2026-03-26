import 'package:fleetfill/l10n/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

String localizedLanguageName(BuildContext context, Locale locale, S s) {
  final localeNames = LocaleNames.of(context);

  return localeNames?.nameOf(_localeKey(locale)) ??
      localeNames?.nameOf(locale.languageCode) ??
      _fallbackLocalizedLanguageName(locale, s);
}

String nativeLanguageName(Locale locale) {
  return LocaleNamesLocalizationsDelegate.nativeLocaleNames[_localeKey(
        locale,
      )] ??
      LocaleNamesLocalizationsDelegate.nativeLocaleNames[locale.languageCode] ??
      locale.toLanguageTag();
}

String _localeKey(Locale locale) {
  final countryCode = locale.countryCode;
  if (countryCode == null || countryCode.isEmpty) {
    return locale.languageCode;
  }

  return '${locale.languageCode}_$countryCode';
}

String _fallbackLocalizedLanguageName(Locale locale, S s) {
  return switch (locale.languageCode) {
    'ar' => s.languageOptionArabic,
    'fr' => s.languageOptionFrench,
    _ => s.languageOptionEnglish,
  };
}
