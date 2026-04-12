# ADR-005: Separate Internal Admin Web Console

## Status

Accepted

## Decision

FleetFill will use a separate internal web admin console as the primary admin operations surface.

Chosen stack:

- Next.js with App Router
- TypeScript
- Tailwind CSS
- `next-intl` with locale-prefixed routing
- TanStack Table
- Radix-based internal primitives for accessibility-sensitive overlays
- Vitest for unit and component coverage
- Playwright for browser and interaction coverage
- Supabase SSR/Auth, Postgres, Storage, RPCs, and Edge Functions
- Vercel for admin web hosting

The existing Flutter admin surface remains a temporary fallback for urgent internal operations until the admin web console reaches parity on critical queues.

## Why

- admin work is queue-heavy, audit-heavy, and desktop-oriented
- browser-based internal tools are easier to ship, review, and update than native desktop apps
- FleetFill already has a strong Supabase backend that can be reused directly
- building a second backend for admin would duplicate business rules and increase risk
- localization and RTL support are first-class requirements, so locale routing and message loading need a dedicated web i18n architecture
- accessibility-sensitive primitives such as dialogs and drawers should rely on audited foundations instead of ad hoc modal behavior
- Flutter mobile remains the right customer-facing stack, but not the best long-term ops console stack

## Consequences

- the repository gains a separate `apps/admin-web/` app
- Supabase remains the single business-rule boundary for mobile and admin
- the admin web console must enforce admin-only access in both frontend guards and backend authorization
- locale support is governed by a code-level locale registry, while platform settings only enable or disable supported locales at runtime
- browser-level regression coverage is part of the production quality bar for routing, auth shell behavior, and shared modal flows
- the mobile admin surface should not continue to grow into a full desktop substitute
