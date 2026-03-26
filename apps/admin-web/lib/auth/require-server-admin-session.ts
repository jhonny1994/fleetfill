import { redirect } from "next/navigation";

import { getAdminSession, type AdminSession } from "@/lib/auth/get-admin-session";
import { defaultLocale } from "@/lib/i18n/config";

export async function requireServerAdminSession(): Promise<AdminSession> {
  const session = await getAdminSession();

  if (!session) {
    redirect(`/${defaultLocale}/sign-in`);
  }

  return session;
}
