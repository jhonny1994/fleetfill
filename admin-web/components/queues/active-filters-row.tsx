import Link from "next/link";

import { StatusBadge } from "@/components/shared/status-badge";

export function ActiveFiltersRow({
  pathname,
  filters,
  clearAllLabel = "Clear all",
}: {
  pathname: string;
  filters: Array<{ key: string; label: string; value: string | null | undefined }>;
  clearAllLabel?: string;
}) {
  const active = filters.filter((filter) => filter.value && filter.value.trim().length > 0);
  if (active.length === 0) {
    return null;
  }

  return (
    <div className="flex flex-wrap items-center gap-2">
      {active.map((filter) => (
        <StatusBadge key={filter.key} label={`${filter.label}: ${filter.value}`} tone="neutral" />
      ))}
      <Link className="text-sm font-medium text-[var(--color-accent-ink)] underline-offset-4 hover:underline" href={pathname}>
        {clearAllLabel}
      </Link>
    </div>
  );
}
