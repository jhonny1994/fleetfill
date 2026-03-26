"use client";

import { useTransition } from "react";
import { useRouter } from "next/navigation";
import { LogOut } from "lucide-react";

import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import type { AppLocale } from "@/lib/i18n/config";

export function AdminIdentityControls({
  locale,
  label,
  detail,
  signOutLabel,
}: {
  locale: AppLocale;
  label: string;
  detail: string;
  signOutLabel: string;
}) {
  const router = useRouter();
  const supabase = createSupabaseBrowserClient();
  const [isPending, startTransition] = useTransition();

  async function handleSignOut() {
    await supabase.auth.signOut();
    startTransition(() => {
      router.replace(`/${locale}/sign-in`);
      router.refresh();
    });
  }

  return (
    <div className="flex items-center gap-3 rounded-full border border-[var(--color-border)] bg-white/75 px-4 py-2">
      <div className="text-sm">
        <p className="font-medium text-[var(--color-ink-strong)]">{label}</p>
        <p className="text-[var(--color-ink-muted)]">{detail}</p>
      </div>
      <button
        type="button"
        className="flex size-9 items-center justify-center rounded-full border border-[var(--color-border)]"
        aria-label={signOutLabel}
        onClick={handleSignOut}
        disabled={isPending}
      >
        <LogOut className="size-4" />
      </button>
    </div>
  );
}
