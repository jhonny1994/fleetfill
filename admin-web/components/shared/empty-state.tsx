export function EmptyState({
  eyebrow,
  title,
  body,
}: {
  eyebrow: string;
  title: string;
  body: string;
}) {
  return (
    <section className="panel space-y-3 p-6">
      <p className="eyebrow">{eyebrow}</p>
      <h2 className="text-xl font-semibold text-[var(--color-ink-strong)]">{title}</h2>
      <p className="max-w-2xl text-sm text-[var(--color-ink-muted)]">{body}</p>
    </section>
  );
}
