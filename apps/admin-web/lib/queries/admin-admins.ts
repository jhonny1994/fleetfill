import { requireServerSuperAdmin } from "@/lib/auth/require-server-super-admin";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminAccountDetail,
  AdminAccountListItem,
  AdminAuditLogItem,
  AdminInvitationListItem,
  AdminRegistryFilters,
  AdminRegistrySnapshot,
  AdminRegistrySummary,
} from "@/lib/queries/admin-types";

type AdminAccountRow = {
  profile_id: string;
  admin_role: "super_admin" | "ops_admin";
  is_active: boolean;
  invited_by: string | null;
  activated_at: string | null;
  deactivated_at: string | null;
  updated_at: string | null;
  profile:
    | {
        full_name: string | null;
        email: string;
        company_name: string | null;
      }
    | null;
};

type AdminInvitationRow = {
  id: string;
  email: string;
  role: "super_admin" | "ops_admin";
  status: string;
  expires_at: string;
  invited_by: string | null;
  accepted_by_profile_id: string | null;
  created_at: string | null;
  updated_at: string | null;
};

type ProfileRow = {
  id: string;
  full_name: string | null;
  email: string;
};

type AuditRow = {
  id: string;
  action: string;
  target_type: string;
  target_id: string | null;
  outcome: string;
  reason: string | null;
  metadata: Record<string, unknown> | null;
  created_at: string | null;
};

type RegistryData = {
  accounts: AdminAccountListItem[];
  invitations: AdminInvitationListItem[];
};

function resolveDisplayName(name: string | null, email: string | null | undefined) {
  return name?.trim() || email?.trim() || "Unknown admin";
}

function normalizeQuery(value?: string) {
  return value?.trim().toLowerCase() ?? "";
}

function matchesQuery(values: Array<string | null | undefined>, query: string) {
  if (!query) {
    return true;
  }

  return values.some((value) => value?.toLowerCase().includes(query));
}

function clampPage(page: number | undefined) {
  return Number.isFinite(page) && (page ?? 1) > 0 ? Math.floor(page as number) : 1;
}

function clampPageSize(pageSize: number | undefined) {
  const normalized = Number.isFinite(pageSize) ? Math.floor(pageSize as number) : 10;
  return Math.min(25, Math.max(5, normalized || 10));
}

function pageRange(page: number, pageSize: number) {
  const from = (page - 1) * pageSize;
  return { from, to: from + pageSize - 1 };
}

function mapAuditLogs(rows: AuditRow[]): AdminAuditLogItem[] {
  return rows.map((row) => ({
    id: row.id,
    action: row.action,
    targetType: row.target_type,
    targetId: row.target_id,
    outcome: row.outcome,
    reason: row.reason,
    metadata: row.metadata ?? {},
    createdAt: row.created_at,
  }));
}

async function fetchRegistryData(): Promise<RegistryData> {
  await requireServerSuperAdmin();
  const supabase = await createSupabaseServerClient();
  const [accountsResult, invitationsResult] = await Promise.all([
    supabase
      .from("admin_accounts")
      .select(
        "profile_id, admin_role, is_active, invited_by, activated_at, deactivated_at, updated_at, profile:profiles!admin_accounts_profile_id_fkey(full_name,email,company_name)",
      )
      .order("updated_at", { ascending: false }),
    supabase
      .from("admin_invitations")
      .select("id, email, role, status, expires_at, invited_by, accepted_by_profile_id, created_at, updated_at")
      .order("created_at", { ascending: false }),
  ]);

  if (accountsResult.error) throw accountsResult.error;
  if (invitationsResult.error) throw invitationsResult.error;

  const accountRows = (accountsResult.data ?? []) as AdminAccountRow[];
  const invitationRows = (invitationsResult.data ?? []) as AdminInvitationRow[];
  const relatedProfileIds = [
    ...new Set(
      [
        ...accountRows.map((row) => row.invited_by).filter(Boolean),
        ...invitationRows.map((row) => row.invited_by).filter(Boolean),
        ...invitationRows.map((row) => row.accepted_by_profile_id).filter(Boolean),
      ] as string[],
    ),
  ];

  const { data: profiles, error: profilesError } = relatedProfileIds.length
    ? await supabase.from("profiles").select("id, full_name, email").in("id", relatedProfileIds)
    : { data: [], error: null };

  if (profilesError) throw profilesError;

  const profileMap = new Map<string, ProfileRow>(((profiles ?? []) as ProfileRow[]).map((profile) => [profile.id, profile]));

  return {
    accounts: accountRows.map((row) => {
      const profile = row.profile;
      return {
        profileId: row.profile_id,
        displayName: resolveDisplayName(profile?.full_name ?? null, profile?.email),
        email: profile?.email ?? "—",
        adminRole: row.admin_role,
        isActive: row.is_active,
        invitedByName: row.invited_by
          ? resolveDisplayName(profileMap.get(row.invited_by)?.full_name ?? null, profileMap.get(row.invited_by)?.email)
          : null,
        activatedAt: row.activated_at,
        deactivatedAt: row.deactivated_at,
        updatedAt: row.updated_at,
      };
    }),
    invitations: invitationRows.map((row) => ({
      id: row.id,
      email: row.email,
      role: row.role,
      status: row.status,
      expiresAt: row.expires_at,
      invitedByName: row.invited_by
        ? resolveDisplayName(profileMap.get(row.invited_by)?.full_name ?? null, profileMap.get(row.invited_by)?.email)
        : null,
      acceptedByName: row.accepted_by_profile_id
        ? resolveDisplayName(
            profileMap.get(row.accepted_by_profile_id)?.full_name ?? null,
            profileMap.get(row.accepted_by_profile_id)?.email,
          )
        : null,
      createdAt: row.created_at,
      updatedAt: row.updated_at,
    })),
  };
}

function filterAccounts(
  accounts: AdminAccountListItem[],
  filters: Required<Pick<AdminRegistryFilters, "q" | "role" | "state">>,
) {
  return accounts.filter((account) => {
    const matchesRole = filters.role === "all" || account.adminRole === filters.role;
    const matchesState = filters.state === "all" || (filters.state === "active" ? account.isActive : !account.isActive);
    const matchesSearch = matchesQuery(
      [
        account.displayName,
        account.email,
        account.invitedByName,
        account.adminRole,
        account.isActive ? "active" : "inactive",
      ],
      filters.q,
    );

    return matchesRole && matchesState && matchesSearch;
  });
}

function filterInvitations(invitations: AdminInvitationListItem[], query: string) {
  return invitations.filter((invitation) =>
    matchesQuery(
      [
        invitation.email,
        invitation.role,
        invitation.status,
        invitation.invitedByName,
        invitation.acceptedByName,
      ],
      query,
    ),
  );
}

function summarizeRegistry(accounts: AdminAccountListItem[], invitations: AdminInvitationListItem[]): AdminRegistrySummary {
  const activeAccounts = accounts.filter((account) => account.isActive).length;
  const inactiveAccounts = accounts.length - activeAccounts;
  return {
    totalAccounts: accounts.length,
    activeAccounts,
    inactiveAccounts,
    superAdmins: accounts.filter((account) => account.adminRole === "super_admin").length,
    opsAdmins: accounts.filter((account) => account.adminRole === "ops_admin").length,
    totalInvitations: invitations.length,
    pendingInvitations: invitations.filter((invitation) => invitation.status === "pending").length,
  };
}

export async function fetchAdminRegistrySnapshot(filters: AdminRegistryFilters = {}): Promise<AdminRegistrySnapshot> {
  const data = await fetchRegistryData();
  const normalizedFilters = {
    q: normalizeQuery(filters.q),
    role: filters.role ?? "all",
    state: filters.state ?? "all",
  } satisfies Required<Pick<AdminRegistryFilters, "q" | "role" | "state">>;
  const pageSize = clampPageSize(filters.pageSize);
  const page = clampPage(filters.page);
  const filteredAccounts = filterAccounts(data.accounts, normalizedFilters);
  const filteredInvitations = filterInvitations(data.invitations, normalizedFilters.q);
  const { from, to } = pageRange(page, pageSize);
  const pagedAccounts = filteredAccounts.slice(from, to + 1);

  return {
    accounts: pagedAccounts,
    invitations: filteredInvitations.slice(0, 25),
    page,
    pageSize,
    totalAccounts: filteredAccounts.length,
    totalInvitations: filteredInvitations.length,
    summary: summarizeRegistry(filteredAccounts, filteredInvitations),
    filters: normalizedFilters,
  };
}

async function fetchAdminAccountsAndInvitations(): Promise<{
  accounts: AdminAccountListItem[];
  invitations: AdminInvitationListItem[];
}> {
  const data = await fetchRegistryData();
  return {
    accounts: data.accounts,
    invitations: data.invitations,
  };
}

export async function fetchAdminAccountDetail(profileId: string): Promise<AdminAccountDetail | null> {
  const { accounts, invitations } = await fetchAdminAccountsAndInvitations();
  const account = accounts.find((item) => item.profileId === profileId);
  if (!account) return null;

  const supabase = await createSupabaseServerClient();
  const { data: auditRows, error: auditError } = await supabase
    .from("admin_audit_logs")
    .select("id, action, target_type, target_id, outcome, reason, metadata, created_at")
    .eq("target_id", profileId)
    .order("created_at", { ascending: false })
    .limit(20);

  if (auditError) throw auditError;

  return {
    account,
    invitations: invitations.filter((item) => item.email.toLowerCase() === account.email.toLowerCase()),
    auditLogs: mapAuditLogs((auditRows ?? []) as AuditRow[]),
  };
}
