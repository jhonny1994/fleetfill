import { AdminQueueScopeTabs } from "@/components/queues/admin-queue-scope-tabs";
import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { getDictionary } from "@/lib/i18n/dictionaries";
import { getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { VerificationQueueView } from "@/components/queues/verification-queue-view";
import { fetchVerificationQueue } from "@/lib/queries/admin-queues";

const verificationStatuses = ["pending", "rejected", "verified"] as const;
type VerificationPageStatus = (typeof verificationStatuses)[number];

export default async function VerificationPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; status?: string; view?: "open" | "history" | "all" }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const view = filters.view ?? "open";
  const rawStatus = filters.status?.trim();
  const status = verificationStatuses.includes(rawStatus as VerificationPageStatus)
    ? (rawStatus as VerificationPageStatus)
    : undefined;
  const dictionary = await getDictionary(lang as "ar" | "fr" | "en");
  const ui = getAdminUi(lang);
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
      <AdminFilterBar
        pathname={pathname}
        query={query}
        status={status}
        hiddenFields={[{ name: "view", value: view }]}
        statusOptions={[
          { value: "pending", label: getEnumLabel(lang, "verification", "pending") },
          { value: "rejected", label: getEnumLabel(lang, "verification", "rejected") },
          { value: "verified", label: getEnumLabel(lang, "verification", "verified") },
        ]}
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
