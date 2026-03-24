# Planning Docs

This folder contains delivery planning and execution artifacts.

These files help us build the product, but they do not override canonical product truth in the numbered docs at the root of `docs/`.

## Structure

- `docs/planning/admin-web/` - admin web product planning, PRD, master spec, system design, UI/UX spec, and implementation tasks
- `docs/planning/operations/` - operational rollout, production-readiness, stabilization, and deferred polish tracking

## Rules

- keep product/domain/security truth in the canonical root docs
- use planning docs for implementation sequencing, scope packaging, and execution tracking
- when a planning document introduces a domain or architecture change, update the owning canonical doc first

## Admin Web Doc Roles

Use the admin-web planning docs as one connected system, not as isolated notes:

- `prd-admin-web-console.md` answers what must be built and why
- `tasks-admin-web-console.md` answers in what order it should be built and verified
- `admin-web-master-spec.md` is the umbrella implementation source that ties the admin product together
- `admin-web-system-design.md` answers how the web app, Supabase, governance, and deployment fit together
- `admin-web-ui-ux-spec.md` answers how the product should look, behave, and scale responsively
- `admin-web-console-plan.md` turns the locked decisions into practical rollout phases and feature inventory
- `admin-web-production-checklist.md` is the release-readiness tracker that records what is complete, what is only partially proven, and what still blocks a true production launch
- `admin-web-browser-qa-checklist.md` is the operator-grade preview QA checklist for role access, queues, mutations, locales, and responsive fallback
