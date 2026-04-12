import { execFileSync } from "node:child_process";
import path from "node:path";

export const e2eFixtureEmails = {
  superAdmin: "playwright-super-admin@fleetfill.local",
  opsAdmin: "playwright-ops-admin@fleetfill.local",
} as const;

export const e2eFixturePasswords = {
  superAdmin: "PlaywrightAdminPass123!",
  opsAdmin: "PlaywrightOpsPass123!",
} as const;

export const e2eFixtureNames = {
  superAdmin: "Playwright Super Admin",
  opsAdmin: "Playwright Ops Admin",
} as const;

const appRoot = process.env.E2E_APP_ROOT ?? path.resolve(process.cwd());
export const repoRoot = process.env.E2E_REPO_ROOT ?? path.resolve(appRoot, "..", "..");
export const adminStorageStatePath = path.join(appRoot, ".playwright", "admin-storage-state.json");
export const adminFixtureManifestPath = path.join(appRoot, ".playwright", "admin-fixtures.json");

let cachedSupabaseStatusEnv: Record<string, string> | null = null;
const supabaseCliEnv = {
  ...process.env,
  GOOGLE_WEB_CLIENT_ID: process.env.GOOGLE_WEB_CLIENT_ID ?? "dummy-google-web-client-id.apps.googleusercontent.com",
  GOOGLE_IOS_CLIENT_ID: process.env.GOOGLE_IOS_CLIENT_ID ?? "dummy-google-ios-client-id.apps.googleusercontent.com",
  SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID:
    process.env.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID ?? "dummy-google-web-client-id.apps.googleusercontent.com",
  SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET:
    process.env.SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_SECRET ?? "dummy-google-client-secret",
};

function getSupabaseStatusEnv() {
  if (cachedSupabaseStatusEnv) {
    return cachedSupabaseStatusEnv;
  }

  const stdout = execFileSync("supabase", ["status", "-o", "env", "--workdir", "backend"], {
    cwd: repoRoot,
    encoding: "utf8",
    env: supabaseCliEnv,
  });

  cachedSupabaseStatusEnv = stdout
    .split(/\r?\n/)
    .map((line) => line.match(/^([A-Z_]+)="?(.*?)"?$/))
    .filter((match): match is RegExpMatchArray => match !== null)
    .reduce<Record<string, string>>((envMap, match) => {
      envMap[match[1]] = match[2];
      return envMap;
    }, {});

  return cachedSupabaseStatusEnv;
}

function requireEnv(name: string) {
  const value = process.env[name] ?? getSupabaseStatusEnv()[name];

  if (!value) {
    throw new Error(`Missing required environment variable for Playwright: ${name}`);
  }

  return value;
}

export function getPlaywrightBaseUrl() {
  return process.env.PLAYWRIGHT_BASE_URL ?? "http://127.0.0.1:3005";
}

export function getSupabaseRuntimeEnv() {
  const statusEnv = getSupabaseStatusEnv();

  return {
    url: process.env.NEXT_PUBLIC_SUPABASE_URL ?? statusEnv.API_URL ?? requireEnv("NEXT_PUBLIC_SUPABASE_URL"),
    anonKey: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? statusEnv.ANON_KEY ?? requireEnv("NEXT_PUBLIC_SUPABASE_ANON_KEY"),
    serviceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY ?? statusEnv.SERVICE_ROLE_KEY ?? requireEnv("SUPABASE_SERVICE_ROLE_KEY"),
    secretKey: process.env.SUPABASE_SECRET_KEY ?? process.env.SECRET_KEY ?? statusEnv.SECRET_KEY ?? "",
  };
}
