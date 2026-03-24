"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { adminActivationSchema, adminRoleChangeSchema } from "@/lib/validation/admin-management";

export function AdminAccountActions({
  profileId,
  currentRole,
  isActive,
}: {
  profileId: string;
  currentRole: "super_admin" | "ops_admin";
  isActive: boolean;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [error, setError] = useState<string | null>(null);
  const [pendingRole, setPendingRole] = useState<z.infer<typeof adminRoleChangeSchema> | null>(null);
  const [pendingActivation, setPendingActivation] = useState<z.infer<typeof adminActivationSchema> | null>(null);
  const [isPending, setIsPending] = useState(false);

  const roleForm = useForm<z.input<typeof adminRoleChangeSchema>, unknown, z.output<typeof adminRoleChangeSchema>>({
    resolver: zodResolver(adminRoleChangeSchema),
    defaultValues: {
      role: currentRole,
      reason: "",
    },
  });

  const activationForm = useForm<z.input<typeof adminActivationSchema>, unknown, z.output<typeof adminActivationSchema>>({
    resolver: zodResolver(adminActivationSchema),
    defaultValues: {
      isActive,
      reason: "",
    },
  });

  async function confirmRoleChange() {
    if (!pendingRole) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_update_admin_role", {
      p_profile_id: profileId,
      p_new_role: pendingRole.role,
      p_reason: pendingRole.reason || null,
    });
    setIsPending(false);
    setPendingRole(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  async function confirmActivationChange() {
    if (!pendingActivation) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_set_admin_account_active", {
      p_profile_id: profileId,
      p_is_active: pendingActivation.isActive,
      p_reason: pendingActivation.reason || null,
    });
    setIsPending(false);
    setPendingActivation(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  return (
    <div className="space-y-5">
      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">Change role</h3>
        <form className="space-y-3" onSubmit={roleForm.handleSubmit((values) => setPendingRole(values))}>
          <label className="grid gap-1 text-sm">
            <span>Role</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...roleForm.register("role")}>
              <option value="ops_admin">Ops admin</option>
              <option value="super_admin">Super admin</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>Reason</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...roleForm.register("reason")} />
          </label>
          <button className="button-secondary" type="submit">
            Update role
          </button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{isActive ? "Deactivate admin" : "Reactivate admin"}</h3>
        <form
          className="space-y-3"
          onSubmit={activationForm.handleSubmit((values) =>
            setPendingActivation({
              ...values,
              isActive: !isActive,
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>Reason</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...activationForm.register("reason")} />
          </label>
          <button className={isActive ? "button-secondary" : "button-primary"} type="submit">
            {isActive ? "Deactivate admin" : "Reactivate admin"}
          </button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingRole !== null}
        title="Update this admin role?"
        body="This changes the admin's governance privileges and is recorded in the admin audit log."
        confirmLabel="Update role"
        isPending={isPending}
        onCancel={() => setPendingRole(null)}
        onConfirm={confirmRoleChange}
      />
      <ConfirmDialog
        open={pendingActivation !== null}
        title={isActive ? "Deactivate this admin?" : "Reactivate this admin?"}
        body={
          isActive
            ? "This removes active admin access for the selected account."
            : "This restores admin access for the selected account."
        }
        confirmLabel={isActive ? "Deactivate" : "Reactivate"}
        isPending={isPending}
        onCancel={() => setPendingActivation(null)}
        onConfirm={confirmActivationChange}
      />
    </div>
  );
}
