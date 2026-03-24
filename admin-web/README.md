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

Use the local Supabase browser URL for web development, typically `http://127.0.0.1:54321`.

### How To Update Environment Values

Local:

```bash
cp .env.example .env.local
```

Then edit `.env.local` and restart `pnpm dev`.

Vercel preview/production:

- update environment variables in the Vercel project settings
- redeploy the affected environment

### How To Verify Runtime Targeting

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

- Preview deployments are a Vercel delivery channel, not a separate FleetFill runtime mode.
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

## Browser QA Focus

Before calling a deployment ready, verify:

- locale switching changes the URL and keeps you on the same admin route
- Arabic layout keeps drawer/sidebar alignment and icon direction correct
- dashboard, queues, and detail workspaces remain readable on laptop and emergency mobile browser widths
- auth, search, and one primary action per queue still work after env changes
