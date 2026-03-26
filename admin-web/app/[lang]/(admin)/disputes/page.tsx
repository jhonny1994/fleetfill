import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminDetailCopy, getAdminUi } from "@/lib/i18n/admin-ui";
import { DisputesQueueView } from "@/components/queues/disputes-queue-view";
import { fetchDisputeQueue } from "@/lib/queries/admin-queues";

export default async function DisputesPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);
<<<<<<< HEAD
  const items = await fetchDisputeQueue({ query });
=======
  const statuses: DisputePageStatus[] = status
    ? [status]
    : view === "history"
      ? ["resolved"]
      : view === "all"
        ? ["open", "resolved"]
        : ["open"];
  const [items, openItems, historyItems, allItems] = await Promise.all([
    fetchDisputeQueue({ query, statuses }),
    fetchDisputeQueue({ query, statuses: ["open"] }),
    fetchDisputeQueue({ query, statuses: ["resolved"] }),
    fetchDisputeQueue({ query, statuses: ["open", "resolved"] }),
  ]);
>>>>>>> 7e581ab (Strengthen lifecycle workspaces and production integration)
  const pathname = `/${lang}/disputes`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.disputes.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.disputes.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {detailCopy.disputes.description}
        </p>
      </section>
<<<<<<< HEAD
=======
      <AdminQueueScopeTabs
        pathname={pathname}
        locale={lang}
        currentScope={view}
        query={query}
        status={status}
        counts={{
          open: openItems.length,
          history: historyItems.length,
          all: allItems.length,
        }}
      />
>>>>>>> 7e581ab (Strengthen lifecycle workspaces and production integration)
      <AdminFilterBar
        pathname={pathname}
        query={query}
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
      />
      <DisputesQueueView items={items} locale={lang} />
    </div>
  );
}
