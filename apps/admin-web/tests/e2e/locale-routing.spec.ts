import { expect, test } from "@playwright/test";

test.describe("locale routing and document semantics", () => {
  test("negotiates the first visit locale from Accept-Language", async ({ browser }) => {
    const context = await browser.newContext({
      locale: "fr-FR",
    });
    const page = await context.newPage();

    await page.goto("/");

    await expect(page).toHaveURL(/\/fr\/sign-in$/);
    await context.close();
  });

  test("loads direct locale routes explicitly", async ({ page }) => {
    await page.goto("/en/sign-in");

    await expect(page).toHaveURL(/\/en\/sign-in$/);
    await expect(page.getByRole("heading", { name: "Admin sign in" })).toBeVisible();
  });

  test("applies document lang and dir semantics for Arabic", async ({ page }) => {
    await page.goto("/ar/sign-in");

    await expect(page.locator("html")).toHaveAttribute("lang", "ar");
    await expect(page.locator("html")).toHaveAttribute("dir", "rtl");
  });
});
