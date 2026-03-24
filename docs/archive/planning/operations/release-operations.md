# Release Operations

This file defines the operational release workflow for FleetFill local development, release candidates, and production rollout.

## Branch, Tag, And Changelog Conventions

- the long-lived protected branch is `main`
- feature and phase work should use descriptive branch names such as `phase14-16-release-readiness`
- release tags should use `v<major>.<minor>.<patch>`
- every release tag must map to one changelog entry and one GitHub Release
- GitHub Releases must stay customer-facing and describe user-visible outcomes, not internal migration details

## Versioning Rules

- app versions use `major.minor.patch`
- Android `versionCode` must increase for every release candidate and production rollout
- iOS `buildNumber` must increase for every release candidate and production rollout
- release-candidate and production artifacts must record the source commit SHA used to produce them

## Release Rehearsal Checklist

- validate the current commit with `dart analyze`, `flutter test`, `supabase db reset --yes`, and `supabase db lint --debug`
- validate `admin-web` with `pnpm lint`, `pnpm typecheck`, `pnpm test`, and `pnpm build`
- confirm hosted rehearsal secrets remain distinct from production secrets
- seed hosted rehearsal reference data and current platform settings
- verify shipper, carrier, and admin critical flows with hosted rehearsal data
- verify `ops_admin` and `super_admin` browser flows in the admin web preview
- verify support email routing, payout procedure rehearsal, refund procedure rehearsal, and scheduled automation health

## Release Candidate Checklist

- create or confirm the release tag only after release rehearsal succeeds
- build Android release artifacts from the tagged commit
- verify the admin web preview deployment for the tagged commit and confirm production Vercel variables are present
- review accessibility, Arabic/French/English QA, profile-mode performance, and app-size checks
- confirm rollback readiness for mobile and backend changes before approval

## Admin Web Bootstrap And Access Checklist

- create the first `super_admin` only through the bootstrap workflow owned by FleetFill operators
- verify the bootstrap action produces both `profiles` and `admin_accounts` records
- confirm the first `super_admin` can sign in to the admin web and access the `Admins` section
- create at least one additional admin through the invitation flow before production handoff
- verify last-active-`super_admin` safeguards before go-live
- store the bootstrap and recovery procedure in the internal operator runbook, not in public user-facing materials

## Rollback Procedure

- if a release fails critical health checks, stop rollout and revert to the last known-good tag
- if backend deployment fails, restore the last known-good deployed configuration before retrying
- if admin web deployment fails, roll back the Vercel production deployment to the last known-good build before retrying
- do not stack emergency fixes on top of an unstable release without first restoring service health
- document the incident, affected tag, rollback timestamp, and follow-up remediation items

## Monitoring Checklist

- review booking, payment, dispute, payout, and email backlog health after rollout
- review dead-letter email jobs, bounced addresses, and overdue automations
- confirm support contact routing remains operational
- confirm generated document delivery and secure access still work for recent bookings
- confirm admin web sign-in, dashboard load, queue load, and admin governance flows remain operational after deployment
