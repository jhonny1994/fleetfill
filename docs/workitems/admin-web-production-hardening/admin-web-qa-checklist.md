# Admin Web QA Checklist

Use this as a pass/fail checklist for `apps/admin-web`.

## Current Status - 2026-04-10

Resolved in the implementation pass:

- [x] Global error UI keeps user-facing copy localized and safe.
  Evidence: `app/global-error.tsx` now logs the raw error and renders localized fallback copy.
- [x] Admin route error UI keeps user-facing copy localized and safe.
  Evidence: `app/[lang]/(admin)/error.tsx` now logs the raw error and renders localized fallback copy.
- [x] First-visit locale routing honors runtime-enabled locales, not just code-supported locales.
  Evidence: `app/page.tsx` and `proxy.ts` now resolve locale with the shared runtime localization policy.
- [x] Disabled-locale redirects preserve the current target route.
  Evidence: `app/[lang]/layout.tsx` and `proxy.ts` now rebuild the localized path instead of redirecting to the bare locale root.
- [x] Locale switching preserves query string and hash state.
  Evidence: `components/admin-shell/admin-locale-switcher.tsx` now rebuilds the full localized URL with search and hash.
- [x] Arabic desktop shell is structurally mirrored.
  Evidence: `app/[lang]/(admin)/layout.tsx` now mirrors sidebar/content order for RTL.
- [x] Sign-in page mirrors correctly between RTL and LTR.
  Evidence: `app/[lang]/(auth)/sign-in/page.tsx` now uses explicit panel ordering instead of direction-sensitive flex defaults.
- [x] Major async routes use page-shaped loading states.
  Evidence: `app/[lang]/(admin)/loading.tsx` and `app/[lang]/(auth)/sign-in/loading.tsx` now provide segment-shaped loading UI for the main admin and auth surfaces.
- [x] Queue empty states preserve table-shell geometry.
  Evidence: `components/queues/admin-data-table.tsx` now keeps empty states inside `table-shell`.
- [x] Queue search returns complete results for older records, not just the newest capped window.
  Evidence: `lib/queries/admin-queues.ts` now removes the capped fetch limit when a search query is present for payments, verification, and disputes.
- [x] Queue reset and clear-all actions preserve the current scope unless intentionally changed.
  Evidence: `components/queues/admin-filter-bar.tsx` now keeps hidden scope fields in reset and clear-all links.
- [x] Support search safely escapes user text before building backend filters.
  Evidence: `lib/queries/admin-queues.ts` now uses `.ilike(...)` for free-text support queries and reserves `.or(...)` for UUID-safe exact matching.

Confirmed passes from the first production QA pass:

- [x] Auth credential inputs force LTR behavior inside RTL.
  Evidence: `components/auth/admin-sign-in-form.tsx` sets `dir=\"ltr\"` on email and password inputs.
- [x] Mobile drawer mirrors correctly for RTL and includes modal behavior.
  Evidence: focused audit found the mobile shell mirroring path in `components/admin-shell/mobile-admin-sidebar.tsx` acceptable.
- [x] Localized not-found state is present and internally consistent.
  Evidence: `app/[lang]/not-found.tsx` uses localized copy and the shared panel style.

Browser verification completed:

- [x] Playwright end-to-end verification completed on this machine.
  Evidence: `pnpm test:e2e` passed after the local Supabase Docker stack was available.

## 1. Routing and Shell

- [ ] `/` redirects to the correct localized entry route.
- [ ] `/[lang]` uses the correct `html[lang]`.
- [ ] `/[lang]` uses the correct `html[dir]`.
- [ ] Unsupported locale routes fail safely.
- [ ] Disabled locale routes redirect to the runtime fallback locale.
- [ ] Desktop sidebar nav items are correct and in the right order.
- [ ] Desktop active nav state is visually clear.
- [ ] Mobile drawer opens from the correct side for LTR.
- [ ] Mobile drawer opens from the correct mirrored side for RTL.
- [ ] Mobile drawer traps focus.
- [ ] Mobile drawer closes on `Escape`.
- [ ] Mobile drawer restores focus to the trigger.
- [ ] Header controls do not overflow at normal laptop width.
- [ ] Locale switcher preserves the current route.
- [ ] Sign-out returns the user to the correct localized sign-in page.

## 2. Auth

- [ ] Sign-in page layout is visually consistent in `en`.
- [ ] Sign-in page layout is visually consistent in `fr`.
- [ ] Sign-in page layout is visually consistent in `ar`.
- [ ] Arabic auth page is mirrored, not redesigned.
- [ ] Email field behaves as LTR inside RTL.
- [ ] Password field behaves as LTR inside RTL.
- [ ] Sign-in validation messages are localized.
- [ ] Invalid credentials show a safe localized message.
- [ ] Non-admin accounts are rejected.
- [ ] Inactive admins are rejected.
- [ ] Valid admins are redirected into the shell correctly.
- [ ] Sign-out fully clears the session.

## 3. Dashboard

- [ ] Metric strip loads correctly.
- [ ] Exception alerts load correctly.
- [ ] Queue preview cards load correctly.
- [ ] Dashboard empty states are visually stable.
- [ ] Dashboard counts match backend reality.
- [ ] Dashboard remains readable in `ar`, `fr`, and `en`.

## 4. Queue Pages

Run for:
- [ ] Payments
- [ ] Verification
- [ ] Disputes
- [ ] Payouts
- [ ] Support

For each queue:
- [ ] Shared page hero is consistent.
- [ ] Filter bar is aligned and usable.
- [ ] Scope tabs are aligned and usable where applicable.
- [ ] Refresh action is visible and works.
- [ ] Active filters row is correct.
- [ ] Empty state is meaningful.
- [ ] No-results state is meaningful.
- [ ] Filter state is reflected in the URL.
- [ ] Refresh/share/reload preserves the same filtered state.
- [ ] Queue counts match filtered backend results.
- [ ] Queue layout remains stable in RTL and LTR.
- [ ] Table/list remains usable on narrow widths.

## 5. Detail Pages

Run for:
- [ ] Booking
- [ ] Shipment
- [ ] User
- [ ] Admin
- [ ] Payment
- [ ] Verification
- [ ] Dispute
- [ ] Payout
- [ ] Support thread

For each detail page:
- [ ] Header, facts block, main region, and action rail follow the shared pattern.
- [ ] Timeline panel renders correctly.
- [ ] File preview panel behaves correctly where applicable.
- [ ] Missing entity state is handled cleanly.
- [ ] Partial data does not break the layout.
- [ ] Labels and metadata are localized.
- [ ] Mixed Arabic/Latin content remains readable.
- [ ] Page remains visually stable while data loads.

## 6. Action Flows

Run for:
- [ ] Payment approve
- [ ] Payment reject
- [ ] Verification approve
- [ ] Verification reject
- [ ] Dispute resolve complete
- [ ] Dispute resolve refund
- [ ] Payout release
- [ ] Support reply
- [ ] Support status change
- [ ] User suspend/reactivate
- [ ] Admin role change
- [ ] Admin deactivate/reactivate
- [ ] Admin invitation create
- [ ] Admin invitation revoke
- [ ] Email retry
- [ ] Dead-letter retry

For each action:
- [ ] Trigger is visible and correctly labeled.
- [ ] Confirm dialog opens when required.
- [ ] Confirm dialog traps focus.
- [ ] Confirm dialog closes on `Escape`.
- [ ] Cancel does not mutate backend state.
- [ ] Confirm performs the correct mutation.
- [ ] Pending state is visible and not misleading.
- [ ] UI refresh reflects the final backend result.
- [ ] Audit trail reflects the action where expected.
- [ ] Error state is localized and recoverable.

## 7. Search

- [ ] Empty query state is clear.
- [ ] Search input is usable in LTR and RTL.
- [ ] Results are grouped correctly.
- [ ] No-results state is clear.
- [ ] Each result links to the correct entity detail route.
- [ ] Locale is preserved when navigating from search.

## 8. Settings

- [ ] Settings sections are visually consistent.
- [ ] Disabled controls look intentionally disabled.
- [ ] Localization settings show the correct enabled locales.
- [ ] Fallback locale is valid and enabled.
- [ ] Saving settings shows a stable pending state.
- [ ] Save success refreshes correctly.
- [ ] Save failures are localized and recoverable.
- [ ] Runtime locale policy matches persisted backend state.

## 9. Audit and Health

- [ ] Audit overview renders correctly.
- [ ] Audit trail renders correctly.
- [ ] Email deliveries page renders correctly.
- [ ] Dead letters page renders correctly.
- [ ] Retry actions work and reconcile in UI.
- [ ] Audit data matches backend records.
- [ ] Empty/error states preserve layout and navigation context.

## 10. Globalization

Run across `ar`, `fr`, and `en`:
- [ ] All user-facing copy is translated.
- [ ] No raw backend/runtime message leaks into UI.
- [ ] Enum labels are translated.
- [ ] Status labels are translated.
- [ ] Modal labels are translated.
- [ ] Empty/loading/error states are translated.
- [ ] Locale switcher shows only runtime-enabled locales.
- [ ] Locale switch preserves route and page context.

## 11. RTL / LTR

- [ ] Arabic shell mirrors correctly.
- [ ] Arabic auth layout mirrors correctly.
- [ ] Arabic queue headers/filters/tabs mirror correctly.
- [ ] Arabic detail pages mirror correctly.
- [ ] `fr` and `en` remain stable LTR.
- [ ] Icons/chevrons do not become ambiguous in RTL.
- [ ] Badges/pills/metadata rows remain readable in RTL.
- [ ] Tables remain readable in RTL.
- [ ] Emails, IDs, codes, and references remain readable in RTL.
- [ ] Copy length in Arabic and French does not break layout.

## 12. Loading / Skeleton / Empty / Error

- [ ] Major async routes have acceptable loading states.
- [ ] Loading states preserve page geometry well enough to avoid obvious layout jump.
- [ ] Queue loading states do not collapse the layout.
- [ ] Detail loading states do not collapse the layout.
- [ ] Dashboard loading states do not collapse the layout.
- [ ] Empty states preserve the same visual system.
- [ ] Not-found state matches the product style.
- [ ] Route error state matches the product style.
- [ ] Global error state matches the product style.
- [ ] No major CLS-like jumps are visible between loading and loaded states.

## 13. Backend / Integration

- [ ] Auth/session behavior is consistent for first visit, deep link, refresh, and expired session.
- [ ] Queue counts match backend filters.
- [ ] URL params are canonical and stable.
- [ ] Unsupported filter values fail safely.
- [ ] Search results map to the correct entity type.
- [ ] Signed file preview handles missing/expired URLs safely.
- [ ] Mutations do not leave stale UI after refresh.
- [ ] Audit rows are created for sensitive actions.
- [ ] Locale settings cannot persist invalid combinations.
- [ ] Client and server stay on the same locale boundary.

## 14. Automated Gate

- [ ] `pnpm lint`
- [ ] `pnpm typecheck`
- [ ] `pnpm test`
- [ ] `pnpm build`
- [ ] `pnpm i18n:audit-keys`
- [ ] `pnpm i18n:scan-hardcoded`
- [ ] `pnpm dlx knip`
- [ ] `pnpm dlx pruny --all`
- [ ] Playwright locale-routing coverage passes
- [ ] Playwright locale-switching coverage passes
- [ ] Playwright drawer/dialog coverage passes
- [ ] Playwright queue URL-state coverage passes

## 15. Final Signoff

- [ ] Full pass completed in `ar`
- [ ] Full pass completed in `fr`
- [ ] Full pass completed in `en`
- [ ] Full pass completed at desktop width
- [ ] Full pass completed at mobile/narrow width
- [ ] At least one happy path per major domain verified
- [ ] At least one destructive path per major domain verified
- [ ] Product feels consistent as one admin system, not page-by-page implementations
