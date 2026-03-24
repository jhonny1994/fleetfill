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

## Verification Commands

```bash
pnpm lint
pnpm typecheck
pnpm test
pnpm build
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
