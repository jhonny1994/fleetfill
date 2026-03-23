# FleetFill UX And Localization

## 1. UX Goal

FleetFill must reduce uncertainty for users who are sending valuable goods across long routes with limited trust and limited tolerance for ambiguity.

The interface should emphasize:

- what the user is booking
- who is responsible
- what the total price is
- what has happened already
- what happens next

## 2. Product Truths The UX Must Respect

- payments are external and proof-based, not instant card checkout
- tracking is milestone-driven, not live GPS at launch
- one shipment travels on one truck/trip only
- exact-route search is the default behavior
- if no exact route exists, the app asks the user to redefine search
- support begins with email, not live chat

Any future-state concepts must be clearly labeled and must not conflict with the operational truth of the product.

## 3. Mobile Design Direction

### 3.1 Audience Reality

Design for:

- older Android phones
- bright outdoor usage
- quick task completion
- mixed Arabic/French business language
- users who may trust phone calls and paper proof more than digital systems

### 3.2 Tone

Use operational language, not startup language.

Good examples:

- `Payment proof received`
- `Waiting for FleetFill verification`
- `Picked up by carrier`
- `Delivered, review period active`

Avoid vague labels such as:

- `Your order is awesome`
- `We are processing magic`

### 3.2.1 Entry Flow

- first launch should open a lightweight welcome/onboarding entry before auth
- sign in and sign up are separate identity screens, not the first product explanation screen
- once the user continues past welcome, persist that choice and avoid repeating the intro on every signed-out launch
- authenticated onboarding should then continue with role selection, profile setup, and phone completion in that order when required
- language selection is an app-wide preference, not a separate language mode per role

### 3.3 Material 3 And Theme Contract

FleetFill should use Material 3 as the default Flutter design system baseline.

Rules:

- use a `ColorScheme`-driven theme for light and dark modes
- keep semantic status colors distinct from brand colors
- define reusable tokens for color, spacing, typography, radius, elevation, borders, icon sizing, and motion
- expose app-specific tokens through shared theme utilities or `ThemeExtension` where needed
- restore user theme preference before the first routed screen when possible to avoid visible theme flashing

## 4. Search UX

### 4.1 Search Inputs

- shipment draft
- origin wilaya and commune
- destination wilaya and commune
- pickup date from the selected shipment
- shipment weight
- optional shipment volume from the selected shipment

### 4.2 Default Results Strategy

Default tab: `Recommended`

Only exact route results appear in the main success state.

### 4.3 Result Card Must Show

- carrier name
- rating and review count
- route
- departure date and time
- remaining capacity
- total price
- insurance availability
- primary action to book

### 4.4 No Result States

If same-day exact result is missing:

- show nearest exact-lane dates

If exact route does not exist:

- show a clear empty state
- explain that no exact route is currently available
- offer actions to change date or route inputs

Do not silently mix approximate routes into the exact result list.

Long result lists must use lazy rendering, clear loading states, empty states, and error recovery states.

### 4.5 Loading UX

- use skeleton loading for result cards, shipment summaries, carrier summaries, and other structured content where layout is already known
- prefer skeleton or shimmer placeholders over generic spinners when loading replaces a content list, summary card, or detail page body
- use simple progress indicators only for short blocking actions such as submit, approve, delete, or upload
- keep skeleton layouts close to final content shape so users can predict what is loading
- avoid flashing between skeleton, empty, and loaded states; use stable transitions where possible

Recommended skeleton targets in FleetFill:

- search result cards
- shipment summary cards
- route and one-off trip detail summaries
- carrier public profile summary and review list
- admin verification packet detail and queue cards
- payout account list and route/trip list summaries

## 5. Shipment Creation UX

### 5.1 Shipment Form

The shipment form should capture:

- origin wilaya
- origin commune
- destination wilaya
- destination commune
- pickup date
- weight
- optional volume
- shipment details

The shipment form should not ask for category, item rows, or separate notes fields.

## 6. Adaptive Layout Rules

- do not lock device orientation
- adapt layouts based on available width and safe-area constraints, not device-name or tablet detection
- use compact mobile layouts by default
- expand to wider tablet/admin layouts only when width meaningfully supports it
- preserve readability by constraining max content width on large screens where appropriate
- role shells may switch from bottom navigation to wider navigation patterns on larger layouts if implemented later
- respect keyboard `viewInsets` so forms, sheets, and dialogs stay usable during text entry
- adapt modal presentation by available width: bottom sheets on compact layouts, dialog or side-sheet style presentation on wider layouts when useful
- foldable and multi-window specializations may be deferred, but layouts must still fail gracefully using width and safe-area rules

## 6.1 Cross-Phase UX Polish Rules

These improvements should be treated as cross-cutting finish work applied after most major phases are operationally complete.

Already appropriate to apply during completed phases:

- request debouncing for search/filter inputs
- stale-result protection and request cancellation where searches can overlap
- lazy rendering for long lists and result sets
- inline recovery states instead of disruptive success/error route hops
- destructive-action confirmation for delete/deactivate/cancel flows
- consistent offline, retry, and not-found states
- page storage keys for long-lived scrollable lists that keep the same layout and benefit from preserved position

Better deferred to the end-of-major-phase polish pass:

- skeleton loading for known-content layouts
- progressive reveal and light transition polish using reduced-motion-safe patterns
- image optimization through constrained dimensions, compression, and thumbnails where media-heavy screens exist
- final accessibility pass for semantics, focus order, large text, and keyboard traversal
- final bidi and localization pass for identifiers, mixed Arabic/French content, and user-facing status copy

Project-scale terms to use in planning and review:

- loading strategy
- skeleton loading / shimmer loading
- progressive disclosure
- debounce / throttling / request cancellation
- stale-result protection
- lazy rendering / virtualization
- payload minimization
- image optimization
- accessibility release pass
- localization polish pass

## 7. Payment UX

### 6.1 Payment Summary

The payment screen must show:

- base price
- platform fee
- carrier fee if customer-visible
- optional insurance fee
- tax fee if any
- final total
- payment reference
- supported payment rail instructions

### 6.2 Payment Proof Flow

The shipper flow should be:

1. view amount and payment reference
2. pay externally through CCP, Dahabia, or bank transfer
3. upload proof
4. see `Payment proof received`
5. see `Under verification`

Do not present this flow as instant payment success.

### 6.3 Proof Upload Requirements

- image or PDF
- clear replacement flow after rejection
- latest status visible
- rejection reason visible when applicable
- any amount mismatch is treated as rejected and must be explained clearly to the shipper

## 8. Tracking UX

Tracking is milestone-based.

The primary timeline should show:

- payment under review
- confirmed
- picked up
- in transit
- delivered pending review
- completed

Optional notes and proof attachments can enrich milestones later.

Delivery UX should use a grace-period confirmation model:

- carrier marks delivered
- shipper can confirm delivery
- shipper can raise a dispute during the review window
- if the shipper takes no action in time, the booking auto-completes

Do not design live moving truck maps as if they already exist.

Status changes that happen asynchronously should be announced accessibly when the user is actively viewing the screen.

## 9. Carrier Reputation UX

Carrier public profile should show:

- company or carrier name
- rating average
- rating count
- written comments
- verification badges where appropriate

Trust cues should matter more than decorative UI.

## 9.1 Carrier Verification UX

- vehicles and verification live under the carrier profile branch, not as extra carrier shell tabs
- profile and vehicle verification documents should be managed from sections/cards with upload and replace actions instead of route-per-document flows
- latest verification status and rejection reason must stay visible near the affected profile or vehicle record so carriers can correct issues quickly

## 10. Support UX

Support entry point should be simple:

- support email visible in profile and booking flows
- prefilled subject/body options where useful
- escalation copy that explains what information to send

Support chat is not required in the canonical launch UX.

Email communications sent by FleetFill must align with the same trust-first tone used in the app.

Rules:

- operational before promotional
- clear subject lines
- clear next action when user action is required
- no vague marketing-style copy for payment, dispute, or delivery events

## 11. Generated Documents UX

Users should be able to access system-generated PDFs where relevant.

Initial scope:

- booking invoice
- payment receipt where applicable
- payout receipt for carrier settlement where applicable

## 12. Email UX And Localization

FleetFill emails are transactional product communications, not marketing campaigns.

Requirements:

- templates should exist for Arabic, French, and English
- locale selection should follow the user's effective app/account locale where available
- fallback locale should always be English when the requested locale is unsupported
- transactional emails should mirror in-app wording for statuses and actions
- invoices should appear in the email body as structured HTML when needed, not as file attachments by default

Placeholder note:

- final sender names, sender addresses, and brand-specific email copy can remain placeholder configuration until business email ownership is finalized

Recommended email template groups:

- booking lifecycle
- payment lifecycle
- dispute lifecycle
- payout lifecycle
- support acknowledgement
- document availability notifications

## 13. Localization

Supported languages:

- Arabic
- French
- English

Rules:

- Arabic is first-class and fully RTL
- all operational copy must be localized
- route names must support Arabic and Latin display
- mixed-script strings must be laid out carefully
- flutter-intl generated ARB files should own UI copy, labels, errors, action text, and empty-state content
- location names come from data tables, not ARB files
- locale fallback should be deterministic and documented in app code
- plurals, counts, and formatted dates/currency must use locale-aware formatting

### 12.1 Operational Identifier Display

For phone numbers, payment references, tracking numbers, and vehicle plates, keep Latin digits for consistency and error reduction even in Arabic UI.

Mixed-script values should use bidi-safe rendering patterns so Arabic labels and Latin operational identifiers do not visually corrupt each other.

## 14. Accessibility

Accessibility is a baseline requirement.

Minimum standard:

- 48dp minimum touch targets
- high contrast in sunlight conditions
- resilient large-text layouts
- semantic labels for status, amounts, and actions
- screen-reader-friendly timelines and proof status messages
- RTL-safe interaction patterns

Additional requirements:

- logical focus order for forms, dialogs, and review flows
- merged semantics for dense cards so screen readers announce one coherent summary instead of noisy fragments
- explicit semantics for custom buttons, status chips, and money summaries
- accessible modal and bottom-sheet titles, dismiss actions, and confirmation language
- TalkBack and VoiceOver checks on critical flows before release candidates
- honor reduced-motion preferences where the platform exposes them and avoid unnecessary motion in operational flows
- define keyboard traversal and focus behavior for larger-device dialogs, forms, and admin workflows

## 15. Theme And Visual System

Theme persistence is supported.

Use design tokens for:

- color
- spacing
- typography
- elevation
- status colors
- radius
- borders and strokes
- icon sizing
- component state colors
- motion durations and easing

The visual style should remain sober and trust-first rather than flashy.

## 16. Auth Surface Visual Contract

The authentication surfaces should use a trust-forward visual language inspired by modern mobile auth cards while staying operational and lightweight.

Rules:

- keep one primary auth panel with soft rounded corners, subtle depth, and clear field grouping
- use semantic iconography and avoid emoji/icons as decorative placeholders
- use calm neutral backgrounds with muted teal accent gradients for trust cues
- preserve high-contrast, sunlight-readable text and controls
- keep primary action prominence on the sign-in / sign-up card
- keep support actions (forgot password, alternate sign-in method) visible but clearly secondary
- use optional preview visuals on medium/expanded layouts only; compact mobile layout should prioritize form completion
- avoid auth UI patterns that imply unsupported product behavior (for example OTP keypad entry) unless backend/auth flow supports it

Auth UI elements that are allowed in FleetFill:

- email and password form rows with inline leading icons
- password visibility toggle
- remember-session checkbox label
- primary submit button with loading state
- localized divider text for alternate identity providers
- localized provider continuation button(s) for configured providers
- localized footer prompt to move between sign-in and sign-up
