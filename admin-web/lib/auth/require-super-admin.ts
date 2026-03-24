import { requireAdmin } from "@/lib/auth/require-admin";
import type { AppLocale } from "@/lib/i18n/config";
import { redirect } from "next/navigation";

export async function requireSuperAdmin(locale?: AppLocale) {
  const session = await requireAdmin(locale);

  if (session.adminRole !== "super_admin") {
    redirect(`/${locale ?? "ar"}/dashboard`);
  }

  return session;
}
