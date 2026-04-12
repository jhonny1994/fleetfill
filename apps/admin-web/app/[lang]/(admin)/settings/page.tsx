import { getMessages } from "next-intl/server";
import { PlatformSettingsForms } from "@/components/settings/platform-settings-forms";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import { getAdminDetailCopy } from "@/lib/i18n/admin-ui";
import { defaultLocale, parseSupportedLocale } from "@/lib/i18n/config";
import { asAdminMessages } from "@/lib/i18n/messages";
import { fetchPlatformSettingsSnapshot } from "@/lib/queries/admin-settings";

export default async function SettingsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = parseSupportedLocale(lang) ?? defaultLocale;
  const [session, settings, messages] = await Promise.all([
    getAdminSession(),
    fetchPlatformSettingsSnapshot(),
    getMessages({ locale }).then(asAdminMessages),
  ]);
  const { ui } = messages;
  const detailCopy = getAdminDetailCopy(locale);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-5">
        <p className="eyebrow">{ui.pages.settings.eyebrow}</p>
        <h1 className="text-[1.55rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.settings.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {detailCopy.settings.description}
        </p>
      </section>
      <PlatformSettingsForms locale={locale} settings={settings} isSuperAdmin={session?.adminRole === "super_admin"} />
    </div>
  );
}
