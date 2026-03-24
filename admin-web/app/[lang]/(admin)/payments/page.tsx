import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
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
  const items = await fetchPaymentQueue({ query });
  const pathname = `/${lang}/payments`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Payments</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Payment-proof review queue</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Review incoming proof uploads, compare them against expected totals, and keep the trust-first
          payment workflow moving.
        </p>
      </section>
      <AdminFilterBar pathname={pathname} query={query} />
      <PaymentsQueueView items={items} />
    </div>
  );
}
