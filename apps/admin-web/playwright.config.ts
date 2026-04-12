import { execFileSync } from "node:child_process";
import path from "node:path";

import { defineConfig } from "@playwright/test";

const port = Number(process.env.PLAYWRIGHT_PORT ?? 3005);
const baseURL = process.env.PLAYWRIGHT_BASE_URL ?? `http://127.0.0.1:${port}`;
const repoRoot = path.resolve(process.cwd(), "..", "..");
const appRoot = process.cwd();
const supabaseCliEnv = {
  ...process.env,
  GOOGLE_WEB_CLIENT_ID: process.env.GOOGLE_WEB_CLIENT_ID ?? "dummy-google-web-client-id.apps.googleusercontent.com",
  GOOGLE_IOS_CLIENT_ID: process.env.GOOGLE_IOS_CLIENT_ID ?? "dummy-google-ios-client-id.apps.googleusercontent.com",
  SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID:
    process.env.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID ?? "dummy-google-web-client-id.apps.googleusercontent.com",
  SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET:
    process.env.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET ?? "dummy-google-client-secret",
};

function resolveSupabaseStatusEnv() {
  try {
    const stdout = execFileSync("supabase", ["status", "-o", "env", "--workdir", "backend"], {
      cwd: repoRoot,
      encoding: "utf8",
      env: supabaseCliEnv,
    });

    return stdout
      .split(/\r?\n/)
      .map((line) => line.match(/^([A-Z_]+)="?(.*?)"?$/))
      .filter((match): match is RegExpMatchArray => match !== null)
      .reduce<Record<string, string>>((envMap, match) => {
        envMap[match[1]] = match[2];
        return envMap;
      }, {});
  } catch {
    return {};
  }
}

const supabaseStatusEnv = resolveSupabaseStatusEnv();

process.env.NEXT_PUBLIC_SUPABASE_URL ??= supabaseStatusEnv.API_URL;
process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ??= supabaseStatusEnv.ANON_KEY;
process.env.SUPABASE_SERVICE_ROLE_KEY ??= supabaseStatusEnv.SERVICE_ROLE_KEY;
process.env.SUPABASE_SECRET_KEY ??= supabaseStatusEnv.SECRET_KEY;
process.env.E2E_APP_ROOT ??= appRoot;
process.env.E2E_REPO_ROOT ??= repoRoot;

export const adminStorageStatePath = path.join(process.cwd(), ".playwright", "admin-storage-state.json");

export default defineConfig({
  testDir: "./tests/e2e",
  fullyParallel: false,
  timeout: 45_000,
  expect: {
    timeout: 10_000,
  },
  retries: process.env.CI ? 1 : 0,
  reporter: process.env.CI ? [["github"], ["html", { open: "never" }]] : "list",
  use: {
    baseURL,
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
    video: "retain-on-failure",
  },
  globalSetup: "./tests/e2e/global.setup.ts",
  webServer: {
    command: "pnpm start:e2e",
    url: baseURL,
    reuseExistingServer: !process.env.CI,
    timeout: 120_000,
    env: {
      ...process.env,
      NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
      NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
      SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY,
      SUPABASE_SECRET_KEY: process.env.SUPABASE_SECRET_KEY,
      NEXT_PUBLIC_SITE_URL: baseURL,
      PLAYWRIGHT_BASE_URL: baseURL,
      E2E_APP_ROOT: process.env.E2E_APP_ROOT,
      E2E_REPO_ROOT: process.env.E2E_REPO_ROOT,
      GOOGLE_WEB_CLIENT_ID: supabaseCliEnv.GOOGLE_WEB_CLIENT_ID,
      GOOGLE_IOS_CLIENT_ID: supabaseCliEnv.GOOGLE_IOS_CLIENT_ID,
      SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID: supabaseCliEnv.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID,
      SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET: supabaseCliEnv.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET,
    },
  },
});
