import { requireServerSuperAdmin } from "@/lib/auth/require-server-super-admin";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminAccountDetail,
  AdminAccountListItem,
  AdminAuditLogItem,
  AdminInvitationListItem,
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

function resolveDisplayName(name: string | null, email: string | null | undefined) {
  return name?.trim() || email?.trim() || "Unknown admin";
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

export async function fetchAdminAccountsAndInvitations(): Promise<{
  accounts: AdminAccountListItem[];
  invitations: AdminInvitationListItem[];
}> {
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
      .order("created_at", { ascending: false })
      .limit(25),
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

export async function fetchAdminAccountDetail(profileId: string): Promise<AdminAccountDetail | null> {
  await requireServerSuperAdmin();
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
