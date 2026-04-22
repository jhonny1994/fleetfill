# Netlify Cutover

## Goal

Make Netlify the permanent admin-web host and retire Vercel without losing rollback safety during the transition.

This runbook assumes:

- the `migration/hosting` branch has already been validated on Netlify
- Netlify serves the admin-web app correctly
- Supabase remains the backend provider

## Canonical Hosting Contract

The permanent hosting contract for admin-web is:

- Netlify is the active production host
- `PUBLIC_SITE_URL` is the canonical public origin for hosted flows
- `NEXT_PUBLIC_SITE_URL` is the admin-web public origin exposed to the browser
- Vercel is not part of runtime truth after cutover

## Pre-Cutover Checklist

Before switching permanently:

- merge `migration/hosting` into `main`
- confirm GitHub `main` passes [ci.yml](../.github/workflows/ci.yml)
- confirm Netlify can deploy `main`
- confirm Netlify production environment contains:
  - `NEXT_PUBLIC_SUPABASE_URL`
  - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
  - `NEXT_PUBLIC_SITE_URL`
- confirm GitHub variables contain:
  - `SUPABASE_URL`
  - `SUPABASE_PUBLISHABLE_KEY`
  - `PUBLIC_SITE_URL`
  - `NETLIFY_SITE_ID`
- confirm GitHub secrets contain:
  - `NETLIFY_AUTH_TOKEN`
  - `SUPABASE_ACCESS_TOKEN`
- verify login, logout, locale redirects, and at least one authenticated admin flow on Netlify
- verify [tool/verify_hosted_rollout.ps1](../tool/verify_hosted_rollout.ps1) passes against the Netlify host

## Cutover Steps

### 1. Merge The Migration Branch

- merge `migration/hosting` into `main`
- push `main`
- keep `migration/hosting` for rollback until the observation window ends

### 2. Switch Netlify To Main

- change the Netlify production branch to `main`
- trigger a fresh production deploy from `main`
- verify:
  - `/`
  - `/ar/sign-in`
  - `/auth/mobile-callback`
  - one authenticated admin page
  - one deep-linked detail route

### 3. Keep Vercel As Rollback Only

During the observation window:

- do not send new operational traffic to Vercel
- do not treat Vercel as the canonical host
- keep the Vercel project and env vars intact only for emergency rollback

Recommended observation window:

- `3 to 7 days`

### 4. Commit To Netlify

Once the observation window passes cleanly:

- keep Netlify as the only active admin-web host
- keep `PUBLIC_SITE_URL` and `NEXT_PUBLIC_SITE_URL` aligned with the Netlify production hostname
- remove any remaining operator guidance that refers to Vercel as an active platform

## Vercel Retirement Steps

After the rollback window expires:

1. Remove Vercel-specific GitHub variables:
   - `VERCEL_ORG_ID`
   - `VERCEL_ADMIN_WEB_PROJECT_ID`
2. Remove the Vercel-specific GitHub secret:
   - `VERCEL_TOKEN`
3. Remove or archive the Vercel project in the Vercel dashboard.
4. Remove stale local Vercel env/bootstrap files from trusted operator machines if no longer needed.
5. Delete `migration/hosting` after `main` is confirmed stable.

## Rollback Plan

If Netlify `main` fails during cutover:

- switch the Netlify production branch back to `migration/hosting` if that branch remains healthy
- or keep users on the existing Vercel host while fixing `main`
- do not change Supabase hosting or backend providers as part of rollback unless the issue is proven to be backend-related

Rollback should prefer the smallest reversible change:

- branch rollback first
- host rollback second
- backend rollback only if necessary

## Post-Cutover Validation

After Netlify is permanent:

- rerun hosted rollout verification against the canonical Netlify URL
- verify auth callbacks and locale redirects again
- verify static assets and images
- verify Android App Links against `PUBLIC_SITE_URL` on a real device
- confirm release docs and operations docs still match the live production setup

## Ownership

This cutover should remain documented and reproducible.

Future hosting changes should follow the same pattern:

- provider-neutral app contract first
- migration branch validation second
- controlled cutover third
- retirement of the old provider last
