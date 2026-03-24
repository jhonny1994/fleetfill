import { EmailDeadLetterRetryAction, EmailDeliveryRetryAction } from "@/components/audit-health/email-retry-actions";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchAuditAndHealthSnapshot } from "@/lib/queries/admin-audit-health";

export default async function AuditAndHealthPage() {
  const snapshot = await fetchAuditAndHealthSnapshot();

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Audit & health</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Operational audit and delivery health</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Review privileged actions, retry eligible email failures, and spot dead-letter operational problems before they
          turn into customer-facing incidents.
        </p>
      </section>

      <section className="panel space-y-4 p-6">
        <div className="space-y-2">
          <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">Admin audit trail</h2>
          <p className="text-sm text-[var(--color-ink-muted)]">Latest privileged actions across the platform.</p>
        </div>
        <div className="space-y-3">
          {snapshot.auditLogs.map((log) => (
            <div key={log.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <div className="flex flex-wrap items-center gap-2">
                <StatusBadge label={log.action} tone="neutral" />
                <StatusBadge label={log.outcome} tone={log.outcome === "success" ? "success" : "danger"} />
              </div>
              <p className="mt-2 text-sm text-[var(--color-ink-strong)]">
                {log.targetType}
                {log.targetId ? ` • ${log.targetId}` : ""}
              </p>
              <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                {log.reason ?? "No reason provided"} • {formatDateTime(log.createdAt)}
              </p>
            </div>
          ))}
        </div>
      </section>

      <section className="grid gap-4 xl:grid-cols-2">
        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">Email delivery logs</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">Soft failures can be retried from here.</p>
          </div>
          <div className="space-y-3">
            {snapshot.emailDeliveries.map((log) => (
              <div key={log.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge
                    label={log.status}
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
                    {log.errorCode ?? "delivery_error"}: {log.errorMessage ?? "No provider message"}
                  </p>
                ) : null}
                {log.status === "soft_failed" ? <div className="mt-3"><EmailDeliveryRetryAction deliveryLogId={log.id} /></div> : null}
              </div>
            ))}
          </div>
        </section>

        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">Dead-letter backlog</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">Only retryable failures should be replayed.</p>
          </div>
          <div className="space-y-3">
            {snapshot.deadLetterEmails.map((job) => (
              <div key={job.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label="email dead-letter" tone="danger" />
                  <p className="text-sm font-medium text-[var(--color-ink-strong)]">{job.templateKey}</p>
                </div>
                <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{job.recipientEmail}</p>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  Attempts {job.attemptCount}/{job.maxAttempts} • {formatDateTime(job.updatedAt)}
                </p>
                {job.lastErrorCode || job.lastErrorMessage ? (
                  <p className="mt-2 text-xs text-[var(--color-red-700)]">
                    {job.lastErrorCode ?? "dead_letter"}: {job.lastErrorMessage ?? "No provider message"}
                  </p>
                ) : null}
                <div className="mt-3">
                  <EmailDeadLetterRetryAction jobId={job.id} />
                </div>
              </div>
            ))}
            {snapshot.deadLetterPushes.map((job) => (
              <div key={job.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label="push dead-letter" tone="warning" />
                  <p className="text-sm font-medium text-[var(--color-ink-strong)]">{job.title}</p>
                </div>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  {job.eventKey} • attempts {job.attemptCount}/{job.maxAttempts}
                </p>
                {job.lastErrorCode || job.lastErrorMessage ? (
                  <p className="mt-2 text-xs text-[var(--color-red-700)]">
                    {job.lastErrorCode ?? "dead_letter"}: {job.lastErrorMessage ?? "No provider message"}
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
