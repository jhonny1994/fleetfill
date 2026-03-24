import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminDetailCopy, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchBookingWorkspaceDetail } from "@/lib/queries/admin-operations";

export default async function BookingDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const detail = await fetchBookingWorkspaceDetail(bookingId);
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.bookings.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={ui.pages.bookings.eyebrow}
      title={detail.booking.trackingNumber}
      description={detailCopy.bookings.description}
      facts={[
        { label: detailCopy.bookings.bookingStateLabel, value: getEnumLabel(lang, "booking", detail.booking.bookingStatus) },
        { label: detailCopy.bookings.paymentStateLabel, value: getEnumLabel(lang, "payment", detail.booking.paymentStatus) },
        { label: detailCopy.bookings.shipperTotalLabel, value: formatCurrencyDzd(detail.booking.shipperTotalDzd) },
        { label: detailCopy.bookings.carrierPayoutLabel, value: formatCurrencyDzd(detail.booking.carrierPayoutDzd) },
      ]}
      main={
        <>
          <section className="panel space-y-3 p-6">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.bookings.linkedOps}</h2>
            <div className="flex flex-wrap gap-2">
              <Link className="button-secondary" href={buildAdminRoute(lang, "payment", detail.booking.id)}>
                {ui.actions.paymentReview}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "payout", detail.booking.id)}>
                {ui.actions.payoutDetail}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "dispute", detail.booking.id)}>
                {ui.actions.disputeDetail}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(lang, "shipment", detail.booking.shipmentId)}>
                {ui.actions.shipmentDetail}
              </Link>
            </div>
            <div className="flex flex-wrap gap-2">
              <StatusBadge label={formatTemplate(detailCopy.bookings.paymentProofCount, { count: detail.paymentProofCount })} tone="neutral" />
              {detail.disputeStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.disputeBadge, { state: getEnumLabel(lang, "dispute", detail.disputeStatus) })} tone="warning" />
              ) : null}
              {detail.payoutStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.payoutBadge, { state: getEnumLabel(lang, "payout", detail.payoutStatus) })} tone="success" />
              ) : null}
            </div>
            {detail.shipment ? (
              <p className="text-sm text-[var(--color-ink-muted)]">
                {formatTemplate(detailCopy.bookings.shipmentSummary, {
                  origin: detail.shipment.originLabel,
                  destination: detail.shipment.destinationLabel,
                })}
              </p>
            ) : null}
          </section>
          <TimelinePanel
            items={detail.trackingEvents.map((event) => ({
              id: event.id,
              title: event.eventType,
              detail: event.note ?? ui.labels.noNote,
              at: formatDateTime(event.recordedAt),
            }))}
          />
        </>
      }
      rail={
        <section className="panel space-y-3 p-6">
          <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.bookings.references}</h2>
          <p className="text-sm text-[var(--color-ink-muted)]">{formatTemplate(detailCopy.bookings.paymentReference, { reference: detail.booking.paymentReference })}</p>
          <p className="text-sm text-[var(--color-ink-muted)]">{formatTemplate(detailCopy.bookings.createdAt, { date: formatDateTime(detail.booking.createdAt) })}</p>
        </section>
      }
    />
  );
}
