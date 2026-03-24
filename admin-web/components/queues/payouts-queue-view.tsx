"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import type { EligiblePayoutQueueItem, ReleasedPayoutItem } from "@/lib/queries/admin-types";

function buildEligibleColumns(locale: string): ColumnDef<EligiblePayoutQueueItem>[] {
  return [
  {
    accessorKey: "trackingNumber",
    header: "Booking",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/payouts/${row.original.bookingId}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
          {row.original.trackingNumber}
        </Link>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.bookingId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "carrierName",
    header: "Carrier",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.carrierName}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.carrierId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "carrierPayoutDzd",
    header: "Ready amount",
    enableSorting: true,
    cell: ({ row }) => <p className="font-medium">{formatCurrencyDzd(row.original.carrierPayoutDzd)}</p>,
  },
  {
    accessorKey: "ageHours",
    header: "Ready since",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 48 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.updatedAt)}</p>
      </div>
    ),
  },
];
}

const releasedColumns: ColumnDef<ReleasedPayoutItem>[] = [
  {
    accessorKey: "bookingId",
    header: "Booking",
    enableSorting: true,
    cell: ({ row }) => <p className="font-medium">{formatCompactReference(row.original.bookingId)}</p>,
  },
  {
    accessorKey: "amountDzd",
    header: "Released amount",
    enableSorting: true,
    cell: ({ row }) => <p>{formatCurrencyDzd(row.original.amountDzd)}</p>,
  },
  {
    accessorKey: "status",
    header: "Status",
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={row.original.status} tone={row.original.status === "released" ? "success" : "neutral"} />,
  },
  {
    accessorKey: "processedAt",
    header: "Processed",
    enableSorting: true,
    cell: ({ row }) => <p>{formatDateTime(row.original.processedAt)}</p>,
  },
];

export function PayoutsQueueView({
  eligible,
  released,
  locale,
}: {
  eligible: EligiblePayoutQueueItem[];
  released: ReleasedPayoutItem[];
  locale: string;
}) {
  return (
    <div className="space-y-4">
      <section className="space-y-3">
        <div className="flex items-center justify-between gap-3">
          <div>
            <p className="eyebrow">Eligible payouts</p>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Bookings ready for carrier release</h2>
          </div>
          <StatusBadge label={`${eligible.length} ready`} tone={eligible.length > 0 ? "warning" : "success"} />
        </div>
        <AdminDataTable
          data={eligible}
          columns={buildEligibleColumns(locale)}
          emptyEyebrow="Payouts"
          emptyTitle="No payouts are ready right now."
          emptyBody="Completed, secured bookings without open disputes will appear here when they are eligible for release."
        />
      </section>
      <section className="space-y-3">
        <div className="flex items-center justify-between gap-3">
          <div>
            <p className="eyebrow">Recently processed</p>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Latest payout activity</h2>
          </div>
          <StatusBadge label={`${released.length} recent`} tone="neutral" />
        </div>
        <AdminDataTable
          data={released}
          columns={releasedColumns}
          emptyEyebrow="Recent payouts"
          emptyTitle="No payouts have been processed yet."
          emptyBody="Released payouts will accumulate here for operational visibility and audit trail entry points."
        />
      </section>
    </div>
  );
}
