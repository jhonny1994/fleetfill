import { getMessages } from "next-intl/server";
import Link from "next/link";

import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchGlobalSearchPage } from "@/lib/queries/admin-search";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import type { GlobalSearchKindFilter } from "@/lib/queries/admin-types";

function normalizeKind(value: string | undefined, includeAdmins: boolean): GlobalSearchKindFilter {
  const allowedKinds: GlobalSearchKindFilter[] = includeAdmins
    ? ["all", "booking", "shipment", "user", "payment", "verification", "dispute", "payout", "support", "admin"]
    : ["all", "booking", "shipment", "user", "payment", "verification", "dispute", "payout", "support"];

  return allowedKinds.includes((value ?? "all") as GlobalSearchKindFilter)
    ? ((value ?? "all") as GlobalSearchKindFilter)
    : "all";
}

function buildSearchHref(lang: string, query: string, kind: GlobalSearchKindFilter, page = 1) {
  const params = new URLSearchParams();
  if (query) params.set("q", query);
  if (kind !== "all") params.set("kind", kind);
  if (page > 1) params.set("page", String(page));
  const suffix = params.toString();
  return `/${lang}/search${suffix ? `?${suffix}` : ""}`;
}

export default async function SearchPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; kind?: string; page?: string }>;
}) {
  const [{ lang }, filters, session] = await Promise.all([params, searchParams, getAdminSession()]);
  const locale = resolveAppLocale(lang);
  const query = filters.q?.trim() ?? "";
  const includeAdmins = session?.adminRole === "super_admin";
  const kind = normalizeKind(filters.kind, includeAdmins);
  const currentPage = Math.max(1, Number(filters.page ?? "1") || 1);
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const snapshot = await fetchGlobalSearchPage({
    locale,
    query,
    includeAdmins,
    kind,
    page: currentPage,
    pageSize: 10,
  });
  const groupLabels = dictionary.search.groups;
  const totalPages = Math.max(1, Math.ceil(snapshot.totalResults / snapshot.pageSize));
  const resultKinds = snapshot.groups.filter((group) => includeAdmins || group.kind !== "admin");

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{dictionary.search.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{dictionary.search.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{dictionary.search.body}</p>
      </section>

      <section className="panel space-y-4 p-5">
        <form className="grid gap-3 lg:grid-cols-[minmax(0,1fr)_220px_auto] lg:items-end" action={`/${locale}/search`} method="get">
          <div className="space-y-2">
            <label className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-ink-muted)]" htmlFor="search-query">
              {dictionary.search.queryLabel}
            </label>
            <input
              id="search-query"
              type="search"
              name="q"
              defaultValue={query}
              placeholder={dictionary.search.placeholder}
              className="min-w-0 w-full rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
            />
          </div>
          <div className="space-y-2">
            <label className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-ink-muted)]" htmlFor="search-kind">
              {dictionary.search.kindLabel}
            </label>
            <select
              id="search-kind"
              name="kind"
              defaultValue={kind}
              className="w-full rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
            >
              <option value="all">{dictionary.search.allKinds}</option>
              <option value="booking">{groupLabels.booking}</option>
              <option value="shipment">{groupLabels.shipment}</option>
              <option value="user">{groupLabels.user}</option>
              <option value="payment">{groupLabels.payment}</option>
              <option value="verification">{groupLabels.verification}</option>
              <option value="dispute">{groupLabels.dispute}</option>
              <option value="payout">{groupLabels.payout}</option>
              <option value="support">{groupLabels.support}</option>
              {includeAdmins ? <option value="admin">{groupLabels.admin}</option> : null}
            </select>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <button className="button-primary" type="submit">
              {dictionary.search.submit}
            </button>
            <Link className="button-secondary" href={`/${locale}/search`}>
              {dictionary.search.reset}
            </Link>
          </div>
        </form>
      </section>

      {query ? (
        <section className="panel space-y-4 p-5">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="space-y-1">
              <p className="eyebrow">{dictionary.search.summaryEyebrow}</p>
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{dictionary.search.summaryTitle}</h2>
            </div>
            <p className="text-sm text-[var(--color-ink-muted)]">
              {snapshot.totalResults} {dictionary.search.resultCountLabel}
            </p>
          </div>
          <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-3">
            {resultKinds.map((group) => (
              <Link
                key={group.kind}
                href={buildSearchHref(locale, query, group.kind)}
                className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:bg-white/75"
              >
                <div className="flex items-start justify-between gap-3">
                  <div className="space-y-1">
                    <p className="text-sm font-medium text-[var(--color-ink-muted)]">{groupLabels[group.kind]}</p>
                    <p className="text-2xl font-semibold text-[var(--color-ink-strong)]">{group.total}</p>
                  </div>
                  <span className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-accent)]">
                    {dictionary.search.viewAll}
                  </span>
                </div>
              </Link>
            ))}
          </div>
        </section>
      ) : null}

      {!query ? (
        <section className="panel p-6 text-sm text-[var(--color-ink-muted)]">{dictionary.search.emptyQuery}</section>
      ) : snapshot.kind === "all" && snapshot.groups.length > 0 ? (
        <div className="space-y-4">
          {snapshot.groups.map((group) => (
            <section key={group.kind} className="panel space-y-4 p-6">
              <div className="flex flex-wrap items-center justify-between gap-3">
                <div className="space-y-2">
                  <p className="eyebrow">{groupLabels[group.kind]}</p>
                  <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
                    {groupLabels[group.kind]} <span className="text-sm font-medium text-[var(--color-ink-muted)]">({group.total})</span>
                  </h2>
                </div>
                <Link className="button-secondary" href={buildSearchHref(locale, query, group.kind)}>
                  {dictionary.search.viewAll}
                </Link>
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
      ) : snapshot.selectedGroup ? (
        <section className="panel space-y-4 p-6">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="space-y-2">
              <p className="eyebrow">{groupLabels[snapshot.selectedGroup.kind]}</p>
              <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
                {groupLabels[snapshot.selectedGroup.kind]} <span className="text-sm font-medium text-[var(--color-ink-muted)]">({snapshot.selectedGroup.total})</span>
              </h2>
              <p className="text-sm text-[var(--color-ink-muted)]">
                {dictionary.search.pageSummaryPrefix} {snapshot.page} / {totalPages}
              </p>
            </div>
            <Link className="button-secondary" href={buildSearchHref(locale, query, "all")}>
              {dictionary.search.backToAll}
            </Link>
          </div>

          <div className="grid gap-3">
            {snapshot.selectedGroup.items.map((item) => (
              <Link
                key={`${snapshot.selectedGroup?.kind}-${item.id}`}
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

          <div className="flex flex-wrap items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
            <p className="text-sm text-[var(--color-ink-muted)]">
              {dictionary.search.pageSummaryPrefix} {snapshot.page} / {totalPages}
            </p>
            <div className="flex gap-2">
              {snapshot.page > 1 ? (
                <Link className="button-secondary" href={buildSearchHref(locale, query, snapshot.kind, snapshot.page - 1)}>
                  {ui.pages.audit.previous}
                </Link>
              ) : null}
              {snapshot.page < totalPages ? (
                <Link className="button-secondary" href={buildSearchHref(locale, query, snapshot.kind, snapshot.page + 1)}>
                  {ui.pages.audit.next}
                </Link>
              ) : null}
            </div>
          </div>
        </section>
      ) : (
        <section className="panel p-6 text-sm text-[var(--color-ink-muted)]">
          {dictionary.search.noResultsPrefix} <span className="font-semibold text-[var(--color-ink-strong)]">{query}</span>.
        </section>
      )}
    </div>
  );
}
