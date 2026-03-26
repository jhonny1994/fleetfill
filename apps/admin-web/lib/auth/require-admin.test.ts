import { beforeEach, describe, expect, it, vi } from "vitest";

const redirectMock = vi.fn();
const getAdminSessionMock = vi.fn();

vi.mock("next/navigation", () => ({
  redirect: (...args: unknown[]) => redirectMock(...args),
}));

vi.mock("@/lib/auth/get-admin-session", () => ({
  getAdminSession: () => getAdminSessionMock(),
}));

describe("requireAdmin", () => {
  beforeEach(() => {
    redirectMock.mockReset();
    getAdminSessionMock.mockReset();
  });

  it("redirects to sign-in when there is no admin session", async () => {
    getAdminSessionMock.mockResolvedValue(null);

    const { requireAdmin } = await import("@/lib/auth/require-admin");
    await requireAdmin("fr");

    expect(redirectMock).toHaveBeenCalledWith("/fr/sign-in");
  });

  it("returns the admin session when it exists", async () => {
    const session = {
      userId: "user-1",
      email: "admin@example.com",
      fullName: "Ops Admin",
      adminRole: "ops_admin",
    };
    getAdminSessionMock.mockResolvedValue(session);

    const { requireAdmin } = await import("@/lib/auth/require-admin");

    await expect(requireAdmin("en")).resolves.toEqual(session);
    expect(redirectMock).not.toHaveBeenCalled();
  });
});
