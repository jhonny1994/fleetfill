import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { PayoutReleaseActions } from "@/components/detail/payout-release-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCompactReference, formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import {
  formatTemplate,
  getAdminDetailCopy,
  getAdminUi,
  getEnumLabel,
  getPayoutRequestBlockedReasonLabel,
  getPayoutRequestLabel,
} from "@/lib/i18n/admin-ui";
import { fetchPayoutDetail } from "@/lib/queries/admin-payouts";

export default async function PayoutDetailPage({
  params,
}: {
  params: Promise<{ lang: string; bookingId: string }>;
}) {
  const { lang, bookingId } = await params;
  const detail = await fetchPayoutDetail(bookingId);
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);

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
        { label: detailCopy.payouts.payoutState, value: detail.existingPayout ? getEnumLabel(lang, "payout", detail.existingPayout.status) : detailCopy.payouts.notReleased },
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
                <p>{getPayoutRequestLabel(lang, detail.payoutRequestContext.requestStatus)}</p>
                {detail.payoutRequestContext.requestedAt ? (
                  <p>{formatDateTime(detail.payoutRequestContext.requestedAt)}</p>
                ) : null}
                {detail.payoutRequestContext.blockedReason ? (
                  <p>{getPayoutRequestBlockedReasonLabel(lang, detail.payoutRequestContext.blockedReason)}</p>
                ) : null}
              </div>
            ) : null}
          </section>
          <TimelinePanel
            locale={lang}
            items={
              detail.existingPayout
                ? [
                    {
                      id: detail.existingPayout.id,
                      title: formatTemplate(detailCopy.payouts.payoutEntry, { state: getEnumLabel(lang, "payout", detail.existingPayout.status) }),
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
        <ActionRail locale={lang} title={ui.pages.payouts.actions} description={ui.pages.payouts.title}>
          <PayoutReleaseActions locale={lang} bookingId={detail.booking.id} />
        </ActionRail>
      }
    />
  );
}
