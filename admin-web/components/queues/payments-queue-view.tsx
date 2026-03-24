"use client";

import type { ColumnDef } from "@tanstack/react-table";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import type { PaymentQueueItem } from "@/lib/queries/admin-types";

const columns: ColumnDef<PaymentQueueItem>[] = [
  {
    accessorKey: "trackingNumber",
    header: "Booking",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p className="font-semibold text-[var(--color-ink-strong)]">{row.original.trackingNumber}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.bookingId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "submittedReference",
    header: "Proof",
    enableSorting: false,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.submittedReference ?? "No transfer note"}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.paymentRail.toUpperCase()} • {formatCompactReference(row.original.paymentReference)}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "submittedAmountDzd",
    header: "Amount",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p className="font-medium">{formatCurrencyDzd(row.original.submittedAmountDzd)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          Expected {formatCurrencyDzd(row.original.shipperTotalDzd)}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "ageHours",
    header: "Age",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 24 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.submittedAt)}</p>
      </div>
    ),
  },
];

export function PaymentsQueueView({ items }: { items: PaymentQueueItem[] }) {
  return (
    <AdminDataTable
      data={items}
      columns={columns}
      emptyEyebrow="Payments"
      emptyTitle="No payment proofs need review."
      emptyBody="This queue will repopulate when shippers submit new proofs or a payment review returns to pending."
    />
  );
}
