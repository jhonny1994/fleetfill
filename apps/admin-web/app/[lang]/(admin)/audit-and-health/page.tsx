import { EmailDeadLetterRetryAction, EmailDeliveryRetryAction } from "@/components/audit-health/email-retry-actions";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminActionLabel, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchAuditAndHealthSnapshot } from "@/lib/queries/admin-audit-health";

export default async function AuditAndHealthPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const ui = getAdminUi(lang);
  const snapshot = await fetchAuditAndHealthSnapshot();

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.audit.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {ui.pages.audit.body}
        </p>
      </section>

      <section className="panel space-y-4 p-6">
        <div className="space-y-2">
          <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.auditTrail}</h2>
          <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.auditTrailBody}</p>
        </div>
        <div className="space-y-3">
          {snapshot.auditLogs.map((log) => (
            <div key={log.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <div className="flex flex-wrap items-center gap-2">
                <StatusBadge label={getAdminActionLabel(lang, log.action)} tone="neutral" />
                <StatusBadge label={getEnumLabel(lang, "activity", log.outcome === "success" ? "active" : "inactive")} tone={log.outcome === "success" ? "success" : "danger"} />
              </div>
              <p className="mt-2 text-sm text-[var(--color-ink-strong)]">
                {log.targetType}
                {log.targetId ? ` • ${log.targetId}` : ""}
              </p>
              <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                {log.reason ?? ui.labels.noReasonProvided} • {formatDateTime(log.createdAt)}
              </p>
            </div>
          ))}
        </div>
      </section>

      <section className="grid gap-4 xl:grid-cols-2">
        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.emailLogs}</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.emailLogsBody}</p>
          </div>
          <div className="space-y-3">
            {snapshot.emailDeliveries.map((log) => (
              <div key={log.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge
                    label={getEnumLabel(lang, "email", log.status)}
                    tone={log.status === "delivered" ? "success" : log.status === "soft_failed" ? "warning" : "danger"}
                  />
                  <p className="text-sm font-medium text-[var(--color-ink-strong)]">{log.templateKey}</p>
                </div>
                <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{log.recipientEmail}</p>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  {log.provider} • {formatDateTime(log.lastAttemptAt ?? log.createdAt)}
                </p>
                {log.errorCode || log.errorMessage ? (
                  <p className="mt-2 text-xs text-[var(--color-red-700)]">
                    {log.errorCode ?? "delivery_error"}: {log.errorMessage ?? ui.labels.noProviderMessage}
                  </p>
                ) : null}
                {log.status === "soft_failed" ? <div className="mt-3"><EmailDeliveryRetryAction deliveryLogId={log.id} locale={lang} /></div> : null}
              </div>
            ))}
          </div>
        </section>

        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.deadLetters}</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.deadLettersBody}</p>
          </div>
          <div className="space-y-3">
            {snapshot.deadLetterEmails.map((job) => (
              <div key={job.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label={getEnumLabel(lang, "email", "dead_letter")} tone="danger" />
                  <p className="text-sm font-medium text-[var(--color-ink-strong)]">{job.templateKey}</p>
                </div>
                <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{job.recipientEmail}</p>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  {job.attemptCount}/{job.maxAttempts} • {formatDateTime(job.updatedAt)}
                </p>
                {job.lastErrorCode || job.lastErrorMessage ? (
                  <p className="mt-2 text-xs text-[var(--color-red-700)]">
                    {job.lastErrorCode ?? "dead_letter"}: {job.lastErrorMessage ?? ui.labels.noProviderMessage}
                  </p>
                ) : null}
                <div className="mt-3">
                  <EmailDeadLetterRetryAction jobId={job.id} locale={lang} />
                </div>
              </div>
            ))}
            {snapshot.deadLetterPushes.map((job) => (
              <div key={job.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label={getEnumLabel(lang, "email", "dead_letter")} tone="warning" />
                  <p className="text-sm font-medium text-[var(--color-ink-strong)]">{job.title}</p>
                </div>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  {job.eventKey} • {job.attemptCount}/{job.maxAttempts}
                </p>
                {job.lastErrorCode || job.lastErrorMessage ? (
                  <p className="mt-2 text-xs text-[var(--color-red-700)]">
                    {job.lastErrorCode ?? "dead_letter"}: {job.lastErrorMessage ?? ui.labels.noProviderMessage}
                  </p>
                ) : null}
              </div>
            ))}
          </div>
        </section>
      </section>
    </div>
  );
}
