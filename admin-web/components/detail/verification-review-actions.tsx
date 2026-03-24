"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { verificationReviewSchema } from "@/lib/validation/review-actions";

type DocumentOption = {
  id: string;
  label: string;
  status: string;
};

export function VerificationReviewActions({
  carrierId,
  documents,
}: {
  carrierId: string;
  documents: DocumentOption[];
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [pendingApproveAll, setPendingApproveAll] = useState(false);
  const [pendingDocumentReview, setPendingDocumentReview] = useState<z.infer<typeof verificationReviewSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const form = useForm<z.infer<typeof verificationReviewSchema>>({
    resolver: zodResolver(verificationReviewSchema),
    defaultValues: {
      documentId: documents[0]?.id ?? "",
      status: "verified",
      reason: "",
    },
  });

  async function confirmApproveAll() {
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_approve_verification_packet", {
      p_carrier_id: carrierId,
    });
    setIsPending(false);
    setPendingApproveAll(false);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  async function confirmDocumentReview() {
    if (!pendingDocumentReview) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_review_verification_document", {
      p_document_id: pendingDocumentReview.documentId,
      p_status: pendingDocumentReview.status,
      p_reason: pendingDocumentReview.reason || undefined,
    });
    setIsPending(false);
    setPendingDocumentReview(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Approve complete packet</h3>
        <p className="text-sm text-[var(--color-ink-muted)]">
          Use this when the full driver and vehicle packet is complete and ready to verify in one action.
        </p>
        <button className="button-primary" type="button" onClick={() => setPendingApproveAll(true)}>
          Approve packet
        </button>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Review individual document</h3>
        <form className="space-y-3" onSubmit={form.handleSubmit((values) => setPendingDocumentReview(values))}>
          <label className="grid gap-1 text-sm">
            <span>Document</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("documentId")}>
              {documents.map((document) => (
                <option key={document.id} value={document.id}>
                  {document.label} • {document.status}
                </option>
              ))}
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>Decision</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("status")}>
              <option value="verified">Approve document</option>
              <option value="rejected">Reject document</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>Reason (required on rejection)</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("reason")} />
          </label>
          <button className="button-secondary" type="submit">Review document</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingApproveAll}
        title="Approve the full verification packet?"
        body="This will mark the packet approved and send the verification-approved notification when the packet becomes fully verified."
        confirmLabel="Approve packet"
        isPending={isPending}
        onCancel={() => setPendingApproveAll(false)}
        onConfirm={confirmApproveAll}
      />
      <ConfirmDialog
        open={pendingDocumentReview !== null}
        title="Submit document review?"
        body="This will update the document review state immediately and refresh the carrier packet."
        confirmLabel="Submit review"
        isPending={isPending}
        onCancel={() => setPendingDocumentReview(null)}
        onConfirm={confirmDocumentReview}
      />
    </div>
  );
}
