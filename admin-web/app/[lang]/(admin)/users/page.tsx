import Link from "next/link";

import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminUi, getEnumLabel, getUserVerificationLabel } from "@/lib/i18n/admin-ui";
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
  const ui = getAdminUi(lang);
  const users = await fetchUsers({ query, role, activity, verification });

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
        <form className="stacked-filter-form" action={`/${lang}/users`} method="get">
          <input
            type="search"
            name="q"
            defaultValue={query}
            placeholder={ui.pages.users.searchPlaceholder}
            className="admin-field stacked-filter-search"
          />
          <div className="stacked-filter-secondary">
            <select aria-label={ui.labels.role} name="role" defaultValue={role ?? ""} className="admin-field admin-select">
              <option value="">{ui.labels.allRoles}</option>
              <option value="shipper">{getEnumLabel(lang, "userRoles", "shipper")}</option>
              <option value="carrier">{getEnumLabel(lang, "userRoles", "carrier")}</option>
            </select>
            <select aria-label={ui.labels.accountState} name="activity" defaultValue={activity ?? ""} className="admin-field admin-select">
              <option value="">{ui.labels.allAccountStates}</option>
              <option value="active">{getEnumLabel(lang, "activity", "active")}</option>
              <option value="inactive">{getEnumLabel(lang, "activity", "inactive")}</option>
            </select>
            <select
              aria-label={ui.labels.verification}
              name="verification"
              defaultValue={verification ?? ""}
              className="admin-field admin-select"
            >
              <option value="">{ui.labels.allVerificationStates}</option>
              <option value="pending">{getEnumLabel(lang, "verification", "pending")}</option>
              <option value="verified">{getEnumLabel(lang, "verification", "verified")}</option>
              <option value="rejected">{getEnumLabel(lang, "verification", "rejected")}</option>
            </select>
            <button className="button-primary" type="submit">
              {ui.actions.confirm}
            </button>
            <Link className="button-secondary" href={`/${lang}/users`}>
              {ui.actions.cancel}
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
                  <StatusBadge label={getEnumLabel(lang, "userRoles", user.role)} tone="neutral" />
                </td>
                <td>
                  <StatusBadge label={getEnumLabel(lang, "activity", user.isActive ? "active" : "suspended")} tone={user.isActive ? "success" : "danger"} />
                </td>
                <td>
                  <StatusBadge
                    label={getUserVerificationLabel(lang, user.role, user.verificationStatus)}
                    tone={
                      user.role !== "carrier"
                        ? "neutral"
                        : user.verificationStatus === "verified"
                        ? "success"
                        : user.verificationStatus === "rejected"
                          ? "danger"
                          : "warning"
                    }
                  />
                </td>
                <td className="text-sm">
                  <div className="space-y-1">
                    <p>{user.bookingCount} {ui.pages.users.bookingsLabel}</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">{ui.labels.vehiclesSummary.replace("{count}", String(user.vehicleCount))}</p>
                  </div>
                </td>
                <td className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(user.updatedAt)}</td>
                <td>
                  <Link className="button-secondary" href={`/${lang}/users/${user.profileId}`}>
                    {ui.actions.openDetail}
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
