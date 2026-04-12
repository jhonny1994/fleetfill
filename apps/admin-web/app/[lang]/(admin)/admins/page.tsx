import { AdminAccountsTable } from "@/components/admin-management/admin-accounts-table";
import { AdminInviteForm } from "@/components/admin-management/admin-invite-form";
import { fetchAdminRegistrySnapshot } from "@/lib/queries/admin-admins";

export default async function AdminsPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; role?: string; state?: string; page?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const snapshot = await fetchAdminRegistrySnapshot({
    q: filters.q,
    role: filters.role === "super_admin" || filters.role === "ops_admin" ? filters.role : "all",
    state: filters.state === "active" || filters.state === "inactive" ? filters.state : "all",
    page: Number(filters.page ?? "1") || 1,
  });

  return (
    <div className="space-y-4">
      <AdminInviteForm locale={lang} />
      <AdminAccountsTable locale={lang} snapshot={snapshot} />
    </div>
  );
}
