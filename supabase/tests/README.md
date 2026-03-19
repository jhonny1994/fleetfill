# Supabase Database Tests

This directory is reserved for database-level regression checks.

Target coverage for FleetFill:

- RLS ownership checks
- carrier verification gates for capacity publication
- verified-vehicle requirement for route and one-off trip publication
- append-only route revision history
- verification review helper privilege boundaries
- booked-capacity delete guards

When database test execution is added, keep tests:

- deterministic
- local-reset friendly
- focused on schema/function/security contracts
- independent from Flutter UI tests
