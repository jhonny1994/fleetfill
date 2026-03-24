export const locales = ["ar", "fr", "en"] as const;

export type AppLocale = (typeof locales)[number];

export const defaultLocale: AppLocale = "ar";

export function isSupportedLocale(value: string): value is AppLocale {
  return locales.includes(value as AppLocale);
}
