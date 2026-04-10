import { getMessages } from "next-intl/server";
import { AdminQueuePage } from "@/components/queues/admin-queue-page";
import { resolveAppLocale } from "@/lib/i18n/config";
import { getEnumLabel } from "@/lib/i18n/admin-ui";
import { asAdminMessages } from "@/lib/i18n/messages";
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
  const locale = resolveAppLocale(lang);
  const query = filters.q?.trim();
  const status = filters.status?.trim();
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const items = await fetchSupportQueue({ query, status });
  const pathname = `/${lang}/support`;

  return (
    <AdminQueuePage
      locale={locale}
      eyebrow={ui.pages.support.eyebrow}
      title={ui.pages.support.title}
      description={dictionary.dashboard.body}
        pathname={pathname}
      query={query}
      status={status}
      statusOptions={[
        { value: "open", label: getEnumLabel(locale, "supportStatus", "open") },
        { value: "in_progress", label: getEnumLabel(locale, "supportStatus", "in_progress") },
        { value: "waiting_for_user", label: getEnumLabel(locale, "supportStatus", "waiting_for_user") },
        { value: "resolved", label: getEnumLabel(locale, "supportStatus", "resolved") },
        { value: "closed", label: getEnumLabel(locale, "supportStatus", "closed") },
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
      <SupportQueueView items={items} locale={locale} />
    </AdminQueuePage>
  );
}
