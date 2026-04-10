import { describe, expect, it } from "vitest";

import {
  defaultLocale,
  resolveAppLocale,
  resolveEnabledLocales,
  resolveFallbackLocale,
} from "@/lib/i18n/config";

describe("i18n config", () => {
  it("filters unsupported locales from runtime-enabled locales", () => {
    expect(resolveEnabledLocales(["ar", "es", "fr", "ar"])).toEqual(["ar", "fr"]);
  });

  it("falls back to all locales when runtime-enabled locales are invalid", () => {
    expect(resolveEnabledLocales(["es"])).toContain(defaultLocale);
  });

  it("forces fallback locale to remain inside the enabled locale set", () => {
    expect(resolveFallbackLocale("en", ["ar", "fr"])).toBe("ar");
    expect(resolveFallbackLocale("fr", ["ar", "fr"])).toBe("fr");
  });

  it("resolves unknown app locales to the default locale", () => {
    expect(resolveAppLocale("es")).toBe(defaultLocale);
  });
});
