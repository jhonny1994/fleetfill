# FleetFill Admin Web

Internal desktop-first operations console for FleetFill.

## Stack

- Next.js App Router
- React 19
- TypeScript
- Tailwind CSS
- `next-intl` with locale-prefixed routing
- TanStack Table
- Supabase SSR/Auth + Postgres RPCs
- Radix-based internal dialog and drawer primitives
- Vitest for unit/component tests
- Playwright for browser coverage
- pnpm

## Local Development

Install dependencies and run the app:

```bash
pnpm install
pnpm dev
```

Default local URL:

```text
http://localhost:3000
```

## Environment

Copy [`.env.example`](.env.example) to `.env.local` and set:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `NEXT_PUBLIC_SITE_URL`

For local development, `NEXT_PUBLIC_SUPABASE_URL` is typically `http://127.0.0.1:54321`.

Update local env:

```bash
cp .env.example .env.local
```

Then edit `.env.local` and restart `pnpm dev`.

For Vercel production:

- update environment variables in the Vercel project settings
- redeploy the affected environment
- or run [sync_admin_vercel_env.ps1](../../tool/sync_admin_vercel_env.ps1) from the repo root
- production `NEXT_PUBLIC_SITE_URL` should stay `https://fleetfill.vercel.app`

## Localization

The app uses a registry-driven `next-intl` setup:

- supported locales are defined in [config.ts](lib/i18n/config.ts)
- locale messages live in [messages](messages)
- locale negotiation happens in [proxy.ts](proxy.ts)
- runtime platform settings can enable or disable supported locales without changing code

Locale growth rule:

- add one locale entry to the registry
- add one locale message file
- keep runtime settings within the supported locale registry

## Validation

Primary quality gate in `apps/admin-web`:

```bash
pnpm lint
pnpm typecheck
pnpm test
pnpm build
pnpm i18n:audit-keys
pnpm i18n:scan-hardcoded
pnpm dlx knip
pnpm dlx pruny --all
```

## Browser Testing

Playwright coverage lives under [tests/e2e](tests/e2e).

Install the browser once:

```bash
pnpm test:e2e:install
```

Before running browser tests locally, start the local Supabase stack from the repo root or `backend`:

```bash
supabase start --workdir backend
supabase db reset --workdir backend --yes
```

Then run:

```bash
pnpm test:e2e
```

The Playwright harness seeds deterministic admin fixtures and builds the app against the local Supabase runtime automatically.
It runs the app on `http://127.0.0.1:3005`, which is a test-only host and not the production site contract.

## CI/CD

GitHub Actions workflows:

- [ci.yml](../../.github/workflows/ci.yml)
- [production_admin_web.yml](../../.github/workflows/production_admin_web.yml)
- [production_supabase.yml](../../.github/workflows/production_supabase.yml)

The admin-web CI path now covers:

- lint
- typecheck
- unit/component tests
- production build
- dead-code scans
- Playwright browser tests against local Supabase

## Deployment Notes

- Preview deployments are a Vercel delivery channel, not a separate FleetFill runtime mode.
- Production should use the admin-only domain and production Supabase environment variables.
- Never expose `service_role` keys to the browser or client bundles.
- Sensitive admin mutations continue to run through the backend RPC layer.
- [production_admin_web.yml](../../.github/workflows/production_admin_web.yml) is the canonical production workflow.

## Browser QA Focus

Before calling a deployment ready, verify:

- locale switching keeps the current admin route
- Arabic routes apply correct RTL semantics and mirrored shell behavior
- auth still works in every supported locale
- at least one queue filter flow keeps URL state
- at least one destructive confirmation flow behaves modally
