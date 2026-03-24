export function ErrorState({ title, body }: { title: string; body: string }) {
  return (
    <section className="panel border-[var(--color-red-100)] bg-white/80 p-6">
      <h2 className="text-lg font-semibold text-[var(--color-red-700)]">{title}</h2>
      <p className="mt-2 text-sm text-[var(--color-ink-muted)]">{body}</p>
    </section>
  );
}
