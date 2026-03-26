import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";

import { DetailWorkspace } from "@/components/detail/detail-workspace";

describe("DetailWorkspace", () => {
  it("renders facts and both content rails", () => {
    render(
      <DetailWorkspace
        eyebrow="Payments"
        title="Proof review"
        description="Review the proof."
        facts={[
          { label: "Booking", value: "FF-101" },
          { label: "State", value: "pending" },
        ]}
        main={<div>Main body</div>}
        rail={<div>Action rail</div>}
      />,
    );

    expect(screen.getByText("Proof review")).toBeInTheDocument();
    expect(screen.getByText("FF-101")).toBeInTheDocument();
    expect(screen.getByText("Main body")).toBeInTheDocument();
    expect(screen.getByText("Action rail")).toBeInTheDocument();
  });
});
