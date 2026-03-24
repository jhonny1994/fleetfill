"use client";

import { usePathname } from "next/navigation";

import { getSupportUiCopy } from "@/lib/i18n/admin-ui";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

export default function LocaleLoading() {
  const pathname = usePathname();
  const segment = pathname.split("/").filter(Boolean)[0] ?? defaultLocale;
  const locale = isSupportedLocale(segment) ? segment : defaultLocale;
  const copy = getSupportUiCopy(locale);

  return (
    <main className="flex min-h-[60vh] items-center justify-center">
      <div className="panel px-6 py-5 text-sm text-[var(--color-ink-muted)]">
        {copy.loading}
      </div>
    </main>
  );
}
