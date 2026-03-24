# Polish Backlog

## Goal

Track cross-phase polish work that should not be forgotten, but also should not distract from finishing the core operational phases.

This file is intentionally not a source of product truth. It is a delivery backlog for timing-sensitive polish work.

## When To Use This File

Use this file when:

- a UX/performance/accessibility improvement is valid but not urgent for the current phase
- the work is better applied consistently across multiple screens after more phases exist
- the current phase already has the correct product behavior and the remaining work is refinement rather than truth correction

Do not use this file to redefine domain rules, pricing rules, status models, or security ownership.

## Current Deferred Polish Items

### Loading Strategy

- [ ] Implement shared skeleton loading primitives for known-content layouts
- [ ] Apply skeleton loading to:
  - search result cards
  - shipment summary cards
  - carrier public profile summary and reviews
  - route and one-off trip detail summaries
  - admin verification queue cards and packet detail
  - payout account list and route/trip list summaries
- [ ] Add reduced-motion-safe fallback behavior for shimmer/skeleton animations

### Motion And Transition Polish

- [ ] Standardize low-distraction content transitions for loading -> data, data -> empty, and filter/sort updates
- [ ] Audit `AnimatedSwitcher` / implicit animation usage so transitions stay meaningful and not decorative

### Media And Asset Optimization

- [ ] Audit image/media-heavy surfaces and add constrained sizes, thumbnails, or compression where useful
- [ ] Confirm no unnecessarily large images/PDF previews are loaded into memory on operational screens

### Accessibility Release Pass

- [ ] Run a final screen-by-screen semantics pass across completed user journeys
- [ ] Re-check large text scale, focus order, sheet/dialog traversal, and tappable target sizing
- [ ] Re-check keyboard and larger-layout behavior on desktop/web-capable surfaces if those surfaces expand later

### Localization And Bidi Polish

- [ ] Run a final copy sweep for Arabic, French, and English operational consistency
- [ ] Re-check mixed-script identifiers, route/tracking/payment labels, and long status strings for bidi readability
- [ ] Replace any remaining scaffold-like or overly technical copy that survives later phases

## Already Expected During Feature Delivery

The following are not deferred polish items. They should be applied during normal implementation of the relevant feature:

- debounce for search/filter inputs
- stale-result protection
- lazy rendering for long lists
- destructive confirmations
- localized error mapping
- shared recovery states
- scroll-position preservation where useful

## Exit Criteria

This backlog should be closed only when:

- most major product phases are implemented
- the app is nearing release-hardening mode
- polish can be applied consistently instead of one screen at a time
