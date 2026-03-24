"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import { getAdminUi } from "@/lib/i18n/admin-ui";
import type { DisputeQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string): ColumnDef<DisputeQueueItem>[] {
  const ui = getAdminUi(locale);
  return [
  {
    accessorKey: "trackingNumber",
    header: ui.labels.booking,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/disputes/${row.original.bookingId}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
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
    cell: ({ row }) => <StatusBadge label={row.original.status} tone="warning" />,
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
  const ui = getAdminUi(locale);
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale)}
      emptyEyebrow={ui.pages.disputes.eyebrow}
      emptyTitle={locale === "ar" ? "لا توجد نزاعات مفتوحة تحتاج إلى تدخل حالياً." : locale === "fr" ? "Aucun litige ouvert ne demande d'intervention pour le moment." : "No open disputes require attention."}
      emptyBody={locale === "ar" ? "تغادر النزاعات التي تم حلها أو إغلاقها هذا الطابور تلقائياً." : locale === "fr" ? "Les litiges resolus et fermes quittent automatiquement cette file." : "Resolved and closed disputes leave this queue automatically."}
    />
  );
}
