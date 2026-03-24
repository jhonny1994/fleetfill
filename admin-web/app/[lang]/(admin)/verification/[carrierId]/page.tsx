import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { FilePreviewPanel } from "@/components/detail/file-preview-panel";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { VerificationReviewActions } from "@/components/detail/verification-review-actions";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchVerificationDetail } from "@/lib/queries/admin-verification";

export default async function VerificationDetailPage({
  params,
}: {
  params: Promise<{ carrierId: string }>;
}) {
  const { carrierId } = await params;
  const detail = await fetchVerificationDetail(carrierId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Verification packet not found.</div>;
  }

  const previewDocument = detail.documents[0] ?? null;

  return (
    <DetailWorkspace
      eyebrow="Verification"
      title={`Verification packet for ${detail.profile.company_name ?? detail.profile.full_name ?? detail.profile.email}`}
      description="Review the unified driver and vehicle packet, preview the latest uploads, and approve the packet or individual documents using audited backend workflows."
      facts={[
        { label: "Carrier", value: detail.profile.company_name ?? detail.profile.full_name ?? detail.profile.email },
        { label: "Carrier ID", value: detail.profile.id },
        { label: "Profile state", value: detail.profile.verification_status },
        { label: "Documents", value: String(detail.documents.length) },
      ]}
      main={
        <>
          {previewDocument ? (
            <FilePreviewPanel
              title="Latest document preview"
              label={previewDocument.label}
              storagePath={previewDocument.storage_path}
              contentType={previewDocument.content_type}
              signedUrl={previewDocument.signedUrl}
            />
          ) : null}
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Documents in packet</h2>
            <div className="space-y-3">
              {detail.documents.map((document) => (
                <div key={document.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                  <div className="flex flex-wrap items-center justify-between gap-3">
                    <div className="space-y-1">
                      <p className="font-medium text-[var(--color-ink-strong)]">{document.label}</p>
                      <p className="text-sm text-[var(--color-ink-muted)]">{document.status}</p>
                    </div>
                    <p className="text-xs text-[var(--color-ink-muted)]">{document.entity_type} • {formatDateTime(document.created_at)}</p>
                  </div>
                </div>
              ))}
            </div>
          </section>
          <TimelinePanel
            items={detail.auditLogs.map((log) => ({
              id: log.id,
              title: log.action,
              detail: log.reason ?? log.outcome,
              at: formatDateTime(log.created_at),
            }))}
          />
        </>
      }
      rail={
        <ActionRail
          title="Verification actions"
          description="Approve the packet when everything is in order, or review individual documents when a correction or rejection is needed."
        >
          <VerificationReviewActions
            carrierId={detail.profile.id}
            documents={detail.documents.map((document) => ({
              id: document.id,
              label: document.label,
              status: document.status,
            }))}
          />
        </ActionRail>
      }
    />
  );
}
