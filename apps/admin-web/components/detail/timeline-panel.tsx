import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";

export type TimelineItem = {
  id: string;
  title: string;
  detail: string;
  at: string | null;
};

export function TimelinePanel({
  locale = "en",
  title,
  items,
}: {
  locale?: AppLocale | string;
  title?: string;
  items: TimelineItem[];
}) {
  const ui = getAdminUi(locale);
  return (
    <section className="panel space-y-4 p-5">
      <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title ?? ui.labels.timeline}</h2>
      {items.length === 0 ? (
        <p className="text-sm text-[var(--color-ink-muted)]">{ui.labels.noTimeline}</p>
      ) : (
        <ol className="space-y-4">
          {items.map((item, index) => (
            <li
              key={item.id}
              className={`relative flex gap-4 rounded-3xl border p-4 ${
                index === 0
                  ? "border-[var(--color-accent)] bg-[color-mix(in_srgb,var(--color-accent)_12%,white)]"
                  : "border-[var(--color-border)] bg-[var(--color-panel)]"
              }`}
            >
              <div className="relative flex w-5 justify-center">
                <span
                  className={`mt-1.5 size-2 rounded-full ${
                    index === 0 ? "bg-[var(--color-accent-strong)]" : "bg-[var(--color-accent)]"
                  }`}
                />
                {index < items.length - 1 ? (
                  <span className="absolute top-4 h-[calc(100%+12px)] w-px bg-[var(--color-border)]" />
                ) : null}
              </div>
              <div className="space-y-1">
                {index === 0 ? (
                  <span className="inline-flex rounded-full border border-[var(--color-accent)] px-2 py-0.5 text-[0.7rem] font-semibold uppercase tracking-[0.16em] text-[var(--color-accent-strong)]">
                    {ui.labels.current}
                  </span>
                ) : null}
                <p className="font-medium text-[var(--color-ink-strong)]">{item.title}</p>
                <p className="text-sm text-[var(--color-ink-muted)]">{item.detail}</p>
                {item.at ? <p className="text-xs text-[var(--color-ink-muted)]">{item.at}</p> : null}
              </div>
            </li>
          ))}
        </ol>
      )}
    </section>
  );
}
