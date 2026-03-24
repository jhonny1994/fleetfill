"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { getAdminUi } from "@/lib/i18n/admin-ui";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

export function EmailDeliveryRetryAction({
  deliveryLogId,
  locale = "en",
}: {
  deliveryLogId: string;
  locale?: string;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [open, setOpen] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const ui = getAdminUi(locale);

  async function retry() {
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_retry_email_delivery", {
      p_delivery_log_id: deliveryLogId,
    });
    setIsPending(false);
    setOpen(false);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-2">
      <button type="button" className="button-secondary" onClick={() => setOpen(true)}>
        {ui.actions.retryEmailDelivery}
      </button>
      {error ? <p className="text-xs text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={open}
        locale={locale}
        title={ui.actions.retryEmailDeliveryTitle}
        body={ui.actions.retryEmailDeliveryBody}
        confirmLabel={ui.actions.retry}
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={retry}
      />
    </div>
  );
}

export function EmailDeadLetterRetryAction({
  jobId,
  locale = "en",
}: {
  jobId: string;
  locale?: string;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [open, setOpen] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const ui = getAdminUi(locale);

  async function retry() {
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_retry_dead_letter_email_job", {
      p_job_id: jobId,
    });
    setIsPending(false);
    setOpen(false);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-2">
      <button type="button" className="button-secondary" onClick={() => setOpen(true)}>
        {ui.actions.retryDeadLetter}
      </button>
      {error ? <p className="text-xs text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={open}
        locale={locale}
        title={ui.actions.retryDeadLetterTitle}
        body={ui.actions.retryDeadLetterBody}
        confirmLabel={ui.actions.retry}
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={retry}
      />
    </div>
  );
}
