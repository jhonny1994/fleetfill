import Link from "next/link";

type QueueScope = "open" | "history" | "all";

function scopeLabel(locale: string, scope: QueueScope) {
  switch (locale) {
    case "ar":
      return scope === "open" ? "قيد المعالجة" : scope === "history" ? "السجل" : "الكل";
    case "fr":
      return scope === "open" ? "En cours" : scope === "history" ? "Historique" : "Tout";
    default:
      return scope === "open" ? "Open" : scope === "history" ? "History" : "All";
  }
}

function buildHref(pathname: string, scope: QueueScope, query?: string, status?: string) {
  const params = new URLSearchParams();
  params.set("view", scope);
  if (query) {
    params.set("q", query);
  }
  if (status) {
    params.set("status", status);
  }
  const search = params.toString();
  return search ? `${pathname}?${search}` : pathname;
}

export function AdminQueueScopeTabs({
  pathname,
  locale,
  currentScope,
  query,
  status,
  counts,
}: {
  pathname: string;
  locale: string;
  currentScope: QueueScope;
  query?: string;
  status?: string;
  counts?: Partial<Record<QueueScope, number>>;
}) {
  const scopes: QueueScope[] = ["open", "history", "all"];

  return (
    <div className="inline-flex flex-wrap gap-1 rounded-full border border-[var(--color-border)] bg-[var(--color-surface-muted)] p-1 shadow-[inset_0_1px_0_rgba(255,255,255,0.6)]">
      {scopes.map((scope) => {
        const isActive = scope === currentScope;
        return (
          <Link
            key={scope}
            href={buildHref(pathname, scope, query, status)}
            className={
              isActive
                ? "rounded-full border border-[var(--color-accent)] bg-[var(--color-accent)] px-4 py-2 text-sm font-semibold text-white shadow-sm"
                : "rounded-full border border-transparent bg-white/80 px-4 py-2 text-sm font-medium text-[var(--color-ink-strong)] transition hover:border-[var(--color-border-strong)] hover:bg-white"
            }
          >
            {scopeLabel(locale, scope)}
            {counts?.[scope] != null ? ` (${counts[scope]})` : ""}
          </Link>
        );
      })}
    </div>
  );
}
