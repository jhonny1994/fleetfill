import Link from "next/link";

import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
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
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.users.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {ui.pages.users.title}
        </p>
      </section>

      <section className="panel p-4">
        <form className="grid gap-3 lg:grid-cols-[minmax(0,1.2fr)_repeat(3,minmax(0,0.55fr))_auto]" action={`/${lang}/users`} method="get">
          <input
            type="search"
            name="q"
            defaultValue={query}
            placeholder={ui.pages.users.title === "تشغيل المستخدمين ودورة حياتهم" ? "ابحث بالاسم أو البريد أو الهاتف أو معرّف الملف" : ui.pages.users.title === "Operations et cycle de vie utilisateur" ? "Rechercher par nom, email, telephone ou identifiant profil" : "Search by name, email, phone, or profile ID"}
            className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
          />
          <select name="role" defaultValue={role ?? ""} className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm">
            <option value="">{ui.labels.none}</option>
            <option value="shipper">{getEnumLabel(lang, "userRoles", "shipper")}</option>
            <option value="carrier">{getEnumLabel(lang, "userRoles", "carrier")}</option>
          </select>
          <select name="activity" defaultValue={activity ?? ""} className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm">
            <option value="">{ui.labels.none}</option>
            <option value="active">{getEnumLabel(lang, "activity", "active")}</option>
            <option value="inactive">{getEnumLabel(lang, "activity", "inactive")}</option>
          </select>
          <select
            name="verification"
            defaultValue={verification ?? ""}
            className="rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
          >
            <option value="">{ui.labels.none}</option>
            <option value="pending">{getEnumLabel(lang, "verification", "pending")}</option>
            <option value="verified">{getEnumLabel(lang, "verification", "verified")}</option>
            <option value="rejected">{getEnumLabel(lang, "verification", "rejected")}</option>
          </select>
          <div className="flex items-center gap-2">
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
              <th>{ui.pages.users.eyebrow.slice(0, -1) || "User"}</th>
              <th>{ui.labels.role}</th>
              <th>{ui.labels.accountState}</th>
              <th>{ui.labels.verification}</th>
              <th>{ui.labels.queue === "طابور" ? "السياق التشغيلي" : ui.labels.queue === "File" ? "Contexte operationnel" : "Operational context"}</th>
              <th>{ui.labels.updated}</th>
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
                    label={getEnumLabel(lang, "verification", user.verificationStatus)}
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
                    <p>{user.bookingCount}</p>
                    <p className="text-xs text-[var(--color-ink-muted)]">{user.vehicleCount}</p>
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
