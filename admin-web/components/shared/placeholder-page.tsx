import { ArrowRight } from "lucide-react";

import { EmptyState } from "@/components/shared/empty-state";
import { StatusBadge } from "@/components/shared/status-badge";

export function PlaceholderPage({
  eyebrow,
  title,
  body,
}: {
  eyebrow: string;
  title: string;
  body: string;
}) {
  return (
    <div className="space-y-5">
      <div className="flex flex-wrap items-center gap-3">
        <p className="eyebrow">{eyebrow}</p>
        <StatusBadge label="Scaffolded" tone="warning" />
      </div>
      <EmptyState eyebrow={eyebrow} title={title} body={body} />
      <section className="panel grid gap-4 p-6 lg:grid-cols-[1.2fr_0.8fr]">
        <div className="space-y-3">
          <h3 className="text-lg font-semibold text-[var(--color-ink-strong)]">
            Ready for queue wiring
          </h3>
          <p className="text-sm text-[var(--color-ink-muted)]">
            This route has the right shell and spacing contract in place. The next step is to
            connect the real queue or workspace data source.
          </p>
        </div>
        <div className="rounded-[24px] border border-[var(--color-border)] bg-white/65 p-4">
          <div className="flex items-center justify-between text-sm font-medium text-[var(--color-ink-base)]">
            <span>Implementation note</span>
            <ArrowRight className="size-4" />
          </div>
          <p className="mt-3 text-sm text-[var(--color-ink-muted)]">
            Keep this route table-first and action-first. Do not replace it with oversized cards.
          </p>
        </div>
      </section>
    </div>
  );
}
