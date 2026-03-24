"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import type { AppLocale } from "@/lib/i18n/config";
import { getAdminUi } from "@/lib/i18n/admin-ui";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";

export function AdminInvitationActions({
  locale,
  invitationId,
  status,
}: {
  locale: AppLocale | string;
  invitationId: string;
  status: string;
}) {
  const ui = getAdminUi(locale);
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
      p_reason: ui.actions.revokeReason,
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
        {ui.actions.revoke}
      </button>
      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}
      <ConfirmDialog
        locale={locale}
        open={open}
        title={ui.actions.revokeTitle}
        body={ui.actions.revokeBody}
        confirmLabel={ui.actions.revoke}
        isPending={isPending}
        onCancel={() => setOpen(false)}
        onConfirm={revokeInvitation}
      />
    </div>
  );
}
