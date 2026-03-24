import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { SupportQueueView } from "@/components/queues/support-queue-view";
import { fetchSupportQueue } from "@/lib/queries/admin-queues";

export default async function SupportPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; status?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const status = filters.status?.trim();
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const ui = getAdminUi(lang);
  const items = await fetchSupportQueue({ query, status });
  const pathname = `/${lang}/support`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.support.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.support.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {dictionary.dashboard.body}
        </p>
      </section>
      <AdminFilterBar
        pathname={pathname}
        query={query}
        status={status}
        locale={lang as "ar" | "fr" | "en"}
        labels={{
          searchPlaceholder: dictionary.shell.searchPlaceholder,
          status: dictionary.common.status,
          allStatuses: dictionary.common.allStatuses,
          apply: dictionary.common.apply,
          reset: dictionary.common.reset,
          query: dictionary.common.query,
          clearAll: dictionary.common.clearAll,
          refresh: dictionary.common.refresh,
          refreshAriaLabel: dictionary.common.refreshQueue,
        }}
        statusOptions={[
          { value: "open", label: getEnumLabel(lang, "supportStatus", "open") },
          { value: "in_progress", label: getEnumLabel(lang, "supportStatus", "in_progress") },
          { value: "waiting_for_user", label: getEnumLabel(lang, "supportStatus", "waiting_for_user") },
          { value: "resolved", label: getEnumLabel(lang, "supportStatus", "resolved") },
          { value: "closed", label: getEnumLabel(lang, "supportStatus", "closed") },
        ]}
      />
      <SupportQueueView items={items} locale={lang} />
    </div>
  );
}
