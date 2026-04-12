import { getMessages } from "next-intl/server";
import Link from "next/link";

import { PaginationSummary } from "@/components/shared/pagination-summary";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getEnumLabel, getUserVerificationLabel } from "@/lib/i18n/admin-ui";
import { resolveAppLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchUsers } from "@/lib/queries/admin-users";

export default async function UsersPage({
  params,
  searchParams,
}: {
  params: Promise<{ lang: string }>;
  searchParams: Promise<{ q?: string; role?: string; activity?: string; verification?: string; page?: string }>;
}) {
  const [{ lang }, filters] = await Promise.all([params, searchParams]);
  const locale = resolveAppLocale(lang);
  const query = filters.q?.trim() ?? "";
  const role = filters.role?.trim() === "shipper" || filters.role?.trim() === "carrier" ? (filters.role.trim() as "shipper" | "carrier") : "all";
  const activity =
    filters.activity?.trim() === "active" || filters.activity?.trim() === "inactive"
      ? (filters.activity.trim() as "active" | "inactive")
      : "all";
  const verification =
    filters.verification?.trim() === "pending" || filters.verification?.trim() === "verified" || filters.verification?.trim() === "rejected"
      ? (filters.verification.trim() as "pending" | "verified" | "rejected")
      : "all";
  const page = Math.max(1, Number(filters.page ?? "1") || 1);
  const { ui, dictionary } = asAdminMessages(await getMessages({ locale }));
  const snapshot = await fetchUsers({ q: query, role, activity, verification, page });
  const search = new URLSearchParams();
  if (snapshot.filters.q) search.set("q", snapshot.filters.q);
  if (snapshot.filters.role !== "all") search.set("role", snapshot.filters.role);
  if (snapshot.filters.activity !== "all") search.set("activity", snapshot.filters.activity);
  if (snapshot.filters.verification !== "all") search.set("verification", snapshot.filters.verification);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.users.eyebrow}</p>
        <h1 className="text-[1.7rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.users.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {ui.pages.users.listBody}
        </p>
      </section>

      <section className="panel stacked-filter-surface p-5">
        <form className="stacked-filter-form" action={`/${locale}/users`} method="get">
          <input
            type="search"
            name="q"
            defaultValue={snapshot.filters.q}
            placeholder={ui.pages.users.searchPlaceholder}
            className="admin-field stacked-filter-search"
          />
          <div className="stacked-filter-secondary">
            <select aria-label={ui.labels.role} name="role" defaultValue={snapshot.filters.role} className="admin-field admin-select">
              <option value="all">{ui.labels.allRoles}</option>
              <option value="shipper">{getEnumLabel(locale, "userRoles", "shipper")}</option>
              <option value="carrier">{getEnumLabel(locale, "userRoles", "carrier")}</option>
            </select>
            <select aria-label={ui.labels.accountState} name="activity" defaultValue={snapshot.filters.activity} className="admin-field admin-select">
              <option value="all">{ui.labels.allAccountStates}</option>
              <option value="active">{getEnumLabel(locale, "activity", "active")}</option>
              <option value="inactive">{getEnumLabel(locale, "activity", "inactive")}</option>
            </select>
            <select
              aria-label={ui.labels.verification}
              name="verification"
              defaultValue={snapshot.filters.verification}
              className="admin-field admin-select"
            >
              <option value="all">{ui.labels.allVerificationStates}</option>
              <option value="pending">{getEnumLabel(locale, "verification", "pending")}</option>
              <option value="verified">{getEnumLabel(locale, "verification", "verified")}</option>
              <option value="rejected">{getEnumLabel(locale, "verification", "rejected")}</option>
            </select>
            <button className="button-primary" type="submit">
              {ui.actions.confirm}
            </button>
            <Link className="button-secondary" href={`/${locale}/users`}>
              {dictionary.common.reset}
            </Link>
          </div>
        </form>
      </section>

      <div className="table-shell">
        <table>
          <thead>
            <tr>
              <th>{ui.pages.users.userLabel}</th>
              <th>{ui.labels.role}</th>
              <th>{ui.labels.accountState}</th>
              <th>{ui.labels.verification}</th>
              <th>{ui.labels.operationalContext}</th>
              <th>{ui.labels.updated}</th>
              <th />
            </tr>
          </thead>
          <tbody>
            {snapshot.users.map((user) => (
              <tr key={user.profileId}>
                <td>
                  <div className="space-y-1">
                    <Link
                      href={`/${locale}/users/${user.profileId}`}
                      className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline"
                    >
                      {user.displayName}
                    </Link>
                    <p className="text-xs text-[var(--color-ink-muted)]">{user.email}</p>
                  </div>
                </td>
                <td>
                  <StatusBadge label={getEnumLabel(locale, "userRoles", user.role)} tone="neutral" />
                </td>
                <td>
                  <StatusBadge label={getEnumLabel(locale, "activity", user.isActive ? "active" : "suspended")} tone={user.isActive ? "success" : "danger"} />
                </td>
                <td>
                  {user.role === "carrier" ? (
                    <StatusBadge
                      label={getUserVerificationLabel(locale, user.role, user.verificationStatus)}
                      tone={
                        user.verificationStatus === "verified"
                          ? "success"
                          : user.verificationStatus === "rejected"
                            ? "danger"
                            : "warning"
                      }
                    />
                  ) : (
                    <span className="text-sm text-[var(--color-ink-muted)]">-</span>
                  )}
                </td>
                <td className="text-sm">
                  <div className="space-y-1">
                    <p>{user.bookingCount} {ui.pages.users.bookingsLabel}</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">
                      {user.role === "carrier"
                        ? ui.labels.vehiclesSummary.replace("{count}", String(user.vehicleCount))
                        : `${user.shipmentCount} ${ui.pages.userDetail.recentShipments}`}
                    </p>
                  </div>
                </td>
                <td className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(user.updatedAt)}</td>
                <td>
                  <Link className="button-secondary" href={`/${locale}/users/${user.profileId}`}>
                    {ui.actions.openDetail}
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <PaginationSummary
        pathname={`/${locale}/users`}
        searchParams={search}
        page={snapshot.page}
        pageSize={snapshot.pageSize}
        total={snapshot.totalUsers}
        previousLabel={ui.pages.audit.previous}
        nextLabel={ui.pages.audit.next}
        pageLabel={ui.pages.audit.page}
        totalLabel={ui.pages.audit.total}
      />
    </div>
  );
}
