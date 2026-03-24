"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

const schema = z.object({
  reason: z.string().trim().max(500).optional().or(z.literal("")),
});

export function UserActivationActions({
  locale,
  profileId,
  isActive,
}: {
  locale: AppLocale | string;
  profileId: string;
  isActive: boolean;
}) {
  const ui = getAdminUi(locale);
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [pendingValues, setPendingValues] = useState<z.infer<typeof schema> | null>(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const form = useForm<z.input<typeof schema>, unknown, z.output<typeof schema>>({
    resolver: zodResolver(schema),
    defaultValues: {
      reason: "",
    },
  });

  async function confirm() {
    if (!pendingValues) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_set_profile_active", {
      p_profile_id: profileId,
      p_is_active: !isActive,
      p_reason: pendingValues.reason || undefined,
    });
    setIsPending(false);
    setPendingValues(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-4">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{isActive ? ui.actions.suspendUser : ui.actions.reactivateUser}</h3>
        <p className="text-sm leading-6 text-[var(--color-ink-muted)]">
          {isActive ? ui.actions.suspendBody : ui.actions.reactivateBody}
        </p>
        <form className="space-y-3" onSubmit={form.handleSubmit((values) => setPendingValues(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.labels.reason}</span>
            <textarea
              className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2"
              {...form.register("reason")}
            />
          </label>
          <button className={isActive ? "button-secondary" : "button-primary"} type="submit">
            {isActive ? ui.actions.suspendUser : ui.actions.reactivateUser}
          </button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        locale={locale}
        open={pendingValues !== null}
        title={isActive ? ui.actions.suspendTitle : ui.actions.reactivateTitle}
        body={isActive ? ui.actions.suspendConfirmBody : ui.actions.reactivateConfirmBody}
        confirmLabel={isActive ? ui.actions.suspendUser : ui.actions.reactivateUser}
        isPending={isPending}
        onCancel={() => setPendingValues(null)}
        onConfirm={confirm}
      />
    </div>
  );
}
