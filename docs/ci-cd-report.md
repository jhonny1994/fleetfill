# CI/CD Report

## What Was Wrong

The previous GitHub Actions setup worked, but it was fragmented:

- three separate quality workflows split by surface
- one manual Vercel deploy workflow with duplicated preview and production jobs
- one light release-candidate reminder workflow that did not materially protect production
- no single document describing the actual production contract

That created two problems:

- the pipeline looked more complex than it really was
- operators had to infer which workflow mattered for CI versus real production rollout

## What The Production Model Is Now

FleetFill now uses a clearer split:

- CI
  - one workflow: [C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\ci.yml)
  - validates Flutter, admin-web, and Supabase on pull requests and `main`
- CD
  - backend and hosted config rollout: [C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_supabase.yml)
  - admin-web publication: [C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_admin_web.yml)
  - mobile release artifacts: [C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\production_flutter.yml)

## Why This Is Better

- fewer workflows to reason about
- one obvious CI gate for repository health
- CI only runs the heavy checks for the surfaces that actually changed
- GitHub becomes the operator control surface for what actually ships
- backend rollout keeps using repo-owned rollout logic, but GitHub now controls which rollout parts execute
- release automation stays separated from day-to-day backend and web promotion

## Current Production Truth

- merge validated work to `main`
- wait for `FleetFill CI` to pass
- if backend or hosted config changed, run `Production Supabase`
- if admin-web should ship, run `Production Admin Web`
- cut mobile releases from tags or `Production Flutter` when ready

## Important Clarifications

- `SUPABASE_URL: http://127.0.0.1:54321` in CI is the local validation stack inside GitHub Actions, not the hosted cloud project
- the `tool/` scripts are still part of real production rollout behavior
  - they are no longer "developer-only helpers"
  - they are the project-specific implementation behind the GitHub deploy buttons
  - GitHub Actions now decides when they run and which production surface they affect
- Supabase reset in CI does not touch production
  - it only resets the temporary local validation database used by the workflow

## Follow-Up Operator Action

One environment issue still exists outside the repo:

- the GitHub secret `VERCEL_TOKEN` must be valid for the configured Vercel team

If that token is invalid, any Vercel CLI-based env sync or hosted verification step that depends on it will fail even though the repository code is correct.
