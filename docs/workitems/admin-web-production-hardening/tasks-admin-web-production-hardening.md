## Relevant Files

- `apps/admin-web/package.json` - Admin web dependencies and scripts; add `next-intl`, Playwright, and any supporting scripts here.
- `apps/admin-web/next.config.ts` - Likely integration point for the `next-intl` plugin or related App Router i18n config.
- `apps/admin-web/proxy.ts` - Current locale negotiation and request header flow; needs to align with the final i18n architecture.
- `apps/admin-web/app/layout.tsx` - Root document semantics and top-level provider wiring.
- `apps/admin-web/app/[lang]/layout.tsx` - Current localized route segment layout; likely to change during the `next-intl` migration.
- `apps/admin-web/app/page.tsx` - Root locale redirect behavior.
- `apps/admin-web/lib/i18n/config.ts` - Current locale registry; should become the single source of truth for supported locales and metadata.
- `apps/admin-web/lib/i18n/dictionaries.ts` - Current in-code dictionary source; likely to be replaced or reduced during message-file migration.
- `apps/admin-web/lib/i18n/admin-ui.ts` - Shared admin copy and enum-label helpers; likely to be refactored to use the new i18n foundation.
- `apps/admin-web/lib/validation/settings.ts` - Current hardcoded locale validation for platform settings.
- `apps/admin-web/lib/queries/admin-settings.ts` - Current parsing/defaulting for localization settings.
- `apps/admin-web/components/admin-shell/admin-locale-switcher.tsx` - Locale switcher behavior and locale option rendering.
- `apps/admin-web/app/[lang]/(admin)/**` - Current route-level consumers of `getDictionary`, `getAdminUi`, and `AppLocale` that must move to the final i18n API.
- `apps/admin-web/components/**` - Shared component consumers of the current custom i18n APIs; these must not be left on a hybrid i18n layer.
- `apps/admin-web/components/admin-shell/mobile-admin-sidebar.tsx` - Shared mobile drawer behavior that should move to audited primitives.
- `apps/admin-web/components/shared/confirm-dialog.tsx` - Shared dialog behavior that should move to audited primitives.
- `apps/admin-web/components/queues/admin-queue-page.tsx` - Shared queue-page composition; should remain the reusable composition point as hardening continues.
- `apps/admin-web/components/queues/admin-queue-scope-tabs.tsx` - Still contains inline locale branching that should become message- or registry-driven.
- `apps/admin-web/components/queues/disputes-queue-view.tsx` - Example of remaining inline locale-specific empty-state strings.
- `apps/admin-web/scripts/audit-i18n-keys.mjs` - Existing i18n validation tool that may need to be updated or replaced.
- `apps/admin-web/scripts/find-hardcoded-strings.mjs` - Existing hardcoded-string scan that should stay compatible with the final i18n setup.
- `apps/admin-web/tests/` - Current test setup area; likely place for shared browser test helpers or bootstrap logic.
- `.github/workflows/ci.yml` - Main CI workflow; likely place to wire browser tests into validation.
- `apps/admin-web/README.md` - Developer documentation that should reflect the new i18n and browser-testing approach.
- `docs/adr/ADR-005-admin-web-console.md` - Existing admin web ADR; may need an update if the hardening changes documented stack choices or standards.

### Notes

- Unit and component tests should stay near the code they protect where possible.
- Playwright tests should live in a dedicated admin-web browser test structure and be runnable independently in CI.
- The final implementation should preserve locale-prefixed routing.
- “Dynamic” in this work item means one authoritative locale registry plus dynamic message loading, not arbitrary runtime locale creation from database values.
- Task `0.0` is included because the template requires it; whether a branch is actually created can be decided during execution.
- After each implementation phase (`1.0` through `5.0`), run the admin-web validation set for that phase before continuing: `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all`.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [ ] 0.0 Create feature branch
  - [ ] 0.1 Create and checkout a new branch for this feature using the repo’s branch naming convention.
  - [ ] 0.2 Confirm the branch name reflects the work item scope, e.g. `codex/admin-web-production-hardening`.

- [x] 1.0 Replace the custom admin-web localization foundation with a registry-driven `next-intl` architecture
  - [x] 1.1 Add `next-intl` and any required App Router integration dependencies to `apps/admin-web/package.json`.
  - [x] 1.2 Configure `next-intl` in `apps/admin-web/next.config.ts` and add request-scoped i18n configuration in the recommended project location.
  - [x] 1.3 Refactor `apps/admin-web/lib/i18n/config.ts` into the single source of truth for supported locales, fallback locale, direction, Intl locale mapping, and locale labels/keys.
  - [x] 1.4 Move translation content out of the monolithic in-code dictionary shape into locale-specific message files that can be dynamically loaded.
  - [x] 1.5 Update `app/layout.tsx`, `app/[lang]/layout.tsx`, and `app/page.tsx` so locale negotiation, document `lang`/`dir`, and provider wiring flow through the new i18n setup.
  - [x] 1.6 Update `proxy.ts` so request locale negotiation and locale-prefixed route handling are compatible with the final `next-intl` architecture.
  - [x] 1.7 Preserve existing localized routes and ensure unsupported locale behavior remains explicit and safe.
  - [x] 1.8 Migrate all current route-level consumers of `getDictionary`, `getAdminUi`, and related custom i18n APIs to the final `next-intl`-based access pattern.
  - [x] 1.9 Run `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all` in `apps/admin-web` before moving to phase `2.0`.

- [x] 2.0 Remove hardcoded locale behavior and make locale growth safe across validation, settings, routing, and shared UI
  - [x] 2.1 Replace all hardcoded locale unions and arrays in settings validation with registry-derived values.
  - [x] 2.2 Update `lib/queries/admin-settings.ts` so localization defaults and parsing derive from the locale registry instead of inline locale literals.
  - [x] 2.3 Encode the authority rule that the locale registry defines supported locales and platform settings only enable or disable supported locales at runtime.
  - [x] 2.4 Update the locale switcher so locale options are driven entirely by the shared locale registry, translated message labels, and runtime-enabled locale policy.
  - [x] 2.5 Refactor shared helpers in `lib/i18n/admin-ui.ts` so they rely on the new i18n/message structure rather than growing parallel copy systems.
  - [x] 2.6 Migrate shared component consumers off the old custom i18n APIs so the app does not ship with a hybrid localization layer.
  - [x] 2.7 Remove remaining inline locale branching in shared UI such as scope tabs, empty states, and queue-level labels.
  - [x] 2.8 Search the admin web app for remaining locale-specific hardcoding and eliminate it where the behavior should be registry- or message-driven.
  - [x] 2.9 Update i18n validation tooling so missing messages or misregistered locales fail clearly in development and CI.
  - [x] 2.10 Run `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all` in `apps/admin-web` before moving to phase `3.0`.

- [x] 3.0 Standardize admin dialog and drawer primitives on audited accessibility foundations without changing the visual design system
  - [x] 3.1 Add the minimal Radix/shadcn primitive dependencies needed for dialog and drawer/sheet behavior.
  - [x] 3.2 Introduce local wrapper components for shared dialog and drawer primitives so feature code imports FleetFill-owned APIs, not vendor components directly.
  - [x] 3.3 Replace `components/shared/confirm-dialog.tsx` with a wrapper built on the audited primitive foundation while preserving the current visual styling contract.
  - [x] 3.4 Replace `components/admin-shell/mobile-admin-sidebar.tsx` drawer behavior with the new audited drawer/sheet primitive while preserving current layout and shell behavior.
  - [x] 3.5 Update existing consumers of confirm dialogs and mobile navigation so they use the new local primitive APIs without changing business behavior.
  - [x] 3.6 Verify focus trap, Escape handling, inert/background blocking, and focus restoration behavior are covered by tests or browser checks.
  - [x] 3.7 Run `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all` in `apps/admin-web` before moving to phase `4.0`.

- [ ] 4.0 Add Playwright browser coverage and CI validation for locale routing, shared shell behavior, and critical interaction flows
  - [ ] 4.1 Add Playwright configuration, scripts, and browser test scaffolding under `apps/admin-web`.
  - [ ] 4.2 Define a deterministic browser-test execution model, including how admin-web starts locally in CI and how tests target that running app.
  - [ ] 4.3 Define a deterministic auth strategy for Playwright, such as seeded admin credentials, storage-state bootstrap, or server-side test-only session setup.
  - [ ] 4.4 Define deterministic fixture data for queue/filter and destructive-action coverage so tests do not rely on drifting runtime state.
  - [ ] 4.5 Create browser tests for first-visit locale negotiation and direct locale route loading.
  - [ ] 4.6 Create browser tests for locale switching while preserving the current admin route.
  - [ ] 4.7 Create browser tests for document-level `lang` and `dir` semantics, including Arabic RTL behavior.
  - [ ] 4.8 Create browser tests for mobile drawer open/close behavior, keyboard focus management, and Escape dismissal.
  - [ ] 4.9 Create browser tests for at least one destructive confirmation flow using the shared dialog primitive.
  - [ ] 4.10 Create browser tests for at least one queue filter flow where state is reflected in the URL.
  - [ ] 4.11 Wire Playwright into `.github/workflows/ci.yml` or the appropriate frontend validation path so these checks run in CI.
  - [ ] 4.12 Run `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all` in `apps/admin-web` before moving to phase `5.0`.

- [ ] 5.0 Complete production-hardening cleanup across admin-web shared composition, i18n checks, docs, and validation workflows
  - [ ] 5.1 Review shared queue-page composition and continue consolidating repeated page scaffolding where it improves consistency and reusability.
  - [ ] 5.2 Update `README.md` in `apps/admin-web` with the new i18n architecture, browser testing commands, and validation expectations.
  - [ ] 5.3 Update any ADR or active docs that describe the admin web stack if the new standards need to be reflected in project documentation.
  - [ ] 5.4 Run admin-web validation commands including lint, typecheck, unit/component tests, i18n audits, and Playwright tests.
  - [ ] 5.5 Confirm the app still supports the current localized routes and operational shell flows after the migration.
  - [ ] 5.6 Confirm no route or shared component still depends on the retired custom i18n APIs except intentionally retained migration shims, if any.
  - [ ] 5.7 Run `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`, `pnpm dlx knip`, and `pnpm dlx pruny --all` in `apps/admin-web` as the final post-phase validation gate.
