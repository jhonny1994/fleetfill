"use client";

import { ErrorState } from "@/components/shared/error-state";

export default function AdminRouteError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="space-y-4">
      <ErrorState title="This admin route failed to load." body={error.message} />
      <button className="button-primary" type="button" onClick={reset}>
        Retry Route
      </button>
    </div>
  );
}
