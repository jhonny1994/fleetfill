export const locales = ["ar", "fr", "en"] as const;

export type AppLocale = (typeof locales)[number];

export const defaultLocale: AppLocale = "ar";

const intlLocaleMap: Record<AppLocale, string> = {
  ar: "ar-DZ",
  fr: "fr-DZ",
  en: "en-DZ",
};

export function isSupportedLocale(value: string): value is AppLocale {
  return locales.includes(value as AppLocale);
}

export function getLocaleDirection(locale: AppLocale): "rtl" | "ltr" {
  return locale === "ar" ? "rtl" : "ltr";
}

export function getIntlLocale(locale: AppLocale | string): string {
  if (isSupportedLocale(locale)) {
    return intlLocaleMap[locale];
  }

  return locale;
}
