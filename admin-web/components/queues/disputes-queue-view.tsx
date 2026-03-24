"use client";

import type { ColumnDef } from "@tanstack/react-table";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import type { DisputeQueueItem } from "@/lib/queries/admin-types";

const columns: ColumnDef<DisputeQueueItem>[] = [
  {
    accessorKey: "trackingNumber",
    header: "Booking",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p className="font-semibold text-[var(--color-ink-strong)]">{row.original.trackingNumber ?? "Unknown booking"}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.bookingId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "reason",
    header: "Reason",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.reason}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">{row.original.evidenceCount} evidence items</p>
      </div>
    ),
  },
  {
    accessorKey: "status",
    header: "State",
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={row.original.status} tone="warning" />,
  },
  {
    accessorKey: "ageHours",
    header: "Age",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 48 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.createdAt)}</p>
      </div>
    ),
  },
];

export function DisputesQueueView({ items }: { items: DisputeQueueItem[] }) {
  return (
    <AdminDataTable
      data={items}
      columns={columns}
      emptyEyebrow="Disputes"
      emptyTitle="No open disputes require attention."
      emptyBody="Resolved and closed disputes leave this queue automatically."
    />
  );
}
