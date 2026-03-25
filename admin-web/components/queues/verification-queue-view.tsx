"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminUi, getDocumentLabel } from "@/lib/i18n/admin-ui";
import type { VerificationQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string): ColumnDef<VerificationQueueItem>[] {
  const ui = getAdminUi(locale);
  return [
  {
    accessorKey: "displayName",
    header: ui.labels.carrier,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <Link href={`/${locale}/verification/${row.original.carrierId}`} className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
          {row.original.displayName}
        </Link>
        <p className="text-xs text-[var(--color-ink-muted)]">{formatCompactReference(row.original.carrierId)}</p>
      </div>
    ),
  },
  {
    accessorKey: "pendingDocumentCount",
    header: ui.labels.verification,
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={formatTemplate(ui.labels.queue === "طابور" ? "{count} قيد المراجعة" : ui.labels.queue === "File" ? "{count} en attente" : "{count} pending", { count: row.original.pendingDocumentCount })} tone="warning" />,
  },
  {
    accessorKey: "carrierPendingDocuments",
    header: ui.labels.missingOrBlocked,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.carrierMissingDocuments.length > 0 ? row.original.carrierMissingDocuments.map((item) => getDocumentLabel(locale, item)).join(", ") : ui.labels.profileDocsComplete}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {formatTemplate(ui.labels.vehiclesSummary, { count: row.original.vehicles.length })} •{" "}
          {row.original.vehicles
            .flatMap((vehicle) => vehicle.missingDocuments)
            .slice(0, 2)
            .map((item) => getDocumentLabel(locale, item))
            .join(", ") || ui.labels.vehicleDocsComplete}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "latestRelevantUpdateAt",
    header: ui.labels.latestActivity,
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{formatDateTime(row.original.latestRelevantUpdateAt)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.vehicles.map((vehicle) => vehicle.label).slice(0, 2).join(" • ") || ui.labels.noVehiclesYet}
        </p>
      </div>
    ),
  },
];
}

export function VerificationQueueView({ items, locale }: { items: VerificationQueueItem[]; locale: string }) {
  const ui = getAdminUi(locale);
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale)}
      emptyEyebrow={ui.pages.verification.eyebrow}
      emptyTitle={ui.labels.noCarrierPacketsWaiting}
      emptyBody={ui.labels.noCarrierPacketsWaitingBody}
    />
  );
}
