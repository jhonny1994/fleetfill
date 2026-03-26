import { beforeEach, describe, expect, it, vi } from "vitest";

const redirectMock = vi.fn();
const requireAdminMock = vi.fn();

vi.mock("next/navigation", () => ({
  redirect: (...args: unknown[]) => redirectMock(...args),
}));

vi.mock("@/lib/auth/require-admin", () => ({
  requireAdmin: (...args: unknown[]) => requireAdminMock(...args),
}));

describe("requireSuperAdmin", () => {
  beforeEach(() => {
    redirectMock.mockReset();
    requireAdminMock.mockReset();
  });

  it("redirects non-super-admin users back to the dashboard", async () => {
    requireAdminMock.mockResolvedValue({
      userId: "user-1",
      email: "ops@example.com",
      fullName: "Ops Admin",
      adminRole: "ops_admin",
    });

    const { requireSuperAdmin } = await import("@/lib/auth/require-super-admin");
    await requireSuperAdmin("ar");

    expect(redirectMock).toHaveBeenCalledWith("/ar/dashboard");
  });

  it("returns the session for super admins", async () => {
    const session = {
      userId: "user-2",
      email: "super@example.com",
      fullName: "Super Admin",
      adminRole: "super_admin",
    };
    requireAdminMock.mockResolvedValue(session);

    const { requireSuperAdmin } = await import("@/lib/auth/require-super-admin");
    await expect(requireSuperAdmin("en")).resolves.toEqual(session);
    expect(redirectMock).not.toHaveBeenCalled();
  });
});
