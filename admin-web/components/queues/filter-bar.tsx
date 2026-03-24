import { SlidersHorizontal } from "lucide-react";

import { CommandSearch } from "@/components/shared/command-search";

export function FilterBar() {
  return (
    <section className="panel flex flex-col gap-4 p-4 lg:flex-row lg:items-center">
      <div className="min-w-0 flex-1">
        <CommandSearch />
      </div>
      <button className="button-secondary lg:shrink-0" type="button">
        <SlidersHorizontal className="size-4" />
        Filters
      </button>
    </section>
  );
}
