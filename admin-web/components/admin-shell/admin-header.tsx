import { Bell, ShieldCheck } from "lucide-react";

import { AdminIdentityControls } from "@/components/admin-shell/admin-identity-controls";
import { CommandSearch } from "@/components/shared/command-search";
import { StatusBadge } from "@/components/shared/status-badge";
import type { AppLocale } from "@/lib/i18n/config";

export function AdminHeader({
  locale,
  fullName,
  roleLabel,
}: {
  locale: AppLocale;
  fullName: string;
  roleLabel: string;
}) {
  return (
    <header className="panel flex flex-col gap-4 p-4 lg:flex-row lg:items-center">
      <div className="min-w-0 flex-1">
        <CommandSearch locale={locale} />
      </div>
      <div className="flex items-center gap-3">
        <StatusBadge label="Preview shell" tone="warning" />
        <button
          type="button"
          className="flex size-11 items-center justify-center rounded-full border border-[var(--color-border)] bg-white/70"
          aria-label="Open alerts"
        >
          <Bell className="size-4" />
        </button>
        <div className="flex items-center gap-2 rounded-full bg-[var(--color-sand-100)] px-3 py-2 text-sm font-medium text-[var(--color-accent-ink)]">
          <ShieldCheck className="size-4 text-[var(--color-accent)]" />
          <span>{roleLabel}</span>
        </div>
        <AdminIdentityControls locale={locale} label={fullName} detail={roleLabel} />
      </div>
    </header>
  );
}
