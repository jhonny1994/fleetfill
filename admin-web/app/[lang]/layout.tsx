import type { ReactNode } from "react";
import { notFound } from "next/navigation";

import { getDictionary } from "@/lib/i18n/dictionaries";
import { getLocaleDirection, isSupportedLocale, type AppLocale } from "@/lib/i18n/config";

export default async function LocalizedLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;

  if (!isSupportedLocale(lang)) {
    notFound();
  }

  const dictionary = await getDictionary(lang as AppLocale);

  return (
    <div className="admin-body min-h-screen" dir={getLocaleDirection(lang as AppLocale)} lang={lang}>
      <div className="mx-auto min-h-screen max-w-[1600px] px-4 py-4 lg:px-6">
        <div className="sr-only">{dictionary.appTitle}</div>
        {children}
      </div>
    </div>
  );
}
