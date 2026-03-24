type ConfirmDialogProps = {
  title: string;
  body: string;
  confirmLabel?: string;
};

export function ConfirmDialog({
  title,
  body,
  confirmLabel = "Confirm",
}: ConfirmDialogProps) {
  return (
    <section className="panel max-w-md space-y-4 p-5">
      <h3 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h3>
      <p className="text-sm text-[var(--color-ink-muted)]">{body}</p>
      <div className="flex gap-3">
        <button className="button-secondary" type="button">
          Cancel
        </button>
        <button className="button-primary" type="button">
          {confirmLabel}
        </button>
      </div>
    </section>
  );
}
