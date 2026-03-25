import Link from "next/link";

import { ExceptionAlerts } from "@/components/dashboard/exception-alerts";
import { QueueMetricStrip } from "@/components/dashboard/queue-metric-strip";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatQueueAge } from "@/lib/formatting/formatters";
import { getDocumentLabel } from "@/lib/i18n/admin-ui";
import { getDictionary } from "@/lib/i18n/dictionaries";
import {
  buildDashboardAlerts,
  fetchAdminOperationalSummary,
  fetchDashboardQueuePreviews,
} from "@/lib/queries/admin-dashboard";

export default async function DashboardPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang: locale } = await params;
  const dictionary = await getDictionary(locale as "ar" | "fr" | "en");
  const [summary, previews] = await Promise.all([
    fetchAdminOperationalSummary(),
    fetchDashboardQueuePreviews(),
  ]);
  const alerts = buildDashboardAlerts(summary, dictionary.dashboard.alerts);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{dictionary.dashboard.eyebrow}</p>
        <div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
          <div className="space-y-2">
            <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{dictionary.dashboard.title}</h1>
            <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{dictionary.dashboard.body}</p>
          </div>
          <StatusBadge label={`${alerts.length} ${dictionary.common.activeAlerts}`} tone={alerts.length > 0 ? "warning" : "success"} />
        </div>
      </section>

      <QueueMetricStrip
        queueLabel={dictionary.common.queue}
        items={[
          { label: dictionary.dashboard.metrics.paymentProofs, value: String(summary.paymentProofs), href: `/${locale}/payments`, tone: summary.paymentProofs > 0 ? "warning" : "success" },
          { label: dictionary.dashboard.metrics.verificationPackets, value: String(summary.verificationPackets), href: `/${locale}/verification`, tone: summary.verificationPackets > 0 ? "warning" : "success" },
          { label: dictionary.dashboard.metrics.openDisputes, value: String(summary.disputes), href: `/${locale}/disputes`, tone: summary.disputes > 0 ? "warning" : "success" },
          { label: dictionary.dashboard.metrics.eligiblePayouts, value: String(summary.eligiblePayouts), href: `/${locale}/payouts`, tone: summary.eligiblePayouts > 0 ? "warning" : "success" },
          { label: dictionary.dashboard.metrics.supportNeedsReply, value: String(summary.supportNeedsReply), href: `/${locale}/support`, tone: summary.supportNeedsReply > 0 ? "warning" : "success" },
        ]}
      />

      <ExceptionAlerts
        alerts={alerts}
        clearLabel={dictionary.common.clear}
        noExceptionsBody={dictionary.dashboard.noExceptions}
        urgentLabel={dictionary.common.urgent}
        watchLabel={dictionary.common.watch}
      />

      <section className="grid gap-4 xl:grid-cols-2">
        <PreviewPanel
          eyebrow={dictionary.dashboard.previews.paymentsEyebrow}
          title={dictionary.dashboard.previews.paymentsTitle}
          href={`/${locale}/payments`}
          openQueueLabel={dictionary.common.openQueue}
          emptyBody={dictionary.common.emptyQueue}
          rows={previews.payments.map((item) => ({
            title: item.trackingNumber,
            detail: `${item.paymentRail.toUpperCase()} • ${formatCurrencyDzd(item.submittedAmountDzd, locale)}`,
            meta: formatQueueAge(item.ageHours, locale),
          }))}
        />
        <PreviewPanel
          eyebrow={dictionary.dashboard.previews.verificationEyebrow}
          title={dictionary.dashboard.previews.verificationTitle}
          href={`/${locale}/verification`}
          openQueueLabel={dictionary.common.openQueue}
          emptyBody={dictionary.common.emptyQueue}
          rows={previews.verification.map((item) => ({
            title: item.displayName,
            detail: `${item.pendingDocumentCount} ${dictionary.dashboard.pendingDocuments} • ${item.vehicleCount} ${dictionary.dashboard.vehicles}`,
            meta: item.profileMissingDocuments[0]
              ? getDocumentLabel(locale, item.profileMissingDocuments[0])
              : dictionary.dashboard.readyForReview,
          }))}
        />
        <PreviewPanel
          eyebrow={dictionary.dashboard.previews.supportEyebrow}
          title={dictionary.dashboard.previews.supportTitle}
          href={`/${locale}/support`}
          openQueueLabel={dictionary.common.openQueue}
          emptyBody={dictionary.common.emptyQueue}
          rows={previews.support.map((item) => ({
            title: item.subject,
            detail: item.hasUnreadForAdmin ? dictionary.common.new : dictionary.common.seen,
            meta: formatCompactReference(item.id),
          }))}
        />
        <PreviewPanel
          eyebrow={dictionary.dashboard.previews.payoutsEyebrow}
          title={dictionary.dashboard.previews.payoutsTitle}
          href={`/${locale}/payouts`}
          openQueueLabel={dictionary.common.openQueue}
          emptyBody={dictionary.common.emptyQueue}
          rows={previews.payouts.map((item) => ({
            title: item.trackingNumber,
            detail: item.carrierName,
            meta: formatCurrencyDzd(item.carrierPayoutDzd, locale),
          }))}
        />
      </section>
    </div>
  );
}

function PreviewPanel({
  eyebrow,
  title,
  href,
  rows,
  openQueueLabel,
  emptyBody,
}: {
  eyebrow: string;
  title: string;
  href: string;
  rows: Array<{ title: string; detail: string; meta: string }>;
  openQueueLabel: string;
  emptyBody: string;
}) {
  return (
    <section className="panel space-y-4 p-5">
      <div className="flex items-center justify-between gap-3">
        <div>
          <p className="eyebrow">{eyebrow}</p>
          <h2 className="mt-2 text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h2>
        </div>
        <Link href={href} className="text-sm font-medium text-[var(--color-accent-ink)] underline-offset-4 hover:underline">
          {openQueueLabel}
        </Link>
      </div>
      <div className="space-y-3">
        {rows.length === 0 ? (
          <p className="text-sm text-[var(--color-ink-muted)]">{emptyBody}</p>
        ) : (
          rows.map((row) => (
            <div key={`${row.title}-${row.meta}`} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 px-4 py-3">
              <div className="flex items-start justify-between gap-3">
                <div className="space-y-1">
                  <p className="font-medium text-[var(--color-ink-strong)]">{row.title}</p>
                  <p className="text-sm text-[var(--color-ink-muted)]">{row.detail}</p>
                </div>
                <StatusBadge label={row.meta} tone="neutral" />
              </div>
            </div>
          ))
        )}
      </div>
    </section>
  );
}
