import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { PaymentReviewActions } from "@/components/detail/payment-review-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { fetchPaymentDetail } from "@/lib/queries/admin-payments";

export default async function PaymentDetailPage({
  params,
}: {
  params: Promise<{ bookingId: string }>;
}) {
  const { bookingId } = await params;
  const detail = await fetchPaymentDetail(bookingId);

  if (!detail || !detail.latestProof) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Payment detail not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Payments"
      title={`Proof review for ${detail.booking.tracking_number}`}
      description="Review the latest submitted payment proof against the expected booking totals, then approve or reject using the controlled admin workflows."
      facts={[
        { label: "Booking", value: detail.booking.tracking_number },
        { label: "Payment state", value: detail.booking.payment_status },
        { label: "Submitted amount", value: formatCurrencyDzd(Number(detail.latestProof.submitted_amount_dzd)) },
        { label: "Expected total", value: formatCurrencyDzd(Number(detail.booking.shipper_total_dzd)) },
      ]}
      main={
        <>
          <FilePreviewPanel
            title="Proof preview"
            label={`${detail.latestProof.payment_rail.toUpperCase()} proof`}
            storagePath={detail.latestProof.storage_path}
            contentType={detail.latestProof.content_type}
            signedUrl={detail.signedUrl}
          />
          <TimelinePanel
            items={[
              {
                id: "submitted",
                title: "Proof submitted",
                detail: detail.latestProof.submitted_reference ?? "No submitted reference",
                at: formatDateTime(detail.latestProof.submitted_at),
              },
              ...detail.auditLogs.map((log) => ({
                id: log.id,
                title: log.action,
                detail: log.reason ?? log.outcome,
                at: formatDateTime(log.created_at),
              })),
            ]}
          />
        </>
      }
      rail={
        <ActionRail
          title="Payment actions"
          description="All decisions here call the same audited payment-proof RPCs used by the existing platform."
        >
          <PaymentReviewActions
            proofId={detail.latestProof.id}
            defaultAmount={Number(detail.latestProof.submitted_amount_dzd)}
          />
        </ActionRail>
      }
    />
  );
}
