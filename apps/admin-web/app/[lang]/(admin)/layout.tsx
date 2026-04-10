import type { ReactNode } from "react";
import { getMessages } from "next-intl/server";

import { AdminHeader } from "@/components/admin-shell/admin-header";
import { MobileAdminSidebar } from "@/components/admin-shell/mobile-admin-sidebar";
import { AdminSidebar } from "@/components/admin-shell/admin-sidebar";
import { requireAdmin } from "@/lib/auth/require-admin";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchPlatformSettingsSnapshot } from "@/lib/queries/admin-settings";

export default async function AdminLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = isSupportedLocale(lang) ? lang : defaultLocale;
  const [session, messages, settings] = await Promise.all([
    requireAdmin(locale),
    getMessages({ locale }).then(asAdminMessages),
    fetchPlatformSettingsSnapshot(),
  ]);
  const { dictionary } = messages;
  const roleLabel =
    session.adminRole === "super_admin"
      ? dictionary.shell.role.superAdmin
      : dictionary.shell.role.opsAdmin;

  return (
    <div className="space-y-3 lg:grid lg:min-h-[calc(100vh-2rem)] lg:grid-cols-[244px_minmax(0,1fr)] lg:gap-3 lg:space-y-0">
      <div className="hidden lg:block">
        <AdminSidebar locale={locale} dictionary={dictionary} adminRole={session.adminRole} />
      </div>
      <div className="space-y-3">
        <AdminHeader
          locale={locale}
          fullName={session.fullName ?? session.email ?? "FleetFill admin"}
          roleLabel={roleLabel}
          dictionary={dictionary}
          enabledLocales={settings.localization.enabledLocales}
          navigationTrigger={
            <MobileAdminSidebar locale={locale} dictionary={dictionary} adminRole={session.adminRole} />
          }
        />
        <main className="space-y-3">{children}</main>
      </div>
    </div>
  );
}
