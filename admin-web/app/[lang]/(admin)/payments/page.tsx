import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminUi } from "@/lib/i18n/admin-ui";
import { PaymentsQueueView } from "@/components/queues/payments-queue-view";
import { fetchPaymentQueue } from "@/lib/queries/admin-queues";

export default async function PaymentsPage({
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
  const items = await fetchPaymentQueue({ query });
  const pathname = `/${lang}/payments`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.payments.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.payments.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {dictionary.dashboard.body}
        </p>
      </section>
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
      <PaymentsQueueView items={items} locale={lang} />
    </div>
  );
}
