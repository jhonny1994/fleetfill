import { ShieldEllipsis } from "lucide-react";

import { getDictionary } from "@/lib/i18n/dictionaries";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

export default async function AdminSignInPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  const dictionary = await getDictionary(locale);

  return (
    <main className="flex min-h-[calc(100vh-2rem)] items-center justify-center">
      <section className="panel grid max-w-5xl gap-8 overflow-hidden p-6 lg:grid-cols-[1.2fr_0.8fr] lg:p-8">
        <div className="space-y-5">
          <p className="eyebrow">{dictionary.appTitle}</p>
          <h1 className="max-w-xl text-4xl font-semibold leading-tight text-[var(--color-ink-strong)]">
            {dictionary.signInTitle}
          </h1>
          <p className="max-w-xl text-base text-[var(--color-ink-muted)]">
            {dictionary.signInBody}
          </p>
          <div className="rounded-[28px] border border-[var(--color-border)] bg-white/70 p-5">
            <p className="text-sm font-medium text-[var(--color-ink-strong)]">
              Sign-in wiring is the next slice.
            </p>
            <p className="mt-2 text-sm text-[var(--color-ink-muted)]">
              This route is already in the correct localized auth group and will be connected to
              Supabase SSR session handling in the next task block.
            </p>
          </div>
        </div>
        <div className="panel flex flex-col justify-between gap-6 bg-[var(--color-surface-strong)] p-6">
          <div className="flex size-14 items-center justify-center rounded-full bg-[var(--color-sand-100)] text-[var(--color-accent)]">
            <ShieldEllipsis className="size-7" />
          </div>
          <div>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">
              Internal access only
            </h2>
            <p className="mt-2 text-sm text-[var(--color-ink-muted)]">
              Admin bootstrap, invitations, and role governance now exist in the backend. The web
              console is ready for the auth shell to attach to them.
            </p>
          </div>
          <button className="button-primary" type="button">
            Continue with admin sign in
          </button>
        </div>
      </section>
    </main>
  );
}
