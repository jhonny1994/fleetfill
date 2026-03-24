import { Bell, ShieldCheck } from "lucide-react";

import { CommandSearch } from "@/components/shared/command-search";
import { StatusBadge } from "@/components/shared/status-badge";

export function AdminHeader() {
  return (
    <header className="panel flex flex-col gap-4 p-4 lg:flex-row lg:items-center">
      <div className="min-w-0 flex-1">
        <CommandSearch />
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
        <div className="flex items-center gap-3 rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-2">
          <ShieldCheck className="size-4 text-[var(--color-accent)]" />
          <div className="text-sm">
            <p className="font-medium text-[var(--color-ink-strong)]">Admin session</p>
            <p className="text-[var(--color-ink-muted)]">Sign-in wiring comes next</p>
          </div>
        </div>
      </div>
    </header>
  );
}
