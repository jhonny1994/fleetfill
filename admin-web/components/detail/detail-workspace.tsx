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
  description?: string;
  facts: Fact[];
  main: ReactNode;
  rail: ReactNode;
}) {
  return (
    <div className="space-y-4">
      <section className="panel space-y-3.5 p-5">
        <div className="space-y-2">
          <p className="eyebrow">{eyebrow}</p>
          <h1 className="text-[1.45rem] font-semibold text-[var(--color-ink-strong)]">{title}</h1>
          {description ? (
            <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">{description}</p>
          ) : null}
        </div>
        {facts.length > 0 ? (
          <div className="meta-grid">
            {facts.map((fact) => (
              <div key={fact.label} className="meta-card">
                <p className="meta-card-label">{fact.label}</p>
                <p className="meta-card-value">{fact.value}</p>
              </div>
            ))}
          </div>
        ) : null}
      </section>
      <div className="grid gap-4 xl:grid-cols-[minmax(0,1.95fr)_minmax(300px,0.82fr)]">
        <div className="space-y-4">{main}</div>
        <div className="space-y-4">{rail}</div>
      </div>
    </div>
  );
}
