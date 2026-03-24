import type { ReactNode } from "react";

import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";

export function ActionRail({
  locale = "en",
  title,
  description,
  children,
}: {
  locale?: AppLocale | string;
  title?: string;
  description?: string;
  children: ReactNode;
}) {
  const ui = getAdminUi(locale);
  return (
    <aside className="panel space-y-4 p-5">
      <div className="space-y-2">
        <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title ?? ui.actions.confirm}</h2>
        {description ? <p className="text-sm text-[var(--color-ink-muted)]">{description}</p> : null}
      </div>
      <div className="space-y-4">{children}</div>
    </aside>
  );
}
