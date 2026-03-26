import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import {
  formatTemplate,
  getAdminDetailCopy,
  getAdminUi,
  getEnumLabel,
  getPayoutRequestBlockedReasonLabel,
  getPayoutRequestLabel,
  getTimelineEventLabel,
} from "@/lib/i18n/admin-ui";
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

  const nextActionLabel = getBookingNextActionLabel(lang, detail);
  const nextOwnerLabel = getBookingNextOwnerLabel(lang, detail);
  const blockerLabel = getBookingPrimaryBlockerLabel(lang, detail);

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
              <StatusBadge label={nextOwnerLabel} tone="neutral" />
              {blockerLabel ? <StatusBadge label={blockerLabel} tone="warning" /> : null}
              {detail.disputeStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.disputeBadge, { state: getEnumLabel(lang, "dispute", detail.disputeStatus) })} tone="warning" />
              ) : null}
              {detail.payoutStatus ? (
                <StatusBadge label={formatTemplate(detailCopy.bookings.payoutBadge, { state: getEnumLabel(lang, "payout", detail.payoutStatus) })} tone="success" />
              ) : null}
              {detail.payoutRequestContext?.requestStatus ? (
                <StatusBadge
                  label={getPayoutRequestLabel(lang, detail.payoutRequestContext.requestStatus)}
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
                {getPayoutRequestBlockedReasonLabel(lang, detail.payoutRequestContext.blockedReason)}
              </p>
            ) : null}
          </section>
          <TimelinePanel
            locale={lang}
            items={detail.trackingEvents.map((event) => ({
              id: event.id,
              title: getTimelineEventLabel(lang, event.eventType),
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
              {getPayoutRequestBlockedReasonLabel(lang, detail.payoutRequestContext.blockedReason)}
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
  const isArabic = lang === "ar";
  const isFrench = lang === "fr";

  if (detail.disputeStatus === "open") {
    return isArabic
      ? "مالك الخطوة التالية: الإدارة"
      : isFrench
        ? "Prochain propriétaire : admin"
        : "Next owner: admin";
  }

  if (detail.booking.paymentStatus === "unpaid" || detail.booking.paymentStatus === "rejected") {
    return isArabic
      ? "مالك الخطوة التالية: الشاحن"
      : isFrench
        ? "Prochain propriétaire : chargeur"
        : "Next owner: shipper";
  }

  if (detail.booking.paymentStatus === "proof_submitted" || detail.booking.paymentStatus === "under_verification") {
    return isArabic
      ? "مالك الخطوة التالية: الإدارة"
      : isFrench
        ? "Prochain propriétaire : admin"
        : "Next owner: admin";
  }

  if (detail.booking.bookingStatus === "confirmed" || detail.booking.bookingStatus === "in_transit") {
    return isArabic
      ? "مالك الخطوة التالية: الناقل"
      : isFrench
        ? "Prochain propriétaire : transporteur"
        : "Next owner: carrier";
  }

  if (detail.booking.bookingStatus === "delivered_pending_review") {
    return isArabic
      ? "مالك الخطوة التالية: الشاحن أو الإدارة"
      : isFrench
        ? "Prochain propriétaire : chargeur ou admin"
        : "Next owner: shipper or admin";
  }

  if (detail.payoutRequestContext?.requestStatus === "requested" && detail.payoutStatus == null) {
    return isArabic
      ? "مالك الخطوة التالية: الإدارة"
      : isFrench
        ? "Prochain propriétaire : admin"
        : "Next owner: admin";
  }

  return isArabic
    ? "مالك الخطوة التالية: النظام"
    : isFrench
      ? "Prochain propriétaire : système"
      : "Next owner: system";
}

function getBookingPrimaryBlockerLabel(
  lang: string,
  detail: NonNullable<Awaited<ReturnType<typeof fetchBookingWorkspaceDetail>>>,
) {
  const isArabic = lang === "ar";
  const isFrench = lang === "fr";

  if (detail.disputeStatus === "open") {
    return isArabic
      ? "العائق الحالي: نزاع مفتوح"
      : isFrench
        ? "Blocage actuel : litige ouvert"
        : "Current blocker: open dispute";
  }

  if (detail.booking.paymentStatus === "unpaid") {
    return isArabic
      ? "العائق الحالي: لم يتم استلام الدفع بعد"
      : isFrench
        ? "Blocage actuel : paiement non reçu"
        : "Current blocker: payment not received";
  }

  if (detail.booking.paymentStatus === "rejected") {
    return isArabic
      ? "العائق الحالي: إثبات الدفع مرفوض"
      : isFrench
        ? "Blocage actuel : preuve de paiement rejetée"
        : "Current blocker: payment proof rejected";
  }

  if (detail.booking.paymentStatus === "proof_submitted" || detail.booking.paymentStatus === "under_verification") {
    return isArabic
      ? "العائق الحالي: مراجعة الدفع معلقة"
      : isFrench
        ? "Blocage actuel : revue paiement en attente"
        : "Current blocker: payment review pending";
  }

  if (detail.payoutRequestContext?.blockedReason) {
    const blocked = getPayoutRequestBlockedReasonLabel(lang, detail.payoutRequestContext.blockedReason);
    if (blocked) {
      return isArabic
        ? `العائق الحالي: ${blocked}`
        : isFrench
          ? `Blocage actuel : ${blocked}`
          : `Current blocker: ${blocked}`;
    }
  }

  return null;
}

function getBookingNextActionLabel(
  lang: string,
  detail: NonNullable<Awaited<ReturnType<typeof fetchBookingWorkspaceDetail>>>,
) {
  const isArabic = lang === "ar";
  const isFrench = lang === "fr";

  if (detail.disputeStatus === "open") {
    return isArabic
      ? "الإجراء التالي: حل النزاع المفتوح"
      : isFrench
        ? "Action suivante : résoudre le litige ouvert"
        : "Next action: resolve the open dispute";
  }

  if (detail.booking.paymentStatus === "unpaid" || detail.booking.paymentStatus === "rejected") {
    return isArabic
      ? "الإجراء التالي: انتظار الشاحن لإرسال الدفع"
      : isFrench
        ? "Action suivante : attendre le paiement du chargeur"
        : "Next action: wait for shipper payment";
  }

  if (
    detail.booking.paymentStatus === "proof_submitted" ||
    detail.booking.paymentStatus === "under_verification"
  ) {
    return isArabic
      ? "الإجراء التالي: مراجعة إثبات الدفع"
      : isFrench
        ? "Action suivante : revoir la preuve de paiement"
        : "Next action: review payment proof";
  }

  if (detail.payoutRequestContext?.requestStatus === "requested" && detail.payoutStatus == null) {
    return isArabic
      ? "الإجراء التالي: صرف التحويل المطلوب"
      : isFrench
        ? "Action suivante : libérer le versement demandé"
        : "Next action: release the requested payout";
  }

  if (detail.booking.bookingStatus === "delivered_pending_review") {
    return isArabic
      ? "الإجراء التالي: مراقبة مراجعة التسليم"
      : isFrench
        ? "Action suivante : surveiller la revue de livraison"
        : "Next action: monitor delivery review";
  }

  if (detail.booking.bookingStatus === "completed" && detail.payoutStatus != null) {
    return isArabic
      ? "الإجراء التالي: لا يوجد، الحجز مكتمل"
      : isFrench
        ? "Action suivante : aucune, réservation terminée"
        : "Next action: none, booking is complete";
  }

  return isArabic
    ? "الإجراء التالي: متابعة الحجز"
    : isFrench
      ? "Action suivante : suivre la réservation"
      : "Next action: monitor booking progress";
}
