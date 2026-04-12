import { expect, test } from "@playwright/test";

import { adminStorageStatePath } from "@/tests/e2e/env";

test.use({ storageState: adminStorageStatePath });

test.describe("admin shell", () => {
  test("preserves the current admin route when switching locale", async ({ page }) => {
    await page.goto("/en/dashboard");

    await page.getByLabel("Language").selectOption("fr");

    await expect(page).toHaveURL(/\/fr\/dashboard$/);
  });

  test("mirrors document semantics for Arabic authenticated routes", async ({ page }) => {
    await page.goto("/ar/dashboard");

    await expect(page.locator("html")).toHaveAttribute("lang", "ar");
    await expect(page.locator("html")).toHaveAttribute("dir", "rtl");
  });

  test("opens and dismisses the mobile drawer with keyboard-safe modal behavior", async ({ page }) => {
    await page.setViewportSize({ width: 390, height: 844 });
    await page.goto("/en/dashboard");

    const trigger = page.getByRole("button", { name: "Open navigation" });
    await trigger.click();

    const closeButton = page.getByRole("button", { name: "Close navigation" });
    await expect(closeButton).toBeVisible();
    await closeButton.focus();
    await page.keyboard.press("Tab");
    await expect(page.getByRole("dialog")).toContainText("FleetFill Admin");
    await page.keyboard.press("Escape");
    await expect(closeButton).toBeHidden();
    await expect(trigger).toBeFocused();
  });
});
