import Link from "next/link";

import { getDictionary } from "@/lib/i18n/dictionaries";
import { fetchGlobalSearchGroups } from "@/lib/queries/admin-search";
import { getAdminSession } from "@/lib/auth/get-admin-session";

export default async function SearchPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string }>;
}) {
  const [{ lang }, filters, session] = await Promise.all([params, searchParams, getAdminSession()]);
  const query = filters.q?.trim();
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const groups = await fetchGlobalSearchGroups({
    locale: lang,
    query,
    includeAdmins: session?.adminRole === "super_admin",
  });
  const groupLabels = dictionary.search.groups;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{dictionary.search.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{dictionary.search.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {dictionary.search.body}
        </p>
      </section>

      <section className="panel p-4">
        <form className="flex flex-col gap-3 lg:flex-row" action={`/${lang}/search`} method="get">
          <input
            type="search"
            name="q"
            defaultValue={query}
            placeholder={dictionary.search.placeholder}
            className="min-w-0 flex-1 rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
          />
          <div className="flex items-center gap-2">
            <button className="button-primary" type="submit">
              {dictionary.search.submit}
            </button>
            <Link className="button-secondary" href={`/${lang}/search`}>
              {dictionary.search.reset}
            </Link>
          </div>
        </form>
      </section>

      {!query ? (
        <section className="panel p-6 text-sm text-[var(--color-ink-muted)]">
          {dictionary.search.emptyQuery}
        </section>
      ) : groups.length === 0 ? (
        <section className="panel p-6 text-sm text-[var(--color-ink-muted)]">
          {dictionary.search.noResultsPrefix} <span className="font-semibold text-[var(--color-ink-strong)]">{query}</span>.
        </section>
      ) : (
        <div className="space-y-4">
          {groups.map((group) => (
            <section key={group.kind} className="panel space-y-4 p-6">
              <div className="space-y-2">
                <p className="eyebrow">{groupLabels[group.kind]}</p>
                <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{groupLabels[group.kind]}</h2>
              </div>
              <div className="grid gap-3">
                {group.items.map((item) => (
                  <Link
                    key={`${group.kind}-${item.id}`}
                    href={item.href}
                    className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:bg-white/75"
                  >
                    <div className="flex flex-wrap items-start justify-between gap-3">
                      <div className="space-y-1">
                        <p className="font-semibold text-[var(--color-ink-strong)]">{item.title}</p>
                        <p className="text-sm text-[var(--color-ink-muted)]">{item.subtitle}</p>
                      </div>
                      <span className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-accent)]">{item.meta}</span>
                    </div>
                  </Link>
                ))}
              </div>
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
