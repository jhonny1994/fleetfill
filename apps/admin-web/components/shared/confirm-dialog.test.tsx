import { screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { useState } from "react";
import { describe, expect, it, vi } from "vitest";

import { ConfirmDialog } from "@/components/shared/confirm-dialog";
import { renderWithIntl } from "@/tests/render-with-intl";

function ConfirmDialogHarness() {
  const [open, setOpen] = useState(false);

  return (
    <div>
      <button type="button" onClick={() => setOpen(true)}>
        Open confirm
      </button>
      <button type="button">Outside action</button>
      <ConfirmDialog
        open={open}
        title="Delete record"
        body="This action cannot be undone."
        onCancel={() => setOpen(false)}
        onConfirm={vi.fn()}
      />
    </div>
  );
}

describe("ConfirmDialog", () => {
  it("traps focus within the dialog and restores focus to the trigger on escape", async () => {
    const user = userEvent.setup();

    renderWithIntl(<ConfirmDialogHarness />);

    const trigger = screen.getByRole("button", { name: "Open confirm" });
    await user.click(trigger);

    expect(screen.getByRole("dialog", { name: "Delete record" })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Cancel" })).toHaveFocus();

    await user.tab();
    expect(screen.getByRole("button", { name: "Confirm" })).toHaveFocus();

    await user.tab();
    expect(screen.getByRole("button", { name: "Cancel" })).toHaveFocus();

    await user.keyboard("{Escape}");
    expect(screen.queryByRole("dialog", { name: "Delete record" })).not.toBeInTheDocument();
    expect(trigger).toHaveFocus();
  });
});
