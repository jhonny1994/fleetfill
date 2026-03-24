import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { SupportThreadActions } from "@/components/detail/support-thread-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCompactReference, formatDateTime } from "@/lib/formatting/formatters";
import { getAdminUi, getEnumLabel, getSupportMessageTitle } from "@/lib/i18n/admin-ui";
import { fetchSupportDetail } from "@/lib/queries/admin-support";

export default async function SupportDetailPage({
  params,
}: {
  params: Promise<{ lang: string; requestId: string }>;
}) {
  const { lang, requestId } = await params;
  const detail = await fetchSupportDetail(requestId);
  const ui = getAdminUi(lang);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.support.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={ui.pages.support.eyebrow}
      title={detail.request.subject}
      description={lang === "ar" ? "أرسل الردود وحرّك المحادثة داخل مسار الدعم من دون مغادرة لوحة الإدارة." : lang === "fr" ? "Repondez a l'utilisateur et faites avancer le fil support sans quitter la console admin." : "Reply to the user and move the thread through the support workflow without leaving the admin console."}
      facts={[
        { label: ui.labels.request, value: formatCompactReference(detail.request.id) },
        { label: ui.labels.state, value: getEnumLabel(lang, "supportStatus", detail.request.status) },
        { label: ui.labels.priority, value: getEnumLabel(lang, "supportPriority", detail.request.priority) },
        { label: ui.labels.linkedBooking, value: detail.request.booking_id ? formatCompactReference(detail.request.booking_id) : ui.labels.none },
      ]}
      main={
        <>
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.support.conversation}</h2>
            <div className="space-y-3">
              {detail.messages.map((message) => (
                <div key={message.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                  <div className="flex items-center justify-between gap-3">
                    <p className="font-medium text-[var(--color-ink-strong)]">{getEnumLabel(lang, "sender", message.sender_type)}</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">{formatDateTime(message.created_at)}</p>
                  </div>
                  <p className="mt-3 text-sm text-[var(--color-ink-base)]">{message.body}</p>
                </div>
              ))}
            </div>
          </section>
          <TimelinePanel
            locale={lang}
            items={detail.messages.map((message) => ({
              id: message.id,
              title: getSupportMessageTitle(lang, message.sender_type),
              detail: message.body.slice(0, 140),
              at: formatDateTime(message.created_at),
            }))}
          />
        </>
      }
      rail={
        <ActionRail locale={lang} title={ui.pages.support.actions} description={lang === "ar" ? "الردود وتغييرات الحالة هنا تستخدم إجراءات الدعم المدققة نفسها المعتمدة في المنصة." : lang === "fr" ? "Les reponses et changements de statut appellent les memes RPC support audites que le reste de la plateforme." : "Reply and status changes call the same audited support RPCs used by the platform."}>
          <SupportThreadActions
            locale={lang}
            requestId={detail.request.id}
            currentStatus={detail.request.status}
            currentPriority={detail.request.priority}
          />
        </ActionRail>
      }
    />
  );
}
