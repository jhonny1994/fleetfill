"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm, useWatch } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { getAdminDetailCopy, getAdminUi } from "@/lib/i18n/admin-ui";
import { createSupabaseBrowserClient } from "@/lib/supabase/client";
import type { PlatformSettingsSnapshot } from "@/lib/queries/admin-types";
import type { Json } from "@/lib/supabase/database.types";
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

function getSettingAuditDescription(key: "app_runtime" | "booking_pricing" | "delivery_review" | "feature_flags" | "localization") {
  switch (key) {
    case "app_runtime":
      return "Admin-controlled runtime policy for maintenance and minimum supported versions";
    case "booking_pricing":
      return "Admin-controlled booking pricing policy";
    case "delivery_review":
      return "Admin-controlled delivery review timing";
    case "feature_flags":
      return "Admin-controlled runtime feature flags";
    case "localization":
      return "Admin-controlled localization policy";
  }
}

export function PlatformSettingsForms({
  locale,
  settings,
  isSuperAdmin,
}: {
  locale: string;
  settings: PlatformSettingsSnapshot;
  isSuperAdmin: boolean;
}) {
  const ui = getAdminUi(locale);
  const detailCopy = getAdminDetailCopy(locale);
  const router = useRouter();
  const [supabase] = useState(() => createSupabaseBrowserClient());
  const [error, setError] = useState<string | null>(null);
  const [pendingConfig, setPendingConfig] = useState<{
    key: string;
    value: Json;
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
        title={detailCopy.settings.runtimeTitle}
        body={detailCopy.settings.runtimeBody}
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
              description: getSettingAuditDescription("app_runtime"),
            }),
          )}
        >
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...runtimeForm.register("maintenanceMode")} />
            <span>{detailCopy.settings.maintenanceMode}</span>
          </label>
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...runtimeForm.register("forceUpdateRequired")} />
            <span>{detailCopy.settings.forceUpdateRequired}</span>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.minimumAndroidVersion}</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...runtimeForm.register("minimumSupportedAndroidVersion")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.minimumIosVersion}</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...runtimeForm.register("minimumSupportedIosVersion")} />
          </label>
          <div className="md:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.saveRuntimePolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.pricingTitle}
        body={detailCopy.settings.pricingBody}
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
              description: getSettingAuditDescription("booking_pricing"),
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.platformFeeRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("platformFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.carrierFeeRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("carrierFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.insuranceRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("insuranceRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.insuranceMinFee}</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("insuranceMinFeeDzd")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.taxRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("taxRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.paymentResubmissionDeadline}</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...pricingForm.register("paymentResubmissionDeadlineHours")} />
          </label>
          <div className="md:col-span-3">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.savePricingPolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.reviewTitle}
        body={detailCopy.settings.reviewBody}
      >
        <form
          className="grid gap-3 md:grid-cols-[minmax(0,260px)_auto]"
          onSubmit={reviewForm.handleSubmit((values) =>
            setPendingConfig({
              key: "delivery_review",
              value: { grace_window_hours: values.graceWindowHours },
              description: getSettingAuditDescription("delivery_review"),
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.graceWindow}</span>
            <input type="number" disabled={disabled} className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" {...reviewForm.register("graceWindowHours")} />
          </label>
          <div className="self-end">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.saveReviewPolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.featureTitle}
        body={detailCopy.settings.featureBody}
      >
        <form
          className="space-y-3"
          onSubmit={featureForm.handleSubmit((values) =>
            setPendingConfig({
              key: "feature_flags",
              value: { admin_email_resend_enabled: values.adminEmailResendEnabled },
              description: getSettingAuditDescription("feature_flags"),
            }),
          )}
        >
          <label className="flex items-center gap-3 rounded-2xl border border-[var(--color-border)] bg-white px-4 py-3 text-sm">
            <input type="checkbox" disabled={disabled} {...featureForm.register("adminEmailResendEnabled")} />
            <span>{detailCopy.settings.adminEmailResendEnabled}</span>
          </label>
          <button className="button-primary" type="submit" disabled={disabled}>
            {detailCopy.settings.saveFeatureFlags}
          </button>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.localizationTitle}
        body={detailCopy.settings.localizationBody}
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
              description: getSettingAuditDescription("localization"),
            }),
          )}
        >
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.fallbackLocale}</span>
            <select className="rounded-2xl border border-[var(--color-border)] bg-white px-3 py-2" disabled={disabled} {...localizationForm.register("fallbackLocale")}>
              <option value="ar">{ui.enums.locale.ar}</option>
              <option value="fr">{ui.enums.locale.fr}</option>
              <option value="en">{ui.enums.locale.en}</option>
            </select>
          </label>
          <fieldset className="grid gap-2 text-sm">
            <legend className="mb-1 font-medium text-[var(--color-ink-base)]">{detailCopy.settings.enabledLocales}</legend>
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
                <span>{ui.enums.locale[localeCode]}</span>
              </label>
            ))}
          </fieldset>
          <div className="md:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.saveLocalizationPolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      {!isSuperAdmin ? (
        <p className="text-sm text-[var(--color-amber-700)]">
          {detailCopy.settings.superAdminOnly}
        </p>
      ) : null}

      {error ? <p className="text-sm text-[var(--color-red-700)]">{error}</p> : null}

      <ConfirmDialog
        open={pendingConfig !== null}
        title={ui.actions.saveSettingTitle}
        body={ui.actions.saveSettingBody}
        confirmLabel={ui.actions.saveSetting}
        isPending={isPending}
        onCancel={() => setPendingConfig(null)}
        onConfirm={confirmSave}
      />
    </div>
  );
}
