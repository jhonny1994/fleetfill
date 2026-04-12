import {
  defaultLocale,
  locales,
  resolveEnabledLocales,
  resolveFallbackLocale,
  resolvePreferredLocale,
  type AppLocale,
} from "@/lib/i18n/config";

export type RuntimeLocalizationPolicy = {
  fallbackLocale: AppLocale;
  enabledLocales: AppLocale[];
};

export function resolveRuntimeLocalizationPolicy(
  localization: Record<string, unknown> | undefined,
): RuntimeLocalizationPolicy {
  const enabledLocales = resolveEnabledLocales(localization?.enabled_locales);
  const fallbackLocale = resolveFallbackLocale(localization?.fallback_locale ?? defaultLocale, enabledLocales);

  return {
    fallbackLocale,
    enabledLocales,
  };
}

export function resolveEnabledLocaleForRequest(
  acceptLanguage: string | null | undefined,
  policy: RuntimeLocalizationPolicy,
): AppLocale {
  const preferredLocale = resolvePreferredLocale(acceptLanguage);
  return policy.enabledLocales.includes(preferredLocale) ? preferredLocale : policy.fallbackLocale;
}

export function buildLocalizedPath(
  pathname: string,
  _currentLocale: AppLocale,
  nextLocale: AppLocale,
  search = "",
) {
  const normalizedPathname = pathname.startsWith("/") ? pathname : `/${pathname}`;
  const matchedLocale = locales.find(
    (locale) => normalizedPathname === `/${locale}` || normalizedPathname.startsWith(`/${locale}/`),
  );
  const pathWithoutLocale = matchedLocale
    ? normalizedPathname.slice(matchedLocale.length + 1) || "/"
    : normalizedPathname;
  const normalizedSearch = search
    ? search.startsWith("?")
      ? search
      : `?${search}`
    : "";

  if (pathWithoutLocale === "/") {
    return `/${nextLocale}${normalizedSearch}`;
  }

  const safePathWithoutLocale = pathWithoutLocale.startsWith("/") ? pathWithoutLocale : `/${pathWithoutLocale}`;
  return `/${nextLocale}${safePathWithoutLocale}${normalizedSearch}`;
}
