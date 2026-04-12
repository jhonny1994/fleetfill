import { getMessages } from "next-intl/server";
import Link from "next/link";

import { EmailDeadLetterRetryAction } from "@/components/audit-health/email-retry-actions";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAuditHealthErrorLabel, getEnumLabel, getNotificationTemplateLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchDeadLetterHealthPage } from "@/lib/queries/admin-audit-health";

function buildPageHref(lang: string, page: number) {
  return `/${lang}/audit-and-health/dead-letters?page=${page}`;
}

export default async function AdminDeadLettersPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ page?: string }>;
}) {
  const [{ lang }, query] = await Promise.all([params, searchParams]);
  const locale = resolveAppLocale(lang);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const currentPage = Math.max(1, Number(query.page ?? "1") || 1);
  const snapshot = await fetchDeadLetterHealthPage(currentPage);
  const total = snapshot.totalDeadLetterEmails + snapshot.totalDeadLetterPushes;
  const totalPages = Math.max(
    1,
    Math.ceil(Math.max(snapshot.totalDeadLetterEmails, snapshot.totalDeadLetterPushes) / snapshot.pageSize),
  );
  const { backToSummary, previous, next, page, total: totalLabel, emailDeadLetters, pushDeadLetters } = ui.pages.audit;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.audit.eyebrow}</p>
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div className="space-y-2">
            <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.deadLetters}</h1>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.deadLettersBody}</p>
          </div>
          <Link className="button-secondary" href={`/${lang}/audit-and-health`}>
            {backToSummary}
          </Link>
        </div>
      </section>

      <section className="panel space-y-4 p-6">
        <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{emailDeadLetters}</h2>
        {snapshot.deadLetterEmails.map((job) => {
          const card = (
            <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <div className="flex flex-wrap items-center gap-2">
                <StatusBadge label={getEnumLabel(lang, "email", "dead_letter")} tone="danger" />
                <p className="text-sm font-medium text-[var(--color-ink-strong)]">
                  {getNotificationTemplateLabel(lang, job.templateKey)}
                </p>
              </div>
              <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{job.recipientEmail}</p>
              <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                {job.attemptCount}/{job.maxAttempts} • {formatDateTime(job.updatedAt)}
              </p>
              {job.lastErrorCode || job.lastErrorMessage ? (
                <p className="mt-2 text-xs text-[var(--color-red-700)]">
                  {getAuditHealthErrorLabel(lang, job.lastErrorCode, job.lastErrorMessage)}
                </p>
              ) : null}
              <div className="mt-3">
                    <EmailDeadLetterRetryAction jobId={job.id} />
              </div>
            </div>
          );

          return job.bookingId ? (
            <Link key={job.id} href={`/${lang}/bookings/${job.bookingId}`} className="block">
              {card}
            </Link>
          ) : (
            <div key={job.id}>{card}</div>
          );
        })}

        <div className="border-t border-[var(--color-border)] pt-4" />

        <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{pushDeadLetters}</h2>
        {snapshot.deadLetterPushes.map((job) => (
          <Link key={job.id} href={`/${lang}/users/${job.profileId}`} className="block">
            <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <div className="flex flex-wrap items-center gap-2">
                <StatusBadge label={getEnumLabel(lang, "email", "dead_letter")} tone="warning" />
                <p className="text-sm font-medium text-[var(--color-ink-strong)]">
                  {getNotificationTemplateLabel(lang, job.title)}
                </p>
              </div>
              <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                {getNotificationTemplateLabel(lang, job.eventKey)} • {job.attemptCount}/{job.maxAttempts}
              </p>
              {job.lastErrorCode || job.lastErrorMessage ? (
                <p className="mt-2 text-xs text-[var(--color-red-700)]">
                  {getAuditHealthErrorLabel(lang, job.lastErrorCode, job.lastErrorMessage)}
                </p>
              ) : null}
            </div>
          </Link>
        ))}

        <div className="flex items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
          <p className="text-sm text-[var(--color-ink-muted)]">
            {page} {snapshot.page} / {totalPages} • {total} {totalLabel}
          </p>
          <div className="flex gap-2">
            {snapshot.page > 1 ? (
              <Link className="button-secondary" href={buildPageHref(lang, snapshot.page - 1)}>
                {previous}
              </Link>
            ) : null}
            {snapshot.page < totalPages ? (
              <Link className="button-secondary" href={buildPageHref(lang, snapshot.page + 1)}>
                {next}
              </Link>
            ) : null}
          </div>
        </div>
      </section>
    </div>
  );
}
