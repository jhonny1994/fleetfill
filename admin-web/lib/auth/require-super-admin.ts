import { requireAdmin } from "@/lib/auth/require-admin";
import type { AppLocale } from "@/lib/i18n/config";

export async function requireSuperAdmin(locale?: AppLocale) {
  return requireAdmin(locale);
}
