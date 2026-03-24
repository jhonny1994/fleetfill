"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

const schema = z.object({
  reason: z.string().trim().max(500).optional().or(z.literal("")),
});

export function UserActivationActions({
  profileId,
  isActive,
}: {
  profileId: string;
  isActive: boolean;
}) {
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
      p_reason: pendingValues.reason || null,
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
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{isActive ? "Suspend user" : "Reactivate user"}</h3>
        <p className="text-sm leading-6 text-[var(--color-ink-muted)]">
          {isActive
            ? "Use this when the account should be blocked from platform activity until an operator resolves the issue."
            : "Use this to restore account access after a suspension or moderation hold."}
        </p>
        <form className="space-y-3" onSubmit={form.handleSubmit((values) => setPendingValues(values))}>
          <label className="grid gap-1 text-sm">
            <span>Reason</span>
            <textarea
              className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2"
              {...form.register("reason")}
            />
          </label>
          <button className={isActive ? "button-secondary" : "button-primary"} type="submit">
            {isActive ? "Suspend user" : "Reactivate user"}
          </button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingValues !== null}
        title={isActive ? "Suspend this user?" : "Reactivate this user?"}
        body={
          isActive
            ? "This will block the account from normal app access until an admin reactivates it."
            : "This will restore the account and allow the user back into the platform."
        }
        confirmLabel={isActive ? "Suspend" : "Reactivate"}
        isPending={isPending}
        onCancel={() => setPendingValues(null)}
        onConfirm={confirm}
      />
    </div>
  );
}
