import { getMessages } from "next-intl/server";
import { AdminQueuePage } from "@/components/queues/admin-queue-page";
import { resolveAppLocale } from "@/lib/i18n/config";
import { getAdminDetailCopy, getEnumLabel } from "@/lib/i18n/admin-ui";
import { asAdminMessages } from "@/lib/i18n/messages";
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
  const locale = resolveAppLocale(lang);
  const query = filters.q?.trim();
  const view = filters.view ?? "open";
  const rawStatus = filters.status?.trim();
  const status = disputeStatuses.includes(rawStatus as DisputePageStatus)
    ? (rawStatus as DisputePageStatus)
    : undefined;
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);
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
    <AdminQueuePage
      locale={locale}
      eyebrow={ui.pages.disputes.eyebrow}
      title={ui.pages.disputes.title}
      description={detailCopy.disputes.description}
        pathname={pathname}
      query={query}
      status={status}
      view={view}
      counts={{
        open: openItems.length,
        history: historyItems.length,
        all: allItems.length,
      }}
      statusOptions={[
        { value: "open", label: getEnumLabel(locale, "dispute", "open") },
        { value: "resolved", label: getEnumLabel(locale, "dispute", "resolved") },
      ]}
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
    >
      <DisputesQueueView items={items} locale={locale} />
    </AdminQueuePage>
  );
}
