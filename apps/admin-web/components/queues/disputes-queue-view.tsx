"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import type { AdminUi } from "@/lib/i18n/admin-ui";
import { getEnumLabel } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import type { DisputeQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string, ui: AdminUi): ColumnDef<DisputeQueueItem>[] {
  return [
  {
    accessorKey: "trackingNumber",
    header: ui.labels.booking,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/bookings/${row.original.bookingId}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
          {row.original.trackingNumber ?? ui.labels.unknown}
        </Link>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.bookingId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "reason",
    header: ui.labels.reason,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.reason}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">{row.original.evidenceCount} {ui.labels.evidenceItems}</p>
      </div>
    ),
  },
  {
    accessorKey: "status",
    header: ui.labels.state,
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={getEnumLabel(locale, "dispute", row.original.status)} tone="warning" />,
  },
  {
    accessorKey: "ageHours",
    header: ui.labels.age,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 48 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.createdAt)}</p>
      </div>
    ),
  },
];
}

export function DisputesQueueView({ items, locale }: { items: DisputeQueueItem[]; locale: string }) {
  const ui = useAdminUi();
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale, ui)}
      emptyEyebrow={ui.pages.disputes.eyebrow}
      emptyTitle={ui.labels.noOpenDisputesWaiting}
      emptyBody={ui.labels.noOpenDisputesWaitingBody}
    />
  );
}
