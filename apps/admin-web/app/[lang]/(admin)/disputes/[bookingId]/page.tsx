import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { DisputeResolutionActions } from "@/components/detail/dispute-resolution-actions";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminDetailCopy, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchDisputeDetail } from "@/lib/queries/admin-disputes";

export default async function DisputeDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const detail = await fetchDisputeDetail(bookingId);
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.disputes.notFound}</div>;
  }

  const previewEvidence = detail.evidence[0] ?? null;

  return (
    <DetailWorkspace
      eyebrow={ui.pages.disputes.eyebrow}
      title={detail.booking.tracking_number}
      description={detailCopy.disputes.description}
      facts={[
        { label: detailCopy.disputes.bookingLabel, value: detail.booking.tracking_number },
        { label: ui.labels.reason, value: detail.dispute.reason },
        { label: detailCopy.disputes.disputeStateLabel, value: getEnumLabel(lang, "dispute", detail.dispute.status) },
        { label: detailCopy.disputes.evidenceItemsLabel, value: String(detail.evidence.length) },
      ]}
      main={
        <>
          {previewEvidence ? (
            <FilePreviewPanel
              title={ui.pages.disputes.preview}
              label={previewEvidence.note ?? ui.labels.noNote}
              storagePath={previewEvidence.storage_path}
              contentType={previewEvidence.content_type}
              signedUrl={previewEvidence.signedUrl}
            />
          ) : null}
          <TimelinePanel
            items={[
              {
                id: detail.dispute.id,
                title: detailCopy.disputes.opened,
                detail: detail.dispute.description ?? detail.dispute.reason,
                at: formatDateTime(detail.dispute.created_at),
              },
              ...detail.refunds.map((refund) => ({
                id: refund.id,
                title: formatTemplate(detailCopy.disputes.refundEntry, {
                  state: getEnumLabel(lang, "payout", refund.status),
                }),
                detail: `${formatCurrencyDzd(Number(refund.amount_dzd))} • ${refund.reason}`,
                at: formatDateTime(refund.processed_at),
              })),
            ]}
          />
        </>
      }
      rail={
        <ActionRail locale={lang} title={ui.pages.disputes.actions} description={ui.pages.disputes.title}>
          <DisputeResolutionActions locale={lang} disputeId={detail.dispute.id} />
        </ActionRail>
      }
    />
  );
}
