import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";

import { MobileAdminSidebar } from "@/components/admin-shell/mobile-admin-sidebar";
import { dictionaries } from "@/lib/i18n/dictionaries";

vi.mock("@/components/admin-shell/admin-sidebar", () => ({
  AdminSidebar: ({ onNavigate }: { onNavigate?: () => void }) => (
    <nav>
      <button type="button" onClick={onNavigate}>
        Dashboard
      </button>
      <button type="button">Settings</button>
    </nav>
  ),
}));

describe("MobileAdminSidebar", () => {
  it("opens as a dialog, traps focus, closes on escape, and restores focus to the trigger", async () => {
    const user = userEvent.setup();

    render(
      <div>
        <button type="button">Outside action</button>
        <MobileAdminSidebar locale="en" dictionary={dictionaries.en} adminRole="super_admin" />
      </div>,
    );

    const trigger = screen.getByRole("button", { name: dictionaries.en.shell.openNavigation });
    await user.click(trigger);

    expect(screen.getByRole("dialog", { name: dictionaries.en.shell.title })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: dictionaries.en.shell.closeNavigation })).toHaveFocus();

    await user.tab();
    expect(screen.getByRole("button", { name: "Dashboard" })).toHaveFocus();

    await user.keyboard("{Escape}");
    expect(screen.queryByRole("dialog", { name: dictionaries.en.shell.title })).not.toBeInTheDocument();
    expect(trigger).toHaveFocus();
  });
});
