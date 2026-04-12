import { getMessages } from "next-intl/server";
import { AdminQueuePage } from "@/components/queues/admin-queue-page";
import { resolveAppLocale } from "@/lib/i18n/config";
import { getAdminDetailCopy } from "@/lib/i18n/admin-ui";
import { asAdminMessages } from "@/lib/i18n/messages";
import { PayoutsQueueView } from "@/components/queues/payouts-queue-view";
import { fetchEligiblePayoutQueue, fetchRecentReleasedPayouts } from "@/lib/queries/admin-payouts";

export default async function PayoutsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = resolveAppLocale(lang);
  const { dictionary, ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);
  const [eligible, released] = await Promise.all([
    fetchEligiblePayoutQueue(),
    fetchRecentReleasedPayouts(),
  ]);

  return (
    <AdminQueuePage
      locale={locale}
      eyebrow={ui.pages.payouts.eyebrow}
      title={ui.pages.payouts.title}
      description={detailCopy.payouts.description}
        pathname={`/${lang}/payouts`}
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
      <PayoutsQueueView eligible={eligible} released={released} locale={locale} />
    </AdminQueuePage>
  );
}
