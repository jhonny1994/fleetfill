## Relevant Files

- `lib/core/auth/auth_repository.dart` - Existing Supabase Auth signup and password reset entry points; reuse these instead of introducing parallel auth APIs.
- `lib/core/config/app_environment.dart` - Existing unified runtime contract; reuse it for any redirect/config additions rather than reintroducing environment enums.
- `lib/core/config/app_bootstrap.dart` - Existing auth bootstrap and session/recovery handling; extend it if auth-link return handling is incomplete.
- `lib/core/routing/` - Existing route guards and auth routing surfaces; reuse the current routing model for confirm/reset landing behavior.
- `supabase/config.toml` - Local Supabase auth, redirect allowlist, and Mailpit configuration; reuse this as the local source of truth.
- `.env.example` - Shared runtime/env documentation; update only if the new auth-email flow requires additional documented values.
- `supabase/functions/scheduled-automation-tick/index.ts` - Existing transactional scheduler entrypoint; verify this path rather than replacing it.
- `supabase/functions/transactional-email-dispatch-worker/index.ts` - Existing transactional dispatch worker; reuse it as-is unless verification reveals a concrete defect.
- `supabase/functions/email-provider-webhook/index.ts` - Existing provider webhook handler; reuse it for transactional reconciliation.
- `supabase/functions/_shared/email-runtime.ts` - Existing transactional rendering/provider adapter runtime; prefer verification and targeted fixes over redesign.
- `supabase/scripts/configure_scheduled_automation.sql` - Existing cron/Vault setup for hosted transactional email dispatch.
- `admin-web/lib/queries/admin-audit-health.ts` - Existing admin-web transactional email health query surface.
- `admin-web/app/[lang]/(admin)/audit-and-health/page.tsx` - Existing admin-web email health UI that needs truthful scope wording, not a new email console.
- `admin-web/components/audit-health/email-retry-actions.tsx` - Existing transactional resend controls that should remain scoped to transactional mail only.
- `lib/features/admin/infrastructure/admin_operations_repository.dart` - Existing Flutter admin transactional email data access.
- `docs/03-technical-architecture.md` - Canonical architecture and email ownership rules.
- `docs/07-implementation-plan.md` - Current implementation status and remaining hosted verification gaps.
- `docs/09-supabase-implementation-notes.md` - Canonical Supabase/Auth/worker/runtime guidance.
- `docs/planning/operations/tasks-environment-contract-unification.md` - Completed prerequisite work; this plan must build on it, not duplicate it.

### Notes

- This task list assumes the environment-contract unification work is already complete and should be reused, not repeated.
- Reuse existing auth calls, routing, worker paths, admin pages, and docs whenever possible.
- Create new UI or config surfaces only where the current flow is incomplete or misleading.
- Auth emails and transactional emails remain separate systems.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [ ] 0.0 Create feature branch
  - [ ] 0.1 Create and checkout a new branch for this feature using the required `codex/` prefix
  - [ ] 0.2 Confirm the branch starts after the environment-contract unification changes and does not reintroduce removed environment abstractions

- [ ] 1.0 Lock the remaining scope around Supabase Auth email flows
  - [ ] 1.1 Reuse the existing environment-contract outcome and remove any leftover task wording that still assumes named runtime environments
  - [ ] 1.2 Confirm in docs that signup confirmation and password reset are owned by Supabase Auth, not the FleetFill transactional worker
  - [ ] 1.3 Confirm in docs that local uses Mailpit while Supabase cloud is the source of truth for real inbox delivery
  - [ ] 1.4 Record the chosen redirect contract, preferring one shared mobile deep link unless a concrete hosted/mobile constraint requires more
  - [ ] 1.5 Record which parts of the fix are code changes versus hosted Supabase settings, provider setup, secrets, or Vault

- [ ] 2.0 Complete the confirm-email user flow by extending existing auth surfaces
  - [ ] 2.1 Reuse `AuthRepository.signUpWithPassword(...)` as the only signup entry point and avoid introducing duplicate auth services
  - [ ] 2.2 Reuse the current routing/bootstrap model to add any missing “check your email” and post-confirmation handling states
  - [ ] 2.3 Add or finish confirmation-link return handling in the current auth bootstrap flow instead of inventing a parallel callback system
  - [ ] 2.4 Add success, invalid-link, and expired-link UI states with recovery guidance using existing auth screen patterns where possible
  - [ ] 2.5 Reuse the current onboarding/auth landing logic so successfully confirmed users end up in the correct next state
  - [ ] 2.6 Add resend-confirmation behavior only if the existing Supabase/Auth SDK path supports it cleanly; otherwise document the fallback UX and keep the current architecture simple

- [ ] 3.0 Complete the password-reset user flow by extending existing recovery surfaces
  - [ ] 3.1 Reuse `AuthRepository.sendPasswordResetEmail(...)` as the only reset-email entry point
  - [ ] 3.2 Reuse existing auth UI patterns to add or finish the “reset email sent” confirmation state
  - [ ] 3.3 Reuse the current recovery/auth bootstrap signals to detect password-recovery link returns
  - [ ] 3.4 Reuse the current reset-password screen/state if it exists, and only create new UI if the existing recovery destination is incomplete
  - [ ] 3.5 Add success, invalid-link, expired-link, and reused-link handling without creating a separate auth subsystem
  - [ ] 3.6 Reuse existing post-auth routing so users land in the correct signed-in or signed-out destination after updating their password

- [ ] 4.0 Verify Supabase Auth email delivery in local and cloud
  - [ ] 4.1 Verify the local flow through `supabase/config.toml` and Mailpit instead of trying to force local to behave like hosted inbox delivery
  - [ ] 4.2 Verify the cloud Supabase Auth setup for redirect allowlists, confirmation behavior, and SMTP-backed delivery
  - [ ] 4.3 Prove that confirm-email reaches a real inbox in cloud
  - [ ] 4.4 Prove that password-reset reaches a real inbox in cloud
  - [ ] 4.5 Prove that both link types return to the intended callback target and complete the app flow correctly
  - [ ] 4.6 Capture the non-repo hosted setup steps needed to keep this working so future contributors can reproduce the result

- [ ] 5.0 Verify the existing transactional email pipeline end to end in Supabase cloud
  - [ ] 5.1 Reuse the current outbox, scheduler, worker, and webhook architecture rather than redesigning the transactional path
  - [ ] 5.2 Verify that cloud has the required runtime inputs for the existing scheduler and worker (`SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY`, provider creds, sender, webhook secret)
  - [ ] 5.3 Verify that the existing scheduled automation job and Vault-backed invocation are present and correct in cloud
  - [ ] 5.4 Trigger or seed at least one existing transactional event and confirm the current outbox path creates and claims work correctly
  - [ ] 5.5 Verify provider acceptance, message-id capture, webhook return, and delivery-log reconciliation through the existing codepath
  - [ ] 5.6 Verify one retryable failure path and one dead-letter path using the existing retry and admin surfaces
  - [ ] 5.7 Verify that the current sender identity/provider posture is production-safe, and upgrade only the configuration if the codepath itself is already sound

- [ ] 6.0 Clarify existing admin email surfaces instead of building new ones
  - [ ] 6.1 Reuse the current admin-web audit-and-health page and update wording only where it incorrectly implies it covers auth emails
  - [ ] 6.2 Reuse the existing Flutter admin email views and make the same scope clarification if needed
  - [ ] 6.3 Keep current resend/dead-letter actions limited to transactional mail and verify the UI copy matches that scope
  - [ ] 6.4 Add lightweight operator guidance for auth-email troubleshooting rather than building a fake auth-email queue

- [ ] 7.0 Add regression checks and runbooks around the reused architecture
  - [ ] 7.1 Add or update verification steps for local confirm-email and password-reset through Mailpit
  - [ ] 7.2 Add or update verification steps for cloud confirm-email and password-reset through real inbox delivery
  - [ ] 7.3 Add or update verification steps for the existing transactional scheduler -> worker -> provider -> webhook pipeline
  - [ ] 7.4 Add operator guidance that clearly separates “no auth email received” from “transactional email queued but unsent”
  - [ ] 7.5 Add release-readiness checks that block rollout unless both auth email and transactional email have been verified in cloud
  - [ ] 7.6 Update the planning/architecture docs so future work continues reusing the existing auth and transactional systems rather than forking them
