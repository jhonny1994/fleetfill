import { redirect } from "next/navigation";

import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { defaultLocale } from "@/lib/i18n/config";

export async function requireServerSuperAdmin() {
  const session = await requireServerAdminSession();

  if (session.adminRole !== "super_admin") {
    redirect(`/${defaultLocale}/dashboard`);
  }

  return session;
}
