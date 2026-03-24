export default function LocaleNotFound() {
  return (
    <main className="flex min-h-[60vh] items-center justify-center">
      <section className="panel max-w-lg space-y-3 p-6 text-center">
        <p className="eyebrow">FleetFill Admin</p>
        <h1 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
          This admin page does not exist.
        </h1>
        <p className="text-sm text-[var(--color-ink-muted)]">
          Check the route or go back to the control tower.
        </p>
      </section>
    </main>
  );
}
