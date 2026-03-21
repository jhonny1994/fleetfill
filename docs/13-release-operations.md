# Release Operations

This file defines the operational release workflow for FleetFill staging, release candidates, and production rollout.

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
- staging and production artifacts must record the source commit SHA used to produce them

## Staging Checklist

- validate the current commit with `dart analyze`, `flutter test`, `supabase db reset --yes`, and `supabase db lint --debug`
- on Windows runners, ensure the Visual Studio C++ and ATL desktop build prerequisites are installed before running desktop integration tests that depend on `flutter_secure_storage_windows`
- confirm staging secrets remain distinct from production secrets
- seed staging reference data and current platform settings
- verify shipper, carrier, and admin critical flows with staging data
- verify support email routing, payout procedure rehearsal, refund procedure rehearsal, and scheduled automation health

## Release Candidate Checklist

- create or confirm the release tag only after staging validation succeeds
- build Android release artifacts from the tagged commit
- review accessibility, Arabic/French/English QA, profile-mode performance, and app-size checks
- confirm rollback readiness for mobile and backend changes before approval

## Rollback Procedure

- if a release fails critical health checks, stop rollout and revert to the last known-good tag
- if backend deployment fails, restore the last known-good deployed configuration before retrying
- do not stack emergency fixes on top of an unstable release without first restoring service health
- document the incident, affected tag, rollback timestamp, and follow-up remediation items

## Monitoring Checklist

- review booking, payment, dispute, payout, and email backlog health after rollout
- review dead-letter email jobs, bounced addresses, and overdue automations
- confirm support contact routing remains operational
- confirm generated document delivery and secure access still work for recent bookings
