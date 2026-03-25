## Relevant Files

- `lib/core/auth/auth_repository.dart` - Current signup and password reset calls to Supabase Auth, including the hardcoded redirect target.
- `lib/core/config/app_environment.dart` - Existing environment model where auth redirect configuration should live if it becomes configurable.
- `supabase/config.toml` - Local Supabase auth, Mailpit, and redirect allowlist configuration.
- `supabase/functions/scheduled-automation-tick/index.ts` - Scheduled orchestration entrypoint for transactional email dispatch.
- `supabase/functions/transactional-email-dispatch-worker/index.ts` - Transactional email worker that drains the outbox queue.
- `supabase/functions/email-provider-webhook/index.ts` - Provider webhook handler for delivery-status reconciliation.
- `supabase/functions/_shared/email-runtime.ts` - Shared provider dispatch and template rendering runtime.
- `supabase/scripts/configure_scheduled_automation.sql` - Hosted cron/Vault setup for the scheduled automation tick.
- `admin-web/lib/queries/admin-audit-health.ts` - Admin-web email health query layer, currently transactional-email only.
- `admin-web/app/[lang]/(admin)/audit-and-health/page.tsx` - Admin-web email/audit health page that needs truthful scope/copy.
- `admin-web/components/audit-health/email-retry-actions.tsx` - Admin-web resend actions for transactional email only.
- `lib/features/admin/infrastructure/admin_operations_repository.dart` - Flutter admin transactional email log and dead-letter data access.
- `docs/03-technical-architecture.md` - Canonical architecture and email ownership rules.
- `docs/09-supabase-implementation-notes.md` - Canonical Supabase runtime, worker, and scheduling guidance.
- `docs/07-implementation-plan.md` - Current implementation status and unfinished hosted email verification work.

### Notes

- This file intentionally contains only high-level parent tasks for now.
- The next step is to expand these into sub-tasks after explicit confirmation.
- Auth emails and transactional emails are separate systems and should remain separate in implementation and operator UX.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [ ] 0.0 Create feature branch
  - [ ] 0.1 Create and checkout a new branch for this feature using the required `codex/` prefix
- [ ] 1.0 Finalize the auth-email ownership and environment model
  - [ ] 1.1 Update the planning/docs language so signup confirmation and password reset are explicitly owned by Supabase Auth
  - [ ] 1.2 Document that FleetFill transactional email remains limited to the outbox/worker/webhook path
  - [ ] 1.3 Define the runtime truth for `local` versus Supabase cloud, including Mailpit locally and real inbox delivery in cloud
  - [ ] 1.4 Decide whether one shared mobile deep link is sufficient and document that as the default unless cloud flavor constraints force a split
  - [ ] 1.5 Document which values are code-configured versus which values must be set in hosted Supabase settings, secrets, Vault, or the provider dashboard
- [ ] 2.0 Complete the confirm-email user flow in Flutter and Supabase Auth
  - [ ] 2.1 Move the auth redirect source out of the hardcoded constant into the app environment/auth configuration layer if needed by the chosen model
  - [ ] 2.2 Ensure signup uses the finalized redirect value consistently
  - [ ] 2.3 Add a clear post-signup “check your email” state with user guidance instead of relying on implicit behavior
  - [ ] 2.4 Handle the confirmation deep-link return explicitly in auth bootstrap/routing
  - [ ] 2.5 Add confirmation success, invalid-link, and expired-link states with recovery guidance
  - [ ] 2.6 Add resend-confirmation behavior if supported cleanly in the current Supabase/Auth SDK path, or document the chosen fallback UX
  - [ ] 2.7 Verify the final landing path after successful confirmation so users do not get stranded between unauthenticated and onboarding states
- [ ] 3.0 Complete the password-reset user flow in Flutter and Supabase Auth
  - [ ] 3.1 Ensure the reset request uses the finalized redirect value consistently
  - [ ] 3.2 Add a clear “reset email sent” success state with next-step guidance
  - [ ] 3.3 Handle password-recovery deep-link return explicitly in auth bootstrap/routing
  - [ ] 3.4 Route recovery users into the correct reset-password screen/state without relying on implicit session behavior alone
  - [ ] 3.5 Add success, invalid-link, expired-link, and reused-link handling for the recovery flow
  - [ ] 3.6 Verify the final landing path after password update so users return to the intended signed-in or signed-out destination
- [ ] 4.0 Verify hosted Supabase Auth email delivery and redirect behavior
  - [ ] 4.1 Audit local `supabase/config.toml` and cloud project settings for auth redirect and confirmation behavior consistency
  - [ ] 4.2 Configure or verify hosted SMTP/auth email delivery for cloud Supabase Auth
  - [ ] 4.3 Verify that signup confirmation reaches a real inbox in cloud
  - [ ] 4.4 Verify that password reset reaches a real inbox in cloud
  - [ ] 4.5 Verify that confirmation and recovery links land on the correct deep-link or web fallback target
  - [ ] 4.6 Verify failure cases in cloud, including invalid, expired, and reused links
  - [ ] 4.7 Document the exact hosted settings and non-repo steps required to reproduce and maintain auth email delivery
- [ ] 5.0 Verify the transactional email pipeline end to end in Supabase cloud
  - [ ] 5.1 Verify that required runtime inputs are present in cloud for the scheduler and worker, including `SUPABASE_URL`, `SUPABASE_SECRET_KEY`, `INTERNAL_AUTOMATION_TOKEN`, provider credentials, sender identity, and webhook secret
  - [ ] 5.2 Verify that the scheduled automation job exists in cloud and uses the correct Vault secrets
  - [ ] 5.3 Trigger or seed at least one known transactional email event in cloud
  - [ ] 5.4 Verify outbox row creation and worker claim behavior
  - [ ] 5.5 Verify provider acceptance and message identifier capture
  - [ ] 5.6 Verify webhook delivery and status reconciliation into `email_delivery_logs`
  - [ ] 5.7 Verify one retryable failure path and one dead-letter/operator-visible path
  - [ ] 5.8 Verify that the chosen sender identity and provider configuration are production-safe and not based on a personal mailbox
- [ ] 6.0 Clarify admin email surfaces so they accurately represent transactional email only
  - [ ] 6.1 Audit admin-web email health, dead-letter, and retry surfaces for wording that implies they cover all email
  - [ ] 6.2 Audit the Flutter admin email log and dead-letter views for the same issue
  - [ ] 6.3 Update admin copy/labels/help text so operators understand these pages cover transactional email only
  - [ ] 6.4 Add operator guidance that confirm-email and password-reset delivery are Supabase Auth concerns, not transactional queue items
  - [ ] 6.5 Verify that existing resend controls remain scoped only to transactional delivery logs and dead-letter jobs
- [ ] 7.0 Add regression coverage, operator runbooks, and release-readiness checks for both email systems
  - [ ] 7.1 Add automated or documented verification steps for local confirm-email and password-reset flows through Mailpit
  - [ ] 7.2 Add automated or documented verification steps for cloud confirm-email and password-reset flows through real inbox delivery
  - [ ] 7.3 Add verification steps for the transactional scheduler -> worker -> provider -> webhook pipeline
  - [ ] 7.4 Add an operator runbook for “no auth email received” versus “transactional email queued but unsent”
  - [ ] 7.5 Add release-readiness checklist items that block rollout unless auth email and transactional email have both been verified in cloud
  - [ ] 7.6 Update relevant planning or architecture docs so future contributors do not collapse auth email and transactional email into one system
