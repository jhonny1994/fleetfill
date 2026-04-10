import { getMessages } from "next-intl/server";
import { AdminQueuePage } from "@/components/queues/admin-queue-page";
import { resolveAppLocale } from "@/lib/i18n/config";
import { getEnumLabel } from "@/lib/i18n/admin-ui";
import { asAdminMessages } from "@/lib/i18n/messages";
import { VerificationQueueView } from "@/components/queues/verification-queue-view";
import { fetchVerificationQueue } from "@/lib/queries/admin-queues";

const verificationStatuses = ["pending", "rejected", "verified"] as const;
type VerificationPageStatus = (typeof verificationStatuses)[number];

export default async function VerificationPage({
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
  const status = verificationStatuses.includes(rawStatus as VerificationPageStatus)
    ? (rawStatus as VerificationPageStatus)
    : undefined;
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const statuses: VerificationPageStatus[] = status
    ? [status]
    : view === "history"
      ? ["verified"]
      : view === "all"
        ? ["pending", "rejected", "verified"]
        : ["pending", "rejected"];
  const [items, openItems, historyItems, allItems] = await Promise.all([
    fetchVerificationQueue({ query, statuses }),
    fetchVerificationQueue({ query, statuses: ["pending", "rejected"] }),
    fetchVerificationQueue({ query, statuses: ["verified"] }),
    fetchVerificationQueue({ query, statuses: ["pending", "rejected", "verified"] }),
  ]);
  const pathname = `/${lang}/verification`;

  return (
    <AdminQueuePage
      locale={locale}
      eyebrow={ui.pages.verification.eyebrow}
      title={ui.pages.verification.title}
      description={dictionary.shell.body}
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
        { value: "rejected", label: getEnumLabel(locale, "verification", "rejected") },
        { value: "verified", label: getEnumLabel(locale, "verification", "verified") },
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
      <VerificationQueueView items={items} locale={locale} />
    </AdminQueuePage>
  );
}
