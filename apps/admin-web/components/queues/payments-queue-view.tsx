"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import type { AdminUi } from "@/lib/i18n/admin-ui";
import { formatTemplate } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import type { PaymentQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string, ui: AdminUi): ColumnDef<PaymentQueueItem>[] {
  return [
  {
    accessorKey: "trackingNumber",
    header: ui.labels.linkedBooking,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/bookings/${row.original.bookingId}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
          {row.original.trackingNumber}
        </Link>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.bookingId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "submittedReference",
    header: ui.labels.proof,
    enableSorting: false,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.submittedReference ?? ui.labels.noTransferNote}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.paymentRail.toUpperCase()} • {formatCompactReference(row.original.paymentReference)}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "submittedAmountDzd",
    header: ui.labels.amount,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p className="font-medium">{formatCurrencyDzd(row.original.submittedAmountDzd)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {formatTemplate(ui.labels.expectedAmount, { amount: formatCurrencyDzd(row.original.shipperTotalDzd) })}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "ageHours",
    header: ui.labels.age,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 24 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.submittedAt)}</p>
      </div>
    ),
  },
];
}

export function PaymentsQueueView({ items, locale }: { items: PaymentQueueItem[]; locale: string }) {
  const ui = useAdminUi();
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale, ui)}
      emptyEyebrow={ui.pages.payments.eyebrow}
      emptyTitle={ui.labels.noPaymentProofsWaiting}
      emptyBody={ui.labels.noPaymentProofsWaitingBody}
    />
  );
}
