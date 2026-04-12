import { expect, test } from "@playwright/test";

import { adminStorageStatePath } from "@/tests/e2e/env";
import { readAdminFixtureManifest } from "@/tests/e2e/helpers/admin-fixtures";

test.use({ storageState: adminStorageStatePath });

test("shared destructive confirmation dialog opens and closes on an admin detail action", async ({ page }) => {
  const fixtures = await readAdminFixtureManifest();

  await page.goto(`/en/admins/${fixtures.opsAdmin.profileId}`);

  const deactivateButton = page.getByRole("button", { name: "Deactivate admin" });
  await deactivateButton.click();

  const dialog = page.getByRole("dialog");
  await expect(dialog).toContainText("Deactivate this admin?");
  await page.keyboard.press("Escape");
  await expect(dialog).toBeHidden();
  await expect(deactivateButton).toBeFocused();
});
