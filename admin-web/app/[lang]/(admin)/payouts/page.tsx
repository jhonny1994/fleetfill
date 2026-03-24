import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { PayoutsQueueView } from "@/components/queues/payouts-queue-view";
import { fetchEligiblePayoutQueue, fetchRecentReleasedPayouts } from "@/lib/queries/admin-payouts";

export default async function PayoutsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const [eligible, released] = await Promise.all([
    fetchEligiblePayoutQueue(),
    fetchRecentReleasedPayouts(),
  ]);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Payouts</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Carrier payout operations</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Monitor bookings that are ready for release and keep the payout audit trail visible without leaving the admin desk.
        </p>
      </section>
      <AdminFilterBar pathname={`/${lang}/payouts`} />
      <PayoutsQueueView eligible={eligible} released={released} locale={lang} />
    </div>
  );
}
