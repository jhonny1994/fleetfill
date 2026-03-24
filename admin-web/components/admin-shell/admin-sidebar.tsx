"use client";

import Link from "next/link";
import { useSelectedLayoutSegment } from "next/navigation";

import type { AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";
import { cn } from "@/lib/utils";

export function AdminSidebar({
  locale,
  dictionary,
  compact = false,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
  compact?: boolean;
}) {
  const activeSegment = useSelectedLayoutSegment();
  const items = [
    ["dashboard", dictionary.shell.nav.dashboard],
    ["payments", dictionary.shell.nav.payments],
    ["verification", dictionary.shell.nav.verification],
    ["disputes", dictionary.shell.nav.disputes],
    ["payouts", dictionary.shell.nav.payouts],
    ["support", dictionary.shell.nav.support],
    ["users", dictionary.shell.nav.users],
    ["admins", dictionary.shell.nav.admins],
    ["settings", dictionary.shell.nav.settings],
    ["audit-and-health", dictionary.shell.nav.auditAndHealth],
  ] as const;

  return (
    <aside className={cn("panel flex gap-5 p-5", compact ? "flex-col" : "h-full flex-col")}>
      <div className="space-y-2">
        <p className="eyebrow">{dictionary.shell.eyebrow}</p>
        <h1 className="text-xl font-semibold text-[var(--color-ink-strong)]">{dictionary.shell.title}</h1>
        <p className="text-sm text-[var(--color-ink-muted)]">
          {dictionary.shell.body}
        </p>
      </div>
      <nav className={cn("gap-2", compact ? "flex overflow-x-auto pb-1" : "grid")}>
        {items.map(([slug, label]) => (
          <Link
            key={slug}
            href={`/${locale}/${slug}`}
            className={cn(
              "rounded-2xl px-4 py-3 text-sm font-medium transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-accent)] focus-visible:ring-offset-2",
              compact && "whitespace-nowrap",
              activeSegment === slug
                ? "bg-[var(--color-sand-100)] text-[var(--color-accent-ink)]"
                : "text-[var(--color-ink-base)] hover:bg-white/65",
            )}
          >
            {label}
          </Link>
        ))}
      </nav>
    </aside>
  );
}
