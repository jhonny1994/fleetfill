import { AdminQueueScopeTabs } from "@/components/queues/admin-queue-scope-tabs";
import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminDetailCopy, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { DisputesQueueView } from "@/components/queues/disputes-queue-view";
import { fetchDisputeQueue } from "@/lib/queries/admin-queues";

const disputeStatuses = ["open", "resolved"] as const;
type DisputePageStatus = (typeof disputeStatuses)[number];

export default async function DisputesPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; status?: string; view?: "open" | "history" | "all" }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const view = filters.view ?? "open";
  const rawStatus = filters.status?.trim();
  const status = disputeStatuses.includes(rawStatus as DisputePageStatus)
    ? (rawStatus as DisputePageStatus)
    : undefined;
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);
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
      <AdminFilterBar
        pathname={pathname}
        query={query}
        status={status}
        hiddenFields={[{ name: "view", value: view }]}
        statusOptions={[
          { value: "open", label: getEnumLabel(lang, "dispute", "open") },
          { value: "resolved", label: getEnumLabel(lang, "dispute", "resolved") },
        ]}
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
