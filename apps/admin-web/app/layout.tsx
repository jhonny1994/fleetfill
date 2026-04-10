import type { Metadata } from "next";
import { NextIntlClientProvider } from "next-intl";
import { getLocale, getMessages } from "next-intl/server";

import { defaultLocale, getLocaleDirection, isSupportedLocale } from "@/lib/i18n/config";
import "./globals.css";

export const metadata: Metadata = {};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const [locale, messages] = await Promise.all([getLocale(), getMessages()]);
  const lang = isSupportedLocale(locale) ? locale : defaultLocale;
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
