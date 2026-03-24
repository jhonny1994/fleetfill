"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi, getEnumLabel } from "@/lib/i18n/admin-ui";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { supportReplySchema, supportStatusSchema } from "@/lib/validation/review-actions";

export function SupportThreadActions({
  locale,
  requestId,
  currentStatus,
  currentPriority,
}: {
  locale: AppLocale | string;
  requestId: string;
  currentStatus: string;
  currentPriority: string;
}) {
  const ui = getAdminUi(locale);
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
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.reply}</h3>
        <form className="space-y-3" onSubmit={replyForm.handleSubmit((values) => setPendingReply(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.actions.replyLabel}</span>
            <textarea className="min-h-28 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...replyForm.register("message")} />
          </label>
          <button className="button-primary" type="submit">{ui.actions.reply}</button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.updateStatus}</h3>
        <form className="space-y-3" onSubmit={statusForm.handleSubmit((values) => setPendingStatus(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.labels.state}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...statusForm.register("status")}>
              <option value="open">{getEnumLabel(locale, "supportStatus", "open")}</option>
              <option value="in_progress">{getEnumLabel(locale, "supportStatus", "in_progress")}</option>
              <option value="waiting_for_user">{getEnumLabel(locale, "supportStatus", "waiting_for_user")}</option>
              <option value="resolved">{getEnumLabel(locale, "supportStatus", "resolved")}</option>
              <option value="closed">{getEnumLabel(locale, "supportStatus", "closed")}</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.labels.priority}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...statusForm.register("priority")}>
              <option value="normal">{getEnumLabel(locale, "supportPriority", "normal")}</option>
              <option value="high">{getEnumLabel(locale, "supportPriority", "high")}</option>
              <option value="urgent">{getEnumLabel(locale, "supportPriority", "urgent")}</option>
            </select>
          </label>
          <button className="button-secondary" type="submit">{ui.actions.updateStatus}</button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        locale={locale}
        open={pendingReply !== null}
        title={ui.actions.sendReplyTitle}
        body={ui.actions.sendReplyBody}
        confirmLabel={ui.actions.reply}
        isPending={isPending}
        onCancel={() => setPendingReply(null)}
        onConfirm={confirmReply}
      />
      <ConfirmDialog
        locale={locale}
        open={pendingStatus !== null}
        title={ui.actions.updateStatusTitle}
        body={ui.actions.updateStatusBody}
        confirmLabel={ui.actions.updateStatus}
        isPending={isPending}
        onCancel={() => setPendingStatus(null)}
        onConfirm={confirmStatus}
      />
    </div>
  );
}
