import { getMessages } from "next-intl/server";
import { ShieldEllipsis } from "lucide-react";

import { AdminSignInForm } from "@/components/auth/admin-sign-in-form";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import { defaultLocale, getLocaleDirection, isSupportedLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchRuntimeLocalizationPolicy } from "@/lib/queries/admin-settings";
import { cn } from "@/lib/utils";
import { redirect } from "next/navigation";

export default async function AdminSignInPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  const localizationPolicy = await fetchRuntimeLocalizationPolicy();

  if (!localizationPolicy.enabledLocales.includes(locale)) {
    redirect(`/${localizationPolicy.fallbackLocale}/sign-in`);
  }

  const session = await getAdminSession();

  if (session) {
    redirect(`/${locale}/dashboard`);
  }

  const { dictionary } = asAdminMessages(await getMessages({ locale }));
  const isRtl = getLocaleDirection(locale) === "rtl";

  return (
    <main className="flex min-h-[calc(100vh-2rem)] items-center justify-center">
      <section
        className={cn(
          "panel flex max-w-5xl flex-col gap-8 overflow-hidden p-6 lg:p-8",
          isRtl ? "lg:flex-row" : "lg:flex-row-reverse",
        )}
      >
        <div className={cn("space-y-5 lg:basis-[40%]", isRtl ? "text-right" : "text-left")}>
          <p className="eyebrow">{dictionary.appTitle}</p>
          <h1 className="max-w-xl text-4xl font-semibold leading-tight text-[var(--color-ink-strong)]">
            {dictionary.auth.signInTitle}
          </h1>
          <p className="max-w-xl text-base text-[var(--color-ink-muted)]">
            {dictionary.auth.signInBody}
          </p>
        </div>
        <div
          className={cn(
            "panel flex flex-col justify-between gap-6 bg-[var(--color-surface-strong)] p-6 lg:basis-[60%]",
            isRtl ? "text-right" : "text-left",
          )}
        >
          <div className="flex size-14 items-center justify-center rounded-full bg-[var(--color-sand-100)] text-[var(--color-accent)]">
            <ShieldEllipsis className="size-7" />
          </div>
          <div>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">
              {dictionary.auth.accessTitle}
            </h2>
            <p className="mt-2 text-sm text-[var(--color-ink-muted)]">
              {dictionary.auth.accessBody}
            </p>
          </div>
          <AdminSignInForm locale={locale} dictionary={dictionary} />
        </div>
      </section>
    </main>
  );
}
