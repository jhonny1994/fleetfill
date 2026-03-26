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
    <div className="queue-scope-tabs">
      {scopes.map((scope) => {
        const isActive = scope === currentScope;
        return (
          <Link
            key={scope}
            href={buildHref(pathname, scope, query, status)}
            aria-current={isActive ? "page" : undefined}
            className={isActive ? "queue-scope-tab queue-scope-tab-active" : "queue-scope-tab"}
          >
            {scopeLabel(locale, scope)}
            {counts?.[scope] != null ? ` (${counts[scope]})` : ""}
          </Link>
        );
      })}
    </div>
  );
}
