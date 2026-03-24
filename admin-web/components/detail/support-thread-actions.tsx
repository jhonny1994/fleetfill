"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { supportReplySchema, supportStatusSchema } from "@/lib/validation/review-actions";

export function SupportThreadActions({
  requestId,
  currentStatus,
  currentPriority,
}: {
  requestId: string;
  currentStatus: string;
  currentPriority: string;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [pendingReply, setPendingReply] = useState<z.infer<typeof supportReplySchema> | null>(null);
  const [pendingStatus, setPendingStatus] = useState<z.infer<typeof supportStatusSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const replyForm = useForm<z.infer<typeof supportReplySchema>>({
    resolver: zodResolver(supportReplySchema),
    defaultValues: { message: "" },
  });
  const statusForm = useForm<z.infer<typeof supportStatusSchema>>({
    resolver: zodResolver(supportStatusSchema),
    defaultValues: { status: currentStatus as z.infer<typeof supportStatusSchema>["status"], priority: currentPriority as z.infer<typeof supportStatusSchema>["priority"] },
  });

  async function confirmReply() {
    if (!pendingReply) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("reply_to_support_request", {
      p_request_id: requestId,
      p_message: pendingReply.message,
    });
    setIsPending(false);
    setPendingReply(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    replyForm.reset({ message: "" });
    router.refresh();
  }

  async function confirmStatus() {
    if (!pendingStatus) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_set_support_request_status", {
      p_request_id: requestId,
      p_status: pendingStatus.status,
      p_priority: pendingStatus.priority ?? undefined,
    });
    setIsPending(false);
    setPendingStatus(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Reply to thread</h3>
        <form className="space-y-3" onSubmit={replyForm.handleSubmit((values) => setPendingReply(values))}>
          <label className="grid gap-1 text-sm">
            <span>Reply</span>
            <textarea className="min-h-28 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...replyForm.register("message")} />
          </label>
          <button className="button-primary" type="submit">Send reply</button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Update status</h3>
        <form className="space-y-3" onSubmit={statusForm.handleSubmit((values) => setPendingStatus(values))}>
          <label className="grid gap-1 text-sm">
            <span>Status</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...statusForm.register("status")}>
              <option value="open">Open</option>
              <option value="in_progress">In progress</option>
              <option value="waiting_for_user">Waiting for user</option>
              <option value="resolved">Resolved</option>
              <option value="closed">Closed</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>Priority</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...statusForm.register("priority")}>
              <option value="normal">Normal</option>
              <option value="high">High</option>
              <option value="urgent">Urgent</option>
            </select>
          </label>
          <button className="button-secondary" type="submit">Update status</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingReply !== null}
        title="Send admin reply?"
        body="This will post your reply into the support thread and notify the user."
        confirmLabel="Send reply"
        isPending={isPending}
        onCancel={() => setPendingReply(null)}
        onConfirm={confirmReply}
      />
      <ConfirmDialog
        open={pendingStatus !== null}
        title="Update support status?"
        body="This will change the support workflow state and priority for the thread."
        confirmLabel="Update"
        isPending={isPending}
        onCancel={() => setPendingStatus(null)}
        onConfirm={confirmStatus}
      />
    </div>
  );
}
