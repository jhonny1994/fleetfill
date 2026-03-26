"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import { getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import type { SupportQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string): ColumnDef<SupportQueueItem>[] {
  const ui = getAdminUi(locale);
  return [
  {
    accessorKey: "subject",
    header: ui.labels.subject,
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
    header: ui.labels.workflow,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="flex flex-wrap items-center gap-2">
        <StatusBadge label={getEnumLabel(locale, "supportStatus", row.original.status)} tone="neutral" />
        <StatusBadge label={getEnumLabel(locale, "supportPriority", row.original.priority)} tone={row.original.priority === "urgent" ? "danger" : row.original.priority === "high" ? "warning" : "neutral"} />
      </div>
    ),
  },
  {
    accessorKey: "hasUnreadForAdmin",
    header: ui.labels.readState,
    enableSorting: true,
    cell: ({ row }) => (
      <StatusBadge label={row.original.hasUnreadForAdmin ? ui.labels.new : ui.labels.seen} tone={row.original.hasUnreadForAdmin ? "warning" : "success"} />
    ),
  },
  {
    accessorKey: "lastMessageAt",
    header: ui.labels.latestMessage,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{formatDateTime(row.original.lastMessageAt)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.bookingId
            ? `${ui.labels.linkedBooking} ${formatCompactReference(row.original.bookingId)}`
            : row.original.disputeId
              ? `${ui.labels.reason === "السبب" ? "النزاع" : ui.labels.reason === "Raison" ? "Litige" : "Dispute"} ${formatCompactReference(row.original.disputeId)}`
              : row.original.paymentProofId
                ? `${ui.labels.queue === "طابور" ? "الدفع" : ui.labels.queue === "File" ? "Paiement" : "Payment"} ${formatCompactReference(row.original.paymentProofId)}`
                : ui.labels.noLinkedEntity}
        </p>
      </div>
    ),
  },
];
}

export function SupportQueueView({ items, locale }: { items: SupportQueueItem[]; locale: string }) {
  const ui = getAdminUi(locale);
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale)}
      emptyEyebrow={ui.pages.support.eyebrow}
      emptyTitle={ui.labels.queue === "طابور" ? "لا توجد محادثات دعم تحتاج إلى فرز." : ui.labels.queue === "File" ? "Aucun thread support a trier." : "No support threads need triage."}
      emptyBody={ui.labels.queue === "طابور" ? "ستظهر هنا التذاكر المفتوحة أو التي تحتوي على متابعات من المستخدم." : ui.labels.queue === "File" ? "Les tickets ouverts ou avec suivi utilisateur apparaitront ici." : "Open tickets with user follow-ups or active work will show up here."}
    />
  );
}
