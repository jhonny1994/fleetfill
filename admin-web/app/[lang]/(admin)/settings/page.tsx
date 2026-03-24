import { PlatformSettingsForms } from "@/components/settings/platform-settings-forms";
import { getAdminSession } from "@/lib/auth/get-admin-session";
import { fetchPlatformSettingsSnapshot } from "@/lib/queries/admin-settings";

export default async function SettingsPage() {
  const [session, settings] = await Promise.all([getAdminSession(), fetchPlatformSettingsSnapshot()]);

  return (
    <div className="space-y-4">
      <section className="panel space-y-3 p-6">
        <p className="eyebrow">Settings</p>
        <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">Runtime platform controls</h1>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          These settings control mobile runtime policy, pricing guardrails, localization, and operational safety flags.
        </p>
      </section>
      <PlatformSettingsForms settings={settings} isSuperAdmin={session?.adminRole === "super_admin"} />
    </div>
  );
}
