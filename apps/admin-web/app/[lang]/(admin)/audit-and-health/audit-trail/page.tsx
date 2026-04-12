import { getMessages } from "next-intl/server";
import Link from "next/link";

import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminActionLabel, getAuditOutcomeLabel, getAuditTargetTypeLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchAdminAuditTrailPage } from "@/lib/queries/admin-audit-health";

function buildPageHref(lang: string, page: number) {
  return `/${lang}/audit-and-health/audit-trail?page=${page}`;
}

export default async function AdminAuditTrailPage({
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
  const snapshot = await fetchAdminAuditTrailPage(currentPage);
  const totalPages = Math.max(1, Math.ceil(snapshot.total / snapshot.pageSize));
  const { backToSummary, previous, next, page, total } = ui.pages.audit;

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.audit.eyebrow}</p>
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div className="space-y-2">
            <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.audit.auditTrail}</h1>
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.pages.audit.auditTrailBody}</p>
          </div>
          <Link className="button-secondary" href={`/${lang}/audit-and-health`}>
            {backToSummary}
          </Link>
        </div>
      </section>

      <section className="panel space-y-4 p-6">
        {snapshot.items.map((log) => (
          <div key={log.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <div className="flex flex-wrap items-center gap-2">
              <StatusBadge label={getAdminActionLabel(lang, log.action)} tone="neutral" />
              <StatusBadge
                label={getAuditOutcomeLabel(lang, log.outcome)}
                tone={log.outcome === "success" ? "success" : "danger"}
              />
            </div>
            <p className="mt-2 text-sm text-[var(--color-ink-strong)]">
              {getAuditTargetTypeLabel(lang, log.targetType)}
              {log.targetId ? ` • ${log.targetId}` : ""}
            </p>
            <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
              {log.reason ?? ui.labels.noReasonProvided} • {formatDateTime(log.createdAt)}
            </p>
          </div>
        ))}

        <div className="flex items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
          <p className="text-sm text-[var(--color-ink-muted)]">
            {page} {snapshot.page} / {totalPages} • {snapshot.total} {total}
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
