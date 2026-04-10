import type { ReactNode } from "react";

import { AdminFilterBar } from "@/components/queues/admin-filter-bar";
import { AdminQueueScopeTabs } from "@/components/queues/admin-queue-scope-tabs";
import type { AppLocale } from "@/lib/i18n/config";

type QueueScope = "open" | "history" | "all";

type FilterOption = {
  value: string;
  label: string;
};

type FilterLabels = {
  searchPlaceholder: string;
  status: string;
  allStatuses: string;
  apply: string;
  reset: string;
  query: string;
  clearAll: string;
  refresh: string;
  refreshAriaLabel: string;
};

export function AdminQueuePage({
  locale,
  eyebrow,
  title,
  description,
  pathname,
  query,
  status,
  view,
  counts,
  statusOptions,
  children,
  labels,
}: {
  locale: AppLocale;
  eyebrow: string;
  title: string;
  description: string;
  pathname: string;
  query?: string;
  status?: string;
  view?: QueueScope;
  counts?: Partial<Record<QueueScope, number>>;
  statusOptions?: FilterOption[];
  children: ReactNode;
  labels: FilterLabels;
}) {
  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{description}</p>
      </section>
      {view ? (
        <AdminQueueScopeTabs
          pathname={pathname}
          currentScope={view}
          query={query}
          status={status}
          counts={counts}
        />
      ) : null}
      <AdminFilterBar
        pathname={pathname}
        query={query}
        status={status}
        hiddenFields={view ? [{ name: "view", value: view }] : undefined}
        statusOptions={statusOptions}
        locale={locale}
        labels={labels}
      />
      {children}
    </div>
  );
}
