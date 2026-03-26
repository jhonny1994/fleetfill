import { cache } from "react";

import { createSupabaseServerClient } from "@/lib/supabase/server";
import type { Database } from "@/lib/supabase/database.types";

export type AdminSession = {
  userId: string;
  email: string | null;
  fullName: string | null;
  adminRole: "super_admin" | "ops_admin";
};

type AdminAccountRow = Pick<
  Database["public"]["Tables"]["admin_accounts"]["Row"],
  "admin_role" | "is_active"
> & {
  profile: Pick<
    Database["public"]["Tables"]["profiles"]["Row"],
    "full_name" | "email" | "is_active"
  > | null;
};

export function resolveAdminSessionData({
  userId,
  userEmail,
  adminAccount,
}: {
  userId: string;
  userEmail: string | null;
  adminAccount: AdminAccountRow | null;
}): AdminSession | null {
  if (!adminAccount || adminAccount.is_active !== true) {
    return null;
  }

  const profile = adminAccount.profile;

  if (!profile || profile.is_active !== true) {
    return null;
  }

  return {
    userId,
    email: profile.email ?? userEmail,
    fullName: profile.full_name ?? null,
    adminRole: adminAccount.admin_role,
  };
}

export const getAdminSession = cache(async (): Promise<AdminSession | null> => {
  const supabase = await createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return null;
  }

  const { data: adminAccount } = await supabase
    .from("admin_accounts")
    .select(
      "admin_role,is_active,profile:profiles!admin_accounts_profile_id_fkey(full_name,email,is_active)",
    )
    .eq("profile_id", user.id)
    .maybeSingle();

  return resolveAdminSessionData({
    userId: user.id,
    userEmail: user.email ?? null,
    adminAccount: adminAccount ?? null,
  });
});
