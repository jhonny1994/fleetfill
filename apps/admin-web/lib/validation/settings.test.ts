import { describe, expect, it } from "vitest";

import {
  appRuntimeSettingsSchema,
  bookingPricingSettingsSchema,
  localizationSettingsSchema,
} from "@/lib/validation/settings";

describe("settings schemas", () => {
  it("accepts valid runtime settings", () => {
    const parsed = appRuntimeSettingsSchema.parse({
      maintenanceMode: true,
      forceUpdateRequired: false,
      minimumSupportedAndroidVersion: 12,
      minimumSupportedIosVersion: 16,
    });

    expect(parsed.minimumSupportedAndroidVersion).toBe(12);
  });

  it("rejects invalid booking deadlines", () => {
    expect(() =>
      bookingPricingSettingsSchema.parse({
        platformFeeRate: 0.05,
        carrierFeeRate: 0,
        insuranceRate: 0.01,
        insuranceMinFeeDzd: 100,
        taxRate: 0,
        paymentResubmissionDeadlineHours: 0,
      }),
    ).toThrow();
  });

  it("requires at least one enabled locale", () => {
    expect(() =>
      localizationSettingsSchema.parse({
        fallbackLocale: "ar",
        enabledLocales: [],
      }),
    ).toThrow();
  });
});
