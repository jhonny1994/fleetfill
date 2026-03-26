import { AlertTriangle, ShieldAlert } from "lucide-react";

import { StatusBadge } from "@/components/shared/status-badge";

export function ExceptionAlerts({
  alerts,
  clearLabel = "Clear",
  noExceptionsBody = "No control-tower exceptions are currently above the attention threshold.",
  urgentLabel = "Urgent",
  watchLabel = "Watch",
}: {
  alerts: Array<{
    id: string;
    tone: "warning" | "danger";
    title: string;
    body: string;
  }>;
  clearLabel?: string;
  noExceptionsBody?: string;
  urgentLabel?: string;
  watchLabel?: string;
}) {
  if (alerts.length === 0) {
    return (
      <section className="panel p-5">
        <div className="flex items-center gap-3">
          <StatusBadge label={clearLabel} tone="success" />
          <p className="text-sm text-[var(--color-ink-muted)]">{noExceptionsBody}</p>
        </div>
      </section>
    );
  }

  return (
    <section className="grid gap-3 xl:grid-cols-2">
      {alerts.map((alert) => (
        <article key={alert.id} className="panel flex gap-4 p-5">
          <div className="mt-1 rounded-full bg-[var(--color-red-100)] p-2 text-[var(--color-red-700)]">
            {alert.tone === "danger" ? <ShieldAlert className="size-4" /> : <AlertTriangle className="size-4" />}
          </div>
          <div className="space-y-2">
            <div className="flex items-center gap-3">
              <h3 className="text-base font-semibold text-[var(--color-ink-strong)]">{alert.title}</h3>
              <StatusBadge label={alert.tone === "danger" ? urgentLabel : watchLabel} tone={alert.tone} />
            </div>
            <p className="text-sm text-[var(--color-ink-muted)]">{alert.body}</p>
          </div>
        </article>
      ))}
    </section>
  );
}
