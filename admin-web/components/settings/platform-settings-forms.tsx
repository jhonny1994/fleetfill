"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm, useWatch } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import type { PlatformSettingsSnapshot } from "@/lib/queries/admin-types";
import {
  appRuntimeSettingsSchema,
  bookingPricingSettingsSchema,
  deliveryReviewSettingsSchema,
  featureFlagsSettingsSchema,
  localizationSettingsSchema,
} from "@/lib/validation/settings";

function SectionFrame({
  title,
  body,
  children,
}: {
  title: string;
  body: string;
  children: React.ReactNode;
}) {
  return (
    <section className="rounded-[24px] border border-[var(--color-border)] bg-white/55 p-5">
      <div className="space-y-2">
        <h3 className="text-lg font-semibold text-[var(--color-ink-strong)]">{title}</h3>
        <p className="text-sm leading-6 text-[var(--color-ink-muted)]">{body}</p>
      </div>
      <div className="mt-4">{children}</div>
    </section>
  );
}

export function PlatformSettingsForms({
  settings,
  isSuperAdmin,
}: {
  settings: PlatformSettingsSnapshot;
  isSuperAdmin: boolean;
}) {
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [error, setError] = useState<string | null>(null);
  const [pendingConfig, setPendingConfig] = useState<{
    key: string;
    value: Record<string, unknown>;
    description: string;
  } | null>(null);
  const [isPending, setIsPending] = useState(false);

  const runtimeForm = useForm<z.input<typeof appRuntimeSettingsSchema>, unknown, z.output<typeof appRuntimeSettingsSchema>>({
    resolver: zodResolver(appRuntimeSettingsSchema),
    defaultValues: settings.appRuntime,
  });
  const pricingForm = useForm<
    z.input<typeof bookingPricingSettingsSchema>,
    unknown,
    z.output<typeof bookingPricingSettingsSchema>
  >({
    resolver: zodResolver(bookingPricingSettingsSchema),
    defaultValues: settings.bookingPricing,
  });
  const reviewForm = useForm<
    z.input<typeof deliveryReviewSettingsSchema>,
    unknown,
    z.output<typeof deliveryReviewSettingsSchema>
  >({
    resolver: zodResolver(deliveryReviewSettingsSchema),
    defaultValues: settings.deliveryReview,
  });
  const featureForm = useForm<
    z.input<typeof featureFlagsSettingsSchema>,
    unknown,
    z.output<typeof featureFlagsSettingsSchema>
  >({
    resolver: zodResolver(featureFlagsSettingsSchema),
    defaultValues: settings.featureFlags,
  });
  const localizationForm = useForm<
    z.input<typeof localizationSettingsSchema>,
    unknown,
    z.output<typeof localizationSettingsSchema>
  >({
    resolver: zodResolver(localizationSettingsSchema),
    defaultValues: settings.localization,
  });
  const enabledLocales = useWatch({
    control: localizationForm.control,
    name: "enabledLocales",
  });

  async function confirmSave() {
    if (!pendingConfig) return;
    setIsPending(true);
    setError(null);
    const { error: rpcError } = await supabase.rpc("admin_upsert_platform_setting", {
      p_key: pendingConfig.key,
      p_value: pendingConfig.value,
      p_is_public: false,
      p_description: pendingConfig.description,
    });
    setIsPending(false);
    setPendingConfig(null);
    if (rpcError) {
      setError(rpcError.message);
      return;
    }
    router.refresh();
  }

  const disabled = !isSuperAdmin;

  return (
    <div className="space-y-4">
      <SectionFrame
        title="Runtime policy"
        body="Maintenance mode and minimum supported mobile versions are the highest-impact platform controls."
      >
        <form
          className="grid gap-3 md:grid-cols-2"
          onSubmit={runtimeForm.handleSubmit((values) =>
            setPendingConfig({
              key: "app_runtime",
              value: {
                maintenance_mode: values.maintenanceMode,
                force_update_required: values.forceUpdateRequired,
                minimum_supported_android_version: values.minimumSupportedAndroidVersion,
                minimum_supported_ios_version: values.minimumSupportedIosVersion,
              },
              description: "Admin-controlled runtime policy for maintenance and minimum supported versions",
            }),
          )}
        >
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...runtimeForm.register("maintenanceMode")} />
            <span>Maintenance mode</span>
          </label>
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...runtimeForm.register("forceUpdateRequired")} />
            <span>Force update required</span>
          </label>
          <label className="grid gap-1 text-sm">
            <span>Minimum Android version</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...runtimeForm.register("minimumSupportedAndroidVersion")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Minimum iOS version</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...runtimeForm.register("minimumSupportedIosVersion")} />
          </label>
          <div className="md:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              Save runtime policy
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title="Pricing guardrails"
        body="These values shape price composition and payment review deadlines for all new bookings."
      >
        <form
          className="grid gap-3 md:grid-cols-3"
          onSubmit={pricingForm.handleSubmit((values) =>
            setPendingConfig({
              key: "booking_pricing",
              value: {
                platform_fee_rate: values.platformFeeRate,
                carrier_fee_rate: values.carrierFeeRate,
                insurance_rate: values.insuranceRate,
                insurance_min_fee_dzd: values.insuranceMinFeeDzd,
                tax_rate: values.taxRate,
                payment_resubmission_deadline_hours: values.paymentResubmissionDeadlineHours,
              },
              description: "Admin-controlled booking pricing policy",
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>Platform fee rate</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("platformFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Carrier fee rate</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("carrierFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Insurance rate</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("insuranceRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Insurance min fee (DZD)</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("insuranceMinFeeDzd")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Tax rate</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("taxRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>Payment resubmission deadline (hours)</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("paymentResubmissionDeadlineHours")} />
          </label>
          <div className="md:col-span-3">
            <button className="button-primary" type="submit" disabled={disabled}>
              Save pricing policy
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title="Delivery review"
        body="The grace window determines when delivered bookings become overdue for operational review."
      >
        <form
          className="grid gap-3 md:grid-cols-[minmax(0,260px)_auto]"
          onSubmit={reviewForm.handleSubmit((values) =>
            setPendingConfig({
              key: "delivery_review",
              value: { grace_window_hours: values.graceWindowHours },
              description: "Admin-controlled delivery review timing",
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>Grace window (hours)</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...reviewForm.register("graceWindowHours")} />
          </label>
          <div className="self-end">
            <button className="button-primary" type="submit" disabled={disabled}>
              Save review policy
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title="Feature flags"
        body="Keep these small and operationally meaningful. This is not a dumping ground for product logic."
      >
        <form
          className="space-y-3"
          onSubmit={featureForm.handleSubmit((values) =>
            setPendingConfig({
              key: "feature_flags",
              value: { admin_email_resend_enabled: values.adminEmailResendEnabled },
              description: "Admin-controlled runtime feature flags",
            }),
          )}
        >
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...featureForm.register("adminEmailResendEnabled")} />
            <span>Enable admin email resend actions</span>
          </label>
          <button className="button-primary" type="submit" disabled={disabled}>
            Save feature flags
          </button>
        </form>
      </SectionFrame>

      <SectionFrame
        title="Localization policy"
        body="These values control the fallback locale and the set of enabled locales used across the platform."
      >
        <form
          className="grid gap-3 md:grid-cols-2"
          onSubmit={localizationForm.handleSubmit((values) =>
            setPendingConfig({
              key: "localization",
              value: {
                fallback_locale: values.fallbackLocale,
                enabled_locales: values.enabledLocales,
              },
              description: "Admin-controlled localization policy",
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>Fallback locale</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" disabled={disabled} {...localizationForm.register("fallbackLocale")}>
              <option value="ar">Arabic</option>
              <option value="fr">French</option>
              <option value="en">English</option>
            </select>
          </label>
          <fieldset className="grid gap-2 text-sm">
            <legend className="mb-1 font-medium text-[var(--color-ink-base)]">Enabled locales</legend>
            {(["ar", "fr", "en"] as const).map((localeCode) => (
              <label key={localeCode} className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3">
                <input
                  type="checkbox"
                  disabled={disabled}
                  value={localeCode}
                  checked={enabledLocales.includes(localeCode)}
                  onChange={(event) => {
                    const current = localizationForm.getValues("enabledLocales");
                    localizationForm.setValue(
                      "enabledLocales",
                      event.target.checked ? [...current, localeCode] : current.filter((value) => value !== localeCode),
                    );
                  }}
                />
                <span>{localeCode.toUpperCase()}</span>
              </label>
            ))}
          </fieldset>
          <div className="md:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              Save localization policy
            </button>
          </div>
        </form>
      </SectionFrame>

      {!isSuperAdmin ? (
        <p className="text-sm text-[var(--color-amber-700)]">
          Runtime settings are visible to ops admins, but only super admins can change them.
        </p>
      ) : null}

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingConfig !== null}
        title="Save platform setting?"
        body="This writes directly to the audited runtime settings store and takes effect for future platform behavior."
        confirmLabel="Save setting"
        isPending={isPending}
        onCancel={() => setPendingConfig(null)}
        onConfirm={confirmSave}
      />
    </div>
  );
}
