# FleetFill Admin Web

Internal desktop-first operations console for FleetFill.

## Stack

- Next.js App Router
- TypeScript
- Tailwind CSS
- TanStack Query
- TanStack Table
- Supabase SSR
- pnpm

## Local Development

```bash
pnpm install
pnpm dev
```

Default local URL:

```text
http://localhost:3000
```

## Environment

Copy [`admin-web/.env.example`](C:\Users\raouf\projects\fleetfill\admin-web\.env.example) into `.env.local` and set:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `NEXT_PUBLIC_SITE_URL`
- `NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL` (optional override)

Use the local Supabase browser URL for web development, typically `http://127.0.0.1:54321`.

### Environment Matrix

- `local`
  - `NEXT_PUBLIC_SITE_URL=http://localhost:3000`
  - usually points at local Supabase
  - header badge resolves to `Local` unless overridden
- `preview`
  - `NEXT_PUBLIC_SITE_URL=https://<branch>.vercel.app`
  - points at preview-safe shared backend values
  - header badge resolves to `Preview` unless overridden
- `production`
  - `NEXT_PUBLIC_SITE_URL=https://admin.fleetfill.dz`
  - points at production Supabase values
  - header badge resolves to `Production` unless overridden

### How To Update Environment Values

Local:

```bash
cp .env.example .env.local
```

Then edit `.env.local` and restart `pnpm dev`.

Vercel preview/production:

- update environment variables in the Vercel project settings
- redeploy the affected environment
- if you want the header to show a custom environment name like `Staging`, set `NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL`

### How To Verify Which Environment You Are In

- check the header environment badge in the admin shell
- verify `NEXT_PUBLIC_SITE_URL` matches the expected host
- confirm auth and data point to the intended Supabase project
- for preview/prod, verify the deployed URL and the Vercel environment page agree

## Verification Commands

```bash
pnpm lint
pnpm typecheck
pnpm test
pnpm build
pnpm i18n:audit-keys
pnpm i18n:scan-hardcoded
```

From the repo root, backend validation remains:

```bash
supabase db lint
supabase test db
```

## Vercel Notes

- Preview deployments should point to the shared Supabase project with preview-safe environment variables managed in Vercel.
- Production should use the admin-only domain and production Supabase environment variables.
- Do not expose `service_role` keys to the browser or to Next.js client bundles.
- Sensitive admin mutations continue to run through the backend RPC layer.

## CI/CD

GitHub Actions workflows:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml)
- [C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_deploy.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_deploy.yml)

GitHub configuration expected for deployment:

- secret `VERCEL_TOKEN`
- variable `VERCEL_ORG_ID`
- variable `VERCEL_ADMIN_WEB_PROJECT_ID`

Vercel runtime variables expected by the app:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `NEXT_PUBLIC_SITE_URL`
- `NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL` (optional)

## Browser QA Focus

Before calling an environment ready, verify:

- locale switching changes the URL and keeps you on the same admin route
- Arabic layout keeps drawer/sidebar alignment and icon direction correct
- dashboard, queues, and detail workspaces remain readable on laptop and emergency mobile browser widths
- environment badge matches the actual target environment
- auth, search, and one primary action per queue still work after env changes
