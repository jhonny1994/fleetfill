"use client";

import Link from "next/link";

import type { AdminUi } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";

type QueueScope = "open" | "history" | "all";

function scopeLabel(labels: AdminUi["labels"], scope: QueueScope) {
  return scope === "open"
    ? labels.queueScopeOpen
    : scope === "history"
      ? labels.queueScopeHistory
      : labels.queueScopeAll;
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
  currentScope,
  query,
  status,
  counts,
}: {
  pathname: string;
  currentScope: QueueScope;
  query?: string;
  status?: string;
  counts?: Partial<Record<QueueScope, number>>;
}) {
  const scopes: QueueScope[] = ["open", "history", "all"];
  const ui = useAdminUi();

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
            {scopeLabel(ui.labels, scope)}
            {counts?.[scope] != null ? ` (${counts[scope]})` : ""}
          </Link>
        );
      })}
    </div>
  );
}
