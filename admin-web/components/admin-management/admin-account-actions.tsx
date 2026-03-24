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
import { adminActivationSchema, adminRoleChangeSchema } from "@/lib/validation/admin-management";

export function AdminAccountActions({
  locale,
  profileId,
  currentRole,
  isActive,
}: {
  locale: AppLocale | string;
  profileId: string;
  currentRole: "super_admin" | "ops_admin";
  isActive: boolean;
}) {
  const ui = getAdminUi(locale);
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
      p_role: pendingRole.role,
      p_reason: pendingRole.reason || undefined,
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
      p_reason: pendingActivation.reason || undefined,
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
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{ui.actions.changeRole}</h3>
        <form className="space-y-3" onSubmit={roleForm.handleSubmit((values) => setPendingRole(values))}>
          <label className="grid gap-1 text-sm">
            <span>{ui.labels.role}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...roleForm.register("role")}>
              <option value="ops_admin">{getEnumLabel(locale, "adminRoles", "ops_admin")}</option>
              <option value="super_admin">{getEnumLabel(locale, "adminRoles", "super_admin")}</option>
            </select>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{ui.labels.reason}</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...roleForm.register("reason")} />
          </label>
          <button className="button-secondary" type="submit">
            {ui.actions.updateRole}
          </button>
        </form>
      </section>

      <section className="space-y-3 rounded-[22px] border border-[var(--color-border)] bg-white/50 p-4">
        <h3 className="font-semibold text-[var(--color-ink-strong)]">{isActive ? ui.actions.deactivateAdmin : ui.actions.reactivateAdmin}</h3>
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
            <span>{ui.labels.reason}</span>
            <textarea className="min-h-24 rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...activationForm.register("reason")} />
          </label>
          <button className={isActive ? "button-secondary" : "button-primary"} type="submit">
            {isActive ? ui.actions.deactivateAdmin : ui.actions.reactivateAdmin}
          </button>
        </form>
      </section>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        locale={locale}
        open={pendingRole !== null}
        title={ui.actions.updateRole}
        body={ui.actions.updateRole}
        confirmLabel={ui.actions.updateRole}
        isPending={isPending}
        onCancel={() => setPendingRole(null)}
        onConfirm={confirmRoleChange}
      />
      <ConfirmDialog
        locale={locale}
        open={pendingActivation !== null}
        title={isActive ? ui.actions.deactivateAdmin : ui.actions.reactivateAdmin}
        body={isActive ? ui.actions.deactivateAdmin : ui.actions.reactivateAdmin}
        confirmLabel={isActive ? ui.actions.deactivateAdmin : ui.actions.reactivateAdmin}
        isPending={isPending}
        onCancel={() => setPendingActivation(null)}
        onConfirm={confirmActivationChange}
      />
    </div>
  );
}
