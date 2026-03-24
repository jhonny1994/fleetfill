import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";

import { AdminInviteForm } from "@/components/admin-management/admin-invite-form";

const rpcSpy = vi.fn().mockResolvedValue({
  data: {
    id: "invite-1",
    email: "ops@fleetfill.dz",
    role: "ops_admin",
    status: "pending",
    expires_at: "2026-03-25T10:00:00Z",
    token: "secret-token",
  },
  error: null,
});

Object.assign(navigator, {
  clipboard: {
    writeText: vi.fn(),
  },
});

vi.mock("@/lib/supabase/client", () => ({
  createSupabaseBrowserClient: () => ({
    rpc: rpcSpy,
  }),
}));

describe("AdminInviteForm", () => {
  it("creates admin invitations through the backend rpc", async () => {
    const user = userEvent.setup();

    render(<AdminInviteForm />);

    await user.type(screen.getByLabelText("Email"), "ops@fleetfill.dz");
    await user.click(screen.getByRole("button", { name: "Create invitation" }));

    await waitFor(() =>
      expect(rpcSpy).toHaveBeenCalledWith("create_admin_invitation", {
        p_email: "ops@fleetfill.dz",
        p_role: "ops_admin",
        p_expires_in_hours: 72,
      }),
    );
    expect(screen.getByText("Invitation created for ops@fleetfill.dz")).toBeInTheDocument();
  });
});
