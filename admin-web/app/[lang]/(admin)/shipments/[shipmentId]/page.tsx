import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchShipmentWorkspaceDetail } from "@/lib/queries/admin-operations";

export default async function ShipmentDetailPage({
  params,
}: {
  params: Promise<{ lang: string; shipmentId: string }>;
}) {
  const { lang, shipmentId } = await params;
  const detail = await fetchShipmentWorkspaceDetail(shipmentId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Shipment detail not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Shipments"
      title={detail.shipment.description?.trim() || detail.shipment.id}
      description="Canonical shipment workspace for admin search and operational cross-checks."
      facts={[
        { label: "Status", value: detail.shipment.status },
        { label: "Weight", value: `${detail.shipment.totalWeightKg} kg` },
        { label: "Volume", value: detail.shipment.totalVolumeM3 == null ? "—" : `${detail.shipment.totalVolumeM3} m3` },
        { label: "Created", value: formatDateTime(detail.shipment.createdAt) },
      ]}
      main={
        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Route context</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">
              {detail.shipment.originLabel} {"->"} {detail.shipment.destinationLabel}
            </p>
          </div>
          {detail.booking ? (
            <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <p className="font-medium text-[var(--color-ink-strong)]">Linked booking</p>
              <Link href={buildAdminRoute(lang, "booking", detail.booking.id)} className="mt-2 inline-flex text-sm font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                {detail.booking.trackingNumber}
              </Link>
              <div className="mt-2 flex gap-2">
                <StatusBadge label={detail.booking.bookingStatus} tone="neutral" />
                <StatusBadge label={detail.booking.paymentStatus} tone={detail.booking.paymentStatus === "secured" ? "success" : "warning"} />
              </div>
            </div>
          ) : (
            <p className="text-sm text-[var(--color-ink-muted)]">No booking has been created yet for this shipment.</p>
          )}
        </section>
      }
      rail={
        <section className="panel space-y-3 p-6">
          <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Linked entities</h2>
          <Link className="button-secondary" href={buildAdminRoute(lang, "user", detail.shipment.shipperId)}>
            Shipper profile
          </Link>
        </section>
      }
    />
  );
}
