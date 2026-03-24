import type { ReactNode } from "react";

type Fact = {
  label: string;
  value: string;
};

export function DetailWorkspace({
  eyebrow,
  title,
  description,
  facts,
  main,
  rail,
}: {
  eyebrow: string;
  title: string;
  description: string;
  facts: Fact[];
  main: ReactNode;
  rail: ReactNode;
}) {
  return (
    <div className="space-y-4">
      <section className="panel space-y-4 p-6">
        <div className="space-y-3">
          <p className="eyebrow">{eyebrow}</p>
          <h1 className="text-3xl font-semibold text-[var(--color-ink-strong)]">{title}</h1>
          <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{description}</p>
        </div>
        <div className="grid gap-3 lg:grid-cols-4">
          {facts.map((fact) => (
            <div key={fact.label} className="rounded-[22px] border border-[var(--color-border)] bg-white/55 px-4 py-3">
              <p className="text-xs font-semibold uppercase tracking-[0.14em] text-[var(--color-ink-muted)]">
                {fact.label}
              </p>
              <p className="mt-2 text-base font-medium text-[var(--color-ink-strong)]">{fact.value}</p>
            </div>
          ))}
        </div>
      </section>
      <div className="grid gap-4 xl:grid-cols-[minmax(0,1.5fr)_minmax(340px,0.9fr)]">
        <div className="space-y-4">{main}</div>
        <div className="space-y-4">{rail}</div>
      </div>
    </div>
  );
}
