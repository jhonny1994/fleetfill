import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
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
      <AdminFilterBar pathname={pathname} query={query} />
      <VerificationQueueView items={items} locale={lang} />
    </div>
  );
}
