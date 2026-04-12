"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { getAdminActionErrorMessage } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { paymentApproveSchema, paymentRejectSchema } from "@/lib/validation/review-actions";

export function PaymentReviewActions({
  proofId,
  defaultAmount,
}: {
  proofId: string;
  defaultAmount: number;
}) {
  const ui = useAdminUi();
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [error, setError] = useState<string | null>(null);
  const [pendingApprove, setPendingApprove] = useState<z.infer<typeof paymentApproveSchema> | null>(null);
  const [pendingReject, setPendingReject] = useState<z.infer<typeof paymentRejectSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);

  const approveForm = useForm<z.input<typeof paymentApproveSchema>, unknown, z.output<typeof paymentApproveSchema>>({
    resolver: zodResolver(paymentApproveSchema),
    defaultValues: {
      verifiedAmountDzd: defaultAmount,
      verifiedReference: "",
      decisionNote: "",
    },
  });
  const rejectForm = useForm<z.input<typeof paymentRejectSchema>, unknown, z.output<typeof paymentRejectSchema>>({
    resolver: zodResolver(paymentRejectSchema),
    defaultValues: {
      rejectionReason: "",
      decisionNote: "",
    },
  });

  useEffect(() => {
    approveForm.reset({
      verifiedAmountDzd: defaultAmount,
      verifiedReference: "",
      decisionNote: "",
    });
  }, [approveForm, defaultAmount]);

  async function confirmApprove() {
    if (!pendingApprove) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_approve_payment_proof", {
      p_payment_proof_id: proofId,
      p_verified_amount_dzd: pendingApprove.verifiedAmountDzd,
      p_verified_reference: pendingApprove.verifiedReference || undefined,
      p_decision_note: pendingApprove.decisionNote || undefined,
    });
    setIsPending(false);
    setPendingApprove(null);
    if (rpcError) {
      setError(getAdminActionErrorMessage(ui, rpcError.message, rpcError.code));
      return;
    }
    router.refresh();
  }

  async function confirmReject() {
    if (!pendingReject) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_reject_payment_proof", {
      p_payment_proof_id: proofId,
      p_rejection_reason: pendingReject.rejectionReason,
      p_decision_note: pendingReject.decisionNote || undefined,
    });
    setIsPending(false);
    setPendingReject(null);
    if (rpcError) {
      setError(getAdminActionErrorMessage(ui, rpcError.message, rpcError.code));
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.approveProof}</h3>
        <form className="space-y-3" onSubmit={approveForm.handleSubmit((values) => setPendingApprove(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.verifiedAmount}</span>
            <input type="number" step="1" className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...approveForm.register("verifiedAmountDzd")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.verifiedReference}</span>
            <input className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...approveForm.register("verifiedReference")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.decisionNote}</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...approveForm.register("decisionNote")} />
          </label>
          <button className="button-primary" type="submit">{ui.actions.approveProof}</button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.rejectProof}</h3>
        <form className="space-y-3" onSubmit={rejectForm.handleSubmit((values) => setPendingReject(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.rejectionReason}</span>
            <input className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...rejectForm.register("rejectionReason")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.decisionNote}</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...rejectForm.register("decisionNote")} />
          </label>
          <button className="button-secondary" type="submit">{ui.actions.rejectProof}</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingApprove !== null}
        title={ui.actions.approveTitle}
        body={ui.actions.approveBody}
        confirmLabel={ui.actions.approveProof}
        isPending={isPending}
        onCancel={() => setPendingApprove(null)}
        onConfirm={confirmApprove}
      />
      <ConfirmDialog
        open={pendingReject !== null}
        title={ui.actions.rejectTitle}
        body={ui.actions.rejectBody}
        confirmLabel={ui.actions.rejectProof}
        isPending={isPending}
        onCancel={() => setPendingReject(null)}
        onConfirm={confirmReject}
      />
    </div>
  );
}
