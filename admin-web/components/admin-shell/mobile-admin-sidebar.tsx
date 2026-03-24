"use client";

import { Menu, X } from "lucide-react";
import { useEffect, useState } from "react";
import { createPortal } from "react-dom";

import { AdminSidebar } from "@/components/admin-shell/admin-sidebar";
import type { AppLocale } from "@/lib/i18n/config";
import type { AdminDictionary } from "@/lib/i18n/dictionaries";

export function MobileAdminSidebar({
  locale,
  dictionary,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
}) {
  const [open, setOpen] = useState(false);
  const isRtl = locale === "ar";

  useEffect(() => {
    if (!open) {
      return;
    }

    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = previousOverflow;
    };
  }, [open]);

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        aria-label={dictionary.shell.openNavigation}
        className="admin-toolbar-icon lg:hidden"
      >
        <Menu className="size-5" />
      </button>

      {open && typeof document !== "undefined"
        ? createPortal(
        <div className="fixed inset-0 z-[120] lg:hidden">
          <button
            type="button"
            aria-label={dictionary.shell.closeNavigation}
            className="absolute inset-0 bg-[color-mix(in_srgb,var(--color-ink-strong)_28%,transparent)] backdrop-blur-[2px]"
            onClick={() => setOpen(false)}
          />
          <div
            className={[
              "absolute inset-y-0 flex w-[min(84vw,340px)] flex-col bg-[var(--color-background)] p-3 shadow-[var(--shadow-panel)]",
              isRtl ? "end-0 border-s border-[var(--color-border)]" : "start-0 border-e border-[var(--color-border)]",
            ].join(" ")}
          >
            <div className="mb-2 flex items-center justify-between rounded-[var(--radius-panel)] border border-[var(--color-border)] bg-white/80 px-3 py-2.5">
              <div className="min-w-0">
                <p className="eyebrow">{dictionary.shell.eyebrow}</p>
                <p className="truncate text-sm font-semibold text-[var(--color-ink-strong)]">{dictionary.shell.title}</p>
              </div>
              <button
                type="button"
                aria-label={dictionary.shell.closeNavigation}
                className="admin-toolbar-icon size-10"
                onClick={() => setOpen(false)}
              >
                <X className="size-4" />
              </button>
            </div>
            <AdminSidebar
              locale={locale}
              dictionary={dictionary}
              className="min-h-0 flex-1 overflow-y-auto bg-transparent shadow-none"
              onNavigate={() => setOpen(false)}
            />
          </div>
        </div>,
        document.body,
      ) : null}
    </>
  );
}
