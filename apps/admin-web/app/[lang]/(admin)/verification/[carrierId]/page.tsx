import { getMessages } from "next-intl/server";
import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { VerificationReviewActions } from "@/components/detail/verification-review-actions";
import { formatDateTime } from "@/lib/formatting/formatters";
import {
  formatTemplate,
  getAdminActionLabel,
  getAdminDetailCopy,
  getDocumentLabel,
  getEnumLabel,
} from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchVerificationDetail } from "@/lib/queries/admin-verification";

export default async function VerificationDetailPage({
  params,
}: {
  params: Promise<{ lang: string; carrierId: string }>;
}) {
  const { lang, carrierId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchVerificationDetail(carrierId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const copy = getAdminDetailCopy(locale).verification;

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.verification.notFound}</div>;
  }

  const previewDocument = detail.documents[0] ?? null;
  const carrierName = detail.profile.company_name ?? detail.profile.full_name ?? detail.profile.email;

  return (
    <DetailWorkspace
      eyebrow={ui.pages.verification.eyebrow}
      title={formatTemplate(copy.title, { name: carrierName })}
      description={copy.description}
      facts={[
        { label: ui.labels.carrier, value: carrierName },
        { label: copy.carrierIdLabel, value: detail.profile.id },
        { label: copy.profileStateLabel, value: getEnumLabel(locale, "verification", detail.profile.verification_status) },
        { label: copy.packetDocumentsLabel, value: String(detail.documents.length) },
      ]}
      main={
        <>
          {previewDocument ? (
            <FilePreviewPanel
              title={ui.pages.verification.preview}
              label={getDocumentLabel(locale, previewDocument.document_type)}
              storagePath={previewDocument.storage_path}
              contentType={previewDocument.content_type}
              signedUrl={previewDocument.signedUrl}
              previewUnavailableLabel={ui.labels.previewUnavailable}
              openFileLabel={ui.labels.openFile}
              noSignedPreviewLabel={ui.labels.noSignedPreview}
            />
          ) : null}
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.verification.packetDocs}</h2>
            <div className="space-y-3">
              {detail.documents.map((document) => (
                <div key={document.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                  <div className="flex flex-wrap items-center justify-between gap-3">
                    <div className="space-y-1">
                      <p className="font-medium text-[var(--color-ink-strong)]">{getDocumentLabel(locale, document.document_type)}</p>
                      <p className="text-sm text-[var(--color-ink-muted)]">{getEnumLabel(locale, "verification", document.status)}</p>
                    </div>
                    <p className="text-xs text-[var(--color-ink-muted)]">
                      {formatTemplate(copy.packetDocumentStatus, {
                        entity: getEnumLabel(locale, "entity", document.entity_type),
                        date: formatDateTime(document.created_at),
                      })}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </section>
          <TimelinePanel
            title={ui.labels.timeline}
            currentLabel={ui.labels.current}
            emptyLabel={ui.labels.noTimeline}
            items={detail.auditLogs.map((log) => ({
              id: log.id,
              title: getAdminActionLabel(locale, log.action),
              detail: log.reason ?? log.outcome,
              at: formatDateTime(log.created_at),
            }))}
          />
        </>
      }
      rail={
        <ActionRail
          title={ui.pages.verification.actions}
          description={copy.packetActionsBody}
        >
          <VerificationReviewActions
            locale={locale}
            carrierId={detail.profile.id}
            documents={detail.documents.map((document) => ({
              id: document.id,
              label: getDocumentLabel(locale, document.document_type),
              status: document.status,
            }))}
          />
        </ActionRail>
      }
    />
  );
}
