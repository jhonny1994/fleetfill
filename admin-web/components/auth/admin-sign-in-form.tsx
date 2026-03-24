"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { z } from "zod";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import type { AppLocale } from "@/lib/i18n/config";

const signInSchema = z.object({
  email: z.string().trim().email("Enter a valid admin email."),
  password: z.string().min(8, "Use at least 8 characters."),
});

type SignInValues = z.infer<typeof signInSchema>;

export function AdminSignInForm({ locale }: { locale: AppLocale }) {
  const router = useRouter();
  const supabase = createSupabaseBrowserClient();
  const [authError, setAuthError] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();
  const form = useForm<SignInValues>({
    resolver: zodResolver(signInSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });

  async function onSubmit(values: SignInValues) {
    setAuthError(null);

    const { data, error } = await supabase.auth.signInWithPassword({
      email: values.email,
      password: values.password,
    });

    if (error) {
      setAuthError(error.message);
      return;
    }

    if (!data.user) {
      setAuthError("We could not establish an admin session.");
      return;
    }

    const { data: adminAccount } = await supabase
      .from("admin_accounts")
      .select("admin_role,is_active,profiles:profile_id(is_active)")
      .eq("profile_id", data.user.id)
      .maybeSingle();

    const profile = Array.isArray(adminAccount?.profiles)
      ? adminAccount?.profiles[0]
      : adminAccount?.profiles;

    if (!adminAccount || adminAccount.is_active !== true || profile?.is_active !== true) {
      await supabase.auth.signOut();
      setAuthError("This account does not have active FleetFill admin access.");
      return;
    }

    startTransition(() => {
      router.replace(`/${locale}/dashboard`);
      router.refresh();
    });
  }

  return (
    <form className="space-y-4" onSubmit={form.handleSubmit(onSubmit)}>
      <div className="space-y-2">
        <label className="text-sm font-medium text-[var(--color-ink-strong)]" htmlFor="email">
          Admin email
        </label>
        <input
          id="email"
          type="email"
          className="w-full rounded-[22px] border border-[var(--color-border)] bg-white/85 px-4 py-3 text-sm text-[var(--color-ink-strong)] outline-none"
          placeholder="admin@fleetfill.dz"
          autoComplete="email"
          {...form.register("email")}
        />
        {form.formState.errors.email ? (
          <p className="text-sm text-[var(--color-red-700)]">{form.formState.errors.email.message}</p>
        ) : null}
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium text-[var(--color-ink-strong)]" htmlFor="password">
          Password
        </label>
        <input
          id="password"
          type="password"
          className="w-full rounded-[22px] border border-[var(--color-border)] bg-white/85 px-4 py-3 text-sm text-[var(--color-ink-strong)] outline-none"
          placeholder="Enter your admin password"
          autoComplete="current-password"
          {...form.register("password")}
        />
        {form.formState.errors.password ? (
          <p className="text-sm text-[var(--color-red-700)]">
            {form.formState.errors.password.message}
          </p>
        ) : null}
      </div>
      {authError ? <p className="text-sm text-[var(--color-red-700)]">{authError}</p> : null}
      <button className="button-primary w-full" type="submit" disabled={isPending}>
        {isPending ? "Signing in..." : "Continue with admin sign in"}
      </button>
    </form>
  );
}
