# ADR-001: Single-Role Account Model

## Status

Accepted

## Decision

Each account maps to exactly one role:

- `shipper`
- `carrier`
- `admin`

## Why

- reduces authorization complexity
- keeps onboarding and route guards simpler
- avoids mixed-role UX confusion during early product development
- matches the current product definition

## Consequences

- role switching is not a simple in-app toggle
- future multi-role support would require an explicit new decision and migration plan
