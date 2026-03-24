import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { fetchBookingWorkspaceDetail } from "@/lib/queries/admin-operations";

export default async function BookingDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const detail = await fetchBookingWorkspaceDetail(bookingId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Booking detail not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Bookings"
      title={detail.booking.trackingNumber}
      description="Canonical booking workspace used by search and cross-queue operations. This is the anchor for shipment, payment, dispute, and payout context."
      facts={[
        { label: "Booking state", value: detail.booking.bookingStatus },
        { label: "Payment state", value: detail.booking.paymentStatus },
        { label: "Shipper total", value: formatCurrencyDzd(detail.booking.shipperTotalDzd) },
        { label: "Carrier payout", value: formatCurrencyDzd(detail.booking.carrierPayoutDzd) },
      ]}
      main={
        <>
          <section className="panel space-y-3 p-6">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Linked operations</h2>
            <div className="flex flex-wrap gap-2">
              <Link className="button-secondary" href={buildAdminRoute(lang, "payment", detail.booking.id)}>
                Payment review
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "payout", detail.booking.id)}>
                Payout detail
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "dispute", detail.booking.id)}>
                Dispute detail
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "shipment", detail.booking.shipmentId)}>
                Shipment detail
              </Link>
            </div>
            <div className="flex flex-wrap gap-2">
              <StatusBadge label={`${detail.paymentProofCount} payment proofs`} tone="neutral" />
              {detail.disputeStatus ? <StatusBadge label={`Dispute ${detail.disputeStatus}`} tone="warning" /> : null}
              {detail.payoutStatus ? <StatusBadge label={`Payout ${detail.payoutStatus}`} tone="success" /> : null}
            </div>
            {detail.shipment ? (
              <p className="text-sm text-[var(--color-ink-muted)]">
                Shipment {detail.shipment.originLabel} {"->"} {detail.shipment.destinationLabel}
              </p>
            ) : null}
          </section>
          <TimelinePanel
            items={detail.trackingEvents.map((event) => ({
              id: event.id,
              title: event.eventType,
              detail: event.note ?? "No note",
              at: formatDateTime(event.recordedAt),
            }))}
          />
        </>
      }
      rail={
        <section className="panel space-y-3 p-6">
          <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">References</h2>
          <p className="text-sm text-[var(--color-ink-muted)]">Payment reference {detail.booking.paymentReference}</p>
          <p className="text-sm text-[var(--color-ink-muted)]">Created {formatDateTime(detail.booking.createdAt)}</p>
        </section>
      }
    />
  );
}
