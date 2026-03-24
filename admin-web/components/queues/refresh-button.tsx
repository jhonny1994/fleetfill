"use client";

import { LoaderCircle, RefreshCcw } from "lucide-react";
import { useTransition } from "react";
import { useRouter } from "next/navigation";

import { cn } from "@/lib/utils";

export function RefreshButton({
  className,
  label = "Refresh",
  ariaLabel = "Refresh queue",
}: {
  className?: string;
  label?: string;
  ariaLabel?: string;
}) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();

  return (
    <button
      type="button"
      onClick={() => {
        startTransition(() => {
          router.refresh();
        });
      }}
      className={cn("button-secondary lg:shrink-0", className)}
      disabled={isPending}
      aria-label={ariaLabel}
    >
      {isPending ? <LoaderCircle className="size-4 animate-spin" /> : <RefreshCcw className="size-4" />}
      {label}
    </button>
  );
}
