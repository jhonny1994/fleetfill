export default function AdminSignInLoading() {
  return (
    <main className="flex min-h-[calc(100vh-2rem)] items-center justify-center">
      <section className="panel flex max-w-5xl animate-pulse flex-col gap-8 overflow-hidden p-6 lg:flex-row lg:p-8">
        <div className="space-y-5 lg:basis-[40%]">
          <div className="h-4 w-28 rounded-full bg-[var(--color-sand-100)]" />
          <div className="h-10 w-3/4 rounded-[22px] bg-[var(--color-sand-100)]" />
          <div className="space-y-2">
            <div className="h-4 w-full rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 w-5/6 rounded-full bg-[var(--color-sand-100)]" />
          </div>
        </div>
        <div className="panel flex flex-col gap-6 bg-[var(--color-surface-strong)] p-6 lg:basis-[60%]">
          <div className="size-14 rounded-full bg-[var(--color-sand-100)]" />
          <div className="space-y-2">
            <div className="h-6 w-44 rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 w-full rounded-full bg-[var(--color-sand-100)]" />
            <div className="h-4 w-4/5 rounded-full bg-[var(--color-sand-100)]" />
          </div>
          <div className="space-y-4">
            <div className="space-y-2">
              <div className="h-4 w-24 rounded-full bg-[var(--color-sand-100)]" />
              <div className="h-12 rounded-[22px] bg-white/75" />
            </div>
            <div className="space-y-2">
              <div className="h-4 w-24 rounded-full bg-[var(--color-sand-100)]" />
              <div className="h-12 rounded-[22px] bg-white/75" />
            </div>
            <div className="h-12 rounded-[22px] bg-[var(--color-sand-100)]" />
          </div>
        </div>
      </section>
    </main>
  );
}
