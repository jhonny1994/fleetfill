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
  - CI, validation, and signed release automation

## Product Code

- `lib/`
  - Flutter application
- `admin-web/`
  - internal admin console
- `supabase/`
  - database schema, RPC, RLS, storage, and Edge Functions
- `test/`
  - Flutter and contract coverage

## Operational Tooling

- `tool/`
  - rollout, verification, sync, and maintenance scripts
- `data/`
  - canonical non-secret source data such as location inputs
- `assets/`
  - app assets only; secret-bearing files must not be tracked here

## Local Or Generated Folders

These are expected locally but are not part of the production repo contract:

- `.dart_tool/`
- `build/`
- `.vercel/`
- `.idea/`
- `.vscode/`

## Archive Rule

- active truth belongs in `docs/`
- historical planning and superseded material belongs in `docs/archive/`
- throwaway rollout experiments should not stay at the repo root
