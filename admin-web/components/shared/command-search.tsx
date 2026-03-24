"use client";

import { Search } from "lucide-react";

export function CommandSearch({
  defaultValue,
  inputName,
}: {
  defaultValue?: string;
  inputName?: string;
}) {
  if (inputName) {
    return (
      <label className="flex h-11 w-full items-center gap-3 rounded-full border border-[var(--color-border)] bg-white/70 px-4 text-sm text-[var(--color-ink-muted)]">
        <Search className="size-4" />
        <input
          type="search"
          name={inputName}
          defaultValue={defaultValue}
          placeholder="Search bookings, users, disputes, payouts, support..."
          className="min-w-0 flex-1 border-0 bg-transparent text-[var(--color-ink-strong)] outline-none placeholder:text-[var(--color-ink-muted)]"
        />
      </label>
    );
  }

  return (
    <button
      type="button"
      className="flex w-full items-center gap-3 rounded-full border border-[var(--color-border)] bg-white/70 px-4 py-3 text-left text-sm text-[var(--color-ink-muted)]"
    >
      <Search className="size-4" />
      <span>Search bookings, users, disputes, payouts, support...</span>
      <span className="ml-auto rounded-full bg-[var(--color-surface-muted)] px-2 py-1 text-[0.72rem] text-[var(--color-ink-base)]">
        /
      </span>
    </button>
  );
}
