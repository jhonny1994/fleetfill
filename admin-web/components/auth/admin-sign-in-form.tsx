"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { z } from "zod";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

import type { AdminDictionary } from "@/lib/i18n/dictionaries";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import type { AppLocale } from "@/lib/i18n/config";

type SignInValues = {
  email: string;
  password: string;
};

export function AdminSignInForm({
  locale,
  dictionary,
}: {
  locale: AppLocale;
  dictionary: AdminDictionary;
}) {
  const router = useRouter();
  const supabase = createSupabaseBrowserClient();
  const [authError, setAuthError] = useState<string | null>(null);
  const [isPending, startTransition] = useTransition();
  const signInSchema = z.object({
    email: z.string().trim().email(dictionary.auth.invalidEmail),
    password: z.string().min(8, dictionary.auth.passwordTooShort),
  });
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
      setAuthError(dictionary.auth.noSession);
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
      setAuthError(dictionary.auth.inactiveAdmin);
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
          {dictionary.auth.emailLabel}
        </label>
        <input
          id="email"
          type="email"
          className="w-full rounded-[22px] border border-[var(--color-border)] bg-white/85 px-4 py-3 text-sm text-[var(--color-ink-strong)] outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-accent)]"
          placeholder={dictionary.auth.emailPlaceholder}
          autoComplete="email"
          {...form.register("email")}
        />
        {form.formState.errors.email ? (
          <p className="text-sm text-[var(--color-red-700)]">{form.formState.errors.email.message}</p>
        ) : null}
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium text-[var(--color-ink-strong)]" htmlFor="password">
          {dictionary.auth.passwordLabel}
        </label>
        <input
          id="password"
          type="password"
          className="w-full rounded-[22px] border border-[var(--color-border)] bg-white/85 px-4 py-3 text-sm text-[var(--color-ink-strong)] outline-none focus-visible:ring-2 focus-visible:ring-[var(--color-accent)]"
          placeholder={dictionary.auth.passwordPlaceholder}
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
        {isPending ? dictionary.auth.submitting : dictionary.auth.submit}
      </button>
    </form>
  );
}
