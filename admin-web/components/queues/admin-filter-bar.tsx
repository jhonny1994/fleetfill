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
  hiddenFields = [],
  locale,
  labels,
}: {
  pathname: string;
  query?: string;
  status?: string;
  statusOptions?: FilterOption[];
  hiddenFields?: Array<{ name: string; value: string }>;
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
      <section className="panel toolbar-surface">
        <form className="toolbar-row" action={pathname} method="get">
          {hiddenFields.map((field) => (
            <input key={`${field.name}-${field.value}`} type="hidden" name={field.name} value={field.value} />
          ))}
          <div className="toolbar-controls">
            <div className="min-w-0 flex-[1.6]">
              <CommandSearch
                defaultValue={query}
                inputName="q"
                locale={locale}
                placeholder={labels.searchPlaceholder}
              />
            </div>
            {statusOptions.length > 0 ? (
              <label className="min-w-[180px] max-w-[220px]">
                <span className="sr-only">{labels.status}</span>
                <select
                  aria-label={labels.status}
                  name="status"
                  defaultValue={status ?? ""}
                  className="admin-field admin-select"
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
          </div>
          <div className="toolbar-actions">
            <button className="button-primary" type="submit">
              {labels.apply}
            </button>
            <div className="toolbar-utility">
              <Link className="button-secondary" href={pathname}>
                {labels.reset}
              </Link>
              <RefreshButton label={labels.refresh} ariaLabel={labels.refreshAriaLabel} />
            </div>
          </div>
        </form>
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
