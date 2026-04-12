"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import type { AppLocale } from "@/lib/i18n/config";
import { getAdminActionErrorMessage, getEnumLabel } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { verificationReviewSchema } from "@/lib/validation/review-actions";

type DocumentOption = {
  id: string;
  label: string;
  status: string;
};

export function VerificationReviewActions({
  locale,
  carrierId,
  documents,
}: {
  locale: AppLocale | string;
  carrierId: string;
  documents: DocumentOption[];
}) {
  const ui = useAdminUi();
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

  useEffect(() => {
    form.reset({
      documentId: documents[0]?.id ?? "",
      status: "verified",
      reason: "",
    });
  }, [documents, form]);

  async function confirmApproveAll() {
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_approve_verification_packet", {
      p_carrier_id: carrierId,
    });
    setIsPending(false);
    setPendingApproveAll(false);
    if (rpcError) {
      setError(getAdminActionErrorMessage(ui, rpcError.message, rpcError.code));
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
      setError(getAdminActionErrorMessage(ui, rpcError.message, rpcError.code));
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.approvePacket}</h3>
        <p className="text-sm text-[var(--color-ink-muted)]">
          {ui.actions.approvePacketBody}
        </p>
        <button className="button-primary" type="button" onClick={() => setPendingApproveAll(true)}>
          {ui.actions.approvePacket}
        </button>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.reviewDocument}</h3>
        <form className="space-y-3" onSubmit={form.handleSubmit((values) => setPendingDocumentReview(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.document}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("documentId")}>
              {documents.map((document) => (
                <option key={document.id} value={document.id}>
                  {document.label} • {getEnumLabel(locale, "verification", document.status)}
                </option>
              ))}
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.decision}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("status")}>
              <option value="verified">{ui.actions.approveDocument}</option>
              <option value="rejected">{ui.actions.rejectDocument}</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.reasonRequired}</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...form.register("reason")} />
          </label>
          <button className="button-secondary" type="submit">{ui.actions.reviewDocument}</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingApproveAll}
        title={ui.actions.approvePacketTitle}
        body={ui.actions.approvePacketConfirmBody}
        confirmLabel={ui.actions.approvePacket}
        isPending={isPending}
        onCancel={() => setPendingApproveAll(false)}
        onConfirm={confirmApproveAll}
      />
      <ConfirmDialog
        open={pendingDocumentReview !== null}
        title={ui.actions.submitReviewTitle}
        body={ui.actions.submitReviewBody}
        confirmLabel={ui.actions.reviewDocument}
        isPending={isPending}
        onCancel={() => setPendingDocumentReview(null)}
        onConfirm={confirmDocumentReview}
      />
    </div>
  );
}
