import { expect, test } from "@playwright/test";

import { adminStorageStatePath } from "@/tests/e2e/env";

test.use({ storageState: adminStorageStatePath });

test("queue filters keep state in the URL", async ({ page }) => {
  await page.goto("/en/payments");

  await page.getByRole("combobox", { name: "Status" }).selectOption("verified");
  await page.getByRole("button", { name: "Apply" }).click();

  await expect(page).toHaveURL(/\/en\/payments\?(?:.*&)?view=open(?:&.*)?status=verified(?:&.*)?$/);
});

test("locale switching preserves queue URL state", async ({ page }) => {
  await page.goto("/en/payments?view=history&q=trk&status=verified");

  await page.getByRole("combobox", { name: "Language" }).selectOption("fr");

  await expect(page).toHaveURL(/\/fr\/payments\?(?:.*&)?view=history(?:&.*)?q=trk(?:&.*)?status=verified(?:&.*)?$/);
});
