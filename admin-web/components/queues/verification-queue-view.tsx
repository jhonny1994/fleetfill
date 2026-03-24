"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import type { VerificationQueueItem } from "@/lib/queries/admin-types";

function buildColumns(locale: string): ColumnDef<VerificationQueueItem>[] {
  return [
  {
    accessorKey: "displayName",
    header: "Carrier",
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
    header: "Pending review",
    enableSorting: true,
    cell: ({ row }) => <StatusBadge label={`${row.original.pendingDocumentCount} pending`} tone="warning" />,
  },
  {
    accessorKey: "profilePendingDocuments",
    header: "Missing / blocked",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{row.original.profileMissingDocuments.length > 0 ? row.original.profileMissingDocuments.join(", ") : "Profile docs complete"}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.vehicles.length} vehicles •{" "}
          {row.original.vehicles
            .flatMap((vehicle) => vehicle.missingDocuments)
            .slice(0, 2)
            .join(", ") || "Vehicle docs complete"}
        </p>
      </div>
    ),
  },
  {
    accessorKey: "latestRelevantUpdateAt",
    header: "Latest activity",
    enableSorting: true,
    cell: ({ row }) => (
      <div className="space-y-1">
        <p>{formatDateTime(row.original.latestRelevantUpdateAt)}</p>
        <p className="text-xs text-[var(--color-ink-muted)]">
          {row.original.vehicles.map((vehicle) => vehicle.label).slice(0, 2).join(" • ") || "No vehicles yet"}
        </p>
      </div>
    ),
  },
];
}

export function VerificationQueueView({ items, locale }: { items: VerificationQueueItem[]; locale: string }) {
  return (
    <AdminDataTable
      data={items}
      columns={buildColumns(locale)}
      emptyEyebrow="Verification"
      emptyTitle="No carrier packets are waiting on review."
      emptyBody="When a carrier uploads or resubmits verification documents, the packet will appear here."
    />
  );
}
