import type { ReactNode } from "react";

import { AdminHeader } from "@/components/admin-shell/admin-header";
import { MobileAdminSidebar } from "@/components/admin-shell/mobile-admin-sidebar";
import { AdminSidebar } from "@/components/admin-shell/admin-sidebar";
import { requireAdmin } from "@/lib/auth/require-admin";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { getDictionary } from "@/lib/i18n/dictionaries";

export default async function AdminLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  const session = await requireAdmin(locale);
  const dictionary = await getDictionary(locale);
  const roleLabel =
    session.adminRole === "super_admin"
      ? dictionary.shell.role.superAdmin
      : dictionary.shell.role.opsAdmin;

  return (
    <div className="space-y-3 lg:grid lg:min-h-[calc(100vh-2rem)] lg:grid-cols-[244px_minmax(0,1fr)] lg:gap-3 lg:space-y-0">
      <div className="hidden lg:block">
        <AdminSidebar locale={locale} dictionary={dictionary} />
      </div>
      <div className="space-y-3">
        <AdminHeader
          locale={locale}
          fullName={session.fullName ?? session.email ?? "FleetFill admin"}
          roleLabel={roleLabel}
          dictionary={dictionary}
          navigationTrigger={<MobileAdminSidebar locale={locale} dictionary={dictionary} />}
        />
        <main className="space-y-3">{children}</main>
      </div>
    </div>
  );
}
