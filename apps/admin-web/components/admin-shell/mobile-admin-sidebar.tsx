"use client";

import { Menu, X } from "lucide-react";
import { useId, useState } from "react";

import { AdminSidebar } from "@/components/admin-shell/admin-sidebar";
import { Sheet, SheetClose, SheetContent, SheetTitle, SheetTrigger } from "@/components/shared/sheet";
import type { AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";

export function MobileAdminSidebar({
  locale,
  dictionary,
  adminRole,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
  adminRole: "super_admin" | "ops_admin";
}) {
  const [open, setOpen] = useState(false);
  const isRtl = locale === "ar";
  const titleId = useId();

  return (
    <Sheet open={open} onOpenChange={setOpen}>
      <SheetTrigger asChild>
        <button
          type="button"
          aria-label={dictionary.shell.openNavigation}
          className="admin-toolbar-icon lg:hidden"
        >
          <Menu className="size-5" />
        </button>
      </SheetTrigger>
      <SheetContent
        side={isRtl ? "end" : "start"}
        aria-labelledby={titleId}
        className={isRtl ? "border-s border-[var(--color-border)]" : "border-e border-[var(--color-border)]"}
      >
        <div className="mb-2 flex items-center justify-between rounded-[var(--radius-panel)] border border-[var(--color-border)] bg-white/80 px-3 py-2.5">
          <div className="min-w-0">
            <p className="eyebrow">{dictionary.shell.eyebrow}</p>
            <SheetTitle id={titleId} className="truncate text-sm font-semibold text-[var(--color-ink-strong)]">
              {dictionary.shell.title}
            </SheetTitle>
          </div>
          <SheetClose asChild>
            <button
              type="button"
              aria-label={dictionary.shell.closeNavigation}
              className="admin-toolbar-icon size-10"
            >
              <X className="size-4" />
            </button>
          </SheetClose>
        </div>
        <AdminSidebar
          locale={locale}
          dictionary={dictionary}
          adminRole={adminRole}
          className="min-h-0 flex-1 overflow-y-auto bg-transparent shadow-none"
          onNavigate={() => setOpen(false)}
        />
      </SheetContent>
    </Sheet>
  );
}
