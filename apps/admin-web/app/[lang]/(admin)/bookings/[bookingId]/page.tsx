import { getMessages } from "next-intl/server";
import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import {
  formatTemplate,
  getAdminDetailCopy,
  getEnumLabel,
  getPayoutRequestBlockedReasonLabel,
  getPayoutRequestLabel,
  getTimelineEventLabel,
} from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchBookingWorkspaceDetail } from "@/lib/queries/admin-operations";

export default async function BookingDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchBookingWorkspaceDetail(bookingId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.bookings.notFound}</div>;
  }

  const nextActionLabel = getBookingNextActionLabel(locale, detail);
  const nextOwnerLabel = getBookingNextOwnerLabel(locale, detail);
  const blockerLabel = getBookingPrimaryBlockerLabel(locale, detail);

  return (
    <DetailWorkspace
      eyebrow={ui.pages.bookings.eyebrow}
      title={detail.booking.trackingNumber}
      description={detailCopy.bookings.description}
      backLink={{ href: `/${locale}/bookings`, label: ui.pages.bookings.eyebrow }}
      relatedLinks={[
        { href: buildAdminRoute(locale, "shipment", detail.booking.shipmentId), label: ui.actions.shipmentDetail },
        { href: buildAdminRoute(locale, "payment", detail.booking.id), label: ui.actions.paymentReview },
        { href: buildAdminRoute(locale, "payout", detail.booking.id), label: ui.actions.payoutDetail },
        { href: buildAdminRoute(locale, "dispute", detail.booking.id), label: ui.actions.disputeDetail },
      ]}
      facts={[
        { label: detailCopy.bookings.bookingStateLabel, value: getEnumLabel(locale, "booking", detail.booking.bookingStatus) },
        { label: detailCopy.bookings.paymentStateLabel, value: getEnumLabel(locale, "payment", detail.booking.paymentStatus) },
        { label: detailCopy.bookings.shipperTotalLabel, value: formatCurrencyDzd(detail.booking.shipperTotalDzd) },
        { label: detailCopy.bookings.carrierPayoutLabel, value: formatCurrencyDzd(detail.booking.carrierPayoutDzd) },
      ]}
      main={
        <>
          <section className="panel space-y-3 p-6">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.bookings.linkedOps}</h2>
            <div className="flex flex-wrap gap-2">
              <Link className="button-secondary" href={buildAdminRoute(locale, "payment", detail.booking.id)}>
                {ui.actions.paymentReview}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(locale, "payout", detail.booking.id)}>
                {ui.actions.payoutDetail}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(locale, "dispute", detail.booking.id)}>
                {ui.actions.disputeDetail}
              </Link>
              <Link className="button-secondary" href={buildAdminRoute(locale, "shipment", detail.booking.shipmentId)}>
                {ui.actions.shipmentDetail}
              </Link>
            </div>
            <div className="flex flex-wrap gap-2">
              <StatusBadge label={formatTemplate(detailCopy.bookings.paymentProofCount, { count: detail.paymentProofCount })} tone="neutral" />
              <StatusBadge label={nextOwnerLabel} tone="neutral" />
              {blockerLabel ? <StatusBadge label={blockerLabel} tone="warning" /> : null}
              {detail.disputeStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.disputeBadge, { state: getEnumLabel(locale, "dispute", detail.disputeStatus) })} tone="warning" />
              ) : null}
              {detail.payoutStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.payoutBadge, { state: getEnumLabel(locale, "payout", detail.payoutStatus) })} tone="success" />
              ) : null}
              {detail.payoutRequestContext?.requestStatus ? (
                <StatusBadge
                  label={getPayoutRequestLabel(locale, detail.payoutRequestContext.requestStatus)}
                  tone={detail.payoutRequestContext.requestStatus === "requested" ? "warning" : "success"}
                />
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
            {detail.payoutRequestContext?.blockedReason ? (
              <p className="text-sm text-[var(--color-ink-muted)]">
                {getPayoutRequestBlockedReasonLabel(locale, detail.payoutRequestContext.blockedReason)}
              </p>
            ) : null}
          </section>
          <TimelinePanel
            title={ui.labels.timeline}
            currentLabel={ui.labels.current}
            emptyLabel={ui.labels.noTimeline}
            items={detail.trackingEvents.map((event) => ({
              id: event.id,
              title: getTimelineEventLabel(locale, event.eventType),
              detail: event.note ?? ui.labels.noNote,
              at: formatDateTime(event.recordedAt),
            }))}
          />
        </>
      }
      rail={
        <section className="panel space-y-3 p-6">
          <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.bookings.references}</h2>
          <StatusBadge
            label={nextActionLabel}
            tone={detail.disputeStatus === "open" ? "warning" : detail.booking.paymentStatus === "secured" ? "success" : "neutral"}
          />
          <p className="text-sm text-[var(--color-ink-muted)]">{nextOwnerLabel}</p>
          {blockerLabel ? <p className="text-sm text-[var(--color-ink-muted)]">{blockerLabel}</p> : null}
          <p className="text-sm text-[var(--color-ink-muted)]">{formatTemplate(detailCopy.bookings.paymentReference, { reference: detail.booking.paymentReference })}</p>
          <p className="text-sm text-[var(--color-ink-muted)]">{formatTemplate(detailCopy.bookings.createdAt, { date: formatDateTime(detail.booking.createdAt) })}</p>
          {detail.payoutRequestContext?.blockedReason ? (
            <p className="text-sm text-[var(--color-ink-muted)]">
              {getPayoutRequestBlockedReasonLabel(locale, detail.payoutRequestContext.blockedReason)}
            </p>
          ) : null}
        </section>
      }
    />
  );
}

function getBookingNextOwnerLabel(
  lang: string,
  detail: NonNullable<Awaited<ReturnType<typeof fetchBookingWorkspaceDetail>>>,
) {
  const copy = getAdminDetailCopy(resolveAppLocale(lang)).bookings;

  if (detail.disputeStatus === "open") {
    return copy.nextOwnerAdmin;
  }

  if (detail.booking.paymentStatus === "unpaid" || detail.booking.paymentStatus === "rejected") {
    return copy.nextOwnerShipper;
  }

  if (detail.booking.paymentStatus === "proof_submitted" || detail.booking.paymentStatus === "under_verification") {
    return copy.nextOwnerAdmin;
  }

  if (detail.booking.bookingStatus === "confirmed" || detail.booking.bookingStatus === "in_transit") {
    return copy.nextOwnerCarrier;
  }

  if (detail.booking.bookingStatus === "delivered_pending_review") {
    return copy.nextOwnerShipperOrAdmin;
  }

  if (detail.payoutRequestContext?.requestStatus === "requested" && detail.payoutStatus == null) {
    return copy.nextOwnerAdmin;
  }

  return copy.nextOwnerSystem;
}

function getBookingPrimaryBlockerLabel(
  lang: string,
  detail: NonNullable<Awaited<ReturnType<typeof fetchBookingWorkspaceDetail>>>,
) {
  const copy = getAdminDetailCopy(resolveAppLocale(lang)).bookings;

  if (detail.disputeStatus === "open") {
    return copy.blockerOpenDispute;
  }

  if (detail.booking.paymentStatus === "unpaid") {
    return copy.blockerPaymentNotReceived;
  }

  if (detail.booking.paymentStatus === "rejected") {
    return copy.blockerPaymentRejected;
  }

  if (detail.booking.paymentStatus === "proof_submitted" || detail.booking.paymentStatus === "under_verification") {
    return copy.blockerPaymentReviewPending;
  }

  if (detail.payoutRequestContext?.blockedReason) {
    const blocked = getPayoutRequestBlockedReasonLabel(lang, detail.payoutRequestContext.blockedReason);
    if (blocked) {
      return formatTemplate(copy.blockerTemplate, { reason: blocked });
    }
  }

  return null;
}

function getBookingNextActionLabel(
  lang: string,
  detail: NonNullable<Awaited<ReturnType<typeof fetchBookingWorkspaceDetail>>>,
) {
  const copy = getAdminDetailCopy(resolveAppLocale(lang)).bookings;

  if (detail.disputeStatus === "open") {
    return copy.nextActionResolveDispute;
  }

  if (detail.booking.paymentStatus === "unpaid" || detail.booking.paymentStatus === "rejected") {
    return copy.nextActionWaitForShipperPayment;
  }

  if (
    detail.booking.paymentStatus === "proof_submitted" ||
    detail.booking.paymentStatus === "under_verification"
  ) {
    return copy.nextActionReviewPaymentProof;
  }

  if (detail.payoutRequestContext?.requestStatus === "requested" && detail.payoutStatus == null) {
    return copy.nextActionReleaseRequestedPayout;
  }

  if (detail.booking.bookingStatus === "delivered_pending_review") {
    return copy.nextActionMonitorDeliveryReview;
  }

  if (detail.booking.bookingStatus === "completed" && detail.payoutStatus != null) {
    return copy.nextActionNoneBookingComplete;
  }

  return copy.nextActionMonitorProgress;
}
