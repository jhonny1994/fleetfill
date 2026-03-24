# Admin Web Production Checklist

This document is the release-readiness tracker for the FleetFill admin web console.

Use it to answer one question honestly:

- can FleetFill staff operate the business safely and fully from the admin web console in a real production environment?

This checklist is broader than implementation-complete. It covers product scope, workflow completeness, governance, auth, backend integrity, UX, accessibility, CI/CD, deployment, observability, and operational launch readiness.

Status values:

- `pass` - complete and validated
- `partial` - implemented in part, but not yet fully proven or not yet fully operationalized
- `fail` - missing or not acceptable for launch
- `n/a` - intentionally not in current launch scope

Evidence should point to code, docs, workflows, or explicit validation commands.

## Summary

| Area | Status | Notes |
| --- | --- | --- |
| Product scope | `pass` | Planned admin feature set exists in `admin-web/` |
| Workflow completeness | `partial` | Implemented, but not yet fully browser-QA’d on deployed env |
| Role and governance | `pass` | Bootstrap, invite, role changes, safeguards exist and are DB-tested |
| Auth and session security | `pass` | Query-layer server guards added and locally smoke-tested |
| Backend contract integrity | `pass` | Typed Supabase contract, migrations, RPC-backed workflows, DB tests |
| Queue correctness | `partial` | Implemented and tested indirectly, but needs full browser QA pass |
| Detail workspace quality | `partial` | Implemented, but still needs full operator walkthrough |
| Search | `partial` | Implemented and hardened, but needs full ops QA |
| UI/UX quality | `partial` | Strong design/spec alignment, needs final deployed visual QA |
| Internationalization | `partial` | Routing/RTL/locales implemented, needs complete content QA |
| Accessibility | `partial` | Good baseline, but no explicit final accessibility audit yet |
| Performance | `partial` | Local build is healthy, but no preview/prod benchmark pass yet |
| Error handling | `partial` | Boundaries exist and auth leak was fixed; broader fault injection still missing |
| CI | `partial` | Dedicated `admin-web` workflow and full Supabase suite workflow exist; still needs first green GitHub runs |
| CD / deployment | `partial` | Deployment workflow is defined, but Vercel wiring and first green deploy are still pending |
| Environment and secrets | `partial` | `.env.example` exists, but deployment env validation is incomplete |
| Repo hygiene | `partial` | Core structure is good, log handling is cleaner, and `next-env.d.ts` is now a deliberate tracked convention; broader cleanup still remains |
| Observability and ops | `partial` | Audit and queue health exist; deploy/runtime monitoring not fully set |
| Browser QA | `partial` | Critical auth smoke done locally; full queue/action QA still pending |
| Launch operations | `partial` | Release, rollback, and bootstrap guidance now exist, but final signoff ownership still needs to be locked |

## 1. Product Scope

### 1.1 Admin surfaces exist

Status: `pass`

Required:

- dashboard
- payments
- verification
- disputes
- payouts
- support
- users
- admins
- settings
- audit and health
- global search

Evidence:

- routes present under [C:\Users\raouf\projects\fleetfill\admin-web\app\[lang]\(admin)](C:\Users\raouf\projects\fleetfill\admin-web\app\[lang]\(admin))
- implementation scope tracked in [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\tasks-admin-web-console.md](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\tasks-admin-web-console.md)

### 1.2 No critical admin dependence on Flutter admin

Status: `pass`

Required:

- admin web provides the intended admin product surface
- Flutter admin is fallback/companion only, not a core dependency

Evidence:

- admin-web PRD/spec/package in [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web)

## 2. Workflow Completeness

### 2.1 Queue and detail coverage

Status: `partial`

Required:

- each major queue has a list page
- each queue has a detail/workspace page
- each critical queue exposes the intended primary action

Current read:

- implemented in code
- still needs one human browser walkthrough by role and by queue

Evidence:

- app routes from build output validated locally
- `pnpm build`

### 2.2 Critical operational actions

Status: `partial`

Must verify end to end:

- payment approve/reject
- verification approve/reject
- dispute resolve
- payout release
- support reply/status flows
- admin invitation / revoke / role change / deactivate
- settings updates

Current read:

- backend workflows exist
- surfaces exist
- final browser exercise is still needed

## 3. Role And Governance

### 3.1 Admin roles

Status: `pass`

Locked roles:

- `super_admin`
- `ops_admin`

Evidence:

- governance schema/workflows in [C:\Users\raouf\projects\fleetfill\supabase\migrations\20260317010000_create_foundation_layer.sql](C:\Users\raouf\projects\fleetfill\supabase\migrations\20260317010000_create_foundation_layer.sql)

### 3.2 First admin bootstrap

Status: `pass`

Evidence:

- real local bootstrap completed during smoke validation
- runtime tests in [C:\Users\raouf\projects\fleetfill\supabase\tests\runtime_admin_governance_test.sql](C:\Users\raouf\projects\fleetfill\supabase\tests\runtime_admin_governance_test.sql)

### 3.3 Invite and lifecycle safeguards

Status: `pass`

Required:

- invite
- accept
- revoke
- activate/deactivate
- promote/demote
- last active `super_admin` protection

Evidence:

- DB runtime governance tests
- admin management routes in `admin-web`

## 4. Auth And Session Security

### 4.1 Protected admin pages

Status: `pass`

Required:

- signed-out users cannot access protected data
- protected pages redirect safely
- under-privileged users cannot access `super_admin` routes

Evidence:

- query-layer guards in:
  - [C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\require-server-admin-session.ts](C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\require-server-admin-session.ts)
  - [C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\require-server-super-admin.ts](C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\require-server-super-admin.ts)
- local smoke:
  - unauthenticated `/ar/dashboard` redirects cleanly
  - authenticated `super_admin` reaches `/ar/dashboard` and `/ar/admins`

### 4.2 Inactive admin handling

Status: `pass`

Evidence:

- session resolution in [C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\get-admin-session.ts](C:\Users\raouf\projects\fleetfill\admin-web\lib\auth\get-admin-session.ts)

## 5. Backend Contract Integrity

### 5.1 Typed contract

Status: `pass`

Evidence:

- [C:\Users\raouf\projects\fleetfill\admin-web\lib\supabase\database.types.ts](C:\Users\raouf\projects\fleetfill\admin-web\lib\supabase\database.types.ts)

### 5.2 Admin workflows are backend-owned

Status: `pass`

Required:

- no critical admin mutation should be frontend-only
- privileged actions should be enforced in Supabase

Evidence:

- admin governance RPCs and DB tests
- queue/detail mutations call backend workflows

## 6. Queue Correctness

### 6.1 Operational filtering and navigation

Status: `partial`

Current read:

- implemented
- needs browser-level verification per queue with realistic seeded data

Suggested validation:

- payments
- verification
- disputes
- payouts
- support
- users

## 7. Detail Workspace Quality

### 7.1 Sufficient context to act safely

Status: `partial`

Required:

- summary facts
- linked entities
- files/proofs where relevant
- action affordance near context
- no raw implementation leakage as primary UX

Current read:

- code looks production-shaped
- still needs final operator walkthrough

## 8. Search

### 8.1 Cross-entity search

Status: `partial`

Current read:

- implemented
- UUID/free-text hardening is in place
- still needs realistic ops QA for usefulness and ranking

Evidence:

- [C:\Users\raouf\projects\fleetfill\admin-web\lib\queries\admin-search.ts](C:\Users\raouf\projects\fleetfill\admin-web\lib\queries\admin-search.ts)

## 9. UI/UX Quality

### 9.1 Desktop-first operations UX

Status: `partial`

Required:

- queue-first desktop behavior
- usable dense layouts
- strong states
- no stale generic dashboard feel

Evidence:

- design/spec docs:
  - [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-ui-ux-spec.md](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-ui-ux-spec.md)
  - [C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-master-spec.md](C:\Users\raouf\projects\fleetfill\docs\planning\admin-web\admin-web-master-spec.md)

Blocker to close:

- final deployed browser visual QA

## 10. Internationalization

### 10.1 Locale routing and RTL

Status: `partial`

What exists:

- `[lang]` route structure
- Arabic/French/English dictionaries
- RTL support

Still needed:

- full string coverage sanity pass
- final multilingual browser QA

## 11. Accessibility

### 11.1 Keyboard and focus baseline

Status: `partial`

What exists:

- focus styling
- label-first forms
- desktop layout discipline

Still needed:

- explicit final accessibility QA checklist run

## 12. Performance

### 12.1 Internal-tool performance

Status: `partial`

What exists:

- healthy local production build
- server-first data loading pattern

Still needed:

- preview deployment benchmark
- realistic queue volume dogfooding

## 13. Error Handling

### 13.1 Boundary and failure behavior

Status: `partial`

What exists:

- auth redirect behavior fixed
- route error/loading structure exists

Still needed:

- broader failure-mode QA:
  - bad env
  - empty data
  - revoked admin
  - RPC failure

## 14. CI

### 14.1 Dedicated admin-web quality workflow

Status: `partial`

Current state:

- dedicated `admin-web` GitHub Actions workflow now exists

Senior-production expectation:

- workflow must be required on PRs into `main`
- failures must block merge
- branch protection must require:
  - admin-web quality
  - supabase validation
- the workflow must only run on relevant path changes
- Node and pnpm versions must be explicit and stable
- lockfile installs must use `--frozen-lockfile`
- build must run in production mode, not only dev/test mode

Required steps:

- `pnpm install --frozen-lockfile`
- `pnpm lint`
- `pnpm typecheck`
- `pnpm test`
- `pnpm build`

Current evidence:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_quality.yml)

Remaining to close:

- first successful GitHub Actions run on the branch/PR
- mark the workflow as a required status check in GitHub branch protection
- verify cache behavior is stable and does not hide lockfile drift
- confirm CI duration is acceptable for daily use

### 14.2 Backend validation completeness

Status: `partial`

Current state:

- Supabase validation exists
- workflow now runs the full runtime DB suite

Senior-production expectation:

- schema lint and runtime DB tests must run on every admin-affecting PR
- CI must prove migrations can replay from zero on fresh infrastructure
- the workflow should fail loudly on migration drift, runtime drift, and policy drift
- governance/security/support/notification tests must remain part of the default suite
- any future seed/setup assumptions in tests must be self-cleaning and rerunnable

Evidence:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\supabase_validation.yml)

Remaining to close:

- first successful GitHub Actions run with the expanded suite
- verify runtime against the same CLI version policy intended for CI/CD long term
- confirm workflow log output is readable enough for incident debugging

## 15. CD / Deployment

### 15.1 Vercel preview deployment

Status: `partial`

Current state:

- preview deployment workflow now exists

Senior-production expectation:

- every meaningful admin-web PR should produce a preview URL automatically
- preview deployment must pull preview-scoped env vars only
- preview URLs should be the environment used for browser QA and stakeholder signoff
- deploy logs should be easy to inspect by maintainers
- deployment should not require local shell auth to validate the pipeline
- preview should not expose elevated secrets or any service-role key material

Current blocker:

- verified Vercel project wiring and first successful preview deploy are still pending

Evidence:

- [C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_deploy.yml](C:\Users\raouf\projects\fleetfill\.github\workflows\admin_web_deploy.yml)

### 15.2 Production deployment path

Status: `partial`

Current state:

- production deployment workflow now exists

Senior-production expectation:

- production deploy should happen only from protected `main`
- production deploy should depend on green CI
- production env vars should be distinct from preview
- the release owner should know exactly how to roll forward and roll back
- deployment should produce an auditable record: commit, deploy time, owner, environment
- smoke verification should run immediately after deploy
- critical auth and queue routes should be part of post-deploy verification

Still needed:

- deploy gate with smoke verification
- first successful production-grade preview/prod rehearsal
- explicit decision on whether production deploy is automatic on merge or manual approval after preview QA

## 16. Environment And Secrets

### 16.1 Environment template completeness

Status: `partial`

What exists:

- [C:\Users\raouf\projects\fleetfill\admin-web\.env.example](C:\Users\raouf\projects\fleetfill\admin-web\.env.example)

Senior-production expectation:

- a complete environment matrix should exist for:
  - local
  - preview
  - production
- each variable should document:
  - where it lives
  - whether it is public or secret
  - which environment needs it
  - whether rotation is operationally sensitive
- no browser-exposed variable should accidentally contain privileged credentials
- deployment should fail clearly if required runtime env vars are missing
- `NEXT_PUBLIC_SITE_URL` should match the real preview/production hostnames used by redirects and links

Still needed:

- confirm final Vercel env matrix by environment
- confirm bootstrap/invite operational env needs
- verify whether any mail/invite/recovery flows need extra admin-web-facing configuration

## 17. Repo Hygiene

### 17.1 Generated and local artifacts

Status: `partial`

Current notes:

- `.next/`, `node_modules/`, `.tsbuildinfo` are correctly ignored
- `admin-web-start.log` is now explicitly ignored
- `next-env.d.ts` is now a deliberate tracked convention

Senior-production expectation:

- generated dev/build artifacts should never appear as meaningful repo noise
- local logs and temp diagnostics should be ignored
- the repo should not rely on accidental local files for successful builds
- Next.js conventions should be deliberate, not accidental

Remaining to close:

- add `admin-web/next-env.d.ts` to version control in the next commit
- review `AGENTS.md` / `CLAUDE.md` presence in `admin-web/` and confirm they are intentionally part of repo guidance, not stray scaffolding

Evidence:

- [C:\Users\raouf\projects\fleetfill\admin-web\.gitignore](C:\Users\raouf\projects\fleetfill\admin-web\.gitignore)

## 18. Observability And Ops

### 18.1 Admin-visible operational health

Status: `partial`

What exists:

- audit log view
- email health / dead letters
- push dead letters

Senior-production expectation:

- the team should know how to answer:
  - is admin auth healthy?
  - are notifications flowing?
  - are mail jobs failing?
  - are key queues loading?
  - are privileged actions erroring?
- not every answer must be in-app, but the operating model must be documented
- there should be at least a minimal monitoring story for:
  - deploy failures
  - runtime crashes
  - auth failures
  - background delivery failures
- post-deploy checks must have a clear owner
- incidents must be traceable from user symptom to audit/log record

Still needed:

- deployment/runtime monitoring checklist
- post-deploy verification owner/process
- decision on whether monitoring lives primarily in Vercel, Supabase, or an external tool

## 19. Browser QA

### 19.1 Local smoke

Status: `partial`

Completed:

- signed-out dashboard redirect
- signed-in `super_admin` dashboard
- signed-in `super_admin` admin management page

Senior-production expectation:

- local smoke is only the first gate
- preview browser QA should cover:
  - `ops_admin` sign-in and role boundaries
  - `super_admin` sign-in and governance pages
  - every queue list
  - at least one detail page per queue
  - primary mutation per critical workflow
  - Arabic/French/English page sanity
  - mobile fallback sanity
- QA should produce pass/fail notes, not just ad hoc confidence

Still needed:

- complete queue/action browser pass
- `ops_admin` role pass
- multilingual browser pass
- deployed preview pass
- explicit QA checklist doc or test script

## 20. Launch Operations

### 20.1 Release runbook

Status: `partial`

Missing:

- final admin-web launch checkoff owner/process

Senior-production expectation:

- one named owner for launch approval
- one named owner for rollback decision
- one named owner for admin bootstrap/recovery handling
- one repeatable checklist that answers:
  - what must be green before deploy
  - what must be checked immediately after deploy
  - what triggers rollback
  - how to verify the first admin / invite flow after release

Recommended final signoff model:

- engineering owner confirms CI, deploy, rollback, and environment readiness
- product/ops owner confirms queue/action/browser QA readiness
- only after both sign off should production be considered certified

## Exit Criteria

Do not call the admin web fully production-ready until all of these are true:

- `admin-web` CI exists and passes
- Supabase CI covers the full current runtime DB suite
- Vercel preview deployment is working
- a real preview browser QA pass is complete
- core admin actions are exercised end to end
- multilingual sanity pass is complete
- release/rollback/admin-bootstrap runbooks exist
- repo hygiene issues are resolved or intentionally documented

## Immediate Next Actions

1. Get the new GitHub Actions workflows to their first green run and make them required checks.
2. Wire Vercel preview and production environments with the required project/org IDs and token.
3. Run the first preview deployment and record the preview URL as QA evidence.
4. Create and execute a role-aware browser QA checklist on the preview deployment.
5. Lock final launch signoff ownership across engineering and operations.
6. Review remaining repo-hygiene items beyond `next-env.d.ts`, especially intentional guidance files and any local-only artifacts.
