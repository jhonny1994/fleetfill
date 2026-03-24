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
          {items.map((item) => (
            <li key={item.id} className="relative pl-6">
              <span className="absolute left-0 top-1.5 size-2 rounded-full bg-[var(--color-accent)]" />
              <div className="space-y-1">
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
