"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

export function EmailDeliveryRetryAction({ deliveryLogId }: { deliveryLogId: string }) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [open, setOpen] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

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
        Retry delivery
      </button>
      {error ? <p className="text-xs text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={open}
        title="Retry this email delivery?"
        body="This queues a fresh high-priority email job from the failed delivery log."
        confirmLabel="Retry"
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={retry}
      />
    </div>
  );
}

export function EmailDeadLetterRetryAction({ jobId }: { jobId: string }) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [open, setOpen] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

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
        Retry dead-letter
      </button>
      {error ? <p className="text-xs text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={open}
        title="Retry this dead-letter email?"
        body="This creates a new queued email outbox job from the dead-letter payload."
        confirmLabel="Retry"
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={retry}
      />
    </div>
  );
}
