import type { ReactNode } from "react";

export function ActionRail({
  title = "Actions",
  description,
  children,
}: {
  title?: string;
  description?: string;
  children: ReactNode;
}) {
  return (
    <aside className="panel space-y-4 p-5">
      <div className="space-y-2">
        <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h2>
        {description ? <p className="text-sm text-[var(--color-ink-muted)]">{description}</p> : null}
      </div>
      <div className="space-y-4">{children}</div>
    </aside>
  );
}
