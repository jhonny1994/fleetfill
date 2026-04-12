import { getMessages } from "next-intl/server";
import Link from "next/link";

import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { UserActivationActions } from "@/components/users/user-activation-actions";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminActionLabel, getAdminDetailCopy, getAuditOutcomeLabel, getDocumentLabel, getEnumLabel, getUserVerificationLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchUserDetail } from "@/lib/queries/admin-users";

export default async function UserDetailPage({
  params,
}: {
  params: Promise<{ lang: string; userId: string }>;
}) {
  const { lang, userId } = await params;
  const locale = resolveAppLocale(lang);
  const detail = await fetchUserDetail(userId);
  const { ui } = asAdminMessages(await getMessages({ locale }));
  const detailCopy = getAdminDetailCopy(locale);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.users.notFound}</div>;
  }

  const displayName = detail.profile.companyName?.trim() || detail.profile.fullName?.trim() || detail.profile.email;
  const isCarrier = detail.profile.role === "carrier";
  const isShipper = detail.profile.role === "shipper";

  return (
    <DetailWorkspace
      eyebrow={ui.pages.users.eyebrow}
      title={displayName}
      description={detailCopy.users.description}
      backLink={{ href: `/${locale}/users`, label: ui.pages.users.title }}
      relatedLinks={[
        { href: `/${locale}/users?q=${encodeURIComponent(detail.profile.id)}`, label: ui.pages.users.title },
        ...(isShipper ? [{ href: `/${locale}/shipments?q=${encodeURIComponent(detail.profile.id)}`, label: detailCopy.users.recentShipments }] : []),
        { href: `/${locale}/bookings?q=${encodeURIComponent(detail.profile.id)}`, label: detailCopy.users.recentBookings },
      ]}
      facts={[
        { label: ui.labels.role, value: getEnumLabel(lang, "userRoles", detail.profile.role) },
        { label: ui.labels.accountState, value: getEnumLabel(lang, "activity", detail.profile.isActive ? "active" : "suspended") },
        { label: ui.labels.preferredLocale, value: getEnumLabel(lang, "locale", detail.profile.preferredLocale) },
        ...(detail.profile.role === "carrier"
          ? [{ label: ui.labels.verification, value: getUserVerificationLabel(lang, detail.profile.role, detail.profile.verificationStatus) }]
          : []),
      ]}
      main={
        <>
          <section className="panel space-y-4 p-5">
            <div className="space-y-2">
              <h2 className="text-[1.1rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.profileAndVerification}</h2>
              <p className="text-sm text-[var(--color-ink-muted)]">
                {detail.profile.email}
                {detail.profile.phoneNumber ? ` • ${detail.profile.phoneNumber}` : ""}
              </p>
            </div>
            <div className="flex flex-wrap items-center gap-2">
              <StatusBadge label={getEnumLabel(lang, "userRoles", detail.profile.role)} tone="neutral" />
              <StatusBadge label={getEnumLabel(lang, "activity", detail.profile.isActive ? "active" : "suspended")} tone={detail.profile.isActive ? "success" : "danger"} />
              {detail.profile.role === "carrier" ? (
                <StatusBadge
                  label={getUserVerificationLabel(lang, detail.profile.role, detail.profile.verificationStatus)}
                  tone={
                    detail.profile.verificationStatus === "verified"
                      ? "success"
                      : detail.profile.verificationStatus === "rejected"
                        ? "danger"
                        : "warning"
                  }
                />
              ) : null}
            </div>
            {detail.profile.role === "carrier" && detail.profile.verificationRejectionReason ? (
              <p className="rounded-[14px] border border-[var(--color-red-100)] bg-[var(--color-red-100)] px-4 py-3 text-sm text-[var(--color-red-700)]">
                {detail.profile.verificationRejectionReason}
              </p>
            ) : null}
            <div className="meta-grid">
              {isCarrier ? (
                <div className="meta-card">
                  <p className="meta-card-label">{detailCopy.users.vehicles}</p>
                  <p className="meta-card-value">{detail.vehicles.length}</p>
                </div>
              ) : null}
              {isShipper ? (
                <div className="meta-card">
                  <p className="meta-card-label">{detailCopy.users.recentShipments}</p>
                  <p className="meta-card-value">{detail.shipments.length}</p>
                </div>
              ) : null}
              <div className="meta-card">
                <p className="meta-card-label">{detailCopy.users.recentBookings}</p>
                <p className="meta-card-value">{detail.bookings.length}</p>
              </div>
              <div className="meta-card">
                <p className="meta-card-label">{detailCopy.users.supportThreads}</p>
                <p className="meta-card-value">{detail.supportRequests.length}</p>
              </div>
              {isCarrier ? (
                <div className="meta-card">
                  <p className="meta-card-label">{detailCopy.users.payoutAccounts}</p>
                  <p className="meta-card-value">{detail.payoutAccounts.length}</p>
                </div>
              ) : null}
            </div>
          </section>

          {isCarrier ? (
            <section className="grid gap-4 xl:grid-cols-2">
              <section className="panel space-y-3 p-5">
                <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.vehicles}</h2>
                <div className="space-y-3">
                {detail.vehicles.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noVehicles}</p>
                ) : (
                    detail.vehicles.slice(0, 3).map((vehicle) => (
                      <div key={vehicle.id} className="section-card p-3.5">
                        <p className="font-medium text-[var(--color-ink-strong)]">{vehicle.label}</p>
                        <div className="mt-2">
                          <StatusBadge
                            label={getEnumLabel(lang, "verification", vehicle.verificationStatus)}
                            tone={
                              vehicle.verificationStatus === "verified"
                                ? "success"
                                : vehicle.verificationStatus === "rejected"
                                  ? "danger"
                                  : "warning"
                            }
                          />
                        </div>
                      </div>
                    ))
                  )}
                  {detail.vehicles.length > 3 ? <p className="text-xs text-[var(--color-ink-muted)]">+{detail.vehicles.length - 3}</p> : null}
                </div>
              </section>

              <section className="panel space-y-3 p-5">
                <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.payoutAccounts}</h2>
                <div className="space-y-3">
                {detail.payoutAccounts.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noPayoutAccounts}</p>
                ) : (
                    detail.payoutAccounts.slice(0, 3).map((account) => (
                      <div key={account.id} className="section-card p-3.5">
                        <p className="font-medium text-[var(--color-ink-strong)]">
                          {account.accountType.toUpperCase()} • {account.identifier}
                        </p>
                        <p className="mt-1 text-xs text-[var(--color-ink-muted)]">{account.institutionName ?? ui.labels.noInstitution}</p>
                        <div className="mt-2 flex gap-2">
                          <StatusBadge label={getEnumLabel(lang, "activity", account.isActive ? "active" : "inactive")} tone={account.isActive ? "success" : "danger"} />
                          <StatusBadge label={account.isVerified ? getEnumLabel(lang, "verification", "verified") : getEnumLabel(lang, "verification", "pending")} tone={account.isVerified ? "success" : "warning"} />
                        </div>
                      </div>
                    ))
                  )}
                  {detail.payoutAccounts.length > 3 ? <p className="text-xs text-[var(--color-ink-muted)]">+{detail.payoutAccounts.length - 3}</p> : null}
                </div>
              </section>
            </section>
          ) : null}

          <section className="grid gap-4 xl:grid-cols-2">
            {isShipper ? (
              <section className="panel space-y-3 p-5">
                <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.recentShipments}</h2>
                <div className="space-y-3">
                {detail.shipments.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noShipments}</p>
                ) : (
                    detail.shipments.slice(0, 3).map((shipment) => (
                      <div key={shipment.id} className="section-card p-3.5">
                        <Link href={buildAdminRoute(lang, "shipment", shipment.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                          {shipment.description?.trim() || shipment.id}
                        </Link>
                        <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                          {shipment.originLabel} {"->"} {shipment.destinationLabel}
                        </p>
                        <div className="mt-2 flex items-center gap-2">
                          <StatusBadge label={getEnumLabel(lang, "shipment", shipment.status)} tone="neutral" />
                          <span className="text-xs text-[var(--color-ink-muted)]">{shipment.totalWeightKg} kg</span>
                        </div>
                      </div>
                    ))
                  )}
                  {detail.shipments.length > 3 ? (
                    <Link href={`/${locale}/shipments?q=${encodeURIComponent(detail.profile.id)}`} className="inline-flex text-sm font-medium text-[var(--color-accent)] underline-offset-4 hover:underline">
                      {ui.pages.audit.viewAll}
                    </Link>
                  ) : null}
                </div>
              </section>
            ) : null}

            <section className="panel space-y-3 p-5">
              <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.recentBookings}</h2>
              <div className="space-y-3">
                {detail.bookings.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noBookings}</p>
                ) : (
                  detail.bookings.slice(0, 3).map((booking) => (
                    <div key={booking.id} className="section-card p-3.5">
                      <Link href={buildAdminRoute(lang, "booking", booking.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                        {booking.trackingNumber}
                      </Link>
                      <div className="mt-2 flex flex-wrap items-center gap-2">
                        <StatusBadge label={getEnumLabel(lang, "booking", booking.bookingStatus)} tone="neutral" />
                        <StatusBadge label={getEnumLabel(lang, "payment", booking.paymentStatus)} tone={booking.paymentStatus === "secured" ? "success" : "warning"} />
                      </div>
                    </div>
                    ))
                  )}
                  {detail.bookings.length > 3 ? (
                    <Link href={`/${locale}/bookings?q=${encodeURIComponent(detail.profile.id)}`} className="inline-flex text-sm font-medium text-[var(--color-accent)] underline-offset-4 hover:underline">
                      {ui.pages.audit.viewAll}
                    </Link>
                  ) : null}
              </div>
            </section>
          </section>

          <section className="grid gap-4 xl:grid-cols-2">
            <section className="panel space-y-3 p-5">
              <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.supportThreads}</h2>
              <div className="space-y-3">
                {detail.supportRequests.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noSupportThreads}</p>
                ) : (
                  detail.supportRequests.slice(0, 3).map((request) => (
                    <div key={request.id} className="section-card p-3.5">
                      <Link href={buildAdminRoute(lang, "support", request.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                        {request.subject}
                      </Link>
                      <p className="mt-1 text-xs text-[var(--color-ink-muted)]">{formatDateTime(request.lastMessageAt)}</p>
                    </div>
                  ))
                )}
              </div>
            </section>

            <section className="panel space-y-3 p-5">
              <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{detailCopy.users.verificationDocuments}</h2>
              <div className="space-y-3">
                {detail.documents.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">{detailCopy.users.noVerificationDocuments}</p>
                ) : (
                  detail.documents.slice(0, 4).map((document) => (
                    <div key={document.id} className="section-card p-3.5">
                      <p className="font-medium text-[var(--color-ink-strong)]">{getDocumentLabel(lang, document.documentType)}</p>
                      <div className="mt-2 flex gap-2">
                        <StatusBadge label={getEnumLabel(lang, "entity", document.entityType)} tone="neutral" />
                        <StatusBadge
                          label={getEnumLabel(lang, "verification", document.status)}
                          tone={
                            document.status === "verified" ? "success" : document.status === "rejected" ? "danger" : "warning"
                          }
                        />
                      </div>
                    </div>
                  ))
                )}
              </div>
            </section>
          </section>

          <TimelinePanel
            title={ui.labels.timeline}
            currentLabel={ui.labels.current}
            emptyLabel={ui.labels.noTimeline}
            items={detail.auditLogs.map((log) => ({
              id: log.id,
              title: getAdminActionLabel(locale, log.action),
              detail: log.reason ?? getAuditOutcomeLabel(locale, log.outcome),
              at: formatDateTime(log.createdAt),
            }))}
          />
        </>
      }
      rail={
        <ActionRail
          title={detailCopy.users.controls}
        >
          <UserActivationActions profileId={detail.profile.id} isActive={detail.profile.isActive} />
        </ActionRail>
      }
    />
  );
}
