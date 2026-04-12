"use client";

export default function AdminLoading() {
  return (
    <div className="space-y-4 animate-pulse">
      <section className="panel space-y-3 p-6">
        <div className="h-4 w-28 rounded-full bg-[var(--color-sand-100)]" />
        <div className="h-9 w-80 max-w-full rounded-full bg-[var(--color-sand-100)]" />
        <div className="h-4 w-full max-w-3xl rounded-full bg-[var(--color-sand-100)]" />
        <div className="h-4 w-2/3 max-w-2xl rounded-full bg-[var(--color-sand-100)]" />
      </section>
      <section className="panel toolbar-surface">
        <div className="toolbar-row">
          <div className="toolbar-controls">
            <div className="h-12 min-w-0 flex-[1.6] rounded-[22px] bg-white/70" />
            <div className="h-12 min-w-[180px] max-w-[220px] rounded-[22px] bg-white/70" />
          </div>
          <div className="toolbar-actions">
            <div className="h-11 w-24 rounded-[22px] bg-[var(--color-sand-100)]" />
            <div className="toolbar-utility">
              <div className="h-11 w-24 rounded-[22px] bg-[var(--color-sand-100)]" />
              <div className="h-11 w-11 rounded-full bg-[var(--color-sand-100)]" />
            </div>
          </div>
        </div>
      </section>
      <section className="table-shell p-4">
        <div className="space-y-3">
          <div className="grid grid-cols-4 gap-3">
            <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
          </div>
          {Array.from({ length: 6 }).map((_, index) => (
            <div key={index} className="grid grid-cols-4 gap-3 rounded-[22px] border border-[var(--color-border)] bg-white/60 px-4 py-4">
              <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
              <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
              <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
              <div className="h-4 rounded-full bg-[var(--color-sand-100)]" />
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
