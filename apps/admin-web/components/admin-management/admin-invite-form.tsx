"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { Copy } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import type { AppLocale } from "@/lib/i18n/config";
import { formatTemplate, getAdminActionErrorMessage, getEnumLabel } from "@/lib/i18n/admin-ui";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import { adminInviteSchema } from "@/lib/validation/admin-management";

type InviteResult = {
  id: string;
  email: string;
  role: string;
  status: string;
  expires_at: string;
  token: string;
};

export function AdminInviteForm({ locale }: { locale: AppLocale | string }) {
  const ui = useAdminUi();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [error, setError] = useState<string | null>(null);
  const [result, setResult] = useState<InviteResult | null>(null);
  const [isPending, setIsPending] = useState(false);
  const form = useForm<z.input<typeof adminInviteSchema>, unknown, z.output<typeof adminInviteSchema>>({
    resolver: zodResolver(adminInviteSchema),
    defaultValues: {
      email: "",
      role: "ops_admin",
      expiresInHours: 72,
    },
  });

  async function onSubmit(values: z.output<typeof adminInviteSchema>) {
    setIsPending(true);
    setError(null);
    setResult(null);
    const { data, error: rpcError } = await supabase.rpc("create_admin_invitation", {
      p_email: values.email,
      p_role: values.role,
      p_expires_in_hours: values.expiresInHours,
    });
    setIsPending(false);
    if (rpcError) {
      setError(getAdminActionErrorMessage(ui, rpcError.message, rpcError.code));
      return;
    }

    setResult(data as InviteResult);
    form.reset({
      email: "",
      role: "ops_admin",
      expiresInHours: 72,
    });
  }

  async function copyToken() {
    if (!result?.token) return;
    await navigator.clipboard.writeText(result.token);
  }

  return (
    <section className="panel space-y-4 p-5">
      <div className="space-y-2">
        <p className="eyebrow">{ui.pages.admins.eyebrow}</p>
        <h2 className="text-[1.45rem] font-semibold text-[var(--color-ink-strong)]">{ui.pages.admins.inviteTitle}</h2>
        <p className="max-w-3xl text-sm leading-6 text-[var(--color-ink-muted)]">
          {ui.pages.admins.inviteBody}
        </p>
      </div>

      <form className="grid gap-3 xl:grid-cols-[minmax(0,1.4fr)_220px_160px_auto]" onSubmit={form.handleSubmit(onSubmit)}>
        <label className="grid gap-1 text-sm">
          <span>{ui.labels.email}</span>
          <input className="admin-field" {...form.register("email")} />
        </label>
        <label className="grid gap-1 text-sm">
          <span>{ui.labels.role}</span>
          <select className="admin-field admin-select" {...form.register("role")}>
            <option value="ops_admin">{getEnumLabel(locale, "adminRoles", "ops_admin")}</option>
            <option value="super_admin">{getEnumLabel(locale, "adminRoles", "super_admin")}</option>
          </select>
        </label>
        <label className="grid gap-1 text-sm">
          <span>{ui.actions.expiryHours}</span>
          <input
            type="number"
            min="1"
            max="168"
            className="admin-field"
            {...form.register("expiresInHours")}
          />
        </label>
        <div className="self-end">
          <button className="button-primary" type="submit" disabled={isPending}>
            {isPending ? ui.actions.creatingInvitation : ui.actions.createInvitation}
          </button>
        </div>
      </form>

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      {result ? (
        <div className="section-card p-4">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <p className="text-sm font-semibold text-[var(--color-ink-strong)]">
                {formatTemplate(ui.pages.admins.invitationCreatedFor, { email: result.email })}
              </p>
              <p className="text-xs text-[var(--color-ink-muted)]">
                {formatTemplate(ui.pages.admins.invitationMeta, {
                  role: getEnumLabel(locale, "adminRoles", result.role),
                  date: new Date(result.expires_at).toLocaleString(),
                })}
              </p>
            </div>
            <button type="button" className="button-secondary" onClick={copyToken}>
              <Copy className="size-4" />
              {ui.actions.copyToken}
            </button>
          </div>
          <div className="mt-3 rounded-[var(--radius-control)] border border-[var(--color-border)] bg-white px-4 py-3 font-mono text-xs text-[var(--color-ink-strong)]">
            {result.token}
          </div>
        </div>
      ) : null}
    </section>
  );
}
