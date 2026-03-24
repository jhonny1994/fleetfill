import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { AdminAccountActions } from "@/components/admin-management/admin-account-actions";
import { AdminInvitationActions } from "@/components/admin-management/admin-invitation-actions";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminUi, getAdminRoleLabel, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchAdminAccountDetail } from "@/lib/queries/admin-admins";

export default async function AdminDetailPage({
  params,
}: {
  params: Promise<{ lang: string; profileId: string }>;
}) {
  const { lang, profileId } = await params;
  const ui = getAdminUi(lang);
  const detail = await fetchAdminAccountDetail(profileId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">{ui.pages.admins.notFound}</div>;
  }

  return (
    <DetailWorkspace
      eyebrow={ui.pages.admins.eyebrow}
      title={detail.account.displayName}
      description={detail.account.email}
      facts={[
        { label: ui.labels.role, value: getAdminRoleLabel(lang, detail.account.adminRole) },
        { label: ui.labels.state, value: getEnumLabel(lang, "activity", detail.account.isActive ? "active" : "inactive") },
        { label: ui.labels.updated, value: formatDateTime(detail.account.updatedAt) },
      ]}
      main={
        <>
          <section className="panel space-y-3 p-5">
            <div className="section-header">
              <h2 className="text-[1.2rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.invitations}</h2>
            </div>
            <div className="space-y-3">
              {detail.invitations.length === 0 ? (
                <p className="text-sm text-[var(--color-ink-muted)]">{ui.labels.none}</p>
              ) : (
                detail.invitations.slice(0, 4).map((invitation) => (
                  <div key={invitation.id} className="section-card p-4">
                    <p className="font-medium text-[var(--color-ink-strong)]">{invitation.email}</p>
                    <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                      {getAdminRoleLabel(lang, invitation.role)} • {getEnumLabel(lang, "invitations", invitation.status)} • {formatDateTime(invitation.expiresAt)}
                    </p>
                    <div className="mt-3">
                      <AdminInvitationActions locale={lang} invitationId={invitation.id} status={invitation.status} />
                    </div>
                  </div>
                ))
              )}
            </div>
          </section>
          <TimelinePanel
            locale={lang}
            items={detail.auditLogs.slice(0, 6).map((log) => ({
              id: log.id,
              title: log.action,
              detail: log.reason ?? log.outcome,
              at: formatDateTime(log.createdAt),
            }))}
          />
        </>
      }
      rail={
        <ActionRail locale={lang} title={ui.pages.admins.governanceActions}>
          <AdminAccountActions
            locale={lang}
            profileId={detail.account.profileId}
            currentRole={detail.account.adminRole}
            isActive={detail.account.isActive}
          />
        </ActionRail>
      }
    />
  );
}
