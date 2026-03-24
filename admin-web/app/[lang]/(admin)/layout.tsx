import type { ReactNode } from "react";

import { AdminHeader } from "@/components/admin-shell/admin-header";
import { AdminSidebar } from "@/components/admin-shell/admin-sidebar";
import { requireAdmin } from "@/lib/auth/require-admin";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

export default async function AdminLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  await requireAdmin(locale);

  return (
    <div className="grid min-h-[calc(100vh-2rem)] gap-4 lg:grid-cols-[280px_minmax(0,1fr)]">
      <div className="hidden lg:block">
        <AdminSidebar locale={locale} />
      </div>
      <div className="space-y-4">
        <AdminHeader />
        <main className="space-y-4">{children}</main>
      </div>
    </div>
  );
}
