import { execFileSync, execSync } from "node:child_process";
import path from "node:path";

const appRoot = process.cwd();
const repoRoot = path.resolve(appRoot, "..", "..");
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
  if (
    process.env.NEXT_PUBLIC_SUPABASE_URL &&
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY &&
    process.env.SUPABASE_SERVICE_ROLE_KEY
  ) {
    return {
      API_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
      ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
      SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY,
      SECRET_KEY: process.env.SUPABASE_SECRET_KEY ?? "",
    };
  }

  const stdout = execFileSync("supabase", ["status", "-o", "env", "--workdir", "backend"], {
    cwd: repoRoot,
    encoding: "utf8",
    env: supabaseCliEnv,
  });

  return stdout
    .split(/\r?\n/)
    .map((line) => line.match(/^([A-Z_]+)="?(.*?)"?$/))
    .filter((match) => match !== null)
    .reduce((envMap, match) => {
      envMap[match[1]] = match[2];
      return envMap;
    }, {});
}

let statusEnv;

try {
  statusEnv = getSupabaseStatusEnv();
} catch (error) {
  const message = error instanceof Error ? error.message : String(error);
  console.error(
    "Playwright requires either a running local Supabase stack or explicit Supabase env vars. " +
      "The current environment has neither.\n" +
      message,
  );
  process.exit(1);
}
const args = process.argv.slice(2);
const env = {
  ...process.env,
  ...supabaseCliEnv,
  NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL ?? statusEnv.API_URL,
  NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? statusEnv.ANON_KEY,
  SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY ?? statusEnv.SERVICE_ROLE_KEY,
  SUPABASE_SECRET_KEY: process.env.SUPABASE_SECRET_KEY ?? statusEnv.SECRET_KEY,
  PLAYWRIGHT_BASE_URL: process.env.PLAYWRIGHT_BASE_URL ?? "http://127.0.0.1:3005",
  NEXT_PUBLIC_SITE_URL: process.env.NEXT_PUBLIC_SITE_URL ?? "http://127.0.0.1:3005",
  E2E_APP_ROOT: appRoot,
  E2E_REPO_ROOT: repoRoot,
};

execSync("pnpm build", {
  cwd: appRoot,
  env,
  stdio: "inherit",
});

execSync(`pnpm exec playwright test${args.length > 0 ? ` ${args.join(" ")}` : ""}`, {
  cwd: appRoot,
  env,
  stdio: "inherit",
});
