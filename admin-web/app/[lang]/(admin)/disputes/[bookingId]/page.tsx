import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { DisputeResolutionActions } from "@/components/detail/dispute-resolution-actions";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { fetchDisputeDetail } from "@/lib/queries/admin-disputes";

export default async function DisputeDetailPage({
  params,
}: {
  params: Promise<{ bookingId: string }>;
}) {
  const { bookingId } = await params;
  const detail = await fetchDisputeDetail(bookingId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Dispute detail not found.</div>;
  }

  const previewEvidence = detail.evidence[0] ?? null;

  return (
    <DetailWorkspace
      eyebrow="Disputes"
      title={`Dispute for ${detail.booking.tracking_number}`}
      description="Review the dispute reason, evidence, and refund history before resolving the dispute with or without a refund."
      facts={[
        { label: "Booking", value: detail.booking.tracking_number },
        { label: "Reason", value: detail.dispute.reason },
        { label: "Dispute state", value: detail.dispute.status },
        { label: "Evidence items", value: String(detail.evidence.length) },
      ]}
      main={
        <>
          {previewEvidence ? (
            <FilePreviewPanel
              title="Evidence preview"
              label={previewEvidence.note ?? "Dispute evidence"}
              storagePath={previewEvidence.storage_path}
              contentType={previewEvidence.content_type}
              signedUrl={previewEvidence.signedUrl}
            />
          ) : null}
          <TimelinePanel
            items={[
              {
                id: detail.dispute.id,
                title: "Dispute opened",
                detail: detail.dispute.description ?? detail.dispute.reason,
                at: formatDateTime(detail.dispute.created_at),
              },
              ...detail.refunds.map((refund) => ({
                id: refund.id,
                title: `Refund ${refund.status}`,
                detail: `${formatCurrencyDzd(Number(refund.amount_dzd))} • ${refund.reason}`,
                at: formatDateTime(refund.processed_at),
              })),
            ]}
          />
        </>
      }
      rail={
        <ActionRail title="Dispute actions" description="Use the dispute workflows to close the case cleanly or issue a refund-backed resolution.">
          <DisputeResolutionActions disputeId={detail.dispute.id} />
        </ActionRail>
      }
    />
  );
}
