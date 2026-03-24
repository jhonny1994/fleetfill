import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
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
  const items = await fetchDisputeQueue({ query });
  const pathname = `/${lang}/disputes`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Disputes</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Open dispute queue</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Resolve active booking disputes with clear age visibility, evidence counts, and linked booking context.
        </p>
      </section>
      <AdminFilterBar pathname={pathname} query={query} />
      <DisputesQueueView items={items} />
    </div>
  );
}
