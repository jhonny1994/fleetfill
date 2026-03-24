import Link from "next/link";

import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";

export function FilePreviewPanel({
  locale = "en",
  title,
  label,
  storagePath,
  signedUrl,
  contentType,
}: {
  locale?: AppLocale | string;
  title?: string;
  label: string;
  storagePath: string;
  signedUrl?: string | null;
  contentType?: string | null;
}) {
  const ui = getAdminUi(locale);
  const normalizedType = (contentType ?? "").toLowerCase();
  const isImage = normalizedType.startsWith("image/");
  const isPdf = normalizedType === "application/pdf";

  return (
    <section className="panel space-y-4 p-5">
      <div className="space-y-1">
        <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title ?? ui.labels.queue}</h2>
        <p className="text-sm text-[var(--color-ink-muted)]">{label}</p>
      </div>
      <div className="rounded-[24px] border border-[var(--color-border)] bg-white/55 p-3">
        {signedUrl && isImage ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={signedUrl} alt={label} className="max-h-[480px] w-full rounded-[18px] object-contain" />
        ) : signedUrl && isPdf ? (
          <iframe src={signedUrl} title={label} className="h-[480px] w-full rounded-[18px] border-0 bg-white" />
        ) : signedUrl ? (
          <div className="space-y-3">
            <p className="text-sm text-[var(--color-ink-muted)]">{ui.labels.previewUnavailable}</p>
            <Link href={signedUrl} target="_blank" className="button-secondary">
              {ui.labels.openFile}
            </Link>
          </div>
        ) : (
          <p className="text-sm text-[var(--color-ink-muted)]">{ui.labels.noSignedPreview}</p>
        )}
      </div>
      <p className="text-xs text-[var(--color-ink-muted)]">{storagePath}</p>
    </section>
  );
}
