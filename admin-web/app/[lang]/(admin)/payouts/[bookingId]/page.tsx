import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { PayoutReleaseActions } from "@/components/detail/payout-release-actions";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { formatCompactReference, formatCurrencyDzd, formatDateTime } from "@/lib/formatting/formatters";
import { fetchPayoutDetail } from "@/lib/queries/admin-payouts";

export default async function PayoutDetailPage({
  params,
}: {
  params: Promise<{ bookingId: string }>;
}) {
  const { bookingId } = await params;
  const detail = await fetchPayoutDetail(bookingId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Payout detail not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Payouts"
      title={`Payout release for ${detail.booking.tracking_number}`}
      description="Confirm the carrier payout account and release state before creating the payout record for the booking."
      facts={[
        { label: "Booking", value: detail.booking.tracking_number },
        { label: "Carrier", value: detail.carrierName },
        { label: "Payout amount", value: formatCurrencyDzd(Number(detail.booking.carrier_payout_dzd)) },
        { label: "Current payout", value: detail.existingPayout?.status ?? "Not released" },
      ]}
      main={
        <>
          <section className="panel space-y-4 p-5">
            <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">Active payout account</h2>
            {detail.activePayoutAccount ? (
              <div className="space-y-2 text-sm text-[var(--color-ink-base)]">
                <p>{detail.activePayoutAccount.account_type.toUpperCase()}</p>
                <p>{detail.activePayoutAccount.account_holder_name}</p>
                <p>{formatCompactReference(detail.activePayoutAccount.account_identifier)}</p>
                <p>{detail.activePayoutAccount.bank_or_ccp_name ?? "No institution name"}</p>
              </div>
            ) : (
              <p className="text-sm text-[var(--color-ink-muted)]">No active payout account is available for this carrier.</p>
            )}
          </section>
          <TimelinePanel
            items={
              detail.existingPayout
                ? [
                    {
                      id: detail.existingPayout.id,
                      title: `Payout ${detail.existingPayout.status}`,
                      detail: detail.existingPayout.external_reference ?? "No external reference",
                      at: formatDateTime(detail.existingPayout.processed_at),
                    },
                  ]
                : []
            }
          />
        </>
      }
      rail={
        <ActionRail title="Payout actions" description="Release the payout only after confirming the payout account and booking readiness.">
          <PayoutReleaseActions bookingId={detail.booking.id} />
        </ActionRail>
      }
    />
  );
}
