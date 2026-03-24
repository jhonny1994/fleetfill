import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type { PlatformSettingsSnapshot } from "@/lib/queries/admin-types";

type PlatformSettingRow = {
  key: string;
  value: Record<string, unknown>;
  updated_at: string | null;
};

export async function fetchPlatformSettingsSnapshot(): Promise<PlatformSettingsSnapshot> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data, error } = await supabase
    .from("platform_settings")
    .select("key, value, updated_at")
    .in("key", ["app_runtime", "booking_pricing", "delivery_review", "feature_flags", "localization"]);

  if (error) {
    throw error;
  }

  const rows = new Map<string, PlatformSettingRow>(((data ?? []) as PlatformSettingRow[]).map((row) => [row.key, row]));
  const appRuntime = rows.get("app_runtime")?.value ?? {};
  const bookingPricing = rows.get("booking_pricing")?.value ?? {};
  const deliveryReview = rows.get("delivery_review")?.value ?? {};
  const featureFlags = rows.get("feature_flags")?.value ?? {};
  const localization = rows.get("localization")?.value ?? {};

  return {
    appRuntime: {
      maintenanceMode: Boolean(appRuntime.maintenance_mode ?? false),
      forceUpdateRequired: Boolean(appRuntime.force_update_required ?? false),
      minimumSupportedAndroidVersion: Number(appRuntime.minimum_supported_android_version ?? 1),
      minimumSupportedIosVersion: Number(appRuntime.minimum_supported_ios_version ?? 1),
    },
    bookingPricing: {
      platformFeeRate: Number(bookingPricing.platform_fee_rate ?? 0.05),
      carrierFeeRate: Number(bookingPricing.carrier_fee_rate ?? 0),
      insuranceRate: Number(bookingPricing.insurance_rate ?? 0.01),
      insuranceMinFeeDzd: Number(bookingPricing.insurance_min_fee_dzd ?? 100),
      taxRate: Number(bookingPricing.tax_rate ?? 0),
      paymentResubmissionDeadlineHours: Number(bookingPricing.payment_resubmission_deadline_hours ?? 24),
    },
    deliveryReview: {
      graceWindowHours: Number(deliveryReview.grace_window_hours ?? 24),
    },
    featureFlags: {
      adminEmailResendEnabled: Boolean(featureFlags.admin_email_resend_enabled ?? true),
    },
    localization: {
      fallbackLocale: ((localization.fallback_locale as "ar" | "fr" | "en" | undefined) ?? "ar"),
      enabledLocales: ((localization.enabled_locales as Array<"ar" | "fr" | "en"> | undefined) ?? ["ar", "fr", "en"]),
    },
    updatedAtByKey: {
      app_runtime: rows.get("app_runtime")?.updated_at ?? null,
      booking_pricing: rows.get("booking_pricing")?.updated_at ?? null,
      delivery_review: rows.get("delivery_review")?.updated_at ?? null,
      feature_flags: rows.get("feature_flags")?.updated_at ?? null,
      localization: rows.get("localization")?.updated_at ?? null,
    },
  };
}
