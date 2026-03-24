import Link from "next/link";

import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { fetchUsers } from "@/lib/queries/admin-users";

export default async function UsersPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; role?: string; activity?: string; verification?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const query = filters.q?.trim();
  const role = filters.role?.trim();
  const activity = filters.activity?.trim();
  const verification = filters.verification?.trim();
  const users = await fetchUsers({ query, role, activity, verification });

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Users</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">User operations and lifecycle</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          Search shippers and carriers, inspect verification and account state, then drill into the full operational
          workspace for each person.
        </p>
      </section>

      <section className="panel p-4">
        <form className="grid gap-3 lg:grid-cols-[minmax(0,1.2fr)_repeat(3,minmax(0,0.55fr))_auto]" action={`/${lang}/users`} method="get">
          <input
            type="search"
            name="q"
            defaultValue={query}
            placeholder="Search by name, email, phone, or profile id"
            className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
          />
          <select name="role" defaultValue={role ?? ""} className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm">
            <option value="">All roles</option>
            <option value="shipper">Shipper</option>
            <option value="carrier">Carrier</option>
          </select>
          <select name="activity" defaultValue={activity ?? ""} className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm">
            <option value="">All activity</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
          </select>
          <select
            name="verification"
            defaultValue={verification ?? ""}
            className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
          >
            <option value="">All verification states</option>
            <option value="pending">Pending</option>
            <option value="verified">Verified</option>
            <option value="rejected">Rejected</option>
          </select>
          <div className="flex items-center gap-2">
            <button className="button-primary" type="submit">
              Apply
            </button>
            <Link className="button-secondary" href={`/${lang}/users`}>
              Reset
            </Link>
          </div>
        </form>
      </section>

      <div className="table-shell">
        <table>
          <thead>
            <tr>
              <th>User</th>
              <th>Role</th>
              <th>Account state</th>
              <th>Verification</th>
              <th>Operational context</th>
              <th>Updated</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.profileId}>
                <td>
                  <div className="space-y-1">
                    <Link
                      href={`/${lang}/users/${user.profileId}`}
                      className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline"
                    >
                      {user.displayName}
                    </Link>
                    <p className="text-xs text-[var(--color-ink-muted)]">{user.email}</p>
                  </div>
                </td>
                <td>
                  <StatusBadge label={user.role} tone="neutral" />
                </td>
                <td>
                  <StatusBadge label={user.isActive ? "Active" : "Suspended"} tone={user.isActive ? "success" : "danger"} />
                </td>
                <td>
                  <StatusBadge
                    label={user.verificationStatus}
                    tone={
                      user.verificationStatus === "verified"
                        ? "success"
                        : user.verificationStatus === "rejected"
                          ? "danger"
                          : "warning"
                    }
                  />
                </td>
                <td className="text-sm">
                  <div className="space-y-1">
                    <p>{user.bookingCount} bookings</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">{user.vehicleCount} vehicles</p>
                  </div>
                </td>
                <td className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(user.updatedAt)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
