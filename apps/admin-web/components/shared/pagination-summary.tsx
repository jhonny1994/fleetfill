import Link from "next/link";

import { buildPageHref, totalPages } from "@/lib/pagination";

export function PaginationSummary({
  pathname,
  searchParams,
  page,
  pageSize,
  total,
  previousLabel,
  nextLabel,
  pageLabel,
  totalLabel,
}: {
  pathname: string;
  searchParams: URLSearchParams;
  page: number;
  pageSize: number;
  total: number;
  previousLabel: string;
  nextLabel: string;
  pageLabel: string;
  totalLabel: string;
}) {
  const pages = totalPages(total, pageSize);

  return (
    <div className="flex items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
      <p className="text-sm text-[var(--color-ink-muted)]">
        {pageLabel} {page} / {pages} • {total} {totalLabel}
      </p>
      <div className="flex gap-2">
        {page > 1 ? (
          <Link className="button-secondary" href={buildPageHref(pathname, searchParams, page - 1)}>
            {previousLabel}
          </Link>
        ) : null}
        {page < pages ? (
          <Link className="button-secondary" href={buildPageHref(pathname, searchParams, page + 1)}>
            {nextLabel}
          </Link>
        ) : null}
      </div>
    </div>
  );
}
