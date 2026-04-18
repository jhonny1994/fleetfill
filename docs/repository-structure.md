# Repository Structure

## Production-Facing Top Level

- `README.md`
  - Arabic-first public landing page for the repository
- `README.en.md`
  - English marketing-facing entry point
- `README.fr.md`
  - French marketing-facing entry point
- `docs/`
  - active product, architecture, operations, delivery, and release docs
- `.github/workflows/`
  - production control plane
  - unified CI plus per-surface production workflows
- `apps/`
  - sibling application roots
- `backend/`
  - sibling backend roots

## Product Code

- `apps/mobile/`
  - Flutter application root
  - owns `pubspec.yaml`, platform folders, `lib/`, `test/`, and app assets
- `apps/admin-web/`
  - internal admin console
- `backend/supabase/`
  - database schema, RPC, RLS, storage, and Edge Functions

## First-Class Product Surfaces

FleetFill should be read as three first-class surfaces:

- `mobile`
  - Flutter application in `apps/mobile/`
- `admin-web`
  - internal admin console
- `supabase`
  - backend schema, policies, functions, and hosted logic in `backend/supabase/`

The repo is a pragmatic product monorepo with sibling product surfaces, not a Flutter-root repo.

## Operational Tooling

- `tool/`
  - production executors, operator helpers, and internal helpers
  - execution layer behind the documented production workflows
  - includes the lightweight local workspace runner in [tool/workspace.ps1](../tool/workspace.ps1)
- `data/`
  - canonical non-secret source data such as location inputs
- `apps/mobile/assets/`
  - mobile app assets only; secret-bearing files must not be tracked there

## Environment Ownership

- root `.env`
  - canonical local operator and backend secret source
  - feeds Supabase CLI, rollout scripts, scheduler setup, and secret-sync tooling
- root `.env.example`
  - canonical shared template for backend and operator variables
- `apps/admin-web/.env.example`
  - committed admin-web environment contract only
  - documents public Next.js variables required by the admin surface
- `apps/admin-web/.env` and `apps/admin-web/.env.local`
  - local-only admin development files
  - never committed
- mobile app runtime
  - no committed env file
  - use `--dart-define` or editor launch configuration
  - native Firebase config files stay outside git
- `backend/supabase/functions/.env`
  - local-only Edge Function development helper
  - not part of the committed production contract

## Local Or Generated Folders

These are expected locally but are not part of the production repo contract:

- `.dart_tool/`
- `.metadata`
- `build/`
- `apps/admin-web/.vercel/`
- `.idea/`
- `.vscode/`

## Archive Rule

- active truth belongs in `docs/`
- historical planning and superseded material belongs in `docs/archive/`
- throwaway rollout experiments should not stay at the repo root
