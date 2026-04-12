import Link from "next/link";

export function FilePreviewPanel({
  title,
  label,
  storagePath,
  signedUrl,
  contentType,
  previewUnavailableLabel,
  openFileLabel,
  noSignedPreviewLabel,
}: {
  title: string;
  label: string;
  storagePath: string;
  signedUrl?: string | null;
  contentType?: string | null;
  previewUnavailableLabel: string;
  openFileLabel: string;
  noSignedPreviewLabel: string;
}) {
  const normalizedType = (contentType ?? "").toLowerCase();
  const isImage = normalizedType.startsWith("image/");
  const isPdf = normalizedType === "application/pdf";

  return (
    <section className="panel space-y-4 p-5">
      <div className="space-y-1">
        <h2 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h2>
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
            <p className="text-sm text-[var(--color-ink-muted)]">{previewUnavailableLabel}</p>
            <Link href={signedUrl} target="_blank" className="button-secondary">
              {openFileLabel}
            </Link>
          </div>
        ) : (
          <p className="text-sm text-[var(--color-ink-muted)]">{noSignedPreviewLabel}</p>
        )}
      </div>
      <p className="text-xs text-[var(--color-ink-muted)]">{storagePath}</p>
    </section>
  );
}
