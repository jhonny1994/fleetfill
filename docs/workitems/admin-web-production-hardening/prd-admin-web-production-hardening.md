# PRD: Admin Web Production Hardening

## Introduction/Overview

FleetFill's `apps/admin-web` app already uses a strong modern stack, but the current implementation still has several production-grade gaps around internationalization, dynamic configuration, accessibility-sensitive UI primitives, and browser-level regression protection.

The app currently relies on a custom i18n layer with locale definitions and locale-specific behavior scattered across routing, validation, settings parsing, and UI components. That makes scale risky: adding a new locale requires editing multiple files, inline switches still exist, and locale growth is not safe by construction. The app also still owns some critical interaction primitives directly, which increases accessibility and maintenance risk for dialogs, drawers, and similar overlays.

This work item hardens the admin web app to a more robust production standard by:

- adopting `next-intl` as the App Router i18n foundation
- centralizing locale and formatting behavior into a single registry-driven source of truth
- standardizing accessibility-sensitive primitives on audited foundations for dialog and drawer behavior
- adding Playwright-based browser coverage and CI checks for the shell, locale routing, and high-risk interactions

The goal is to make the admin web app easier to extend, safer to change, and more aligned with modern production practices used by strong frontend teams.

## Goals

- Replace the ad hoc i18n foundation with a production-grade App Router localization system based on `next-intl`.
- Ensure locale configuration is registry-driven so adding a locale requires one source-of-truth update and one message file, not scattered code edits.
- Remove remaining locale-specific inline branching from shared UI behavior where it should be driven by messages or registry metadata.
- Standardize dialog and drawer behavior on audited accessibility primitives while preserving FleetFill's existing design language.
- Add browser-level regression coverage for locale routing, document semantics, shell behavior, and shared interaction flows.
- Keep the current successful core stack where it is already production-appropriate instead of replacing tools without clear benefit.

## User Stories

- As an admin user, I want the admin console to respect my locale and route semantics consistently, so the app feels native rather than partially localized.
- As an Arabic-speaking admin, I want RTL document semantics, navigation, and overlays to work correctly on every route, so the console remains usable in real operational work.
- As a developer, I want locale support to come from one authoritative registry, so adding or changing locales does not require fragile multi-file cleanup.
- As a developer, I want shared overlays like dialogs and drawers to inherit accessible keyboard and focus behavior from trusted primitives, so I do not have to reimplement these patterns repeatedly.
- As a maintainer, I want browser-level tests for locale routing and shared shell behavior, so regressions are caught before they reach production.
- As a product team, I want the admin console to stay on a modern stack that reflects what strong production teams actually use, without unnecessary rewrites of tools that are already the right choice.

## Functional Requirements

1. The system must introduce a single locale registry as the authoritative source of truth for supported locales, fallback locale, text direction, Intl locale mapping, and locale display metadata.
2. The system must derive the `AppLocale` type from the locale registry rather than from repeated hardcoded unions.
3. The system must replace hardcoded locale arrays in validation, settings parsing, UI components, and routing helpers with registry-derived values.
4. The system must adopt `next-intl` request configuration and provider wiring for the admin web App Router.
5. The system must load translation messages dynamically by locale from dedicated message files rather than relying on a single large in-code dictionary object as the primary source of truth.
6. The system must preserve locale-prefixed routing for the admin web app.
7. The system must negotiate the initial locale from the incoming request and apply document-level `lang` and `dir` semantics consistently.
8. The system must make locale switching preserve the current admin route whenever an equivalent localized route exists.
9. The system must ensure dates, times, numbers, and currency formatting flow through locale-aware formatting helpers or `next-intl` formatting utilities rather than ad hoc inline branching.
10. The system must treat the code locale registry as the authoritative list of locales the app is capable of serving.
11. The system must treat platform localization settings as a runtime policy layer that can only enable or disable locales already present in the code locale registry.
12. The system must ensure the configured fallback locale is always a locale supported by the code locale registry and enabled by runtime policy.
13. The system must exclude disabled locales from user-facing locale switcher options.
14. The system must handle requests for disabled locales consistently by redirecting them to the active fallback locale rather than attempting partial rendering.
15. The system must migrate dialog and drawer primitives used by the admin shell to audited accessibility primitives built on Radix/shadcn-style foundations.
16. The system must expose those primitives through a small local wrapper layer so feature code depends on FleetFill-owned component APIs rather than vendor imports directly.
17. The system must preserve the current visual design language when migrating primitives.
18. The system must keep the current production-appropriate choices for forms, schema validation, and data tables unless a concrete issue requires change.
19. The system must retain `react-hook-form` for forms.
20. The system must retain `zod` for schema validation.
21. The system must retain `@tanstack/react-table` for headless admin tables.
22. The system must retain `Vitest` for unit and component testing.
23. The system must add `Playwright` for browser-level testing of the admin web app.
24. The Playwright suite must run against a deterministic local admin-web environment with explicit auth and test-data setup rather than relying on ad hoc manual state.
25. The Playwright suite must cover locale negotiation, direct locale routing, locale switching, document `lang` and `dir`, mobile drawer behavior, and at least one destructive confirmation flow.
26. The Playwright suite must cover at least one queue filtering flow where state is reflected in the URL.
27. The system must wire Playwright into CI for admin-web changes or for the repo's frontend validation path where appropriate.
28. The system must keep the shared queue-page composition approach and continue reducing repeated page scaffolding where that work improves consistency and reusability.
29. The system must update existing i18n audit tooling so it continues to validate the new localization structure or is replaced with an equivalent check.
30. The system must fail clearly when a locale is registered without required messages or configuration.

## Non-Goals (Out of Scope)

- Replacing Next.js, React, Tailwind CSS, Supabase, RHF, Zod, TanStack Table, or Vitest.
- Rebuilding the entire design system or migrating every shared component to shadcn.
- Adopting audited primitives for every UI primitive in a single pass.
- Introducing a runtime CMS or remote translation management platform in this work item.
- Changing the admin web routing model away from locale-prefixed URLs.
- Redesigning unrelated admin workflows, queue logic, or domain behavior outside the hardening scope.

## Design Considerations

- The visual language of the admin console should remain recognizable and consistent with the current FleetFill admin surface.
- The migration to audited primitives should be behavioral and structural, not a cosmetic redesign.
- Arabic and French experiences should be treated as first-class citizens, especially in shell layout, navigation, and overlay interactions.
- Message structure should support long-term growth without forcing developers to manually mirror locale conditionals in component code.

## Technical Considerations

- `next-intl` is the preferred i18n foundation because it is purpose-built for Next.js App Router, supports request-scoped configuration, localized routing, and formatting workflows, and fits the current architecture well.
- The locale registry should be the only place that defines supported locales and locale metadata.
- Runtime localization settings should only narrow the set of code-supported locales; they must never introduce new locales at runtime.
- Locale authority policy must be explicit:
  - the code registry defines what the app can serve
  - runtime settings define which supported locales are enabled
  - when code support and runtime policy disagree, runtime policy wins for routing and locale selection while remaining constrained to code-supported locales
  - disabled locales must be hidden from switchers and other locale pickers
  - any configured fallback must be both supported by code and enabled at runtime
  - requests targeting a disabled locale must redirect to the active fallback locale instead of attempting partial rendering
- Any settings schema or server parsing that references locales should derive its allowed values from the same registry.
- Existing custom i18n helpers may remain temporarily only where needed for migration, but the target architecture should converge on one localization path.
- The current Supabase SSR integration can remain, but auth and request-level locale handling should be compatible with the final App Router and middleware/proxy setup.
- Playwright should be added in a way that supports deterministic CI execution for the admin web app.

## Success Metrics

- Adding a new locale requires one registry change and one message file addition, without scattered hardcoded edits across the app.
- No remaining production UI paths depend on inline locale ternaries for shared labels or locale options where message-driven behavior should be used.
- Shared dialog and drawer behavior passes keyboard and focus expectations consistently.
- Browser-level regressions in locale routing or shell interaction are caught by Playwright before merge.
- The admin web app retains passing lint, typecheck, unit/component tests, and i18n validation after the hardening migration.
- The hardening work reduces duplication in shared admin page composition rather than increasing it.

## Open Questions

- Whether future work should expand audited primitives beyond dialog and drawer into popover, dropdown, and menu components once the initial hardening phase is complete.
- Whether translation management should remain file-based long term or later integrate with a dedicated localization workflow once locale growth justifies it.
