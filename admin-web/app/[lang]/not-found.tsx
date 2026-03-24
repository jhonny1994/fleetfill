"use client";

import { usePathname } from "next/navigation";

import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { getSupportUiCopy } from "@/lib/i18n/admin-ui";

export default function LocaleNotFound() {
  const pathname = usePathname();
  const segment = pathname?.split("/")[1] ?? defaultLocale;
  const locale = isSupportedLocale(segment) ? segment : defaultLocale;
  const copy = getSupportUiCopy(locale);

  return (
    <main className="flex min-h-[60vh] items-center justify-center">
      <section className="panel max-w-lg space-y-3 p-6 text-center">
        <p className="eyebrow">{copy.notFoundEyebrow}</p>
        <h1 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
          {copy.notFoundTitle}
        </h1>
        <p className="text-sm text-[var(--color-ink-muted)]">
          {copy.notFoundBody}
        </p>
      </section>
    </main>
  );
}
