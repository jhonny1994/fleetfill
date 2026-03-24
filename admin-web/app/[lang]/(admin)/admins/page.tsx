import Link from "next/link";

import { AdminAccountActions } from "@/components/admin-management/admin-account-actions";
import { AdminInvitationActions } from "@/components/admin-management/admin-invitation-actions";
import { AdminInviteForm } from "@/components/admin-management/admin-invite-form";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminUi, getAdminRoleLabel, getEnumLabel } from "@/lib/i18n/admin-ui";
import { fetchAdminAccountsAndInvitations } from "@/lib/queries/admin-admins";

export default async function AdminsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const ui = getAdminUi(lang);
  const { accounts, invitations } = await fetchAdminAccountsAndInvitations();

  return (
    <div className="space-y-4">
      <AdminInviteForm locale={lang} />

      <section className="panel space-y-4 p-6">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.title}</h2>
          <p className="text-sm leading-6 text-[var(--color-ink-muted)]">
            {ui.pages.admins.title}
          </p>
        </div>
        <div className="space-y-4">
          {accounts.map((account) => (
            <div key={account.profileId} className="rounded-[24px] border border-[var(--color-border)] bg-white/55 p-5">
              <div className="flex flex-wrap items-start justify-between gap-4">
                <div className="space-y-2">
                  <Link
                    href={`/${lang}/admins/${account.profileId}`}
                    className="text-lg font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline"
                  >
                    {account.displayName}
                  </Link>
                  <p className="text-sm text-[var(--color-ink-muted)]">{account.email}</p>
                  <div className="flex flex-wrap items-center gap-2">
                    <StatusBadge label={getAdminRoleLabel(lang, account.adminRole)} tone={account.adminRole === "super_admin" ? "warning" : "neutral"} />
                    <StatusBadge label={getEnumLabel(lang, "activity", account.isActive ? "active" : "inactive")} tone={account.isActive ? "success" : "danger"} />
                  </div>
                  <p className="text-xs text-[var(--color-ink-muted)]">
                    {formatTemplate(ui.pages.admins.invitationMeta, {
                      role: account.invitedByName ?? ui.labels.unknown,
                      date: formatDateTime(account.updatedAt),
                    })}
                  </p>
                </div>
                <div className="w-full max-w-md">
                  <AdminAccountActions
                    locale={lang}
                    profileId={account.profileId}
                    currentRole={account.adminRole}
                    isActive={account.isActive}
                  />
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="panel space-y-4 p-6">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-2xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.invitations}</h2>
        </div>
        <div className="space-y-3">
          {invitations.map((invitation) => (
            <div key={invitation.id} className="flex flex-wrap items-center justify-between gap-4 rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
              <div className="space-y-1">
                <p className="font-semibold text-[var(--color-ink-strong)]">{invitation.email}</p>
                <div className="flex flex-wrap items-center gap-2">
                  <StatusBadge label={getAdminRoleLabel(lang, invitation.role)} tone={invitation.role === "super_admin" ? "warning" : "neutral"} />
                  <StatusBadge
                    label={getEnumLabel(lang, "invitations", invitation.status)}
                    tone={
                      invitation.status === "accepted"
                        ? "success"
                        : invitation.status === "revoked" || invitation.status === "expired"
                          ? "danger"
                          : "warning"
                    }
                  />
                </div>
                <p className="text-xs text-[var(--color-ink-muted)]">
                  {formatTemplate(ui.pages.admins.invitationMeta, {
                    role: invitation.invitedByName ?? ui.labels.unknown,
                    date: formatDateTime(invitation.expiresAt),
                  })}
                </p>
              </div>
              <AdminInvitationActions locale={lang} invitationId={invitation.id} status={invitation.status} />
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
