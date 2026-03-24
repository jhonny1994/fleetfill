import { PlatformSettingsForms } from "@/components/settings/platform-settings-forms";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import { getAdminDetailCopy, getAdminUi } from "@/lib/i18n/admin-ui";
import { fetchPlatformSettingsSnapshot } from "@/lib/queries/admin-settings";

export default async function SettingsPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const [session, settings] = await Promise.all([getAdminSession(), fetchPlatformSettingsSnapshot()]);
  const ui = getAdminUi(lang);
  const detailCopy = getAdminDetailCopy(lang);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">{ui.pages.settings.eyebrow}</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{ui.pages.settings.title}</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {detailCopy.settings.description}
        </p>
      </section>
      <PlatformSettingsForms locale={lang} settings={settings} isSuperAdmin={session?.adminRole === "super_admin"} />
    </div>
  );
}
