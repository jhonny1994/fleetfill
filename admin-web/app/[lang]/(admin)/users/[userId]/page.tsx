import Link from "next/link";

import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { StatusBadge } from "@/components/shared/status-badge";
import { UserActivationActions } from "@/components/users/user-activation-actions";
import { buildAdminRoute } from "@/lib/admin-routes";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchUserDetail } from "@/lib/queries/admin-users";

export default async function UserDetailPage({
  params,
}: {
  params: Promise<{ lang: string; userId: string }>;
}) {
  const { lang, userId } = await params;
  const detail = await fetchUserDetail(userId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">User detail not found.</div>;
  }

  const displayName = detail.profile.companyName?.trim() || detail.profile.fullName?.trim() || detail.profile.email;

  return (
    <DetailWorkspace
      eyebrow="Users"
      title={displayName}
      description="Operational user context, verification artifacts, recent bookings, and controlled account lifecycle actions."
      facts={[
        { label: "Role", value: detail.profile.role },
        { label: "Account state", value: detail.profile.isActive ? "Active" : "Suspended" },
        { label: "Verification", value: detail.profile.verificationStatus },
        { label: "Preferred locale", value: detail.profile.preferredLocale.toUpperCase() },
      ]}
      main={
        <>
          <section className="panel space-y-4 p-6">
            <div className="space-y-2">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Profile and verification</h2>
              <p className="text-sm text-[var(--color-ink-muted)]">
                {detail.profile.email}
                {detail.profile.phoneNumber ? ` • ${detail.profile.phoneNumber}` : ""}
              </p>
            </div>
            <div className="flex flex-wrap items-center gap-2">
              <StatusBadge label={detail.profile.role} tone="neutral" />
              <StatusBadge label={detail.profile.isActive ? "Active" : "Suspended"} tone={detail.profile.isActive ? "success" : "danger"} />
              <StatusBadge
                label={detail.profile.verificationStatus}
                tone={
                  detail.profile.verificationStatus === "verified"
                    ? "success"
                    : detail.profile.verificationStatus === "rejected"
                      ? "danger"
                      : "warning"
                }
              />
            </div>
            {detail.profile.verificationRejectionReason ? (
              <p className="rounded-2xl border border-[var(--color-red-100)] bg-[var(--color-red-100)] px-4 py-3 text-sm text-[var(--color-red-700)]">
                {detail.profile.verificationRejectionReason}
              </p>
            ) : null}
          </section>

          <section className="grid gap-4 xl:grid-cols-2">
            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Vehicles</h2>
              <div className="space-y-3">
                {detail.vehicles.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No vehicles linked to this user.</p>
                ) : (
                  detail.vehicles.map((vehicle) => (
                    <div key={vehicle.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <p className="font-medium text-[var(--color-ink-strong)]">{vehicle.label}</p>
                      <div className="mt-2">
                        <StatusBadge
                          label={vehicle.verificationStatus}
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
              </div>
            </section>

            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Payout accounts</h2>
              <div className="space-y-3">
                {detail.payoutAccounts.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No payout accounts on file.</p>
                ) : (
                  detail.payoutAccounts.map((account) => (
                    <div key={account.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <p className="font-medium text-[var(--color-ink-strong)]">
                        {account.accountType.toUpperCase()} • {account.identifier}
                      </p>
                      <p className="mt-1 text-xs text-[var(--color-ink-muted)]">{account.institutionName ?? "No institution name"}</p>
                      <div className="mt-2 flex gap-2">
                        <StatusBadge label={account.isActive ? "Active" : "Inactive"} tone={account.isActive ? "success" : "danger"} />
                        <StatusBadge label={account.isVerified ? "Verified" : "Unverified"} tone={account.isVerified ? "success" : "warning"} />
                      </div>
                    </div>
                  ))
                )}
              </div>
            </section>
          </section>

          <section className="grid gap-4 xl:grid-cols-2">
            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Recent shipments</h2>
              <div className="space-y-3">
                {detail.shipments.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No shipments created by this user.</p>
                ) : (
                  detail.shipments.map((shipment) => (
                    <div key={shipment.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <Link href={buildAdminRoute(lang, "shipment", shipment.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                        {shipment.description?.trim() || shipment.id}
                      </Link>
                      <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                        {shipment.originLabel} {"->"} {shipment.destinationLabel}
                      </p>
                      <div className="mt-2 flex items-center gap-2">
                        <StatusBadge label={shipment.status} tone="neutral" />
                        <span className="text-xs text-[var(--color-ink-muted)]">{shipment.totalWeightKg} kg</span>
                      </div>
                    </div>
                  ))
                )}
              </div>
            </section>

            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Recent bookings</h2>
              <div className="space-y-3">
                {detail.bookings.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No bookings linked to this user.</p>
                ) : (
                  detail.bookings.map((booking) => (
                    <div key={booking.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <Link href={buildAdminRoute(lang, "booking", booking.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                        {booking.trackingNumber}
                      </Link>
                      <div className="mt-2 flex flex-wrap items-center gap-2">
                        <StatusBadge label={booking.bookingStatus} tone="neutral" />
                        <StatusBadge label={booking.paymentStatus} tone={booking.paymentStatus === "secured" ? "success" : "warning"} />
                      </div>
                    </div>
                  ))
                )}
              </div>
            </section>
          </section>

          <section className="grid gap-4 xl:grid-cols-2">
            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Support threads</h2>
              <div className="space-y-3">
                {detail.supportRequests.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No support threads for this user.</p>
                ) : (
                  detail.supportRequests.map((request) => (
                    <div key={request.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <Link href={buildAdminRoute(lang, "support", request.id)} className="font-medium text-[var(--color-ink-strong)] underline-offset-4 hover:underline">
                        {request.subject}
                      </Link>
                      <p className="mt-1 text-xs text-[var(--color-ink-muted)]">{formatDateTime(request.lastMessageAt)}</p>
                    </div>
                  ))
                )}
              </div>
            </section>

            <section className="panel space-y-3 p-6">
              <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Verification documents</h2>
              <div className="space-y-3">
                {detail.documents.length === 0 ? (
                  <p className="text-sm text-[var(--color-ink-muted)]">No verification documents for this user.</p>
                ) : (
                  detail.documents.map((document) => (
                    <div key={document.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                      <p className="font-medium text-[var(--color-ink-strong)]">{document.documentType}</p>
                      <div className="mt-2 flex gap-2">
                        <StatusBadge label={document.entityType} tone="neutral" />
                        <StatusBadge
                          label={document.status}
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
            items={detail.auditLogs.map((log) => ({
              id: log.id,
              title: log.action,
              detail: log.reason ?? log.outcome,
              at: formatDateTime(log.createdAt),
            }))}
          />
        </>
      }
      rail={
        <ActionRail
          title="Account controls"
          description="Account lifecycle actions go through the same audited admin RPCs as the existing platform."
        >
          <UserActivationActions profileId={detail.profile.id} isActive={detail.profile.isActive} />
        </ActionRail>
      }
    />
  );
}
