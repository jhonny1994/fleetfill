import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
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
  const query = filters.q?.trim();
  const status = filters.status?.trim();
  const items = await fetchSupportQueue({ query, status });
  const pathname = `/${lang}/support`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Support</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Support inbox</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Triage user support requests with operational state, linked booking context, and correct New / Seen read-state language.
        </p>
      </section>
      <AdminFilterBar
        pathname={pathname}
        query={query}
        status={status}
        statusOptions={[
          { value: "open", label: "Open" },
          { value: "in_progress", label: "In progress" },
          { value: "waiting_for_user", label: "Waiting for user" },
          { value: "resolved", label: "Resolved" },
          { value: "closed", label: "Closed" },
        ]}
      />
      <SupportQueueView items={items} locale={lang} />
    </div>
  );
}
