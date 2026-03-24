import { ShieldEllipsis } from "lucide-react";

import { AdminSignInForm } from "@/components/auth/admin-sign-in-form";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { redirect } from "next/navigation";

export default async function AdminSignInPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  const session = await getAdminSession();

  if (session) {
    redirect(`/${locale}/dashboard`);
  }

  const dictionary = await getDictionary(locale);

  return (
    <main className="flex min-h-[calc(100vh-2rem)] items-center justify-center">
      <section className="panel grid max-w-5xl gap-8 overflow-hidden p-6 lg:grid-cols-[1.2fr_0.8fr] lg:p-8">
        <div className="space-y-5">
          <p className="eyebrow">{dictionary.appTitle}</p>
          <h1 className="max-w-xl text-4xl font-semibold leading-tight text-[var(--color-ink-strong)]">
            {dictionary.auth.signInTitle}
          </h1>
          <p className="max-w-xl text-base text-[var(--color-ink-muted)]">
            {dictionary.auth.signInBody}
          </p>
        </div>
        <div className="panel flex flex-col justify-between gap-6 bg-[var(--color-surface-strong)] p-6">
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
