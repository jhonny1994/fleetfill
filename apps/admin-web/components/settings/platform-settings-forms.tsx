"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useState } from "react";
import type { ReactNode } from "react";
import { useForm, useWatch } from "react-hook-form";
import { z } from "zod";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { formatDateTime } from "@/lib/formatting/formatters";
import { getAdminDetailCopy } from "@/lib/i18n/admin-ui";
import { localeEntries, resolveEnabledLocales, resolveFallbackLocale, type AppLocale } from "@/lib/i18n/config";
import { useAdminUi } from "@/lib/i18n/use-admin-messages";
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
  meta,
  children,
}: {
  title: string;
  body: string;
  meta?: string | null;
  children: ReactNode;
}) {
  return (
    <section className="panel space-y-4 p-5">
      <div className="section-header">
        <h3 className="text-[1.15rem] font-semibold text-[var(--color-ink-strong)]">{title}</h3>
        <p>{body}</p>
        {meta ? <p className="text-xs text-[var(--color-ink-muted)]">{meta}</p> : null}
      </div>
      <div className="max-w-5xl">{children}</div>
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
  locale: AppLocale;
  settings: PlatformSettingsSnapshot;
  isSuperAdmin: boolean;
}) {
  const ui = useAdminUi();
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
        meta={settings.updatedAtByKey.app_runtime ? `${ui.labels.updated}: ${formatDateTime(settings.updatedAtByKey.app_runtime, locale)}` : null}
      >
        <form
          className="grid max-w-4xl gap-3 lg:grid-cols-2"
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
          <label className="admin-checkbox-row text-sm">
            <input type="checkbox" disabled={disabled} className="admin-checkbox" {...runtimeForm.register("maintenanceMode")} />
            <span>{detailCopy.settings.maintenanceMode}</span>
          </label>
          <label className="admin-checkbox-row text-sm">
            <input type="checkbox" disabled={disabled} className="admin-checkbox" {...runtimeForm.register("forceUpdateRequired")} />
            <span>{detailCopy.settings.forceUpdateRequired}</span>
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.minimumAndroidVersion}</span>
            <input type="number" disabled={disabled} className="admin-field" {...runtimeForm.register("minimumSupportedAndroidVersion")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.minimumIosVersion}</span>
            <input type="number" disabled={disabled} className="admin-field" {...runtimeForm.register("minimumSupportedIosVersion")} />
          </label>
          <div className="form-actions lg:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.saveRuntimePolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.pricingTitle}
        body={detailCopy.settings.pricingBody}
        meta={settings.updatedAtByKey.booking_pricing ? `${ui.labels.updated}: ${formatDateTime(settings.updatedAtByKey.booking_pricing, locale)}` : null}
      >
        <form
          className="grid max-w-5xl gap-3 lg:grid-cols-2 xl:grid-cols-3"
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
            <input type="number" step="0.01" disabled={disabled} className="admin-field" {...pricingForm.register("platformFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.carrierFeeRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="admin-field" {...pricingForm.register("carrierFeeRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.insuranceRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="admin-field" {...pricingForm.register("insuranceRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.insuranceMinFee}</span>
            <input type="number" disabled={disabled} className="admin-field" {...pricingForm.register("insuranceMinFeeDzd")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.taxRate}</span>
            <input type="number" step="0.01" disabled={disabled} className="admin-field" {...pricingForm.register("taxRate")} />
          </label>
          <label className="grid gap-1 text-sm">
            <span>{detailCopy.settings.paymentResubmissionDeadline}</span>
            <input type="number" disabled={disabled} className="admin-field" {...pricingForm.register("paymentResubmissionDeadlineHours")} />
          </label>
          <div className="form-actions xl:col-span-3 lg:col-span-2">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.savePricingPolicy}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.reviewTitle}
        body={detailCopy.settings.reviewBody}
        meta={settings.updatedAtByKey.delivery_review ? `${ui.labels.updated}: ${formatDateTime(settings.updatedAtByKey.delivery_review, locale)}` : null}
      >
        <form
          className="grid max-w-xl gap-3 lg:grid-cols-[minmax(0,220px)_auto]"
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
            <input type="number" disabled={disabled} className="admin-field" {...reviewForm.register("graceWindowHours")} />
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
        meta={settings.updatedAtByKey.feature_flags ? `${ui.labels.updated}: ${formatDateTime(settings.updatedAtByKey.feature_flags, locale)}` : null}
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
          <label className="admin-checkbox-row text-sm">
            <input type="checkbox" disabled={disabled} className="admin-checkbox" {...featureForm.register("adminEmailResendEnabled")} />
            <span>{detailCopy.settings.adminEmailResendEnabled}</span>
          </label>
          <div className="form-actions">
            <button className="button-primary" type="submit" disabled={disabled}>
              {detailCopy.settings.saveFeatureFlags}
            </button>
          </div>
        </form>
      </SectionFrame>

      <SectionFrame
        title={detailCopy.settings.localizationTitle}
        body={detailCopy.settings.localizationBody}
        meta={settings.updatedAtByKey.localization ? `${ui.labels.updated}: ${formatDateTime(settings.updatedAtByKey.localization, locale)}` : null}
      >
        <form
          className="space-y-4"
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
          <div className="grid max-w-4xl gap-4 xl:grid-cols-[minmax(0,1fr)_260px]">
            <fieldset className="space-y-2 text-sm">
              <legend className="mb-1 font-medium text-[var(--color-ink-base)]">{detailCopy.settings.enabledLocales}</legend>
              <div className="grid gap-2 sm:grid-cols-2 xl:grid-cols-3">
                {localeEntries.map(([localeCode]) => (
                  <label key={localeCode} className="admin-checkbox-row">
                    <input
                      type="checkbox"
                      disabled={disabled}
                      value={localeCode}
                      checked={enabledLocales.includes(localeCode)}
                      className="admin-checkbox"
                      onChange={(event) => {
                        const current = localizationForm.getValues("enabledLocales");
                        const nextEnabledLocales = resolveEnabledLocales(
                          event.target.checked
                            ? [...current, localeCode]
                            : current.filter((value) => value !== localeCode),
                        );
                        const nextFallbackLocale = resolveFallbackLocale(
                          localizationForm.getValues("fallbackLocale"),
                          nextEnabledLocales,
                        );

                        localizationForm.setValue(
                          "enabledLocales",
                          nextEnabledLocales,
                        );
                        localizationForm.setValue("fallbackLocale", nextFallbackLocale);
                      }}
                    />
                    <span>{ui.enums.locale[localeCode]}</span>
                  </label>
                ))}
              </div>
            </fieldset>
            <label className="grid gap-1 text-sm content-start">
              <span>{detailCopy.settings.fallbackLocale}</span>
              <select className="admin-field admin-select" disabled={disabled} {...localizationForm.register("fallbackLocale")}>
                {localeEntries.map(([localeCode]) => (
                  <option key={localeCode} value={localeCode} disabled={!enabledLocales.includes(localeCode)}>
                    {ui.enums.locale[localeCode]}
                  </option>
                ))}
              </select>
            </label>
          </div>
          <div className="form-actions">
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
