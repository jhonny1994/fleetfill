// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(documentCount, vehicleCount) =>
      "${documentCount} pending documents across ${vehicleCount} vehicles";

  static String m1(bookingId) => "Booking ${bookingId}";

  static String m2(carrierId) => "Carrier ${carrierId}";

  static String m3(reason) => "Verification needs attention: ${reason}";

  static String m4(documentId) => "Document ${documentId}";

  static String m5(documentId) => "Generated document ${documentId}";

  static String m6(languageCode) => "Current language: ${languageCode}";

  static String m7(notificationId) => "Notification ${notificationId}";

  static String m8(tripId) => "One-off trip ${tripId}";

  static String m9(proofId) => "Proof ${proofId}";

  static String m10(routeId) => "Route ${routeId}";

  static String m11(dates) =>
      "No same-day exact result is available. Showing nearest exact dates: ${dates}";

  static String m12(count) => "Search results (${count})";

  static String m13(shipmentId) => "Shipment ${shipmentId}";

  static String m14(index) => "Item ${index}";

  static String m15(bookingId) => "Tracking ${bookingId}";

  static String m16(reason) =>
      "Vehicle verification needs attention: ${reason}";

  static String m17(reason) => "Rejected: ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "Review the latest sensitive admin actions and their outcomes.",
    ),
    "adminAuditLogTitle": MessageLookupByLibrary.simpleMessage(
      "Admin audit log",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "Monitor queue health, alerts, and the current operational backlog.",
    ),
    "adminDashboardNavLabel": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Admin dashboard",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "Review payments, verification, disputes, payouts, and email work from one queue hub.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Queues"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Admin queues"),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Manage platform settings, maintenance controls, version policy, and monitoring summaries.",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Admin settings",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "Search for users and review account details when operations need context.",
    ),
    "adminUsersNavLabel": MessageLookupByLibrary.simpleMessage("Users"),
    "adminUsersTitle": MessageLookupByLibrary.simpleMessage("Users"),
    "adminVerificationApproveAction": MessageLookupByLibrary.simpleMessage(
      "Approve",
    ),
    "adminVerificationApproveAllAction": MessageLookupByLibrary.simpleMessage(
      "Approve all",
    ),
    "adminVerificationApproveAllSuccess": MessageLookupByLibrary.simpleMessage(
      "Verification packet approved.",
    ),
    "adminVerificationApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Verification document approved.",
    ),
    "adminVerificationAuditEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No recent verification audit items yet.",
    ),
    "adminVerificationAuditTitle": MessageLookupByLibrary.simpleMessage(
      "Verification audit",
    ),
    "adminVerificationMissingDocumentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "No submitted verification documents yet.",
        ),
    "adminVerificationPacketDescription": MessageLookupByLibrary.simpleMessage(
      "Review profile and vehicle documents together before approving operational access.",
    ),
    "adminVerificationPacketTitle": MessageLookupByLibrary.simpleMessage(
      "Verification packet",
    ),
    "adminVerificationPendingDocumentsLabel":
        MessageLookupByLibrary.simpleMessage("Pending documents"),
    "adminVerificationQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No carrier verification packets need review right now.",
    ),
    "adminVerificationQueueItemSubtitle": m0,
    "adminVerificationQueueSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Verification queue summary",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier verification queue",
    ),
    "adminVerificationRejectAction": MessageLookupByLibrary.simpleMessage(
      "Reject",
    ),
    "adminVerificationRejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "Add the reason the carrier should see.",
    ),
    "adminVerificationRejectReasonTitle": MessageLookupByLibrary.simpleMessage(
      "Rejection reason",
    ),
    "adminVerificationRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "Verification document rejected.",
    ),
    "appGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill could not complete this action right now.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("FleetFill"),
    "authAccountCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Your account was created. Continue by signing in.",
    ),
    "authAuthenticationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Sign in to continue this action.",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Repeat your password",
    ),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "authContinueWithLabel": MessageLookupByLibrary.simpleMessage(
      "or continue with",
    ),
    "authCreateAccountAction": MessageLookupByLibrary.simpleMessage(
      "Create account",
    ),
    "authCreateAccountCta": MessageLookupByLibrary.simpleMessage(
      "Create a new account",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "Create a strong password",
    ),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("you@example.com"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Email address"),
    "authEmailNotConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Confirm your email before signing in.",
    ),
    "authForgotPasswordCta": MessageLookupByLibrary.simpleMessage(
      "Forgot your password?",
    ),
    "authForgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Request a password reset link for your FleetFill account.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot password",
    ),
    "authGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill could not complete this auth request.",
    ),
    "authGoogleAction": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "authGoogleStartedMessage": MessageLookupByLibrary.simpleMessage(
      "Google sign-in started. Return here after approval.",
    ),
    "authGoogleUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Google sign-in is not available in this environment.",
    ),
    "authHaveAccountCta": MessageLookupByLibrary.simpleMessage(
      "Already have an account? Sign in",
    ),
    "authHidePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Hide password",
    ),
    "authInvalidCredentialsMessage": MessageLookupByLibrary.simpleMessage(
      "Check your email and password, then try again.",
    ),
    "authInvalidEmailMessage": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address.",
    ),
    "authKeepSignedInLabel": MessageLookupByLibrary.simpleMessage(
      "Keep me signed in",
    ),
    "authNetworkErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Network issue detected. Try again in a moment.",
    ),
    "authNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "New password",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "authPasswordMinLengthMessage": MessageLookupByLibrary.simpleMessage(
      "Use at least 8 characters.",
    ),
    "authPasswordMismatchMessage": MessageLookupByLibrary.simpleMessage(
      "The passwords do not match.",
    ),
    "authPasswordResetInfoMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill will send a reset link to the email address on file.",
    ),
    "authPasswordUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Your password was updated.",
    ),
    "authRequiredFieldMessage": MessageLookupByLibrary.simpleMessage(
      "This field is required.",
    ),
    "authResetEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Password reset instructions were sent.",
    ),
    "authResetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Set a new password after opening your secure recovery link.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Open this screen from the password recovery link to set a new password.",
    ),
    "authSendResetAction": MessageLookupByLibrary.simpleMessage(
      "Send reset link",
    ),
    "authSessionExpiredAction": MessageLookupByLibrary.simpleMessage(
      "Sign in again",
    ),
    "authSessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Your session ended. Sign in again to continue safely.",
    ),
    "authSessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Session expired",
    ),
    "authShowPasswordAction": MessageLookupByLibrary.simpleMessage(
      "Show password",
    ),
    "authSignInAction": MessageLookupByLibrary.simpleMessage("Sign in"),
    "authSignInDescription": MessageLookupByLibrary.simpleMessage(
      "Sign in with your email and password, or continue with Google when available.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "Signed in successfully.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Sign in"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "Create your FleetFill account to start shipping or publishing capacity.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Update password",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "An account already exists for this email.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Check your email to confirm the account before signing in.",
    ),
    "bookingBasePriceLabel": MessageLookupByLibrary.simpleMessage("Base price"),
    "bookingCarrierFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Carrier fee",
    ),
    "bookingCarrierPayoutLabel": MessageLookupByLibrary.simpleMessage(
      "Carrier payout",
    ),
    "bookingConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirm booking",
    ),
    "bookingCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Booking created. Continue to payment instructions.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shared booking detail routes sit above role shells.",
    ),
    "bookingDetailTitle": m1,
    "bookingInsuranceAction": MessageLookupByLibrary.simpleMessage(
      "Insurance option",
    ),
    "bookingInsuranceDescription": MessageLookupByLibrary.simpleMessage(
      "Insurance is optional and calculated as a percentage with a minimum fee floor.",
    ),
    "bookingInsuranceFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Insurance fee",
    ),
    "bookingInsuranceIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "Included",
    ),
    "bookingInsuranceLabel": MessageLookupByLibrary.simpleMessage("Insurance"),
    "bookingInsuranceNotIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "Not included",
    ),
    "bookingPaymentReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Payment reference",
    ),
    "bookingPlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Platform fee",
    ),
    "bookingPricingBreakdownAction": MessageLookupByLibrary.simpleMessage(
      "Pricing breakdown",
    ),
    "bookingReviewDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier reputation, trip detail, and pricing review live here before payment.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Booking review",
    ),
    "bookingStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "bookingStatusCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Completed",
    ),
    "bookingStatusConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmed",
    ),
    "bookingStatusDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Delivered pending review"),
    "bookingStatusDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Disputed",
    ),
    "bookingStatusInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "In transit",
    ),
    "bookingStatusPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("Payment under review"),
    "bookingStatusPendingPaymentLabel": MessageLookupByLibrary.simpleMessage(
      "Waiting for payment",
    ),
    "bookingStatusPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Picked up",
    ),
    "bookingTaxFeeLabel": MessageLookupByLibrary.simpleMessage("Tax fee"),
    "bookingTotalLabel": MessageLookupByLibrary.simpleMessage("Final total"),
    "bookingTrackingNumberLabel": MessageLookupByLibrary.simpleMessage(
      "Tracking number",
    ),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "carrierBookingsDescription": MessageLookupByLibrary.simpleMessage(
      "Active and historical booking worklists live in this branch.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage("Bookings"),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier bookings",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Verification, trips, booking actions, and payout reminders live here.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage("Carrier home"),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier verification status, payout reminders, and profile tools live here.",
    ),
    "carrierProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "carrierProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier details",
    ),
    "carrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier profile",
    ),
    "carrierProfileVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "Verification",
    ),
    "carrierProfileVerificationPending": MessageLookupByLibrary.simpleMessage(
      "Pending",
    ),
    "carrierProfileVerificationRejected": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "carrierProfileVerificationVerified": MessageLookupByLibrary.simpleMessage(
      "Verified",
    ),
    "carrierPublicProfileCommentsTitle": MessageLookupByLibrary.simpleMessage(
      "Recent comments",
    ),
    "carrierPublicProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Review this carrier\'s public reputation, comments, and verification status.",
    ),
    "carrierPublicProfileNoCommentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "No review comments are visible yet.",
        ),
    "carrierPublicProfileRatingLabel": MessageLookupByLibrary.simpleMessage(
      "Average rating",
    ),
    "carrierPublicProfileReviewCountLabel":
        MessageLookupByLibrary.simpleMessage("Review count"),
    "carrierPublicProfileSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier summary",
    ),
    "carrierPublicProfileTitle": m2,
    "carrierVehiclesShortcutDescription": MessageLookupByLibrary.simpleMessage(
      "Manage trucks, upload missing documents, and resolve verification blockers.",
    ),
    "carrierVerificationCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Upload and replace profile or vehicle verification documents from one place.",
    ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Verification center",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "Your verification packet is under review. Upload any missing documents to keep approval moving.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "Verification requirements and missing documents stay grouped under your profile branch.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Verification summary",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirm"),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Open this document in your secure viewer when access is ready.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Open Document",
    ),
    "documentViewerTitle": m4,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Secure document access is temporarily unavailable.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Update your carrier contact and company details.",
    ),
    "editCarrierProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Carrier profile updated.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit carrier profile",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Update your shipper contact details.",
    ),
    "editShipperProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Shipper profile updated.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit shipper profile",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage("Something went wrong"),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "Re-authenticate recently before opening this sensitive admin surface.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "This area is not available for your account.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("Access restricted"),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Open generated invoices and receipts from a secure shared route.",
    ),
    "generatedDocumentViewerTitle": m5,
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("French"),
    "languageSelectionCurrentMessage": m6,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the language you want FleetFill to use.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Language selection",
    ),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("Load more"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill is preparing your workspace.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("Loading"),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill is temporarily unavailable while maintenance is in progress.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "Maintenance mode",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Guide the user back to media access when they need to upload proof or documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Media upload permission",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Pricing summary",
    ),
    "myRoutesActiveRoutesLabel": MessageLookupByLibrary.simpleMessage(
      "Active recurring routes",
    ),
    "myRoutesActiveTripsLabel": MessageLookupByLibrary.simpleMessage(
      "Active one-off trips",
    ),
    "myRoutesAddAction": MessageLookupByLibrary.simpleMessage("Add capacity"),
    "myRoutesCreateRouteAction": MessageLookupByLibrary.simpleMessage(
      "Add recurring route",
    ),
    "myRoutesCreateTripAction": MessageLookupByLibrary.simpleMessage(
      "Add one-off trip",
    ),
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Recurring routes and one-off trips stay grouped in one branch.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Publish a recurring route or one-off trip to start offering capacity.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Routes"),
    "myRoutesOneOffTab": MessageLookupByLibrary.simpleMessage("One-off trips"),
    "myRoutesPublishedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Published capacity",
    ),
    "myRoutesRecurringTab": MessageLookupByLibrary.simpleMessage(
      "Recurring routes",
    ),
    "myRoutesReservedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Reserved capacity",
    ),
    "myRoutesRouteListTitle": MessageLookupByLibrary.simpleMessage(
      "Recurring routes",
    ),
    "myRoutesSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Capacity publication summary",
    ),
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("My routes"),
    "myRoutesTripListTitle": MessageLookupByLibrary.simpleMessage(
      "One-off trips",
    ),
    "myRoutesUpcomingDeparturesLabel": MessageLookupByLibrary.simpleMessage(
      "Upcoming departures",
    ),
    "myRoutesUtilizationLabel": MessageLookupByLibrary.simpleMessage(
      "Utilization",
    ),
    "myShipmentsDescription": MessageLookupByLibrary.simpleMessage(
      "Active, history, and draft shipment states stay inside this branch.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("Shipments"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("My shipments"),
    "noExactResultsMessage": MessageLookupByLibrary.simpleMessage(
      "No exact route is available for this search yet.",
    ),
    "noExactResultsTitle": MessageLookupByLibrary.simpleMessage(
      "No exact route found",
    ),
    "notFoundMessage": MessageLookupByLibrary.simpleMessage(
      "The requested page or entity could not be found.",
    ),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("Not found"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review the full details for this notification.",
    ),
    "notificationDetailTitle": m7,
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Review recent alerts, booking updates, and operational reminders.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Explain why tracking and booking updates matter before opening system settings.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications permission",
    ),
    "offlineMessage": MessageLookupByLibrary.simpleMessage(
      "You are offline. Some actions are temporarily unavailable.",
    ),
    "oneOffTripActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activate trip",
    ),
    "oneOffTripActivateConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Activate this trip for new bookings?",
        ),
    "oneOffTripActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "One-off trip activated.",
    ),
    "oneOffTripCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Add one-off trip",
    ),
    "oneOffTripCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "One-off trip added.",
    ),
    "oneOffTripDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Deactivate trip",
    ),
    "oneOffTripDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Deactivate this trip for new bookings? Existing bookings will stay unchanged.",
    ),
    "oneOffTripDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "One-off trip deactivated.",
    ),
    "oneOffTripDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Delete trip",
    ),
    "oneOffTripDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "This trip cannot be deleted because it already has bookings.",
    ),
    "oneOffTripDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Delete this one-off trip from FleetFill?",
    ),
    "oneOffTripDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "One-off trip removed.",
    ),
    "oneOffTripDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "Departure",
    ),
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review this one-off trip before booking or operational follow-up.",
    ),
    "oneOffTripDetailTitle": m8,
    "oneOffTripEditTitle": MessageLookupByLibrary.simpleMessage(
      "Edit one-off trip",
    ),
    "oneOffTripEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publish one dated trip with vehicle, lane, departure, and capacity details.",
    ),
    "oneOffTripSaveAction": MessageLookupByLibrary.simpleMessage("Save trip"),
    "oneOffTripSavedMessage": MessageLookupByLibrary.simpleMessage(
      "One-off trip updated.",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Instructions, reference, proof upload, and payment status remain in one coherent flow.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Payment flow"),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "Payment instructions",
    ),
    "paymentStatusProofSubmittedLabel": MessageLookupByLibrary.simpleMessage(
      "Proof submitted",
    ),
    "paymentStatusRefundedLabel": MessageLookupByLibrary.simpleMessage(
      "Refunded",
    ),
    "paymentStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "paymentStatusReleasedToCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Released to carrier",
    ),
    "paymentStatusSecuredLabel": MessageLookupByLibrary.simpleMessage(
      "Secured",
    ),
    "paymentStatusUnderVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "Under verification",
    ),
    "paymentStatusUnpaidLabel": MessageLookupByLibrary.simpleMessage("Unpaid"),
    "payoutAccountAddAction": MessageLookupByLibrary.simpleMessage(
      "Add payout account",
    ),
    "payoutAccountDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Delete payout account",
    ),
    "payoutAccountDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "This payout account cannot be removed right now.",
    ),
    "payoutAccountDeleteConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Remove this payout account from FleetFill?",
        ),
    "payoutAccountDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Payout account removed.",
    ),
    "payoutAccountEditAction": MessageLookupByLibrary.simpleMessage(
      "Edit payout account",
    ),
    "payoutAccountHolderLabel": MessageLookupByLibrary.simpleMessage(
      "Account holder name",
    ),
    "payoutAccountIdentifierLabel": MessageLookupByLibrary.simpleMessage(
      "Account number or identifier",
    ),
    "payoutAccountInstitutionLabel": MessageLookupByLibrary.simpleMessage(
      "Bank or CCP name",
    ),
    "payoutAccountSaveAction": MessageLookupByLibrary.simpleMessage(
      "Save payout account",
    ),
    "payoutAccountSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Payout account saved.",
    ),
    "payoutAccountTypeBankLabel": MessageLookupByLibrary.simpleMessage(
      "Bank transfer",
    ),
    "payoutAccountTypeCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "payoutAccountTypeDahabiaLabel": MessageLookupByLibrary.simpleMessage(
      "Dahabia",
    ),
    "payoutAccountTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Payout rail",
    ),
    "payoutAccountsDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier payout accounts stay grouped under the profile branch.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Payout accounts",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Operational actions stay gated until a phone number is present.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Save phone number",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Phone number saved.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Phone completion",
    ),
    "priceCurrencyLabel": MessageLookupByLibrary.simpleMessage("DZD"),
    "pricePerKgUnitLabel": MessageLookupByLibrary.simpleMessage("DZD/kg"),
    "profileCarrierVerificationHint": MessageLookupByLibrary.simpleMessage(
      "Add your carrier details now, then upload the required verification documents from your profile.",
    ),
    "profileCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Company name",
    ),
    "profileFullNameLabel": MessageLookupByLibrary.simpleMessage("Full name"),
    "profilePhoneLabel": MessageLookupByLibrary.simpleMessage("Phone number"),
    "profileSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Complete the required profile details before using operational features.",
    ),
    "profileSetupSaveAction": MessageLookupByLibrary.simpleMessage(
      "Save profile",
    ),
    "profileSetupSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Profile details saved.",
    ),
    "profileSetupTitle": MessageLookupByLibrary.simpleMessage("Profile setup"),
    "profileVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Profile verification documents",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Open this proof from a secure shared route when access is ready.",
    ),
    "proofViewerTitle": m9,
    "publicationActiveLabel": MessageLookupByLibrary.simpleMessage("Active"),
    "publicationEffectiveDateFutureMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choose an effective date and time that is now or later.",
        ),
    "publicationInactiveLabel": MessageLookupByLibrary.simpleMessage(
      "Inactive",
    ),
    "publicationNoRevisionsMessage": MessageLookupByLibrary.simpleMessage(
      "No route revisions recorded yet.",
    ),
    "publicationRevisionHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Revision history",
    ),
    "publicationSameLaneErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Origin and destination must be different communes.",
    ),
    "publicationSearchCommunesHint": MessageLookupByLibrary.simpleMessage(
      "Search communes",
    ),
    "publicationSelectValueAction": MessageLookupByLibrary.simpleMessage(
      "Select",
    ),
    "publicationVehicleUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choose one of your available vehicles for this publication.",
        ),
    "publicationVerifiedCarrierRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Complete carrier verification before publishing capacity.",
        ),
    "publicationVerifiedVehicleRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choose a verified vehicle before publishing capacity.",
        ),
    "publicationWeekdaysRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Select at least one departure day.",
    ),
    "retryLabel": MessageLookupByLibrary.simpleMessage("Retry"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publish trips, manage bookings, and keep verification moving.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Continue as a carrier",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "One account selects one role before operational access begins.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Create shipments, compare exact trips, and follow delivery progress.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Continue as a shipper",
    ),
    "roleSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Role selection",
    ),
    "routeActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activate route",
    ),
    "routeActivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Activate this route for new bookings?",
    ),
    "routeActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Route activated.",
    ),
    "routeCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Add recurring route",
    ),
    "routeCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Recurring route added.",
    ),
    "routeDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Deactivate route",
    ),
    "routeDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Deactivate this route for new bookings? Existing bookings will stay unchanged.",
    ),
    "routeDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Route deactivated.",
    ),
    "routeDeleteAction": MessageLookupByLibrary.simpleMessage("Delete route"),
    "routeDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "This route cannot be deleted because it already has bookings.",
    ),
    "routeDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Delete this recurring route from FleetFill?",
    ),
    "routeDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Recurring route removed.",
    ),
    "routeDepartureTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Default departure time",
    ),
    "routeDestinationLabel": MessageLookupByLibrary.simpleMessage(
      "Destination commune",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shared route detail presentation sits above the role shells.",
    ),
    "routeDetailTitle": m10,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "Edit recurring route",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publish a recurring lane with vehicle, schedule, and capacity details.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage(
      "Effective from",
    ),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill could not open this route.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage("Origin commune"),
    "routePricePerKgLabel": MessageLookupByLibrary.simpleMessage(
      "Price per kg (DZD)",
    ),
    "routeRecurringDaysLabel": MessageLookupByLibrary.simpleMessage(
      "Recurring days",
    ),
    "routeSaveAction": MessageLookupByLibrary.simpleMessage("Save route"),
    "routeSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Recurring route updated.",
    ),
    "routeStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Publication status",
    ),
    "routeVehicleLabel": MessageLookupByLibrary.simpleMessage(
      "Assigned vehicle",
    ),
    "sampleBasePriceAmount": MessageLookupByLibrary.simpleMessage("DZD 12,500"),
    "sampleBasePriceLabel": MessageLookupByLibrary.simpleMessage("Base price"),
    "samplePlatformFeeAmount": MessageLookupByLibrary.simpleMessage(
      "DZD 1,200",
    ),
    "samplePlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Platform fee",
    ),
    "sampleTotalAmount": MessageLookupByLibrary.simpleMessage("DZD 13,700"),
    "sampleTotalLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "searchCarrierLabel": MessageLookupByLibrary.simpleMessage("Carrier"),
    "searchCarrierRatingLabel": MessageLookupByLibrary.simpleMessage(
      "Carrier rating",
    ),
    "searchDepartureLabel": MessageLookupByLibrary.simpleMessage("Departure"),
    "searchEstimatedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Estimated total",
    ),
    "searchRequestedDateLabel": MessageLookupByLibrary.simpleMessage(
      "Requested departure date",
    ),
    "searchResultTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Capacity type",
    ),
    "searchShipmentSelectorLabel": MessageLookupByLibrary.simpleMessage(
      "Shipment draft",
    ),
    "searchShipmentSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Shipment summary",
    ),
    "searchSortLowestPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Lowest price",
    ),
    "searchSortNearestDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "Nearest departure",
    ),
    "searchSortRecommendedLabel": MessageLookupByLibrary.simpleMessage(
      "Recommended",
    ),
    "searchSortTopRatedLabel": MessageLookupByLibrary.simpleMessage(
      "Top rated",
    ),
    "searchTripsAction": MessageLookupByLibrary.simpleMessage(
      "Search exact capacity",
    ),
    "searchTripsControlsAction": MessageLookupByLibrary.simpleMessage(
      "Sort and filters",
    ),
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "The search form and exact-route results stay on one page with inline states.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No result matches the current sort and filter selection.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Search"),
    "searchTripsNearestDateMessage": m11,
    "searchTripsNearestDateTitle": MessageLookupByLibrary.simpleMessage(
      "Nearest exact dates found",
    ),
    "searchTripsNoRouteMessage": MessageLookupByLibrary.simpleMessage(
      "No exact route exists for this lane in the nearby search window.",
    ),
    "searchTripsNoRouteTitle": MessageLookupByLibrary.simpleMessage(
      "Redefine your search",
    ),
    "searchTripsOneOffLabel": MessageLookupByLibrary.simpleMessage(
      "One-off trip",
    ),
    "searchTripsRecurringLabel": MessageLookupByLibrary.simpleMessage(
      "Recurring route",
    ),
    "searchTripsRequiresDraftMessage": MessageLookupByLibrary.simpleMessage(
      "Create at least one shipment draft to search exact lane capacity.",
    ),
    "searchTripsResultsTitle": m12,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage("Search trips"),
    "settingsAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Account",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Language, theme, support, and notification preferences stay inside shared settings.",
    ),
    "settingsSignOutAction": MessageLookupByLibrary.simpleMessage("Sign out"),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "You have been signed out.",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Shared cards and shells stay consistent across role surfaces.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Shared foundation preview",
    ),
    "shipmentAddItemAction": MessageLookupByLibrary.simpleMessage("Add item"),
    "shipmentCategoryLabel": MessageLookupByLibrary.simpleMessage("Category"),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage(
      "Create shipment",
    ),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Create shipment draft",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Delete shipment",
    ),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Delete this shipment draft from FleetFill?",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Shipment draft removed.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shipment summary, items, and linked booking summary live here.",
    ),
    "shipmentDetailTitle": m13,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage("Edit shipment"),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage(
      "Edit shipment draft",
    ),
    "shipmentItemLabelField": MessageLookupByLibrary.simpleMessage(
      "Item label",
    ),
    "shipmentItemNotesLabel": MessageLookupByLibrary.simpleMessage(
      "Item notes",
    ),
    "shipmentItemQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "Quantity",
    ),
    "shipmentItemTitle": m14,
    "shipmentItemVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Item volume (m3)",
    ),
    "shipmentItemWeightLabel": MessageLookupByLibrary.simpleMessage(
      "Item weight (kg)",
    ),
    "shipmentItemsTitle": MessageLookupByLibrary.simpleMessage(
      "Shipment items",
    ),
    "shipmentPickupEndLabel": MessageLookupByLibrary.simpleMessage(
      "Pickup window end",
    ),
    "shipmentPickupStartLabel": MessageLookupByLibrary.simpleMessage(
      "Pickup window start",
    ),
    "shipmentPickupWindowOrderMessage": MessageLookupByLibrary.simpleMessage(
      "Pickup window end must be after pickup window start.",
    ),
    "shipmentRemoveItemAction": MessageLookupByLibrary.simpleMessage(
      "Remove item",
    ),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage("Save shipment"),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Shipment draft saved.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage("Booked"),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage("Draft"),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Create a shipment draft before searching exact capacity.",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Active bookings, recent notifications, quick actions, and support shortcut live here.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage("Shipper home"),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Profile, phone, preferences, and support shortcuts stay in one branch.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "shipperProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Shipper details",
    ),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Shipper profile",
    ),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "Bootstrap and blocking initialization states start here.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Splash"),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage(
      "Needs review",
    ),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Ready"),
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Support starts with clear email guidance and structured issue details.",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Your account is currently suspended. Contact FleetFill support by email.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Account suspended"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Tracking timeline, delivery confirmation, dispute, and rating actions stay together here.",
    ),
    "trackingDetailTitle": m15,
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "Update FleetFill to continue with the latest supported version.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Update required",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shipper and carrier specifics remain section-based inside one user detail view.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage("User detail"),
    "vehicleCapacityVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Capacity volume (m3)",
    ),
    "vehicleCapacityWeightLabel": MessageLookupByLibrary.simpleMessage(
      "Capacity weight (kg)",
    ),
    "vehicleCreateAction": MessageLookupByLibrary.simpleMessage("Add vehicle"),
    "vehicleCreateTitle": MessageLookupByLibrary.simpleMessage("Add vehicle"),
    "vehicleCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicle added.",
    ),
    "vehicleDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Delete vehicle",
    ),
    "vehicleDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Delete this vehicle from FleetFill?",
    ),
    "vehicleDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicle removed.",
    ),
    "vehicleDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Vehicle details, documents, and verification status appear here.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicle detail",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage("Edit vehicle"),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Keep vehicle data current so route and verification flows stay valid.",
    ),
    "vehiclePlateLabel": MessageLookupByLibrary.simpleMessage("Plate number"),
    "vehiclePositiveNumberMessage": MessageLookupByLibrary.simpleMessage(
      "Enter a number greater than zero.",
    ),
    "vehicleSaveAction": MessageLookupByLibrary.simpleMessage("Save vehicle"),
    "vehicleSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicle updated.",
    ),
    "vehicleSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicle summary",
    ),
    "vehicleTypeLabel": MessageLookupByLibrary.simpleMessage("Vehicle type"),
    "vehicleVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicle verification documents",
    ),
    "vehicleVerificationRejectedBanner": m16,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Vehicles remain under the carrier profile branch.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Add a vehicle before you publish capacity or complete full verification.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("Vehicles"),
    "verificationDocumentDriverIdentityLabel":
        MessageLookupByLibrary.simpleMessage("Driver identity or license"),
    "verificationDocumentMissingMessage": MessageLookupByLibrary.simpleMessage(
      "No file uploaded yet.",
    ),
    "verificationDocumentNeedsAttentionMessage":
        MessageLookupByLibrary.simpleMessage(
          "Review the rejection reason and upload a replacement.",
        ),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Secure document access prepared.",
        ),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Uploaded and waiting for admin review.",
    ),
    "verificationDocumentRejectedMessage": m17,
    "verificationDocumentReplacedMessage": MessageLookupByLibrary.simpleMessage(
      "Verification document replaced.",
    ),
    "verificationDocumentTransportLicenseLabel":
        MessageLookupByLibrary.simpleMessage("Transport license"),
    "verificationDocumentTruckInspectionLabel":
        MessageLookupByLibrary.simpleMessage("Truck technical inspection"),
    "verificationDocumentTruckInsuranceLabel":
        MessageLookupByLibrary.simpleMessage("Truck insurance"),
    "verificationDocumentTruckRegistrationLabel":
        MessageLookupByLibrary.simpleMessage("Truck registration"),
    "verificationDocumentUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Verification document uploaded.",
    ),
    "verificationDocumentVerifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Verified and accepted.",
    ),
    "verificationReplaceAction": MessageLookupByLibrary.simpleMessage(
      "Replace",
    ),
    "verificationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Complete the required verification steps before continuing.",
    ),
    "verificationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Verification required",
    ),
    "verificationUploadAction": MessageLookupByLibrary.simpleMessage("Upload"),
  };
}
