import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { PaymentReviewActions } from "@/components/detail/payment-review-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminActionLabel, getAdminDetailCopy, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchPaymentDetail } from "@/lib/queries/admin-payments";

export default async function PaymentDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const detail = await fetchPaymentDetail(bookingId);
  const ui = getAdminUi(lang);
  const copy = getAdminDetailCopy(lang).payments;

  if (!detail || !detail.latestProof) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.payments.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={ui.pages.payments.eyebrow}
      title={formatTemplate(copy.title, { trackingNumber: detail.booking.tracking_number })}
      description={copy.description}
      facts={[
        { label: ui.labels.booking, value: detail.booking.tracking_number },
        { label: ui.labels.paymentState, value: getEnumLabel(lang, "payment", detail.booking.payment_status) },
        { label: copy.submittedAmountLabel, value: formatCurrencyDzd(Number(detail.latestProof.submitted_amount_dzd)) },
        { label: copy.expectedTotalLabel, value: formatCurrencyDzd(Number(detail.booking.shipper_total_dzd)) },
      ]}
      main={
        <>
          <FilePreviewPanel
            locale={lang}
            title={ui.pages.payments.preview}
            label={formatTemplate(copy.proofLabel, { rail: detail.latestProof.payment_rail.toUpperCase() })}
            storagePath={detail.latestProof.storage_path}
            contentType={detail.latestProof.content_type}
            signedUrl={detail.signedUrl}
          />
          <TimelinePanel
            locale={lang}
            items={[
              {
                id: "submitted",
                title: copy.submittedTitle,
                detail: detail.latestProof.submitted_reference ?? ui.labels.noSubmittedReference,
                at: formatDateTime(detail.latestProof.submitted_at),
              },
              ...detail.auditLogs.map((log) => ({
                id: log.id,
                title: getAdminActionLabel(lang, log.action),
                detail: log.reason ?? log.outcome,
                at: formatDateTime(log.created_at),
              })),
            ]}
          />
        </>
      }
      rail={
        <ActionRail
          locale={lang}
          title={ui.pages.payments.actions}
          description={copy.paymentActionsBody}
        >
          <PaymentReviewActions
            locale={lang}
            proofId={detail.latestProof.id}
            defaultAmount={Number(detail.latestProof.submitted_amount_dzd)}
          />
        </ActionRail>
      }
    />
  );
}
