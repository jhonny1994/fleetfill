import type { ReactNode } from "react";

import { requireSuperAdmin } from "@/lib/auth/require-super-admin";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

export default async function AdminGovernanceLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  await requireSuperAdmin(locale);

  return children;
}
