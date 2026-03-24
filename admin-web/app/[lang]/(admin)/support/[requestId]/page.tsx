import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { SupportThreadActions } from "@/components/detail/support-thread-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import { fetchSupportDetail } from "@/lib/queries/admin-support";

export default async function SupportDetailPage({
  params,
}: {
  params: Promise<{ requestId: string }>;
}) {
  const { requestId } = await params;
  const detail = await fetchSupportDetail(requestId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Support thread not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Support"
      title={detail.request.subject}
      description="Reply to the user and move the thread through the support workflow without leaving the admin console."
      facts={[
        { label: "Request", value: formatCompactReference(detail.request.id) },
        { label: "Status", value: detail.request.status },
        { label: "Priority", value: detail.request.priority },
        { label: "Linked booking", value: detail.request.booking_id ? formatCompactReference(detail.request.booking_id) : "None" },
      ]}
      main={
        <>
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Conversation</h2>
            <div className="space-y-3">
              {detail.messages.map((message) => (
                <div key={message.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                  <div className="flex items-center justify-between gap-3">
                    <p className="font-medium text-[var(--color-ink-strong)]">{message.sender_type}</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(message.created_at)}</p>
                  </div>
                  <p className="mt-3 text-sm text-[var(--color-ink-base)]">{message.body}</p>
                </div>
              ))}
            </div>
          </section>
          <TimelinePanel
            items={detail.messages.map((message) => ({
              id: message.id,
              title: `${message.sender_type} message`,
              detail: message.body.slice(0, 140),
              at: formatDateTime(message.created_at),
            }))}
          />
        </>
      }
      rail={
        <ActionRail title="Support actions" description="Reply and status changes call the same audited support RPCs used by the platform.">
          <SupportThreadActions
            requestId={detail.request.id}
            currentStatus={detail.request.status}
            currentPriority={detail.request.priority}
          />
        </ActionRail>
      }
    />
  );
}
