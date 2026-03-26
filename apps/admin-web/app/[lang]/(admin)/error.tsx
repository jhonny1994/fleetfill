"use client";

import { usePathname } from "next/navigation";

import { ErrorState } from "@/components/shared/error-state";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";
import { getSupportUiCopy } from "@/lib/i18n/admin-ui";

export default function AdminRouteError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  const pathname = usePathname();
  const segment = pathname?.split("/")[1] ?? defaultLocale;
  const locale = isSupportedLocale(segment) ? segment : defaultLocale;
  const copy = getSupportUiCopy(locale);

  return (
    <div className="space-y-4">
      <ErrorState title={copy.routeErrorTitle} body={error.message} />
      <button className="button-primary" type="button" onClick={reset}>
        {copy.routeRetry}
      </button>
    </div>
  );
}
