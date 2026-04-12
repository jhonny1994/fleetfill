import type { Metadata } from "next";
import { headers } from "next/headers";
import { NextIntlClientProvider } from "next-intl";
import { getMessages } from "next-intl/server";

import { getLocaleDirection, resolveAppLocale } from "@/lib/i18n/config";
import "./globals.css";

export const metadata: Metadata = {};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const requestHeaders = await headers();
  const lang = resolveAppLocale(requestHeaders.get("x-fleetfill-locale"));
  const messages = await getMessages({ locale: lang });
  const dir = getLocaleDirection(lang);

  return (
    <html suppressHydrationWarning lang={lang} dir={dir}>
      <body>
        <NextIntlClientProvider locale={lang} messages={messages}>
          {children}
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
