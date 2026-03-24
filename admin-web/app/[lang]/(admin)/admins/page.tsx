import { AdminAccountsTable } from "@/components/admin-management/admin-accounts-table";
import { AdminInviteForm } from "@/components/admin-management/admin-invite-form";
import { fetchAdminAccountsAndInvitations } from "@/lib/queries/admin-admins";

export default async function AdminsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const { accounts, invitations } = await fetchAdminAccountsAndInvitations();

  return (
    <div className="space-y-4">
      <AdminInviteForm locale={lang} />
      <AdminAccountsTable locale={lang} accounts={accounts} invitations={invitations} />
    </div>
  );
}
