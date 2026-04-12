import fs from "node:fs/promises";
import path from "node:path";

import { chromium } from "@playwright/test";

import { adminStorageStatePath, getPlaywrightBaseUrl } from "@/tests/e2e/env";
import { seedAdminFixtures } from "@/tests/e2e/helpers/admin-fixtures";

export default async function globalSetup() {
  const fixtures = await seedAdminFixtures();
  await fs.mkdir(path.dirname(adminStorageStatePath), { recursive: true });

  const browser = await chromium.launch();
  const page = await browser.newPage();
  const baseURL = getPlaywrightBaseUrl();

  await page.goto(`${baseURL}/en/sign-in`);
  await page.getByLabel("Admin email").fill(fixtures.superAdmin.email);
  await page.getByLabel("Password").fill(fixtures.superAdmin.password);
  await page.getByRole("button", { name: "Continue with admin sign in" }).click();

  const authError = page.locator("p.text-sm.text-\\[var\\(--color-red-700\\)\\]").first();
  const dashboardNavigation = page.waitForURL("**/en/dashboard");
  const authFailure = authError.waitFor({ state: "visible" }).then(async () => {
    throw new Error(`Playwright auth bootstrap failed: ${await authError.innerText()}`);
  });

  await Promise.race([dashboardNavigation, authFailure]).catch(async (error) => {
    const currentUrl = page.url();
    const bodyText = await page.locator("body").innerText();
    throw new Error(
      `${error instanceof Error ? error.message : String(error)}\nCurrent URL: ${currentUrl}\nBody: ${bodyText}`,
    );
  });

  await page.context().storageState({ path: adminStorageStatePath });
  await browser.close();
}
