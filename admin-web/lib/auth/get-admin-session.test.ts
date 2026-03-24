import { describe, expect, it } from "vitest";

import { resolveAdminSessionData } from "@/lib/auth/get-admin-session";

describe("resolveAdminSessionData", () => {
  it("returns null when there is no admin account", () => {
    expect(
      resolveAdminSessionData({
        userId: "user-1",
        userEmail: "admin@example.com",
        adminAccount: null,
      }),
    ).toBeNull();
  });

  it("returns null when the admin account is inactive", () => {
    expect(
      resolveAdminSessionData({
        userId: "user-1",
        userEmail: "admin@example.com",
        adminAccount: {
          admin_role: "ops_admin",
          is_active: false,
          profiles: {
            full_name: "Ops Admin",
            email: "admin@example.com",
            is_active: true,
          },
        },
      }),
    ).toBeNull();
  });

  it("returns a normalized admin session for active admins", () => {
    expect(
      resolveAdminSessionData({
        userId: "user-1",
        userEmail: "admin@example.com",
        adminAccount: {
          admin_role: "super_admin",
          is_active: true,
          profiles: {
            full_name: "Super Admin",
            email: null,
            is_active: true,
          },
        },
      }),
    ).toEqual({
      userId: "user-1",
      email: "admin@example.com",
      fullName: "Super Admin",
      adminRole: "super_admin",
    });
  });
});
