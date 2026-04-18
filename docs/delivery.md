# Delivery

## Production Delivery Model

FleetFill uses a split but intentional delivery path:

- GitHub Actions owns continuous integration
- Supabase production rollout is operator-triggered from GitHub Actions
- admin-web production deploy is operator-triggered from GitHub Actions
- Flutter mobile production artifacts are built from release tags

This is deliberate. It keeps automated quality gates unified while still letting operators choose exactly which production surface to promote.
The active migration direction is one root orchestration workflow calling the surface workflows as reusable building blocks, while preserving the existing operator entrypoints and mobile tag-driven releases.

## CI Contract

GitHub Actions now exposes one main validation workflow:

- [ci.yml](../.github/workflows/ci.yml)

It detects which surface changed, then runs only the needed quality jobs on pull requests and on pushes to `main`:

- Flutter quality
  - localization generation
  - static analysis
  - test suite
- admin-web quality
  - install
  - lint
  - typecheck
  - tests
  - production build
- Supabase validation
  - local Supabase startup
  - database reset
  - database lint
  - runtime SQL test suite

The local Supabase validation environment uses the loopback URL `http://127.0.0.1:54321` because GitHub Actions starts an isolated local Supabase stack for validation. This is never the hosted production project.

## GitHub Governance Contract

- `main` is protected
- pull requests require one approval before merge
- the required CI checks are `System Contracts`, `Detect Changed Surfaces`, `Flutter Quality`, `Admin Web Quality`, and `Supabase Validation`
- stale reviews are dismissed on new pushes and conversation resolution is required before merge
- production release jobs are bound to the GitHub `Production` environment so release execution and release approval stay aligned

## CD Contract

Production delivery is split by surface:

- Supabase backend
  - promoted by [production_supabase.yml](../.github/workflows/production_supabase.yml)
  - operator can choose which parts to run:
    - database push
    - config push
    - secret sync
    - Edge Function deploy
    - scheduler setup
    - hosted verification
- admin-web
  - promoted by [production_admin_web.yml](../.github/workflows/production_admin_web.yml)
  - operator can choose env sync, build, and deploy separately
- Flutter mobile
  - released by [production_flutter.yml](../.github/workflows/production_flutter.yml)
  - produces signed Android artifacts on version tags or manual release dispatch
- Whole product
  - orchestrated by [release.yml](../.github/workflows/release.yml)
  - calls backend, admin-web, and mobile releases in order without replacing the existing surface workflows
  - validates that at least one surface is selected and that any mobile release tag matches `apps/mobile/pubspec.yaml`
  - supports `validate_only` for a no-deploy rehearsal of the coordinated release path

## Hosted Rollout Order

Promote production in this order:

- merge validated work to `main`
- let [ci.yml](../.github/workflows/ci.yml) pass
- run [production_supabase.yml](../.github/workflows/production_supabase.yml) when backend or hosted config changed
- run [production_admin_web.yml](../.github/workflows/production_admin_web.yml) when admin-web should ship
- prefer [release.yml](../.github/workflows/release.yml) when shipping the coordinated product as one release event
- use the same root workflow with `validate_only=true` before the first coordinated production run or after major workflow changes
- run representative-device and hosted smoke validation before announcing release completeness
- keep the custom mobile auth scheme only as a temporary fallback until real-device App Links validation is complete

## Remaining Manual Or Environment-Specific Validation

These checks still require representative devices or real hosted services:

- Profile the app on a representative Android device in profile mode
- validate repeated jank and long-list behavior on target device classes
- run TalkBack and large-text accessibility checks
- run Arabic, French, and English manual localization QA
- verify hosted Supabase Auth email delivery with real inboxes
- confirm push, transactional email, and scheduler behavior in hosted infrastructure

## Release Gate

Do not claim production-ready rollout until all of the following are true:

- CI passed from the current `main` state
- hosted backend rollout completed from the current `main` state
- Vercel published the expected admin-web revision
- auth email works in the hosted project
- transactional email works in the hosted project
- manual device and accessibility validation is complete
