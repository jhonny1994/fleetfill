"use client";

import { usePathname } from "next/navigation";

import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { getSupportUiCopy } from "@/lib/i18n/admin-ui";

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  const pathname = usePathname();
  const segment = pathname?.split("/")[1] ?? defaultLocale;
  const locale = isSupportedLocale(segment) ? segment : defaultLocale;
  const copy = getSupportUiCopy(locale);

  return (
    <html>
      <body className="admin-body">
        <main className="flex min-h-screen items-center justify-center p-6">
          <section className="panel max-w-xl space-y-4 p-6 text-center">
            <p className="eyebrow">{copy.globalErrorEyebrow}</p>
            <h1 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
              {copy.globalErrorTitle}
            </h1>
            <p className="text-sm text-[var(--color-ink-muted)]">
              {error.message || copy.reloadPageHint}
            </p>
            <button className="button-primary mx-auto" onClick={reset} type="button">
              {copy.tryAgain}
            </button>
          </section>
        </main>
      </body>
    </html>
  );
}
