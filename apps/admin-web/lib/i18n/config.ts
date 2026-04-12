export const localeRegistry = {
  ar: {
    direction: "rtl",
    intlLocale: "ar-DZ",
    labelKey: "locale.ar",
  },
  fr: {
    direction: "ltr",
    intlLocale: "fr-DZ",
    labelKey: "locale.fr",
  },
  en: {
    direction: "ltr",
    intlLocale: "en-DZ",
    labelKey: "locale.en",
  },
} as const;

export type AppLocale = keyof typeof localeRegistry;

export const locales = Object.keys(localeRegistry) as AppLocale[];
export const localeValues = [...locales] as [AppLocale, ...AppLocale[]];
export const localeEntries = Object.entries(localeRegistry) as Array<
  [AppLocale, (typeof localeRegistry)[AppLocale]]
>;

export const defaultLocale: AppLocale = "ar";

export function isSupportedLocale(value: string): value is AppLocale {
  return value in localeRegistry;
}

export function parseSupportedLocale(value: unknown): AppLocale | null {
  if (typeof value !== "string") {
    return null;
  }

  return isSupportedLocale(value) ? value : null;
}

export function resolveAppLocale(value: unknown): AppLocale {
  return parseSupportedLocale(value) ?? defaultLocale;
}

export function getLocaleDirection(locale: AppLocale): "rtl" | "ltr" {
  return localeRegistry[locale].direction;
}

export function getIntlLocale(locale: AppLocale | string): string {
  if (isSupportedLocale(locale)) {
    return localeRegistry[locale].intlLocale;
  }

  return locale;
}

export function resolveEnabledLocales(value: unknown): AppLocale[] {
  if (!Array.isArray(value)) {
    return [...locales];
  }

  const uniqueLocales = Array.from(
    new Set(value.map((entry) => parseSupportedLocale(entry)).filter((entry): entry is AppLocale => entry !== null)),
  );

  return uniqueLocales.length > 0 ? uniqueLocales : [...locales];
}

export function resolveFallbackLocale(value: unknown, enabledLocales: readonly AppLocale[]): AppLocale {
  const fallback = parseSupportedLocale(value);

  if (fallback && enabledLocales.includes(fallback)) {
    return fallback;
  }

  return enabledLocales[0] ?? defaultLocale;
}

export function resolvePreferredLocale(acceptLanguage: string | null | undefined): AppLocale {
  if (!acceptLanguage) {
    return defaultLocale;
  }

  const requestedLocales = acceptLanguage
    .split(",")
    .map((entry) => {
      const [tag, qualityToken] = entry.trim().split(";q=");
      const quality = Number.parseFloat(qualityToken ?? "1");

      return {
        locale: tag.toLowerCase(),
        quality: Number.isFinite(quality) ? quality : 0,
      };
    })
    .filter((entry) => entry.locale.length > 0)
    .sort((left, right) => right.quality - left.quality);

  for (const requested of requestedLocales) {
    const baseLocale = requested.locale.split("-")[0];
    if (isSupportedLocale(baseLocale)) {
      return baseLocale;
    }
  }

  return defaultLocale;
}
