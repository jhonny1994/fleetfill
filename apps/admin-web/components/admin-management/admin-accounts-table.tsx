"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminInvitationActions } from "@/components/admin-management/admin-invitation-actions";
import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import type { AdminUi } from "@/lib/i18n/admin-ui";
import { formatTemplate, getAdminRoleLabel, getEnumLabel } from "@/lib/i18n/admin-ui";
import { useAdminDictionary, useAdminUi } from "@/lib/i18n/use-admin-messages";
import type { AdminAccountListItem, AdminInvitationListItem, AdminRegistrySnapshot } from "@/lib/queries/admin-types";

function buildAdminsHref(
  locale: string,
  filters: AdminRegistrySnapshot["filters"],
  page = 1,
) {
  const params = new URLSearchParams();
  if (filters.q) params.set("q", filters.q);
  if (filters.role !== "all") params.set("role", filters.role);
  if (filters.state !== "all") params.set("state", filters.state);
  if (page > 1) params.set("page", String(page));
  const suffix = params.toString();
  return `/${locale}/admins${suffix ? `?${suffix}` : ""}`;
}

function buildAccountColumns(locale: string, ui: AdminUi): ColumnDef<AdminAccountListItem>[] {
  return [
    {
      accessorKey: "displayName",
      header: ui.labels.adminAccount,
      cell: ({ row }) => (
        <div className="space-y-1">
          <Link
            href={`/${locale}/admins/${row.original.profileId}`}
            className="font-semibold text-[var(--color-ink-strong)] underline-offset-4 hover:underline"
          >
            {row.original.displayName}
          </Link>
          <p className="text-xs text-[var(--color-ink-muted)]">{row.original.email}</p>
        </div>
      ),
    },
    {
      accessorKey: "adminRole",
      header: ui.labels.role,
      cell: ({ row }) => (
        <StatusBadge
          label={getAdminRoleLabel(locale, row.original.adminRole)}
          tone={row.original.adminRole === "super_admin" ? "warning" : "neutral"}
        />
      ),
    },
    {
      accessorKey: "isActive",
      header: ui.labels.state,
      cell: ({ row }) => (
        <StatusBadge
          label={getEnumLabel(locale, "activity", row.original.isActive ? "active" : "inactive")}
          tone={row.original.isActive ? "success" : "danger"}
        />
      ),
    },
    {
      accessorKey: "updatedAt",
      header: ui.labels.updated,
      cell: ({ row }) => <span className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(row.original.updatedAt)}</span>,
    },
    {
      id: "meta",
      header: ui.labels.context,
      cell: ({ row }) => (
        <span className="text-xs text-[var(--color-ink-muted)]">
          {formatTemplate(ui.pages.admins.accountMeta, {
            actor: row.original.invitedByName ?? ui.labels.unknown,
            date: formatDateTime(row.original.updatedAt),
          })}
        </span>
      ),
    },
    {
      id: "actions",
      header: "",
      cell: ({ row }) => (
        <Link className="button-secondary" href={`/${locale}/admins/${row.original.profileId}`}>
          {ui.actions.viewAccount}
        </Link>
      ),
    },
  ];
}

function buildInvitationColumns(locale: string, ui: AdminUi): ColumnDef<AdminInvitationListItem>[] {
  return [
    {
      accessorKey: "email",
      header: ui.labels.email,
      cell: ({ row }) => <span className="font-medium text-[var(--color-ink-strong)]">{row.original.email}</span>,
    },
    {
      accessorKey: "role",
      header: ui.labels.role,
      cell: ({ row }) => (
        <StatusBadge
          label={getAdminRoleLabel(locale, row.original.role)}
          tone={row.original.role === "super_admin" ? "warning" : "neutral"}
        />
      ),
    },
    {
      accessorKey: "status",
      header: ui.labels.state,
      cell: ({ row }) => (
        <StatusBadge
          label={getEnumLabel(locale, "invitations", row.original.status)}
          tone={
            row.original.status === "accepted"
              ? "success"
              : row.original.status === "revoked" || row.original.status === "expired"
                ? "danger"
                : "warning"
          }
        />
      ),
    },
    {
      accessorKey: "expiresAt",
      header: ui.labels.updated,
      cell: ({ row }) => <span className="text-sm text-[var(--color-ink-muted)]">{formatDateTime(row.original.expiresAt)}</span>,
    },
    {
      id: "invitationMeta",
      header: ui.labels.context,
      cell: ({ row }) => (
        <span className="text-xs text-[var(--color-ink-muted)]">
          {formatTemplate(ui.pages.admins.invitationMeta, {
            role: row.original.invitedByName ?? ui.labels.unknown,
            date: formatDateTime(row.original.expiresAt),
          })}
        </span>
      ),
    },
    {
      id: "invitationActions",
      header: "",
      cell: ({ row }) => <AdminInvitationActions invitationId={row.original.id} status={row.original.status} />,
    },
  ];
}

export function AdminAccountsTable({
  locale,
  snapshot,
}: {
  locale: string;
  snapshot: AdminRegistrySnapshot;
}) {
  const dictionary = useAdminDictionary();
  const ui = useAdminUi();
  const { accounts, invitations, page, pageSize, totalAccounts, totalInvitations, summary, filters } = snapshot;
  const totalPages = Math.max(1, Math.ceil(totalAccounts / pageSize));

  return (
    <>
      <section className="panel space-y-5 p-5">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-[1.45rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.title}</h2>
          <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{ui.pages.admins.listBody}</p>
        </div>

        <form className="grid gap-3 lg:grid-cols-[minmax(0,1fr)_220px_220px_auto] lg:items-end" action={`/${locale}/admins`} method="get">
          <div className="space-y-2">
            <label className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-ink-muted)]" htmlFor="admins-search">
              {ui.pages.admins.searchLabel}
            </label>
            <input
              id="admins-search"
              type="search"
              name="q"
              defaultValue={filters.q}
              placeholder={ui.pages.admins.searchPlaceholder}
              className="min-w-0 w-full rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
            />
          </div>
          <div className="space-y-2">
            <label className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-ink-muted)]" htmlFor="admins-role">
              {ui.labels.role}
            </label>
            <select
              id="admins-role"
              name="role"
              defaultValue={filters.role}
              className="w-full rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
            >
              <option value="all">{ui.labels.allRoles}</option>
              <option value="super_admin">{getAdminRoleLabel(locale, "super_admin")}</option>
              <option value="ops_admin">{getAdminRoleLabel(locale, "ops_admin")}</option>
            </select>
          </div>
          <div className="space-y-2">
            <label className="text-xs font-medium uppercase tracking-[0.12em] text-[var(--color-ink-muted)]" htmlFor="admins-state">
              {ui.labels.state}
            </label>
            <select
              id="admins-state"
              name="state"
              defaultValue={filters.state}
              className="w-full rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-3 text-sm"
            >
              <option value="all">{ui.labels.allAccountStates}</option>
              <option value="active">{getEnumLabel(locale, "activity", "active")}</option>
              <option value="inactive">{getEnumLabel(locale, "activity", "inactive")}</option>
            </select>
          </div>
          <div className="flex flex-wrap items-center gap-2">
            <button className="button-primary" type="submit">
              {dictionary.common.apply}
            </button>
            <Link className="button-secondary" href={`/${locale}/admins`}>
              {dictionary.common.reset}
            </Link>
          </div>
        </form>

        <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-3">
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.totalAdmins}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.totalAccounts}</p>
          </div>
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.activeAdmins}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.activeAccounts}</p>
          </div>
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.superAdmins}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.superAdmins}</p>
          </div>
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.opsAdmins}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.opsAdmins}</p>
          </div>
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.inactiveAdmins}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.inactiveAccounts}</p>
          </div>
          <div className="rounded-[22px] border border-[var(--color-border)] bg-white/55 p-4">
            <p className="text-xs uppercase tracking-[0.12em] text-[var(--color-ink-muted)]">{ui.pages.admins.pendingInvitations}</p>
            <p className="mt-2 text-2xl font-semibold text-[var(--color-ink-strong)]">{summary.pendingInvitations}</p>
          </div>
        </div>

        <p className="text-sm text-[var(--color-ink-muted)]">
          {ui.pages.admins.accountPageSummary} {page} / {totalPages} • {totalAccounts} {ui.pages.admins.totalAdminAccounts}
        </p>

        <AdminDataTable
          data={accounts}
          columns={buildAccountColumns(locale, ui)}
          emptyEyebrow={ui.pages.admins.eyebrow}
          emptyTitle={ui.pages.admins.title}
          emptyBody={ui.pages.admins.listBody}
        />

        <div className="flex items-center justify-between gap-3 border-t border-[var(--color-border)] pt-4">
          <p className="text-sm text-[var(--color-ink-muted)]">
            {ui.pages.admins.accountPageSummary} {page} / {totalPages} • {totalAccounts} {ui.pages.admins.totalAdminAccounts}
          </p>
          <div className="flex gap-2">
            {page > 1 ? (
              <Link className="button-secondary" href={buildAdminsHref(locale, filters, page - 1)}>
                {ui.pages.audit.previous}
              </Link>
            ) : null}
            {page < totalPages ? (
              <Link className="button-secondary" href={buildAdminsHref(locale, filters, page + 1)}>
                {ui.pages.audit.next}
              </Link>
            ) : null}
          </div>
        </div>
      </section>

      <section className="panel space-y-4 p-5">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-[1.28rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.invitations}</h2>
          <p className="text-sm text-[var(--color-ink-muted)]">
            {formatTemplate(ui.pages.admins.invitationHistorySummary, {
              count: invitations.length,
              total: totalInvitations,
            })}
          </p>
        </div>
        <AdminDataTable
          data={invitations}
          columns={buildInvitationColumns(locale, ui)}
          emptyEyebrow={ui.pages.admins.eyebrow}
          emptyTitle={ui.pages.admins.invitations}
          emptyBody={ui.pages.admins.invitationHistoryBody}
        />
      </section>
    </>
  );
}
