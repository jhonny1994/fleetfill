"use client";

import type { ColumnDef } from "@tanstack/react-table";
import Link from "next/link";

import { AdminInvitationActions } from "@/components/admin-management/admin-invitation-actions";
import { AdminDataTable } from "@/components/queues/admin-data-table";
import { StatusBadge } from "@/components/shared/status-badge";
import { formatDateTime } from "@/lib/formatting/formatters";
import { formatTemplate, getAdminRoleLabel, getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import type { AdminAccountListItem, AdminInvitationListItem } from "@/lib/queries/admin-types";

function buildAccountColumns(locale: string): ColumnDef<AdminAccountListItem>[] {
  const ui = getAdminUi(locale);

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
      cell: ({ row }) => (
        <span className="text-sm text-[var(--color-ink-muted)]">
          {formatDateTime(row.original.updatedAt)}
        </span>
      ),
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

function buildInvitationColumns(locale: string): ColumnDef<AdminInvitationListItem>[] {
  const ui = getAdminUi(locale);

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
      cell: ({ row }) => (
        <span className="text-sm text-[var(--color-ink-muted)]">
          {formatDateTime(row.original.expiresAt)}
        </span>
      ),
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
      cell: ({ row }) => (
        <AdminInvitationActions
          locale={locale}
          invitationId={row.original.id}
          status={row.original.status}
        />
      ),
    },
  ];
}

export function AdminAccountsTable({
  locale,
  accounts,
  invitations,
}: {
  locale: string;
  accounts: AdminAccountListItem[];
  invitations: AdminInvitationListItem[];
}) {
  const ui = getAdminUi(locale);

  return (
    <>
      <section className="panel space-y-4 p-5">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-[1.45rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.title}</h2>
          <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{ui.pages.admins.listBody}</p>
        </div>
        <AdminDataTable
          data={accounts}
          columns={buildAccountColumns(locale)}
          emptyEyebrow={ui.pages.admins.eyebrow}
          emptyTitle={ui.pages.admins.title}
          emptyBody={ui.pages.admins.listBody}
        />
      </section>

      <section className="panel space-y-4 p-5">
        <div className="space-y-2">
          <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
          <h2 className="text-[1.28rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.invitations}</h2>
        </div>
        <AdminDataTable
          data={invitations}
          columns={buildInvitationColumns(locale)}
          emptyEyebrow={ui.pages.admins.eyebrow}
          emptyTitle={ui.pages.admins.invitations}
          emptyBody={ui.pages.admins.invitationHistoryBody}
        />
      </section>
    </>
  );
}
