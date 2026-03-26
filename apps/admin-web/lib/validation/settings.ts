import { z } from "zod";

export const appRuntimeSettingsSchema = z.object({
  maintenanceMode: z.boolean(),
  forceUpdateRequired: z.boolean(),
  minimumSupportedAndroidVersion: z.coerce.number().int().min(1),
  minimumSupportedIosVersion: z.coerce.number().int().min(1),
});

export const bookingPricingSettingsSchema = z.object({
  platformFeeRate: z.coerce.number().min(0),
  carrierFeeRate: z.coerce.number().min(0),
  insuranceRate: z.coerce.number().min(0),
  insuranceMinFeeDzd: z.coerce.number().min(0),
  taxRate: z.coerce.number().min(0),
  paymentResubmissionDeadlineHours: z.coerce.number().int().min(1),
});

export const deliveryReviewSettingsSchema = z.object({
  graceWindowHours: z.coerce.number().int().min(1),
});

export const featureFlagsSettingsSchema = z.object({
  adminEmailResendEnabled: z.boolean(),
});

export const localizationSettingsSchema = z.object({
  fallbackLocale: z.enum(["ar", "fr", "en"]),
  enabledLocales: z.array(z.enum(["ar", "fr", "en"])).min(1),
});
