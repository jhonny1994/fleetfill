import { getMessages } from "next-intl/server";
import { AdminQueuePage } from "@/components/queues/admin-queue-page";
import { resolveAppLocale } from "@/lib/i18n/config";
import { getEnumLabel } from "@/lib/i18n/admin-ui";
import { asAdminMessages } from "@/lib/i18n/messages";
import { PaymentsQueueView } from "@/components/queues/payments-queue-view";
import { fetchPaymentQueue } from "@/lib/queries/admin-queues";

const paymentStatuses = ["pending", "verified", "rejected"] as const;
type PaymentPageStatus = (typeof paymentStatuses)[number];

export default async function PaymentsPage({
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
  const status = paymentStatuses.includes(rawStatus as PaymentPageStatus)
    ? (rawStatus as PaymentPageStatus)
    : undefined;
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const statuses: PaymentPageStatus[] = status
    ? [status]
    : view === "history"
      ? ["verified", "rejected"]
      : view === "all"
        ? ["pending", "verified", "rejected"]
        : ["pending"];
  const [items, openItems, historyItems, allItems] = await Promise.all([
    fetchPaymentQueue({ query, statuses }),
    fetchPaymentQueue({ query, statuses: ["pending"] }),
    fetchPaymentQueue({ query, statuses: ["verified", "rejected"] }),
    fetchPaymentQueue({ query, statuses: ["pending", "verified", "rejected"] }),
  ]);
  const pathname = `/${lang}/payments`;

  return (
    <AdminQueuePage
      locale={locale}
      eyebrow={ui.pages.payments.eyebrow}
      title={ui.pages.payments.title}
      description={dictionary.dashboard.body}
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
        { value: "pending", label: getEnumLabel(locale, "verification", "pending") },
        { value: "verified", label: getEnumLabel(locale, "verification", "verified") },
        { value: "rejected", label: getEnumLabel(locale, "verification", "rejected") },
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
      <PaymentsQueueView items={items} locale={locale} />
    </AdminQueuePage>
  );
}
