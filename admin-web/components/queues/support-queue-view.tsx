"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import type { SupportQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string): ColumnDef<SupportQueueItem>[] {
  return [
  {
    accessorKey: "subject",
    header: "Subject",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/support/${row.original.id}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
          {row.original.subject}
        </Link>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.id)}</p>
      </div>
    ),
  },
  {
    accessorKey: "status",
    header: "Workflow",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="flex flex-wrap items-center gap-2">
        <StatusBadge label={row.original.status} tone="neutral" />
        <StatusBadge label={row.original.priority} tone={row.original.priority === "urgent" ? "danger" : row.original.priority === "high" ? "warning" : "neutral"} />
      </div>
    ),
  },
  {
    accessorKey: "hasUnreadForAdmin",
    header: "Read state",
    enableSorting: true,
    cell: ({ row }) => (
      <StatusBadge label={row.original.hasUnreadForAdmin ? "New" : "Seen"} tone={row.original.hasUnreadForAdmin ? "warning" : "success"} />
    ),
  },
  {
    accessorKey: "lastMessageAt",
    header: "Latest message",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{formatDateTime(row.original.lastMessageAt)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.bookingId
            ? `Booking ${formatCompactReference(row.original.bookingId)}`
            : row.original.disputeId
              ? `Dispute ${formatCompactReference(row.original.disputeId)}`
              : row.original.paymentProofId
                ? `Payment ${formatCompactReference(row.original.paymentProofId)}`
                : "No linked entity"}
        </p>
      </div>
    ),
  },
];
}

export function SupportQueueView({ items, locale }: { items: SupportQueueItem[]; locale: string }) {
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale)}
      emptyEyebrow="Support"
      emptyTitle="No support threads need triage."
      emptyBody="Open tickets with user follow-ups or active work will show up here."
    />
  );
}
