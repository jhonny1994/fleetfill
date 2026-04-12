import { getMessages } from "next-intl/server";
import Link from "next/link";

import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { StatusBadge } from "@/components/shared/status-badge";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminDetailCopy, getEnumLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchShipmentWorkspaceDetail } from "@/lib/queries/admin-operations";

export default async function ShipmentDetailPage({
  params,
}: {
  params: Promise<{ lang: string; shipmentId: string }>;
}) {
  const { lang, shipmentId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchShipmentWorkspaceDetail(shipmentId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{detailCopy.shipments.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={detailCopy.shipments.eyebrow}
      title={detail.shipment.description?.trim() || detail.shipment.id}
      description={detailCopy.shipments.description}
      backLink={{ href: `/${locale}/shipments`, label: detailCopy.shipments.eyebrow }}
      relatedLinks={[
        { href: buildAdminRoute(lang, "user", detail.shipment.shipperId), label: detailCopy.shipments.shipperProfile },
        ...(detail.booking ? [{ href: buildAdminRoute(lang, "booking", detail.booking.id), label: detailCopy.shipments.linkedBooking }] : []),
      ]}
      facts={[
        { label: ui.labels.state, value: getEnumLabel(lang, "shipment", detail.shipment.status) },
        { label: detailCopy.shipments.weightLabel, value: `${detail.shipment.totalWeightKg} kg` },
        { label: detailCopy.shipments.volumeLabel, value: detail.shipment.totalVolumeM3 == null ? "—" : `${detail.shipment.totalVolumeM3} m3` },
        { label: detailCopy.shipments.createdLabel, value: formatDateTime(detail.shipment.createdAt) },
      ]}
      main={
        <section className="panel space-y-4 p-6">
          <div className="space-y-2">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{detailCopy.shipments.routeContext}</h2>
            <p className="text-sm text-[var(--color-ink-muted)]">
              {detail.shipment.originLabel} {"->"} {detail.shipment.destinationLabel}
            </p>
          </div>
          {detail.booking ? (
            <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <p className="font-medium text-[var(--color-ink-strong)]">{detailCopy.shipments.linkedBooking}</p>
              <Link href={buildAdminRoute(lang, "booking", detail.booking.id)} className="mt-2 inline-flex text-sm font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                {detail.booking.trackingNumber}
              </Link>
              <div className="mt-2 flex gap-2">
                <StatusBadge label={getEnumLabel(lang, "booking", detail.booking.bookingStatus)} tone="neutral" />
                <StatusBadge label={getEnumLabel(lang, "payment", detail.booking.paymentStatus)} tone={detail.booking.paymentStatus === "secured" ? "success" : "warning"} />
              </div>
            </div>
          ) : (
            <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.shipments.noBookingYet}</p>
          )}
        </section>
      }
      rail={
        <section className="panel space-y-3 p-6">
          <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{detailCopy.shipments.linkedEntities}</h2>
          <Link className="button-secondary" href={buildAdminRoute(lang, "user", detail.shipment.shipperId)}>
            {detailCopy.shipments.shipperProfile}
          </Link>
        </section>
      }
    />
  );
}
