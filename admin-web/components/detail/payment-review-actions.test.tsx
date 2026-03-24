import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";

import { PaymentReviewActions } from "@/components/detail/payment-review-actions";

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

describe("PaymentReviewActions", () => {
  it("submits the approve flow through the payment RPC", async () => {
    const user = userEvent.setup();

    render(<PaymentReviewActions proofId="proof-1" defaultAmount={12000} />);

    await user.click(screen.getByRole("button", { name: "Approve proof" }));
    await user.click(screen.getByRole("button", { name: "Approve" }));

    await waitFor(() =>
      expect(rpcSpy).toHaveBeenCalledWith("admin_approve_payment_proof", {
        p_payment_proof_id: "proof-1",
        p_verified_amount_dzd: 12000,
        p_verified_reference: undefined,
        p_decision_note: undefined,
      }),
    );
    expect(refreshSpy).toHaveBeenCalled();
  });
});
