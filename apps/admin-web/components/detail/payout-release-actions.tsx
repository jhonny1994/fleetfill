"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { payoutReleaseSchema } from "@/lib/validation/review-actions";

export function PayoutReleaseActions({ bookingId }: { bookingId: string }) {
  const ui = useAdminUi();
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [pendingValues, setPendingValues] = useState<z.infer<typeof payoutReleaseSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const form = useForm<z.infer<typeof payoutReleaseSchema>>({
    resolver: zodResolver(payoutReleaseSchema),
    defaultValues: {
      externalReference: "",
      note: "",
    },
  });

  async function confirmRelease() {
    if (!pendingValues) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_release_payout", {
      p_booking_id: bookingId,
      p_external_reference: pendingValues.externalReference || undefined,
      p_note: pendingValues.note || undefined,
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
      <form className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4" onSubmit={form.handleSubmit((values) => setPendingValues(values))}>
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.releasePayout}</h3>
        <label className="grid gap-1 text-sm">
          <span>{ui.detail.payouts.externalReferenceLabel}</span>
          <input className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("externalReference")} />
        </label>
        <label className="grid gap-1 text-sm">
          <span>{ui.labels.noNote}</span>
          <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("note")} />
        </label>
        <button className="button-primary" type="submit">{ui.actions.releasePayout}</button>
      </form>
      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={pendingValues !== null}
        title={ui.actions.releasePayout}
        body={ui.actions.releasePayout}
        confirmLabel={ui.actions.releasePayout}
        isPending={isPending}
        onCancel={() => setPendingValues(null)}
        onConfirm={confirmRelease}
      />
    </div>
  );
}
