import { Bell, ShieldCheck } from "lucide-react";
import type { ReactNode } from "react";

import { AdminIdentityControls } from "@/components/admin-shell/admin-identity-controls";
import { AdminLocaleSwitcher } from "@/components/admin-shell/admin-locale-switcher";
import { CommandSearch } from "@/components/shared/command-search";
import type { AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";

export function AdminHeader({
  locale,
  fullName,
  roleLabel,
  dictionary,
  enabledLocales,
  navigationTrigger,
}: {
  locale: AppLocale;
  fullName: string;
  roleLabel: string;
  dictionary: AdminDictionary;
  enabledLocales?: AppLocale[];
  navigationTrigger?: ReactNode;
}) {
  return (
    <header className="panel flex flex-col gap-3 p-3 lg:flex-row lg:items-center">
      <div className="flex min-w-0 items-center gap-2.5 lg:flex-1">
        {navigationTrigger ? <div className="lg:hidden">{navigationTrigger}</div> : null}
        <CommandSearch locale={locale} placeholder={dictionary.shell.searchPlaceholder} shortcutLabel="/" />
      </div>
      <div className="flex flex-wrap items-center gap-2">
        <AdminLocaleSwitcher locale={locale} dictionary={dictionary} availableLocales={enabledLocales} />
        <button
          type="button"
          className="admin-toolbar-icon"
          aria-label={dictionary.auth.openAlerts}
        >
          <Bell className="size-4" />
        </button>
        <div className="admin-toolbar-chip bg-[var(--color-sand-100)] text-[var(--color-accent-ink)]">
          <ShieldCheck className="size-4 text-[var(--color-accent)]" />
          <span>{roleLabel}</span>
        </div>
        <AdminIdentityControls
          locale={locale}
          label={fullName}
          detail={roleLabel}
          signOutLabel={dictionary.auth.signOut}
        />
      </div>
    </header>
  );
}
