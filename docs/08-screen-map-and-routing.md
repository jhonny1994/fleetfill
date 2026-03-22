# FleetFill Screen Map And Routing

This file is the finalized screen inventory and GoRouter-oriented route map for FleetFill.

It intentionally avoids route bloat.

Rules:

- only true destinations become full routes
- pickers, confirmations, quick actions, and short subflows should prefer bottom sheets or dialogs
- loading, error, empty, and no-result states should usually stay inline inside the current page
- shared entities should have one canonical detail route instead of duplicated shipper/carrier/admin versions
- shipper and carrier preserve tab state with `StatefulShellRoute.indexedStack`

## 1. Final Route Philosophy

Use the smallest navigation surface that still feels clear.

### 1.1 Full Pages

Use full pages for:

- app bootstrap and blocking global states
- auth and password recovery
- onboarding and required profile completion
- main role tabs
- deep-linkable detail pages
- complex forms and flows that deserve history and restoration
- admin operational queues and detail views

### 1.2 Bottom Sheets

Use bottom sheets for:

- sort and filter controls
- payment method selection
- insurance selection
- simple date shortcuts and option pickers
- cancel/reject reason capture
- quick actions and action menus
- success summaries that do not require a new destination

### 1.3 Dialogs

Use dialogs for:

- destructive confirmation
- unsaved changes confirmation
- session-expired or re-auth prompts
- short blocking acknowledgements

### 1.4 Inline States

Use inline states for:

- loading
- refresh-in-progress
- empty states
- retryable error states
- no exact search result states
- offline/read-only notices
- permission-missing notices for the current task

Use shared Riverpod `AsyncValue` widgets for these states instead of turning them into routes.

### 1.5 Snackbars

Use snackbars for passive feedback only:

- saved
- copied
- resent
- upload started
- action completed

Do not use snackbars for critical decisions or critical failure explanation.

## 2. Final Top-Level Route Tree

```text
/
  splash
  maintenance
  update-required
  welcome

  auth/
    sign-in
    sign-up
    forgot-password
    reset-password

  onboarding/
    role-selection
    language-selection
    profile-setup
    phone-completion

  permissions/
    notifications-help
    media-upload-help

  shared/
    notifications
    notification/:id
    settings
    support
    shipment/:id
    booking/:id
    tracking/:id
    carrier/:carrierId
    route/:id
    oneoff-trip/:id
    proof/:id
    document/:id
    generated-document/:id

  shipper/(StatefulShellRoute.indexedStack)
    home
    shipments
    search
    profile

  carrier/(StatefulShellRoute.indexedStack)
    home
    routes
    bookings
    profile

  admin/(ShellRoute)
    dashboard
    queues
    users
    settings
```

## 3. Route Guards And Gates

### 3.1 Global Guards

- app initialized
- maintenance mode
- minimum supported version / update required
- authenticated session

### 3.2 Account Guards

- suspended or blocked account
- role selected
- onboarding complete
- phone completed before operational actions
- role authorization for route access

### 3.3 Operational Gates

- carrier verification pending/rejected gate before carrier operational actions
- payout account required gate before payout-relevant carrier actions when needed
- recent sign-in or step-up auth for sensitive admin actions
- not-found / unavailable entity handling for deep links
- forbidden access handling for valid route but unauthorized entity

### 3.4 Permissions Handling

Permissions are usually contextual, not global route guards.

- notification permission should be requested after the user understands the value
- media access should be requested only when the user starts uploading proof or documents
- permanently denied permissions should open the relevant help/recovery route

## 4. Shared Reusable UI State Components

These are not routes. They should be reusable widgets/components.

- `AppAsyncStateView`
- `AppSliverAsyncStateView`
- `AppEmptyState`
- `AppErrorState`
- `AppRetryCard`
- `AppOfflineBanner`
- `AppNoExactResultsState`
- `AppPermissionHelpCard`
- `AppNotFoundState`
- `AppForbiddenState`
- `AppSuspendedAccountState`
- `AppVerificationGateState`

## 5. Bootstrap And Global Screens

### Global Full Pages

- `SplashScreen`
- `MaintenanceModeScreen`
- `ForceUpdateScreen`

### Global Shared Full Pages

- `NotificationsCenterScreen`
- `NotificationDetailScreen`
- `SettingsScreen`
- `SupportHomeScreen`
- `ShipmentDetailScreen` for direct draft or pre-booking shipment access when needed

Use nested sections, sheets, or dialogs under these pages when possible instead of separate full routes for routine settings/support subtasks.

### Global Nested/Section Screens Under Settings

- `LanguageSettingsSection`
- `ThemeSettingsSection`
- `AboutFleetFillSection`
- `EmailPreferencesSection`
- `NotificationPreferencesSection`

These should usually live inside `SettingsScreen` rather than as separate routed pages unless deep linking becomes necessary.

### Permission Recovery Pages

- `NotificationsPermissionHelpScreen`
- `MediaUploadPermissionHelpScreen`

## 6. Auth Screens

Use one lean auth shell.

Auth is separate from first-run onboarding entry.

- signed-out first launch should open `WelcomeScreen`
- after the user continues once, persist that state and return later signed-out sessions to `SignInScreen`
- auth screens stay focused on identity tasks only

- `SignInScreen`
- `SignUpScreen`
- `ForgotPasswordScreen`
- `ResetPasswordScreen`

Use dialog or inline handling instead of extra full pages for:

- auth loading
- session expired
- blocked account messaging when already inside app

## 7. Onboarding Screens

Keep onboarding guided and minimal.

First-run welcome is a separate pre-auth entry screen, not part of the authenticated onboarding gate sequence.

### Shared Onboarding Pages

- `RoleSelectionScreen`
- `LanguageSelectionScreen`
- `ProfileSetupScreen`
- `PhoneCompletionScreen`

Implementation note:

- `ProfileSetupScreen` should render role-specific content for shipper vs carrier instead of duplicating many onboarding routes
- theme preference should live in Settings, not in onboarding
- carrier verification intro and review should be sections inside the carrier profile setup flow, not extra routes
- onboarding completion should usually resolve with inline confirmation and forward navigation rather than a permanent standalone destination unless product needs change later

## 8. Shipper Shell

Recommended tabs:

1. `home`
2. `shipments`
3. `search`
4. `profile`

Notifications should not be a permanent shipper tab.

### 8.1 Shipper Home Branch

Full pages:

- `ShipperHomeScreen`

Inline sections:

- active bookings summary
- recent notifications summary
- quick actions
- support shortcut

### 8.2 Shipper Shipments Branch

Full pages:

- `MyShipmentsScreen`

Use in-page tabs/segments instead of separate routes for:

- `active`
- `history`
- `drafts`

Use sheets/dialogs instead of routes for:

- cancel shipment confirm
- draft saved feedback
- origin/destination wilaya and commune pickers where practical

Use sections inside `ShipmentDetailScreen` for:

- shipment summary
- linked booking summary

Deep-linkable shipment/booking follow-up should prefer the shared `BookingDetailScreen` when the user is already in the booked operational flow.

### 8.3 Shipper Search Branch

Full pages:

- `SearchTripsScreen`
- `BookingReviewScreen`
- `PaymentFlowScreen`

Recommended detail strategy:

- use the shared `RouteDetailScreen` / trip detail presentation above the shell when a result is opened deeply or from a notification
- allow an inline preview card or bottom sheet from results when a full route is unnecessary

Use one search page with embedded results instead of separate pages for form and results when possible.

Use sheets for:

- filters
- sort selection
- insurance selection
- pricing breakdown

Use inline states for:

- no exact result
- nearest exact-lane dates
- loading more results
- retrying search

### 8.4 Shipper Profile Branch

Full pages:

- `ShipperProfileScreen`
- `EditShipperProfileScreen`

Nested sections or sheets:

- phone edit
- notification preferences
- email preferences
- support shortcut

## 9. Carrier Shell

Recommended tabs:

1. `home`
2. `routes`
3. `bookings`
4. `profile`

Notifications should not be a permanent carrier tab.

### 9.1 Carrier Home Branch

Full pages:

- `CarrierHomeScreen`

Inline sections:

- pending verification summary
- upcoming trips summary
- pending booking actions
- payout/account reminders

### 9.2 Carrier Routes Branch

Full pages:

- `MyRoutesScreen`
- `RouteFormScreen` for create/edit recurring route
- `OneOffTripFormScreen` for create/edit one-off trip
- `RouteDetailScreen`
- `OneOffTripDetailScreen`

Use sections or sheets instead of separate routes for:

- vehicle assignment
- schedule editing
- capacity summary
- active/inactive toggling

### 9.3 Carrier Bookings Branch

Full pages:

- `CarrierBookingsScreen`
- shared `BookingDetailScreen` opened above shell

Use in-page tabs/segments for:

- active bookings
- history

Use bottom sheets for:

- mark picked up
- mark in transit
- mark delivered
- add optional note

### 9.4 Carrier Profile Branch

Full pages:

- `CarrierProfileScreen`
- `EditCarrierProfileScreen`
- `MyVehiclesScreen`
- `VehicleDetailScreen`
- `PayoutAccountsScreen`

Use reusable create/edit forms instead of separate route families for:

- create vehicle
- edit vehicle
- create payout account
- edit payout account

Use sections and sheets for:

- vehicle documents
- upload/replace document
- verification status and rejection reason details
- rating list preview

Recommended structure:

- keep vehicles and payout accounts under the carrier profile branch so the carrier shell stays at four tabs
- use reusable form/detail shells for vehicle and payout account create/edit flows

Optional separate full pages only if content grows significantly:

- `CarrierRatingsScreen`
- `PayoutHistoryScreen`

## 10. Shared Operational Detail Routes

These routes should sit above the shipper/carrier shells using a parent navigator key.

- `ShipmentDetailScreen`
- `BookingDetailScreen`
- `BookingTrackingScreen`
- `CarrierPublicProfileScreen`
- `RouteDetailScreen`
- `OneOffTripDetailScreen`
- `ProofViewerScreen`
- `DocumentViewerScreen`
- `GeneratedDocumentViewerScreen`

Inside `BookingTrackingScreen`, keep these as sections or actions rather than separate routes:

- tracking timeline
- delivery pending review state
- confirm delivery action
- open dispute action
- rate carrier action after completion

Inside `PaymentFlowScreen`, keep these as internal steps or sections:

- payment instructions
- payment method selection
- payment reference
- proof upload
- proof resubmission after rejection
- payment status
- invoice and receipt access

Do not create separate success pages for booking created, payment submitted, review submitted, dispute submitted, or delivery submitted unless a future product need clearly justifies them.

## 11. Admin Shell

Admin should stay lean on mobile.

Recommended sections:

1. `dashboard`
2. `queues`
3. `users`
4. `settings`

### 11.1 Admin Dashboard

Full page:

- `AdminDashboardScreen`

Inline widgets/sections:

- backlog health
- operational alerts
- quick counts

### 11.2 Admin Queues

Full pages:

- `AdminQueuesScreen`
- `PaymentReviewDetailScreen`
- `VerificationPacketDetailScreen`
- `DisputeDetailScreen`
- `PayoutDetailScreen`
- `EmailLogDetailScreen`

Inside `AdminQueuesScreen`, use segmented tabs/chips for:

- payments
- verification
- disputes
- payouts
- email

Use sheets/dialogs for:

- approve payment
- reject payment
- approve all verification
- reject verification document
- resolve dispute outcome
- release payout
- resend email

### 11.3 Admin Users

Full pages:

- `UsersScreen`
- `UserDetailScreen`

Use sections inside `UserDetailScreen` for shipper/carrier specifics instead of separate routed detail pages unless the information grows too large.

Use dialogs for:

- suspend user
- reactivate user

### 11.4 Admin Settings

Full pages:

- `AdminSettingsScreen`
- `AdminAuditLogScreen`

Use sections inside `AdminSettingsScreen` for:

- platform settings
- maintenance mode control
- version policy
- feature flags
- email monitoring summary

## 12. Final GoRouter Shell Diagram

```text
Root
|- Splash
|- Maintenance
|- ForceUpdate
|- AuthShell
|  |- SignIn
|  |- SignUp
|  |- ForgotPassword
|  |- ResetPassword
|- OnboardingShell
|  |- RoleSelection
|  |- LanguageSelection
|  |- ProfileSetup
|  |- PhoneCompletion
|- PermissionHelpRoutes
|  |- NotificationsHelp
|  |- MediaUploadHelp
|- ShipperShell (StatefulShellRoute.indexedStack)
|  |- HomeBranch
|  |- ShipmentsBranch
|  |- SearchBranch
|  |- ProfileBranch
|- CarrierShell (StatefulShellRoute.indexedStack)
|  |- HomeBranch
|  |- RoutesBranch
|  |- BookingsBranch
|  |- ProfileBranch
|- AdminShell
|  |- Dashboard
|  |- Queues
|  |- Users
|  |- Settings
|- SharedAboveShellRoutes
   |- NotificationsCenter
   |- NotificationDetail
   |- Settings
   |- Support
   |- ShipmentDetail
   |- BookingDetail
   |- TrackingDetail
   |- CarrierProfile
   |- RouteDetail
   |- OneOffTripDetail
   |- ProofViewer
   |- DocumentViewer
   |- GeneratedDocumentViewer
```

## 13. Performance And Navigation Rules

- do not create a route for every state change
- do not duplicate entity detail routes per role unless the information architecture truly differs
- do not make success screens into dead-end pages when a snackbar or sheet is enough
- keep shared detail routes above the role shell so deep links and notification opens do not destroy tab state
- keep list filters and sort in sheets rather than additional routes
- keep long lists lazy and inside stable branch pages
- preserve branch scroll state and tab state across navigation
- use Riverpod `AsyncValue` rendering patterns inside pages instead of swapping whole routes for loading/error/empty states

## 14. Final Notes

- the screen map is intentionally DRY and reusable
- not every named screen must become a unique widget class if a reusable form/detail shell fits better
- if a future feature introduces a new full page, justify why it cannot be a sheet, dialog, or inline state first
