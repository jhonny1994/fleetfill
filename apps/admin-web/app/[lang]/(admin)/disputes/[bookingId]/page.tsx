import { getMessages } from "next-intl/server";
import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { DisputeResolutionActions } from "@/components/detail/dispute-resolution-actions";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminDetailCopy, getEnumLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchDisputeDetail } from "@/lib/queries/admin-disputes";

export default async function DisputeDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchDisputeDetail(bookingId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);

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
        { label: detailCopy.disputes.disputeStateLabel, value: getEnumLabel(locale, "dispute", detail.dispute.status) },
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
              previewUnavailableLabel={ui.labels.previewUnavailable}
              openFileLabel={ui.labels.openFile}
              noSignedPreviewLabel={ui.labels.noSignedPreview}
            />
          ) : null}
          <TimelinePanel
            title={ui.labels.timeline}
            currentLabel={ui.labels.current}
            emptyLabel={ui.labels.noTimeline}
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
                  state: getEnumLabel(locale, "payout", refund.status),
                }),
                detail: `${formatCurrencyDzd(Number(refund.amount_dzd))} • ${refund.reason}`,
                at: formatDateTime(refund.processed_at),
              })),
            ]}
          />
        </>
      }
      rail={
        <ActionRail title={ui.pages.disputes.actions} description={ui.pages.disputes.title}>
          <DisputeResolutionActions locale={locale} disputeId={detail.dispute.id} />
        </ActionRail>
      }
    />
  );
}
