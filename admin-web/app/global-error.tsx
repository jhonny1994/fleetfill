"use client";

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <html>
      <body className="admin-body">
        <main className="flex min-h-screen items-center justify-center p-6">
          <section className="panel max-w-xl space-y-4 p-6 text-center">
            <p className="eyebrow">FleetFill Admin</p>
            <h1 className="text-2xl font-semibold text-[var(--color-ink-strong)]">
              The admin console hit an unrecoverable error.
            </h1>
            <p className="text-sm text-[var(--color-ink-muted)]">
              {error.message || "Please reload the page or try again in a moment."}
            </p>
            <button className="button-primary mx-auto" onClick={reset} type="button">
              Try Again
            </button>
          </section>
        </main>
      </body>
    </html>
  );
}
