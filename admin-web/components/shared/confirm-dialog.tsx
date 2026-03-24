"use client";

import { useId } from "react";

type ConfirmDialogProps = {
  open: boolean;
  title: string;
  body: string;
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
  confirmLabel = "Confirm",
  cancelLabel = "Cancel",
  isPending = false,
  onCancel,
  onConfirm,
}: ConfirmDialogProps) {
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
            {cancelLabel}
          </button>
          <button className="button-primary" type="button" onClick={onConfirm} disabled={isPending}>
            {isPending ? "Working..." : confirmLabel}
          </button>
        </div>
      </section>
    </div>
  );
}
