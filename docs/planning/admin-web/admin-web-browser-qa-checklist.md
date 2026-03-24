# Admin Web Browser QA Checklist

Use this checklist against a real preview deployment before calling the FleetFill admin web console production-ready.

This is not a “click around for confidence” list. It is the minimum operator-grade QA pass for:

- role access
- queue correctness
- detail workspace quality
- critical mutations
- locale sanity
- responsive fallback

Record result per row:

- `pass`
- `fail`
- `blocked`
- `n/a`

## Preconditions

- preview deployment URL is available
- seeded or staging-like data exists for:
  - pending payment proof
  - pending verification packet
  - open dispute
  - payout-eligible booking
  - support request with unread user follow-up
  - at least one active `super_admin`
  - at least one active `ops_admin`
- required env vars are present in preview
- release owner knows the test accounts being used

## 1. Signed-Out Flow

- open `/ar`
  - expect redirect to localized sign-in
- open `/fr`
  - expect redirect to localized sign-in
- open `/en`
  - expect redirect to localized sign-in
- open a protected route directly while signed out:
  - `/ar/dashboard`
  - `/ar/admins`
  - `/ar/payments`
  - expect redirect to sign-in, not crash and not partial protected content

## 2. `ops_admin` Sign-In And Boundaries

- sign in as active `ops_admin`
- verify dashboard loads
- verify payments loads
- verify verification loads
- verify disputes loads
- verify payouts loads
- verify support loads
- verify users loads
- verify settings access behavior matches intended scope
- open `/ar/admins`
  - expect redirect or denied access behavior
- attempt a `super_admin`-only action
  - expect it to be blocked cleanly

## 3. `super_admin` Sign-In And Governance

- sign in as active `super_admin`
- verify dashboard loads
- verify `/ar/admins` loads
- open an admin detail page
- create an admin invitation
- verify the invitation appears immediately
- revoke a pending invitation
- verify state updates correctly
- activate/deactivate an admin account if safe test data exists
- verify last-active-`super_admin` safeguard cannot be bypassed

## 4. Dashboard

- dashboard loads without console/server error
- metric strip counts render
- preview cards render
- alert cards render when seeded data exists
- empty alert state renders cleanly when no alerts exist
- links from dashboard cards open the expected queue

## 5. Payments Queue And Detail

- payments queue loads
- filters render and submit correctly
- search works
- empty state works if no results
- open a payment detail page
- payment proof preview renders
- approve flow works end to end
- reject flow works end to end
- post-action state reflects backend result

## 6. Verification Queue And Detail

- verification queue loads
- filters/search work
- open a verification packet
- all required documents render with previews
- approve packet flow works
- reject document flow works
- rejection reason is preserved
- post-action status reflects backend result

## 7. Disputes Queue And Detail

- disputes queue loads
- queue filters/search work
- dispute detail loads booking/payment/evidence context
- resolution action works
- resulting status and audit state update correctly

## 8. Payouts Queue And Detail

- payouts queue loads
- eligible items appear as expected
- open payout detail
- payout account context is visible
- release payout action works
- released state appears in UI after action

## 9. Support Queue And Thread

- support queue loads
- unread/new state appears correctly
- queue filters/search work
- open support request thread
- reply action works
- status change works
- linked context/navigation works
- unread/read behavior updates correctly after reply and refresh

## 10. Users

- users list loads
- role/activity/verification filters work
- search works with text and ID
- user detail loads linked bookings/vehicles/support/documents
- suspend/reactivate flow works if enabled for test data
- post-action state updates correctly

## 11. Search

- search page loads
- empty query state is useful
- search by booking reference works
- search by user email works
- search by UUID works
- search by free text does not error
- result groups are labeled correctly in the current locale
- clicking a result opens the correct canonical workspace

## 12. Settings

- settings page loads
- current values render
- update action works for allowed fields
- values persist after refresh
- unauthorized role cannot perform forbidden settings changes

## 13. Audit And Health

- audit log page loads
- recent audit items render
- email delivery health renders
- dead-letter sections render
- retry or remediation actions work where enabled

## 14. Localization

Run at least a sanity pass in:

- Arabic
- French
- English

Check:

- page headings
- buttons
- empty states
- search labels
- queue labels
- action labels
- no obvious English leakage on Arabic/French pages
- Arabic layout stays RTL and visually coherent

## 15. Responsive Fallback

Check at minimum:

- desktop wide
- laptop width
- narrow tablet / emergency mobile width

Confirm:

- navigation remains usable
- tables remain horizontally scrollable instead of broken
- primary actions remain reachable
- detail pages remain readable

## 16. Error And Recovery

- open a non-existent detail page
  - expect clean not-found state
- test with missing result set
  - expect clean empty state
- sign out mid-session and revisit a protected page
  - expect redirect to sign-in
- if safe, test an action against stale data
  - expect controlled error handling

## 17. Exit Criteria

Do not mark browser QA complete until:

- all critical queues have been opened
- at least one critical action per queue has been tested where possible
- both `ops_admin` and `super_admin` have been exercised
- Arabic, French, and English have had a sanity pass
- no blocking visual, auth, or mutation bugs remain

## QA Record

Suggested record fields:

- date
- environment
- commit SHA
- tester
- accounts used
- pass/fail summary
- blockers
- screenshots or issue links
