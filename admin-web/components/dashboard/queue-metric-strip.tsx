import Link from "next/link";
import { ArrowRight } from "lucide-react";

import { StatusBadge } from "@/components/shared/status-badge";

export function QueueMetricStrip({
  items,
  queueLabel = "Queue",
}: {
  items: Array<{
    label: string;
    value: string;
    tone?: "neutral" | "success" | "warning" | "danger";
    href: string;
  }>;
  queueLabel?: string;
}) {
  return (
    <section className="grid gap-3 xl:grid-cols-5">
      {items.map((item) => (
        <Link key={item.label} href={item.href} className="panel flex min-h-[120px] flex-col justify-between p-5 transition hover:-translate-y-0.5">
          <div className="flex items-start justify-between gap-3">
            <p className="text-sm font-medium text-[var(--color-ink-muted)]">{item.label}</p>
            <StatusBadge label={queueLabel} tone={item.tone ?? "neutral"} />
          </div>
          <div className="flex items-end justify-between gap-3">
            <p className="text-3xl font-semibold text-[var(--color-ink-strong)]">{item.value}</p>
            <ArrowRight className="size-4 text-[var(--color-accent)]" />
          </div>
        </Link>
      ))}
    </section>
  );
}
