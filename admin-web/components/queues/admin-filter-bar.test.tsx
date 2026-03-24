import { render, screen } from "@testing-library/react";
import type { AnchorHTMLAttributes } from "react";
import { describe, expect, it, vi } from "vitest";

import { AdminFilterBar } from "@/components/queues/admin-filter-bar";

vi.mock("next/link", () => ({
  default: ({ children, href, ...rest }: AnchorHTMLAttributes<HTMLAnchorElement> & { href: string }) => (
    <a href={href} {...rest}>
      {children}
    </a>
  ),
}));

const refreshSpy = vi.fn();

vi.mock("next/navigation", () => ({
  useRouter: () => ({
    refresh: refreshSpy,
  }),
}));

describe("AdminFilterBar", () => {
  it("keeps query and status values visible in the form", () => {
    render(
      <AdminFilterBar
        pathname="/ar/support"
        query="booking issue"
        status="open"
        statusOptions={[
          { value: "open", label: "Open" },
          { value: "resolved", label: "Resolved" },
        ]}
      />,
    );

    expect(screen.getByDisplayValue("booking issue")).toBeInTheDocument();
    expect(screen.getByRole("combobox")).toHaveValue("open");
    expect(screen.getByText("Query: booking issue")).toBeInTheDocument();
    expect(screen.getByText("Status: open")).toBeInTheDocument();
  });

  it("renders reset actions against the canonical queue path", () => {
    render(<AdminFilterBar pathname="/ar/payments" query="trk" />);

    expect(screen.getByRole("link", { name: "Reset" })).toHaveAttribute("href", "/ar/payments");
    expect(screen.getByRole("link", { name: "Clear all" })).toHaveAttribute("href", "/ar/payments");
  });
});
