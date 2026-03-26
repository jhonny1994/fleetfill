"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatDateTime, formatQueueAge } from "@/lib/formatting/formatters";
import { getAdminUi, getEnumLabel, getPayoutRequestLabel } from "@/lib/i18n/admin-ui";
import type { EligiblePayoutQueueItem, ReleasedPayoutItem } from "@/lib/queries/admin-types";

function buildEligibleColumns(locale: string): ColumnDef<EligiblePayoutQueueItem>[] {
  const ui = getAdminUi(locale);
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
    accessorKey: "carrierName",
    header: ui.labels.carrier,
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
    header: ui.labels.amount,
    enableSorting: true,
    cell: ({ row }) => <p className="font-medium">{formatCurrencyDzd(row.original.carrierPayoutDzd)}</p>,
  },
  {
    accessorKey: "ageHours",
    header: ui.labels.age,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <StatusBadge label={formatQueueAge(row.original.ageHours)} tone={row.original.ageHours >= 48 ? "danger" : "warning"} />
        <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.updatedAt)}</p>
      </div>
    ),
  },
  {
    accessorKey: "payoutRequestStatus",
    header: ui.labels.state,
    enableSorting: true,
    cell: ({ row }) =>
      row.original.payoutRequestStatus ? (
        <div className="space-y-1">
          <StatusBadge label={getPayoutRequestLabel(locale, row.original.payoutRequestStatus)} tone="warning" />
          {row.original.payoutRequestedAt ? (
            <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(row.original.payoutRequestedAt)}</p>
          ) : null}
        </div>
      ) : (
        <StatusBadge label={getPayoutRequestLabel(locale, null)} tone="neutral" />
      ),
  },
];
}

function buildReleasedColumns(locale: string): ColumnDef<ReleasedPayoutItem>[] {
  const ui = getAdminUi(locale);
  return [
  {
    accessorKey: "bookingId",
    header: ui.labels.linkedBooking,
    enableSorting: true,
    cell: ({ row }) => <p className="font-medium">{formatCompactReference(row.original.bookingId)}</p>,
  },
  {
    accessorKey: "amountDzd",
    header: ui.labels.amount,
    enableSorting: true,
    cell: ({ row }) => <p>{formatCurrencyDzd(row.original.amountDzd)}</p>,
  },
  {
    accessorKey: "status",
    header: ui.labels.state,
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={getEnumLabel(locale, "payout", row.original.status)} tone={row.original.status === "released" ? "success" : "neutral"} />,
  },
  {
    accessorKey: "processedAt",
    header: ui.labels.updated,
    enableSorting: true,
    cell: ({ row }) => <p>{formatDateTime(row.original.processedAt)}</p>,
  },
];
}

export function PayoutsQueueView({
  eligible,
  released,
  locale,
}: {
  eligible: EligiblePayoutQueueItem[];
  released: ReleasedPayoutItem[];
  locale: string;
}) {
  const ui = getAdminUi(locale);
  return (
    <div className="space-y-4">
      <section className="space-y-3">
        <div className="flex items-center justify-between gap-3">
          <div>
            <p className="eyebrow">{ui.pages.payouts.eyebrow}</p>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.payouts.title}</h2>
          </div>
          <StatusBadge label={`${eligible.length} ready`} tone={eligible.length > 0 ? "warning" : "success"} />
        </div>
        <AdminDataTable
          data={eligible}
          columns={buildEligibleColumns(locale)}
          emptyEyebrow={ui.pages.payouts.eyebrow}
          emptyTitle={ui.labels.queue === "طابور" ? "لا توجد تحويلات جاهزة حالياً." : ui.labels.queue === "File" ? "Aucun versement pret actuellement." : "No payouts are ready right now."}
          emptyBody={ui.labels.queue === "طابور" ? "ستظهر هنا الحجوزات المكتملة والمضمونة من دون نزاعات مفتوحة عندما تصبح جاهزة للصرف." : ui.labels.queue === "File" ? "Les bookings termines et securises sans litige ouvert apparaitront ici quand ils seront eligibles." : "Completed, secured bookings without open disputes will appear here when they are eligible for release."}
        />
      </section>
      <section className="space-y-3">
        <div className="flex items-center justify-between gap-3">
          <div>
            <p className="eyebrow">{ui.pages.payouts.eyebrow}</p>
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.labels.latestActivity}</h2>
          </div>
          <StatusBadge label={`${released.length} recent`} tone="neutral" />
        </div>
        <AdminDataTable
          data={released}
          columns={buildReleasedColumns(locale)}
          emptyEyebrow={ui.pages.payouts.eyebrow}
          emptyTitle={ui.labels.queue === "طابور" ? "لم تُصرف أي تحويلات بعد." : ui.labels.queue === "File" ? "Aucun versement n'a encore ete traite." : "No payouts have been processed yet."}
          emptyBody={ui.labels.queue === "طابور" ? "ستتجمع هنا التحويلات المصروفة لأغراض المتابعة وسجل التدقيق." : ui.labels.queue === "File" ? "Les versements emis s'accumuleront ici pour la visibilite operationnelle." : "Released payouts will accumulate here for operational visibility and audit trail entry points."}
        />
      </section>
    </div>
  );
}
