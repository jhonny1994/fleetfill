import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminUi } from "@/lib/i18n/admin-ui";
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
  const ui = getAdminUi(lang);
<<<<<<< HEAD
  const items = await fetchVerificationQueue({ query });
=======
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
>>>>>>> 7e581ab (Strengthen lifecycle workspaces and production integration)
  const pathname = `/${lang}/verification`;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.verification.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.verification.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {dictionary.shell.body}
        </p>
      </section>
<<<<<<< HEAD
=======
      <AdminQueueScopeTabs
        pathname={pathname}
        locale={lang}
        currentScope={view}
        query={query}
        status={status}
        counts={{
          open: openItems.length,
          history: historyItems.length,
          all: allItems.length,
        }}
      />
>>>>>>> 7e581ab (Strengthen lifecycle workspaces and production integration)
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
