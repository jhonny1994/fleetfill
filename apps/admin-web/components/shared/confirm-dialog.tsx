"use client";

import { useEffect, useRef } from "react";

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogTitle,
} from "@/components/shared/dialog";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";

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
  confirmLabel,
  cancelLabel,
  isPending = false,
  onCancel,
  onConfirm,
}: ConfirmDialogProps) {
  const ui = useAdminUi();
  const previousActiveElementRef = useRef<HTMLElement | null>(null);

  useEffect(() => {
    if (open && document.activeElement instanceof HTMLElement) {
      previousActiveElementRef.current = document.activeElement;
      return;
    }

    if (!open) {
      previousActiveElementRef.current?.focus();
    }
  }, [open]);

  return (
    <Dialog open={open} onOpenChange={(nextOpen) => (!nextOpen ? onCancel() : undefined)}>
      <DialogContent
        className="panel space-y-4 p-5"
        onCloseAutoFocus={(event) => {
          event.preventDefault();
          previousActiveElementRef.current?.focus();
        }}
      >
        <DialogTitle>
          {title}
        </DialogTitle>
        <DialogDescription>
          {body}
        </DialogDescription>
        <div className="flex gap-3">
          <button className="button-secondary" type="button" onClick={onCancel} disabled={isPending}>
            {cancelLabel ?? ui.actions.cancel}
          </button>
          <button className="button-primary" type="button" onClick={onConfirm} disabled={isPending}>
            {isPending ? ui.actions.working : (confirmLabel ?? ui.actions.confirm)}
          </button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
