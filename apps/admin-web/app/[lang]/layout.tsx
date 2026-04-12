import type { Metadata } from "next";
import type { ReactNode } from "react";
import { headers } from "next/headers";
import { getMessages } from "next-intl/server";
import { notFound, redirect } from "next/navigation";

import { isSupportedLocale, resolveAppLocale } from "@/lib/i18n/config";
import { buildLocalizedPath } from "@/lib/i18n/runtime-localization-policy";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchRuntimeLocalizationPolicy } from "@/lib/queries/admin-settings";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ lang: string }>;
}): Promise<Metadata> {
  const { lang } = await params;

  if (!isSupportedLocale(lang)) {
    return {};
  }

  const { dictionary } = asAdminMessages(await getMessages({ locale: lang }));

  return {
    title: dictionary.appTitle,
    description: dictionary.shell.body,
  };
}

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

  const localizationPolicy = await fetchRuntimeLocalizationPolicy();

  if (!localizationPolicy.enabledLocales.includes(lang)) {
    const requestHeaders = await headers();
    redirect(
      buildLocalizedPath(
        requestHeaders.get("x-fleetfill-pathname") ?? `/${lang}`,
        lang,
        localizationPolicy.fallbackLocale,
        requestHeaders.get("x-fleetfill-search") ?? "",
      ),
    );
  }

  const { dictionary } = asAdminMessages(await getMessages({ locale: resolveAppLocale(lang) }));

  return (
    <div className="admin-body min-h-screen">
      <div className="mx-auto min-h-screen max-w-[1600px] px-4 py-4 lg:px-6">
        <div className="sr-only">{dictionary.appTitle}</div>
        {children}
      </div>
    </div>
  );
}
