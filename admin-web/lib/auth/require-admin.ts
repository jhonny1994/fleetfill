import { redirect } from "next/navigation";

import { getAdminSession } from "@/lib/auth/get-admin-session";
import { defaultLocale, type AppLocale } from "@/lib/i18n/config";

export async function requireAdmin(locale?: AppLocale) {
  const session = await getAdminSession();

  if (!session) {
    redirect(`/${locale ?? defaultLocale}/sign-in`);
  }

  return session;
}
