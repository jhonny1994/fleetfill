import { describe, expect, it } from "vitest";

import {
  buildLocalizedPath,
  resolveEnabledLocaleForRequest,
  resolveRuntimeLocalizationPolicy,
} from "@/lib/i18n/runtime-localization-policy";

describe("runtime localization policy helpers", () => {
  it("falls back to the enabled fallback locale when the preferred locale is disabled", () => {
    const policy = resolveRuntimeLocalizationPolicy({
      enabled_locales: ["ar", "en"],
      fallback_locale: "ar",
    });

    expect(resolveEnabledLocaleForRequest("fr-FR,fr;q=0.9,en;q=0.8", policy)).toBe("ar");
  });

  it("preserves the current route and query string when replacing the locale", () => {
    expect(buildLocalizedPath("/fr/payments", "fr", "ar", "?view=history&q=test")).toBe(
      "/ar/payments?view=history&q=test",
    );
  });

  it("keeps localized roots clean when redirecting to a fallback locale", () => {
    expect(buildLocalizedPath("/fr", "fr", "ar")).toBe("/ar");
  });
});
