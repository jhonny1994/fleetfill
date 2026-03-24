import { ActionRail } from "@/components/detail/action-rail";
import { DetailWorkspace } from "@/components/detail/detail-workspace";
import { TimelinePanel } from "@/components/detail/timeline-panel";
import { AdminAccountActions } from "@/components/admin-management/admin-account-actions";
import { AdminInvitationActions } from "@/components/admin-management/admin-invitation-actions";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchAdminAccountDetail } from "@/lib/queries/admin-admins";

export default async function AdminDetailPage({
  params,
}: {
  params: Promise<{ profileId: string }>;
}) {
  const { profileId } = await params;
  const detail = await fetchAdminAccountDetail(profileId);

  if (!detail) {
    return <div className="panel p-6 text-sm text-[var(--color-ink-muted)]">Admin account not found.</div>;
  }

  return (
    <DetailWorkspace
      eyebrow="Admins"
      title={detail.account.displayName}
      description="Admin governance detail, invitation history, and role or activation changes protected by the backend governance rules."
      facts={[
        { label: "Role", value: detail.account.adminRole },
        { label: "State", value: detail.account.isActive ? "Active" : "Inactive" },
        { label: "Email", value: detail.account.email },
        { label: "Updated", value: formatDateTime(detail.account.updatedAt) },
      ]}
      main={
        <>
          <section className="panel space-y-3 p-6">
            <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">Invitation history</h2>
            <div className="space-y-3">
              {detail.invitations.length === 0 ? (
                <p className="text-sm text-[var(--color-ink-muted)]">No invitations recorded for this admin.</p>
              ) : (
                detail.invitations.map((invitation) => (
                  <div key={invitation.id} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
                    <p className="font-medium text-[var(--color-ink-strong)]">{invitation.email}</p>
                    <p className="mt-1 text-xs text-[var(--color-ink-muted)]">
                      {invitation.role} • {invitation.status} • expires {formatDateTime(invitation.expiresAt)}
                    </p>
                    <div className="mt-3">
                      <AdminInvitationActions invitationId={invitation.id} status={invitation.status} />
                    </div>
                  </div>
                ))
              )}
            </div>
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
        <ActionRail title="Governance actions" description="These changes are restricted to super admins and protected against orphaning the last super admin.">
          <AdminAccountActions
            profileId={detail.account.profileId}
            currentRole={detail.account.adminRole}
            isActive={detail.account.isActive}
          />
        </ActionRail>
      }
    />
  );
}
