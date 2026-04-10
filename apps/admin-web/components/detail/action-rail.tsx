import type { ReactNode } from "react";

export function ActionRail({
  title,
  description,
  children,
}: {
  title: string;
  description?: string;
  children: ReactNode;
}) {
  return (
    <aside className="panel space-y-3 p-4">
      <div className="section-header">
        <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h2>
        {description ? <p className="text-sm text-[var(--color-ink-muted)]">{description}</p> : null}
      </div>
      <div className="space-y-3">{children}</div>
    </aside>
  );
}
