"use client";

import { useId } from "react";

import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";

type ConfirmDialogProps = {
  open: boolean;
  title: string;
  body: string;
  locale?: AppLocale | string;
  confirmLabel?: string;
  cancelLabel?: string;
  isPending?: boolean;
  onCancel: () => void;
  onConfirm: () => void;
};

export function ConfirmDialog({
  open,
  title,
  body,
  locale = "en",
  confirmLabel,
  cancelLabel,
  isPending = false,
  onCancel,
  onConfirm,
}: ConfirmDialogProps) {
  const ui = getAdminUi(locale);
  const titleId = useId();
  const bodyId = useId();

  if (!open) {
    return null;
  }

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-[rgba(23,38,49,0.35)] p-4">
      <section
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        className="panel max-w-md space-y-4 p-5"
      >
        <h3 id={titleId} className="text-lg font-semibold text-[var(--color-ink-strong)]">
          {title}
        </h3>
        <p id={bodyId} className="text-sm text-[var(--color-ink-muted)]">
          {body}
        </p>
        <div className="flex gap-3">
          <button className="button-secondary" type="button" onClick={onCancel} disabled={isPending}>
            {cancelLabel ?? ui.actions.cancel}
          </button>
          <button className="button-primary" type="button" onClick={onConfirm} disabled={isPending}>
            {isPending ? ui.actions.working : (confirmLabel ?? ui.actions.confirm)}
          </button>
        </div>
      </section>
    </div>
  );
}
