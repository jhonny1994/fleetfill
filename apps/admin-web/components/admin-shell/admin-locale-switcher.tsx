"use client";

import { Languages } from "lucide-react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";

import { buildLocalizedPath } from "@/lib/i18n/runtime-localization-policy";
import { localeEntries, type AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";

export function AdminLocaleSwitcher({
  locale,
  dictionary,
  availableLocales = localeEntries.map(([localeCode]) => localeCode),
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
  availableLocales?: AppLocale[];
}) {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();
  const ui = useAdminUi();

  function handleChange(nextLocale: string) {
    const hash = typeof window !== "undefined" ? window.location.hash : "";
    const nextPath = buildLocalizedPath(
      pathname ?? "/",
      locale,
      nextLocale as AppLocale,
      searchParams.toString(),
    );
    router.push(`${nextPath}${hash}`);
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
        {availableLocales.map((localeCode) => (
          <option key={localeCode} value={localeCode}>
            {ui.enums.locale[localeCode]}
          </option>
        ))}
      </select>
    </label>
  );
}
