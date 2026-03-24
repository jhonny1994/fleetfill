import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";

import { UserActivationActions } from "@/components/users/user-activation-actions";

const refreshSpy = vi.fn();
const rpcSpy = vi.fn().mockResolvedValue({ error: null });

vi.mock("next/navigation", () => ({
  useRouter: () => ({
    refresh: refreshSpy,
  }),
}));

vi.mock("@/lib/supabase/client", () => ({
  createSupabaseBrowserClient: () => ({
    rpc: rpcSpy,
  }),
}));

describe("UserActivationActions", () => {
  it("submits the admin profile activation rpc with the inverse active state", async () => {
    const user = userEvent.setup();

    render(<UserActivationActions locale="en" profileId="profile-1" isActive />);

    await user.click(screen.getByRole("button", { name: "Suspend user" }));
    await user.click(screen.getAllByRole("button", { name: "Suspend user" })[1]);

    await waitFor(() =>
      expect(rpcSpy).toHaveBeenCalledWith("admin_set_profile_active", {
        p_profile_id: "profile-1",
        p_is_active: false,
        p_reason: undefined,
      }),
    );
    expect(refreshSpy).toHaveBeenCalled();
  });
});
