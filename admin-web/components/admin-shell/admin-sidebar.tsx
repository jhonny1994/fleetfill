"use client";

import Link from "next/link";
import { useSelectedLayoutSegment } from "next/navigation";

import type { AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";
import { cn } from "@/lib/utils";

const navItems = (dictionary: AdminDictionary) =>
  [
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

export function AdminSidebar({
  locale,
  dictionary,
  compact = false,
  className,
  onNavigate,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
  compact?: boolean;
  className?: string;
  onNavigate?: () => void;
}) {
  const activeSegment = useSelectedLayoutSegment();
  const items = navItems(dictionary);

  return (
    <aside
      className={cn(
        "panel flex gap-4",
        locale === "ar" ? "text-right" : "text-left",
        compact ? "flex-col px-3 py-3" : "h-full flex-col p-3.5",
        className,
      )}
    >
      {compact ? (
        <p
          className={cn(
            "px-1 text-xs font-semibold text-[var(--color-ink-muted)]",
            locale === "ar" ? "tracking-normal" : "uppercase tracking-[0.14em]",
          )}
        >
          {dictionary.shell.title}
        </p>
      ) : (
        <div className="space-y-1.5">
          <p className="eyebrow">{dictionary.shell.eyebrow}</p>
          <h1 className="text-[1.02rem] font-semibold text-[var(--color-ink-strong)]">{dictionary.shell.title}</h1>
          <p className="text-sm leading-5 text-[var(--color-ink-muted)]">
            {dictionary.shell.body}
          </p>
        </div>
      )}
      <nav className={cn("gap-1.5", compact ? "grid" : "grid")}>
        {items.map(([slug, label]) => (
          <Link
            key={slug}
            href={`/${locale}/${slug}`}
            onClick={onNavigate}
            className={cn(
              "rounded-[var(--radius-control)] px-3 py-2 text-sm font-medium transition focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-accent)] focus-visible:ring-offset-2",
              compact && "whitespace-normal",
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

export { navItems };
