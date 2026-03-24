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
    <section className="panel space-y-2 p-4">
      <p className="eyebrow">{eyebrow}</p>
      <h2 className="text-[1.05rem] font-semibold text-[var(--color-ink-strong)]">{title}</h2>
      <p className="max-w-2xl text-sm leading-6 text-[var(--color-ink-muted)]">{body}</p>
    </section>
  );
}
