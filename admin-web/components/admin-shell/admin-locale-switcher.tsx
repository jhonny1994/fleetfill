"use client";

import { Languages } from "lucide-react";
import { usePathname, useRouter } from "next/navigation";

import { locales, type AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";
import { getAdminUi } from "@/lib/i18n/admin-ui";

export function AdminLocaleSwitcher({
  locale,
  dictionary,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
}) {
  const pathname = usePathname();
  const router = useRouter();
  const ui = getAdminUi(locale);

  function handleChange(nextLocale: string) {
    const segments = (pathname ?? "/").split("/");
    if (segments.length > 1) {
      segments[1] = nextLocale;
    }
    router.push(segments.join("/") || `/${nextLocale}`);
  }

  return (
    <label className="admin-toolbar-chip min-w-[132px]">
      <Languages className="size-4 shrink-0 text-[var(--color-accent)]" />
      <span className="sr-only">{dictionary.shell.localeSwitcherLabel}</span>
      <select
        aria-label={dictionary.shell.localeSwitcherLabel}
        value={locale}
        onChange={(event) => handleChange(event.target.value)}
        className="w-full border-0 bg-transparent text-sm font-medium text-[var(--color-ink-strong)] outline-none"
      >
        {locales.map((localeCode) => (
          <option key={localeCode} value={localeCode}>
            {ui.enums.locale[localeCode]}
          </option>
        ))}
      </select>
    </label>
  );
}
