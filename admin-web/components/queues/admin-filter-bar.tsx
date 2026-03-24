import Link from "next/link";

import { ActiveFiltersRow } from "@/components/queues/active-filters-row";
import { RefreshButton } from "@/components/queues/refresh-button";
import { CommandSearch } from "@/components/shared/command-search";

export type FilterOption = {
  value: string;
  label: string;
};

export function AdminFilterBar({
  pathname,
  query,
  status,
  statusOptions = [],
}: {
  pathname: string;
  query?: string;
  status?: string;
  statusOptions?: FilterOption[];
}) {
  return (
    <div className="space-y-3">
      <section className="panel flex flex-col gap-4 p-4 lg:flex-row lg:items-center">
        <form className="flex min-w-0 flex-1 flex-col gap-3 lg:flex-row lg:items-center" action={pathname} method="get">
          <div className="min-w-0 flex-1">
            <CommandSearch defaultValue={query} inputName="q" />
          </div>
          {statusOptions.length > 0 ? (
            <label className="flex flex-col gap-1 text-sm font-medium text-[var(--color-ink-base)]">
              <span>Status</span>
              <select
                name="status"
                defaultValue={status ?? ""}
                className="h-11 rounded-full border border-[var(--color-border)] bg-white/75 px-4 text-sm outline-none"
              >
                <option value="">All statuses</option>
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
              Apply
            </button>
            <Link className="button-secondary" href={pathname}>
              Reset
            </Link>
          </div>
        </form>
        <RefreshButton />
      </section>
      <ActiveFiltersRow
        pathname={pathname}
        filters={[
          { key: "query", label: "Query", value: query },
          { key: "status", label: "Status", value: status },
        ]}
      />
    </div>
  );
}
