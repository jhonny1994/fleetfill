# Contributing

FleetFill is a proprietary product repository that is publicly visible for evaluation and due diligence.

## Contribution Model

- External bug reports and product feedback are welcome.
- Code changes should be proposed only after prior coordination with the repository owner.
- Do not submit pull requests that introduce unreviewed product, legal, or infrastructure changes without alignment first.

## Before Opening A Pull Request

- make sure the change belongs in the active product surfaces
- update active docs when behavior or contracts change
- keep cleanup, migration, and enforcement aligned in the same change
- do not commit secrets, generated credentials, or local environment files

## Quality Expectations

When relevant, validate the affected surface before asking for review:

- mobile: `flutter analyze` and `flutter test`
- admin-web: `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`
- backend: `supabase db reset --yes`, `supabase db lint --debug`, `supabase test db`
- cross-surface contract checks: `pwsh -NoProfile -File tool/validate_system_contracts.ps1`

## Security Reports

Do not use public issues for security vulnerabilities.

See [SECURITY.md](SECURITY.md) for the reporting process.
