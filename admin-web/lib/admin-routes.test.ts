import { describe, expect, it } from "vitest";

import { buildAdminRoute } from "@/lib/admin-routes";

describe("buildAdminRoute", () => {
  it("maps each search entity kind to its canonical admin page", () => {
    expect(buildAdminRoute("ar", "booking", "b1")).toBe("/ar/bookings/b1");
    expect(buildAdminRoute("ar", "shipment", "s1")).toBe("/ar/shipments/s1");
    expect(buildAdminRoute("ar", "user", "u1")).toBe("/ar/users/u1");
    expect(buildAdminRoute("ar", "admin", "a1")).toBe("/ar/admins/a1");
    expect(buildAdminRoute("ar", "payment", "p1")).toBe("/ar/payments/p1");
    expect(buildAdminRoute("ar", "verification", "v1")).toBe("/ar/verification/v1");
    expect(buildAdminRoute("ar", "dispute", "d1")).toBe("/ar/disputes/d1");
    expect(buildAdminRoute("ar", "payout", "po1")).toBe("/ar/payouts/po1");
    expect(buildAdminRoute("ar", "support", "sr1")).toBe("/ar/support/sr1");
  });
});
