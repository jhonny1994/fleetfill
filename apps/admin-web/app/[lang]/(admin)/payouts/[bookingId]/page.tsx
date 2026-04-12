import { getMessages } from "next-intl/server";
import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { PayoutReleaseActions } from "@/components/detail/payout-release-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCompactReference, formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import {
  formatTemplate,
  getAdminDetailCopy,
  getEnumLabel,
  getPayoutRequestBlockedReasonLabel,
  getPayoutRequestLabel,
} from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchPayoutDetail } from "@/lib/queries/admin-payouts";

export default async function PayoutDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchPayoutDetail(bookingId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.payouts.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={ui.pages.payouts.eyebrow}
      title={formatTemplate(detailCopy.payouts.title, { trackingNumber: detail.booking.tracking_number })}
      description={detailCopy.payouts.description}
      facts={[
        { label: ui.labels.booking, value: detail.booking.tracking_number },
        { label: ui.labels.carrier, value: detail.carrierName },
        { label: ui.labels.amount, value: formatCurrencyDzd(Number(detail.booking.carrier_payout_dzd)) },
        { label: detailCopy.payouts.payoutState, value: detail.existingPayout ? getEnumLabel(locale, "payout", detail.existingPayout.status) : detailCopy.payouts.notReleased },
      ]}
      main={
        <>
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{ui.pages.payouts.account}</h2>
            {detail.activePayoutAccount ? (
              <div className="space-y-2 text-sm text-[var(--color-ink-base)]">
                <p>{detail.activePayoutAccount.account_type.toUpperCase()}</p>
                <p>{detail.activePayoutAccount.account_holder_name}</p>
                <p>{formatCompactReference(detail.activePayoutAccount.account_identifier)}</p>
                <p>{detail.activePayoutAccount.bank_or_ccp_name ?? ui.labels.noInstitution}</p>
              </div>
            ) : (
              <p className="text-sm text-[var(--color-ink-muted)]">{ui.labels.noActivePayoutAccount}</p>
            )}
            {detail.payoutRequestContext ? (
              <div className="space-y-2 text-sm text-[var(--color-ink-muted)]">
                <p>{getPayoutRequestLabel(locale, detail.payoutRequestContext.requestStatus)}</p>
                {detail.payoutRequestContext.requestedAt ? (
                  <p>{formatDateTime(detail.payoutRequestContext.requestedAt)}</p>
                ) : null}
                {detail.payoutRequestContext.blockedReason ? (
                  <p>{getPayoutRequestBlockedReasonLabel(locale, detail.payoutRequestContext.blockedReason)}</p>
                ) : null}
              </div>
            ) : null}
          </section>
          <TimelinePanel
            title={ui.labels.timeline}
            currentLabel={ui.labels.current}
            emptyLabel={ui.labels.noTimeline}
            items={
              detail.existingPayout
                ? [
                    {
                      id: detail.existingPayout.id,
                      title: formatTemplate(detailCopy.payouts.payoutEntry, { state: getEnumLabel(locale, "payout", detail.existingPayout.status) }),
                      detail: detail.existingPayout.external_reference ?? ui.labels.noExternalReference,
                      at: formatDateTime(detail.existingPayout.processed_at),
                    },
                  ]
                : []
            }
          />
        </>
      }
      rail={
        <ActionRail title={ui.pages.payouts.actions} description={ui.pages.payouts.title}>
          <PayoutReleaseActions bookingId={detail.booking.id} />
        </ActionRail>
      }
    />
  );
}
