# ADR-005: Separate Internal Admin Web Console

## Status

Accepted

## Decision

FleetFill will use a separate internal web admin console as the primary admin operations surface.

Chosen stack:

- Next.js with App Router
- TypeScript
- Tailwind CSS
- shadcn/ui
- TanStack Query
- TanStack Table
- Recharts
- Supabase Auth, Postgres, Storage, RPCs, and Edge Functions
- Vercel for admin web hosting

The existing Flutter admin surface remains a temporary fallback for urgent internal operations until the admin web console reaches parity on critical queues.

## Why

- admin work is queue-heavy, audit-heavy, and desktop-oriented
- browser-based internal tools are easier to ship, review, and update than native desktop apps
- FleetFill already has a strong Supabase backend that can be reused directly
- building a second backend for admin would duplicate business rules and increase risk
- Flutter mobile remains the right customer-facing stack, but not the best long-term ops console stack

## Consequences

- the repository gains a separate `admin-web/` app
- Supabase remains the single business-rule boundary for mobile and admin
- the admin web console must enforce admin-only access in both frontend guards and backend authorization
- the mobile admin surface should not continue to grow into a full desktop substitute
