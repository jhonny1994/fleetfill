import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { VerificationQueueView } from "@/components/queues/verification-queue-view";
import { fetchVerificationQueue } from "@/lib/queries/admin-queues";

export default async function VerificationPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const items = await fetchVerificationQueue({ query });
  const pathname = `/${lang}/verification`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Verification</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Carrier packet review</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          See the unified driver and vehicle verification packet, including missing documents and per-vehicle blocking context.
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
      <VerificationQueueView items={items} locale={lang} />
    </div>
  );
}
