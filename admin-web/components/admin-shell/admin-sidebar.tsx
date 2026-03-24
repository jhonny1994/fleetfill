"use client";

import Link from "next/link";
import { useSelectedLayoutSegment } from "next/navigation";

import type { AppLocale } from "@/lib/i18n/config";
import { cn } from "@/lib/utils";

const items = [
  ["dashboard", "Control tower"],
  ["payments", "Payments"],
  ["verification", "Verification"],
  ["disputes", "Disputes"],
  ["payouts", "Payouts"],
  ["support", "Support"],
  ["users", "Users"],
  ["admins", "Admins"],
  ["settings", "Settings"],
  ["audit-and-health", "Audit & health"],
] as const;

export function AdminSidebar({
  locale,
}: {
  locale: AppLocale;
}) {
  const activeSegment = useSelectedLayoutSegment();

  return (
    <aside className="panel flex h-full flex-col gap-5 p-5">
      <div className="space-y-2">
        <p className="eyebrow">FleetFill Admin</p>
        <h1 className="text-xl font-semibold text-[var(--color-ink-strong)]">Operations desk</h1>
        <p className="text-sm text-[var(--color-ink-muted)]">
          Queue-first tools for verification, payouts, disputes, support, and platform control.
        </p>
      </div>
      <nav className="grid gap-2">
        {items.map(([slug, label]) => (
          <Link
            key={slug}
            href={`/${locale}/${slug}`}
            className={cn(
              "rounded-2xl px-4 py-3 text-sm font-medium transition",
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
