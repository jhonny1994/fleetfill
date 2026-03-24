"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

export function AdminInvitationActions({
  invitationId,
  status,
}: {
  invitationId: string;
  status: string;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [open, setOpen] = useState(false);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (status !== "pending") {
    return null;
  }

  async function revokeInvitation() {
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("revoke_admin_invitation", {
      p_invitation_id: invitationId,
      p_reason: "Revoked from admin console",
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
        Revoke invitation
      </button>
      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        open={open}
        title="Revoke this invitation?"
        body="The invite token will stop working immediately and the invitation will be marked as revoked."
        confirmLabel="Revoke"
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={revokeInvitation}
      />
    </div>
  );
}
