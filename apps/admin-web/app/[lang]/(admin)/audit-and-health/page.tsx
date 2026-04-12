import { getMessages } from "next-intl/server";
import Link from "next/link";

import { EmailDeadLetterRetryAction, EmailDeliveryRetryAction } from "@/components/audit-health/email-retry-actions";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import {
  getAdminActionLabel,
  getAuditOutcomeLabel,
  getAuditHealthErrorLabel,
  getAuditTargetTypeLabel,
  getEnumLabel,
  getNotificationTemplateLabel,
} from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchAuditAndHealthSnapshot } from "@/lib/queries/admin-audit-health";

export default async function AuditAndHealthPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = resolveAppLocale(lang);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const snapshot = await fetchAuditAndHealthSnapshot();
  const latestAuditLogs = snapshot.auditLogs.slice(0, 6);
  const latestEmailDeliveries = snapshot.emailDeliveries.slice(0, 6);
  const latestDeadLetterEmails = snapshot.deadLetterEmails.slice(0, 4);
  const latestDeadLetterPushes = snapshot.deadLetterPushes.slice(0, 4);
  const viewAllLabel = ui.pages.audit.viewAll;

  const resolveAuditHref = (targetType: string, targetId: string | null) => {
    if (!targetId) return null;
    if (targetType === "verification_packet") return `/${locale}/verification/${targetId}`;
    if (targetType === "admin_account") return `/${locale}/admins/${targetId}`;
    if (targetType === "support_request") return `/${locale}/support/${targetId}`;
    if (targetType === "user_profile" || targetType === "profile") return `/${locale}/users/${targetId}`;
    return null;
  };

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.audit.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{ui.pages.audit.body}</p>
      </section>

      <section className="panel space-y-4 p-6">
        <div className="space-y-2">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.auditTrail}</h2>
            <Link className="button-secondary" href={`/${locale}/audit-and-health/audit-trail`}>
              {viewAllLabel} ({snapshot.totals.auditLogs})
            </Link>
          </div>
          <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.auditTrailBody}</p>
          <p className="text-xs uppercase tracking-[0.14em] text-[var(--color-ink-muted)]">{ui.labels.latestActivity}</p>
        </div>
        <div className="space-y-3">
          {latestAuditLogs.map((log) => {
            const href = resolveAuditHref(log.targetType, log.targetId);
            const content = (
              <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:border-[var(--color-accent)] hover:bg-white/80">
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label={getAdminActionLabel(locale, log.action)} tone="neutral" />
                  <StatusBadge
                    label={getAuditOutcomeLabel(locale, log.outcome)}
                    tone={log.outcome === "success" ? "success" : "danger"}
                  />
                </div>
                <p className="mt-2 text-sm text-[var(--color-ink-strong)]">
                  {getAuditTargetTypeLabel(locale, log.targetType)}
                  {log.targetId ? ` • ${log.targetId}` : ""}
                </p>
                <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                  {log.reason ?? ui.labels.noReasonProvided} • {formatDateTime(log.createdAt)}
                </p>
              </div>
            );

            return href ? (
              <Link key={log.id} href={href} className="block">
                {content}
              </Link>
            ) : (
              <div key={log.id}>{content}</div>
            );
          })}
        </div>
      </section>

      <section className="grid gap-4 xl:grid-cols-2">
        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.emailLogs}</h2>
              <Link className="button-secondary" href={`/${locale}/audit-and-health/email-deliveries`}>
                {viewAllLabel} ({snapshot.totals.emailDeliveries})
              </Link>
            </div>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.emailLogsBody}</p>
            <p className="text-xs uppercase tracking-[0.14em] text-[var(--color-ink-muted)]">{ui.labels.latestActivity}</p>
          </div>
          <div className="space-y-3">
            {latestEmailDeliveries.map((log) => {
              const href = log.bookingId ? `/${lang}/bookings/${log.bookingId}` : null;
              const content = (
                <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:border-[var(--color-accent)] hover:bg-white/80">
                  <div className="flex flex-wrap items-center gap-2">
                    <StatusBadge
                      label={getEnumLabel(locale, "email", log.status)}
                      tone={log.status === "delivered" ? "success" : log.status === "soft_failed" ? "warning" : "danger"}
                    />
                    <p className="text-sm font-medium text-[var(--color-ink-strong)]">
                      {getNotificationTemplateLabel(locale, log.templateKey)}
                    </p>
                  </div>
                  <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{log.recipientEmail}</p>
                  <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                    {log.provider} • {formatDateTime(log.lastAttemptAt ?? log.createdAt)}
                  </p>
                  {log.errorCode || log.errorMessage ? (
                    <p className="mt-2 text-xs text-[var(--color-red-700)]">
                      {getAuditHealthErrorLabel(locale, log.errorCode, log.errorMessage)}
                    </p>
                  ) : null}
                  {log.status === "soft_failed" ? (
                    <div className="mt-3">
                      <EmailDeliveryRetryAction deliveryLogId={log.id} />
                    </div>
                  ) : null}
                </div>
              );

              return href ? (
                <Link key={log.id} href={href} className="block">
                  {content}
                </Link>
              ) : (
                <div key={log.id}>{content}</div>
              );
            })}
          </div>
        </section>

        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.deadLetters}</h2>
              <Link className="button-secondary" href={`/${locale}/audit-and-health/dead-letters`}>
                {viewAllLabel} ({snapshot.totals.deadLetterEmails + snapshot.totals.deadLetterPushes})
              </Link>
            </div>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.deadLettersBody}</p>
            <p className="text-xs uppercase tracking-[0.14em] text-[var(--color-ink-muted)]">{ui.labels.latestActivity}</p>
          </div>
          <div className="space-y-3">
            {latestDeadLetterEmails.map((job) => {
              const href = job.bookingId ? `/${lang}/bookings/${job.bookingId}` : null;
              const content = (
                <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:border-[var(--color-accent)] hover:bg-white/80">
                  <div className="flex flex-wrap items-center gap-2">
                    <StatusBadge label={getEnumLabel(locale, "email", "dead_letter")} tone="danger" />
                    <p className="text-sm font-medium text-[var(--color-ink-strong)]">
                      {getNotificationTemplateLabel(locale, job.templateKey)}
                    </p>
                  </div>
                  <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{job.recipientEmail}</p>
                  <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                    {job.attemptCount}/{job.maxAttempts} • {formatDateTime(job.updatedAt)}
                  </p>
                  {job.lastErrorCode || job.lastErrorMessage ? (
                    <p className="mt-2 text-xs text-[var(--color-red-700)]">
                      {getAuditHealthErrorLabel(locale, job.lastErrorCode, job.lastErrorMessage)}
                    </p>
                  ) : null}
                  <div className="mt-3">
                    <EmailDeadLetterRetryAction jobId={job.id} />
                  </div>
                </div>
              );

              return href ? (
                <Link key={job.id} href={href} className="block">
                  {content}
                </Link>
              ) : (
                <div key={job.id}>{content}</div>
              );
            })}
            {latestDeadLetterPushes.map((job) => (
              <Link key={job.id} href={`/${locale}/users/${job.profileId}`} className="block">
                <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4 transition hover:border-[var(--color-accent)] hover:bg-white/80">
                  <div className="flex flex-wrap items-center gap-2">
                    <StatusBadge label={getEnumLabel(locale, "email", "dead_letter")} tone="warning" />
                    <p className="text-sm font-medium text-[var(--color-ink-strong)]">
                      {getNotificationTemplateLabel(locale, job.title)}
                    </p>
                  </div>
                  <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                    {getNotificationTemplateLabel(locale, job.eventKey)} • {job.attemptCount}/{job.maxAttempts}
                  </p>
                  {job.lastErrorCode || job.lastErrorMessage ? (
                    <p className="mt-2 text-xs text-[var(--color-red-700)]">
                      {getAuditHealthErrorLabel(locale, job.lastErrorCode, job.lastErrorMessage)}
                    </p>
                  ) : null}
                </div>
              </Link>
            ))}
          </div>
        </section>
      </section>
    </div>
  );
}
