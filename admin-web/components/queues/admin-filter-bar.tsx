import Link from "next/link";

import { ActiveFiltersRow } from "@/components/queues/active-filters-row";
import { RefreshButton } from "@/components/queues/refresh-button";
import { CommandSearch } from "@/components/shared/command-search";
import type { AppLocale } from "@/lib/i18n/config";

export type FilterOption = {
  value: string;
  label: string;
};

export function AdminFilterBar({
  pathname,
  query,
  status,
  statusOptions = [],
  locale,
  labels,
}: {
  pathname: string;
  query?: string;
  status?: string;
  statusOptions?: FilterOption[];
  locale: AppLocale;
  labels: {
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
}) {
  return (
    <div className="space-y-3">
      <section className="panel flex flex-col gap-4 p-4 lg:flex-row lg:items-center">
        <form className="flex min-w-0 flex-1 flex-col gap-3 lg:flex-row lg:items-center" action={pathname} method="get">
          <div className="min-w-0 flex-1">
            <CommandSearch
              defaultValue={query}
              inputName="q"
              locale={locale}
              placeholder={labels.searchPlaceholder}
            />
          </div>
          {statusOptions.length > 0 ? (
            <label className="flex flex-col gap-1 text-sm font-medium text-[var(--color-ink-base)]">
              <span>{labels.status}</span>
              <select
                name="status"
                defaultValue={status ?? ""}
                className="h-11 rounded-full border border-[var(--color-border)] bg-white/75 px-4 text-sm outline-none"
              >
                <option value="">{labels.allStatuses}</option>
                {statusOptions.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </label>
          ) : null}
          <div className="flex items-center gap-2 lg:ml-auto">
            <button className="button-primary" type="submit">
              {labels.apply}
            </button>
            <Link className="button-secondary" href={pathname}>
              {labels.reset}
            </Link>
          </div>
        </form>
        <RefreshButton label={labels.refresh} ariaLabel={labels.refreshAriaLabel} />
      </section>
      <ActiveFiltersRow
        pathname={pathname}
        clearAllLabel={labels.clearAll}
        filters={[
          { key: "query", label: labels.query, value: query },
          { key: "status", label: labels.status, value: status },
        ]}
      />
    </div>
  );
}
