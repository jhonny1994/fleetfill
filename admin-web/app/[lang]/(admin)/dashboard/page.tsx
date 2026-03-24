import Link from "next/link";

import { ExceptionAlerts } from "@/components/dashboard/exception-alerts";
import { QueueMetricStrip } from "@/components/dashboard/queue-metric-strip";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatCompactReference, formatCurrencyDzd, formatQueueAge } from "@/lib/formatting/formatters";
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
  const [summary, previews] = await Promise.all([
    fetchAdminOperationalSummary(),
    fetchDashboardQueuePreviews(),
  ]);
  const alerts = buildDashboardAlerts(summary);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Control tower</p>
        <div className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
          <div className="space-y-2">
            <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">The FleetFill operations desk starts here.</h1>
            <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
              This is the queue-first snapshot for payment review, verification packets, disputes,
              payouts, support, and operational health. It should always answer what needs action now.
            </p>
          </div>
          <StatusBadge label={`${alerts.length} active alerts`} tone={alerts.length > 0 ? "warning" : "success"} />
        </div>
      </section>

      <QueueMetricStrip
        items={[
          { label: "Payment proofs", value: String(summary.paymentProofs), href: `/${locale}/payments`, tone: summary.paymentProofs > 0 ? "warning" : "success" },
          { label: "Verification packets", value: String(summary.verificationPackets), href: `/${locale}/verification`, tone: summary.verificationPackets > 0 ? "warning" : "success" },
          { label: "Open disputes", value: String(summary.disputes), href: `/${locale}/disputes`, tone: summary.disputes > 0 ? "warning" : "success" },
          { label: "Eligible payouts", value: String(summary.eligiblePayouts), href: `/${locale}/payouts`, tone: summary.eligiblePayouts > 0 ? "warning" : "success" },
          { label: "Support needs reply", value: String(summary.supportNeedsReply), href: `/${locale}/support`, tone: summary.supportNeedsReply > 0 ? "warning" : "success" },
        ]}
      />

      <ExceptionAlerts alerts={alerts} />

      <section className="grid gap-4 xl:grid-cols-2">
        <PreviewPanel
          eyebrow="Payments"
          title="Oldest pending proofs"
          href={`/${locale}/payments`}
          rows={previews.payments.map((item) => ({
            title: item.trackingNumber,
            detail: `${item.paymentRail.toUpperCase()} • ${formatCurrencyDzd(item.submittedAmountDzd)}`,
            meta: formatQueueAge(item.ageHours),
          }))}
        />
        <PreviewPanel
          eyebrow="Verification"
          title="Packets waiting on review"
          href={`/${locale}/verification`}
          rows={previews.verification.map((item) => ({
            title: item.displayName,
            detail: `${item.pendingDocumentCount} pending • ${item.vehicleCount} vehicles`,
            meta: item.profileMissingDocuments[0] ?? "Ready for review",
          }))}
        />
        <PreviewPanel
          eyebrow="Support"
          title="Latest user follow-ups"
          href={`/${locale}/support`}
          rows={previews.support.map((item) => ({
            title: item.subject,
            detail: item.hasUnreadForAdmin ? "New" : "Seen",
            meta: formatCompactReference(item.id),
          }))}
        />
        <PreviewPanel
          eyebrow="Payouts"
          title="Bookings ready for release"
          href={`/${locale}/payouts`}
          rows={previews.payouts.map((item) => ({
            title: item.trackingNumber,
            detail: item.carrierName,
            meta: formatCurrencyDzd(item.carrierPayoutDzd),
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
}: {
  eyebrow: string;
  title: string;
  href: string;
  rows: Array<{ title: string; detail: string; meta: string }>;
}) {
  return (
    <section className="panel space-y-4 p-5">
      <div className="flex items-center justify-between gap-3">
        <div>
          <p className="eyebrow">{eyebrow}</p>
          <h2 className="mt-2 text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h2>
        </div>
        <Link href={href} className="text-sm font-medium text-[var(--color-accent-ink)] underline-offset-4 hover:underline">
          Open queue
        </Link>
      </div>
      <div className="space-y-3">
        {rows.length === 0 ? (
          <p className="text-sm text-[var(--color-ink-muted)]">Nothing waiting in this queue right now.</p>
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
