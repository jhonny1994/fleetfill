"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { disputeCompleteSchema, disputeRefundSchema } from "@/lib/validation/review-actions";

export function DisputeResolutionActions({ disputeId }: { disputeId: string }) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [pendingComplete, setPendingComplete] = useState<z.infer<typeof disputeCompleteSchema> | null>(null);
  const [pendingRefund, setPendingRefund] = useState<z.infer<typeof disputeRefundSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const completeForm = useForm<z.input<typeof disputeCompleteSchema>, unknown, z.output<typeof disputeCompleteSchema>>({
    resolver: zodResolver(disputeCompleteSchema),
    defaultValues: { resolutionNote: "" },
  });
  const refundForm = useForm<z.input<typeof disputeRefundSchema>, unknown, z.output<typeof disputeRefundSchema>>({
    resolver: zodResolver(disputeRefundSchema),
    defaultValues: {
      refundAmountDzd: 0,
      refundReason: "",
      externalReference: "",
      resolutionNote: "",
    },
  });

  async function confirmComplete() {
    if (!pendingComplete) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_resolve_dispute_complete", {
      p_dispute_id: disputeId,
      p_resolution_note: pendingComplete.resolutionNote || null,
    });
    setIsPending(false);
    setPendingComplete(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  async function confirmRefund() {
    if (!pendingRefund) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_resolve_dispute_refund", {
      p_dispute_id: disputeId,
      p_refund_amount_dzd: pendingRefund.refundAmountDzd,
      p_refund_reason: pendingRefund.refundReason,
      p_external_reference: pendingRefund.externalReference || null,
      p_resolution_note: pendingRefund.resolutionNote || null,
    });
    setIsPending(false);
    setPendingRefund(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Resolve without refund</h3>
        <form className="space-y-3" onSubmit={completeForm.handleSubmit((values) => setPendingComplete(values))}>
          <label className="grid gap-1 text-sm">
            <span>Resolution note</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...completeForm.register("resolutionNote")} />
          </label>
          <button className="button-primary" type="submit">Mark complete</button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Resolve with refund</h3>
        <form className="space-y-3" onSubmit={refundForm.handleSubmit((values) => setPendingRefund(values))}>
          <label className="grid gap-1 text-sm">
            <span>Refund amount (DZD)</span>
            <input type="number" step="1" className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...refundForm.register("refundAmountDzd")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Refund reason</span>
            <input className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...refundForm.register("refundReason")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>External reference</span>
            <input className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...refundForm.register("externalReference")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Resolution note</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...refundForm.register("resolutionNote")} />
          </label>
          <button className="button-secondary" type="submit">Issue refund</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingComplete !== null}
        title="Resolve dispute without refund?"
        body="This will close the dispute and preserve the current financial outcome."
        confirmLabel="Resolve dispute"
        isPending={isPending}
        onCancel={() => setPendingComplete(null)}
        onConfirm={confirmComplete}
      />
      <ConfirmDialog
        open={pendingRefund !== null}
        title="Resolve dispute with refund?"
        body="This will create the refund workflow and close the dispute with a refund outcome."
        confirmLabel="Create refund"
        isPending={isPending}
        onCancel={() => setPendingRefund(null)}
        onConfirm={confirmRefund}
      />
    </div>
  );
}
