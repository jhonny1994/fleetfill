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

  static String m4(count) => "Selected files: ${count}";

  static String m5(documentId) => "Document ${documentId}";

  static String m6(documentId) => "Generated document ${documentId}";

  static String m7(languageCode) => "Current app language: ${languageCode}";

  static String m8(milestoneLabel) => "Current status: ${milestoneLabel}";

  static String m9(notificationId) => "Notification ${notificationId}";

  static String m10(documentType) =>
      "Your ${documentType} is ready to view or download.";

  static String m11(tripId) => "One-off trip ${tripId}";

  static String m12(proofId) => "Proof ${proofId}";

  static String m13(routeId) => "Route ${routeId}";

  static String m14(dates) =>
      "No same-day exact result is available. Showing nearest exact dates: ${dates}";

  static String m15(count) => "Search results (${count})";

  static String m16(shipmentId) => "Shipment ${shipmentId}";

  static String m17(supportEmail) => "Support email: ${supportEmail}";

  static String m18(bookingId) => "Tracking ${bookingId}";

  static String m19(reason) =>
      "Vehicle verification needs attention: ${reason}";

  static String m20(reason) => "Rejected: ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "Review the latest sensitive admin actions and their outcomes.",
    ),
    "adminAuditLogEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No admin audit events have been recorded yet.",
    ),
    "adminAuditLogTitle": MessageLookupByLibrary.simpleMessage(
      "Admin audit log",
    ),
    "adminDashboardAutomationTitle": MessageLookupByLibrary.simpleMessage(
      "Time-sensitive tasks",
    ),
    "adminDashboardBacklogHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Pending work",
    ),
    "adminDashboardDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "Failed emails",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "Monitor pending work, alerts, and service health.",
    ),
    "adminDashboardEmailBacklogLabel": MessageLookupByLibrary.simpleMessage(
      "Emails waiting",
    ),
    "adminDashboardEmailHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Email delivery",
    ),
    "adminDashboardNavLabel": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "adminDashboardOverdueDeliveryReviewsLabel":
        MessageLookupByLibrary.simpleMessage("Overdue delivery reviews"),
    "adminDashboardOverduePaymentResubmissionsLabel":
        MessageLookupByLibrary.simpleMessage("Overdue payment resubmissions"),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Admin dashboard",
    ),
    "adminDisputesQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No disputes are waiting for review right now.",
    ),
    "adminDisputesQueueTitle": MessageLookupByLibrary.simpleMessage("Disputes"),
    "adminEligiblePayoutsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No payouts are ready to release right now.",
    ),
    "adminEmailDeadLetterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No failed emails need attention right now.",
    ),
    "adminEmailDeadLetterTitle": MessageLookupByLibrary.simpleMessage(
      "Failed emails",
    ),
    "adminEmailQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No email delivery logs match the current filters.",
    ),
    "adminEmailQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Email delivery",
    ),
    "adminEmailResendAction": MessageLookupByLibrary.simpleMessage("Resend"),
    "adminEmailResendSuccess": MessageLookupByLibrary.simpleMessage(
      "Email resend requested.",
    ),
    "adminEmailSearchLabel": MessageLookupByLibrary.simpleMessage(
      "Search email logs",
    ),
    "adminEmailStatusAllLabel": MessageLookupByLibrary.simpleMessage(
      "All statuses",
    ),
    "adminEmailStatusBouncedLabel": MessageLookupByLibrary.simpleMessage(
      "Bounced",
    ),
    "adminEmailStatusDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "Failed",
    ),
    "adminEmailStatusDeliveredLabel": MessageLookupByLibrary.simpleMessage(
      "Delivered",
    ),
    "adminEmailStatusFilterLabel": MessageLookupByLibrary.simpleMessage(
      "Email status",
    ),
    "adminEmailStatusHardFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Hard failed",
    ),
    "adminEmailStatusQueuedLabel": MessageLookupByLibrary.simpleMessage(
      "Queued",
    ),
    "adminEmailStatusSentLabel": MessageLookupByLibrary.simpleMessage("Sent"),
    "adminEmailStatusSoftFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Soft failed",
    ),
    "adminEmailStatusSuppressedLabel": MessageLookupByLibrary.simpleMessage(
      "Suppressed",
    ),
    "adminPaymentProofQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No payment proofs need review right now.",
    ),
    "adminPaymentProofQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Payment proof review",
    ),
    "adminPayoutEligibleTitle": MessageLookupByLibrary.simpleMessage(
      "Eligible payouts",
    ),
    "adminPayoutQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No payouts have been released yet.",
    ),
    "adminPayoutQueueTitle": MessageLookupByLibrary.simpleMessage("Payouts"),
    "adminPayoutReleaseAction": MessageLookupByLibrary.simpleMessage(
      "Release payout",
    ),
    "adminQueueDisputesTabLabel": MessageLookupByLibrary.simpleMessage(
      "Disputes",
    ),
    "adminQueueEmailTabLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "adminQueuePaymentsTabLabel": MessageLookupByLibrary.simpleMessage(
      "Payments",
    ),
    "adminQueuePayoutsTabLabel": MessageLookupByLibrary.simpleMessage(
      "Payouts",
    ),
    "adminQueueVerificationTabLabel": MessageLookupByLibrary.simpleMessage(
      "Verification",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "Review payments, verification, disputes, payouts, and email issues in one place.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Operations"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Operations"),
    "adminSettingsDeliveryGraceLabel": MessageLookupByLibrary.simpleMessage(
      "Delivery grace window (hours)",
    ),
    "adminSettingsDeliverySectionTitle": MessageLookupByLibrary.simpleMessage(
      "Delivery review policy",
    ),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Manage app access, pricing rules, maintenance mode, and email tools.",
    ),
    "adminSettingsEmailResendEnabledLabel":
        MessageLookupByLibrary.simpleMessage("Enable admin email resend"),
    "adminSettingsFeatureFlagsSectionTitle":
        MessageLookupByLibrary.simpleMessage("Optional features"),
    "adminSettingsForceUpdateLabel": MessageLookupByLibrary.simpleMessage(
      "Force update required",
    ),
    "adminSettingsInsuranceMinimumLabel": MessageLookupByLibrary.simpleMessage(
      "Insurance minimum fee",
    ),
    "adminSettingsInsuranceRateLabel": MessageLookupByLibrary.simpleMessage(
      "Insurance rate",
    ),
    "adminSettingsMaintenanceModeLabel": MessageLookupByLibrary.simpleMessage(
      "Maintenance mode",
    ),
    "adminSettingsMinimumAndroidVersionLabel":
        MessageLookupByLibrary.simpleMessage("Minimum Android version"),
    "adminSettingsMinimumIosVersionLabel": MessageLookupByLibrary.simpleMessage(
      "Minimum iOS version",
    ),
    "adminSettingsMonitoringSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Service summary",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "adminSettingsPaymentDeadlineLabel": MessageLookupByLibrary.simpleMessage(
      "Payment resubmission deadline (hours)",
    ),
    "adminSettingsPlatformFeeRateLabel": MessageLookupByLibrary.simpleMessage(
      "Platform fee rate",
    ),
    "adminSettingsPricingSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Booking pricing policy",
    ),
    "adminSettingsRuntimeSectionTitle": MessageLookupByLibrary.simpleMessage(
      "App access",
    ),
    "adminSettingsSaveAction": MessageLookupByLibrary.simpleMessage(
      "Save settings",
    ),
    "adminSettingsSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Admin settings updated.",
    ),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Admin settings",
    ),
    "adminUserAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Account overview",
    ),
    "adminUserBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No bookings are linked to this user yet.",
    ),
    "adminUserBookingsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Related bookings",
    ),
    "adminUserDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No verification documents are available for this user.",
    ),
    "adminUserDocumentsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Verification documents",
    ),
    "adminUserEmailEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No recent email logs are available for this user.",
    ),
    "adminUserEmailSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Recent emails",
    ),
    "adminUserReactivateAction": MessageLookupByLibrary.simpleMessage(
      "Reactivate user",
    ),
    "adminUserReactivateSuccess": MessageLookupByLibrary.simpleMessage(
      "User reactivated.",
    ),
    "adminUserReasonHint": MessageLookupByLibrary.simpleMessage(
      "Add a reason for this change.",
    ),
    "adminUserRoleAdminLabel": MessageLookupByLibrary.simpleMessage("Admin"),
    "adminUserRoleCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Carrier",
    ),
    "adminUserRoleLabel": MessageLookupByLibrary.simpleMessage("Role"),
    "adminUserRoleShipperLabel": MessageLookupByLibrary.simpleMessage(
      "Shipper",
    ),
    "adminUserStatusActiveLabel": MessageLookupByLibrary.simpleMessage(
      "Active",
    ),
    "adminUserStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Account status",
    ),
    "adminUserStatusSuspendedLabel": MessageLookupByLibrary.simpleMessage(
      "Suspended",
    ),
    "adminUserSuspendAction": MessageLookupByLibrary.simpleMessage(
      "Suspend user",
    ),
    "adminUserSuspendSuccess": MessageLookupByLibrary.simpleMessage(
      "User suspended.",
    ),
    "adminUserVehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No vehicles are linked to this user.",
    ),
    "adminUserVehiclesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicles",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "Search for users and review account details, bookings, and documents.",
    ),
    "adminUsersEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No users match the current search.",
    ),
    "adminUsersNavLabel": MessageLookupByLibrary.simpleMessage("Users"),
    "adminUsersSearchLabel": MessageLookupByLibrary.simpleMessage(
      "Search users",
    ),
    "adminUsersTitle": MessageLookupByLibrary.simpleMessage("Users"),
    "adminVerificationApproveAction": MessageLookupByLibrary.simpleMessage(
      "Approve",
    ),
    "adminVerificationApproveAllAction": MessageLookupByLibrary.simpleMessage(
      "Approve all",
    ),
    "adminVerificationApproveAllSuccess": MessageLookupByLibrary.simpleMessage(
      "Verification approved.",
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
      "Review profile and vehicle documents before approving the carrier.",
    ),
    "adminVerificationPacketTitle": MessageLookupByLibrary.simpleMessage(
      "Verification details",
    ),
    "adminVerificationPendingDocumentsLabel":
        MessageLookupByLibrary.simpleMessage("Pending documents"),
    "adminVerificationQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No carrier verifications need review right now.",
    ),
    "adminVerificationQueueItemSubtitle": m0,
    "adminVerificationQueueSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Verification summary",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier verifications",
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
    "authCancelledMessage": MessageLookupByLibrary.simpleMessage(
      "Sign-in cancelled.",
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
    "authRoleAlreadyAssignedMessage": MessageLookupByLibrary.simpleMessage(
      "This account role is already set and cannot be changed here.",
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
      "Booking created. Continue to payment.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review the booking status, payment details, and price breakdown.",
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
      "Track current bookings, delivery progress, and completed jobs.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage("Bookings"),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier bookings",
    ),
    "carrierGatePayoutMessage": MessageLookupByLibrary.simpleMessage(
      "Add a payout account before opening carrier bookings so completed jobs can be settled correctly.",
    ),
    "carrierGatePayoutTitle": MessageLookupByLibrary.simpleMessage(
      "Payout account required",
    ),
    "carrierGatePhoneMessage": MessageLookupByLibrary.simpleMessage(
      "Add your phone number before opening this carrier workspace so booking and operational updates can reach you.",
    ),
    "carrierGatePhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Phone number required",
    ),
    "carrierGateVerificationMessage": MessageLookupByLibrary.simpleMessage(
      "Finish carrier verification before opening this workspace for publishing routes or handling bookings.",
    ),
    "carrierGateVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "Verification required",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Check your verification status, fleet readiness, and next tasks.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage("Carrier home"),
    "carrierMilestoneUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Booking milestone updated.",
    ),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Manage your business details, verification, payout accounts, and vehicles.",
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
    "carrierVerificationCenterDescription":
        MessageLookupByLibrary.simpleMessage(
          "Upload and replace profile or vehicle verification documents.",
        ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Verification center",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "Your verification is under review. Upload any missing documents to keep it moving.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "Finish the remaining verification steps from your profile.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Verification summary",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirm"),
    "contactSupportAction": MessageLookupByLibrary.simpleMessage(
      "Contact support",
    ),
    "deliveryConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirm delivery",
    ),
    "deliveryConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Delivery confirmed.",
    ),
    "disputeEvidenceAddAction": MessageLookupByLibrary.simpleMessage(
      "Add evidence files",
    ),
    "disputeEvidenceEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No evidence files have been attached to this dispute yet.",
    ),
    "disputeEvidenceSelectedCount": m4,
    "disputeEvidenceTitle": MessageLookupByLibrary.simpleMessage(
      "Dispute evidence",
    ),
    "documentPreviewUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Preview is not available for this file. Open it in another app.",
    ),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "View this document here or open it in another app.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Open document",
    ),
    "documentViewerTitle": m5,
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
    "generatedDocumentAvailableAtLabel": MessageLookupByLibrary.simpleMessage(
      "Available at",
    ),
    "generatedDocumentDownloadAction": MessageLookupByLibrary.simpleMessage(
      "Download PDF",
    ),
    "generatedDocumentFailedMessage": MessageLookupByLibrary.simpleMessage(
      "This document could not be generated yet. Try again later or contact support if the issue persists.",
    ),
    "generatedDocumentFailureReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Issue",
    ),
    "generatedDocumentOpenInBrowserAction":
        MessageLookupByLibrary.simpleMessage("Open in browser"),
    "generatedDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "This document is still being generated. Check back in a moment.",
    ),
    "generatedDocumentStatusFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Needs regeneration",
    ),
    "generatedDocumentStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "Generating",
    ),
    "generatedDocumentTypeBookingInvoice": MessageLookupByLibrary.simpleMessage(
      "Booking invoice",
    ),
    "generatedDocumentTypePaymentReceipt": MessageLookupByLibrary.simpleMessage(
      "Payment receipt",
    ),
    "generatedDocumentTypePayoutReceipt": MessageLookupByLibrary.simpleMessage(
      "Payout receipt",
    ),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "View or download your invoice or receipt.",
    ),
    "generatedDocumentViewerTitle": m6,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Generated invoice and receipt documents will appear here when available.",
    ),
    "generatedDocumentsTapReadyHint": MessageLookupByLibrary.simpleMessage(
      "Tap any ready document to open it securely.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Generated documents",
    ),
    "goBackAction": MessageLookupByLibrary.simpleMessage("Go back"),
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("French"),
    "languageSelectionCurrentMessage": m7,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the language you want FleetFill to use.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Language selection",
    ),
    "legalDisputePolicyBody": MessageLookupByLibrary.simpleMessage(
      "Disputes must be opened during the delivery review window. FleetFill reviews shipment, payment proof, tracking, and related records before resolving the case. A dispute may end with a completed booking, a cancellation, or a refund.",
    ),
    "legalDisputePolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Dispute policy",
    ),
    "legalPaymentDisclosureBody": MessageLookupByLibrary.simpleMessage(
      "Pricing breakdown, platform fees, taxes, and optional insurance are shown before proof submission. FleetFill verifies payment proof against the booking total, secures funds before delivery completion, and releases carrier payout only after the booking becomes payout-eligible.",
    ),
    "legalPaymentDisclosureTitle": MessageLookupByLibrary.simpleMessage(
      "Payment and escrow disclosure",
    ),
    "legalPoliciesDescription": MessageLookupByLibrary.simpleMessage(
      "Review the terms, privacy, payment, and dispute rules that apply when you use FleetFill.",
    ),
    "legalPoliciesSupportHint": MessageLookupByLibrary.simpleMessage(
      "If you need clarification on these policies, contact FleetFill support before continuing with a booking, payment, or dispute action.",
    ),
    "legalPoliciesTitle": MessageLookupByLibrary.simpleMessage(
      "Policies and disclosures",
    ),
    "legalPrivacyBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill stores payment, shipment, support, and audit records only when needed to run the service, investigate disputes, and meet legal or financial obligations. Access is limited to the account owner and authorized staff.",
    ),
    "legalPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Privacy and retention",
    ),
    "legalTermsBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill accepts shipper payment before any carrier payout. Each booking covers one shipment on one confirmed route or trip. Shippers are responsible for accurate shipment details, and carriers are responsible for valid operating documents and lawful transport compliance.",
    ),
    "legalTermsTitle": MessageLookupByLibrary.simpleMessage("Terms of service"),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("Load more"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "Getting things ready for you.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("Loading"),
    "locationUnavailableLabel": MessageLookupByLibrary.simpleMessage(
      "Location unavailable",
    ),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill is temporarily unavailable while we make improvements. Please try again soon.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "We\'ll be back soon",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Allow photo and file access so you can upload payment proof and documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Allow photo and file access",
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
      "Manage your recurring routes and one-off trips.",
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
      "Create shipments, review drafts, and track booked loads.",
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
    "notificationBookingConfirmedBody": MessageLookupByLibrary.simpleMessage(
      "Your booking is confirmed. Follow the payment steps to keep it on track.",
    ),
    "notificationBookingConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Booking confirmed",
    ),
    "notificationBookingMilestoneUpdatedBody": m8,
    "notificationBookingMilestoneUpdatedTitle":
        MessageLookupByLibrary.simpleMessage("Booking milestone updated"),
    "notificationCarrierReviewSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "A new review has been added to your profile.",
        ),
    "notificationCarrierReviewSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Carrier review received"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review the full details for this notification.",
    ),
    "notificationDetailTitle": m9,
    "notificationDisputeOpenedBody": MessageLookupByLibrary.simpleMessage(
      "Your dispute has been opened and is waiting for review.",
    ),
    "notificationDisputeOpenedTitle": MessageLookupByLibrary.simpleMessage(
      "Dispute opened",
    ),
    "notificationDisputeResolvedBody": MessageLookupByLibrary.simpleMessage(
      "Your dispute has been resolved. Check the latest booking and payment update.",
    ),
    "notificationDisputeResolvedTitle": MessageLookupByLibrary.simpleMessage(
      "Dispute resolved",
    ),
    "notificationGeneratedDocumentReadyBody": m10,
    "notificationGeneratedDocumentReadyTitle":
        MessageLookupByLibrary.simpleMessage("Document ready"),
    "notificationPaymentProofSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "We received your payment proof. We will review it shortly.",
        ),
    "notificationPaymentProofSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Payment proof submitted"),
    "notificationPaymentRejectedBody": MessageLookupByLibrary.simpleMessage(
      "Your payment proof was rejected. Check the reason and send a new one before the deadline.",
    ),
    "notificationPaymentRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "Payment proof rejected",
    ),
    "notificationPaymentSecuredBody": MessageLookupByLibrary.simpleMessage(
      "Your payment has been secured and the booking is confirmed.",
    ),
    "notificationPaymentSecuredTitle": MessageLookupByLibrary.simpleMessage(
      "Payment secured",
    ),
    "notificationPayoutReleasedBody": MessageLookupByLibrary.simpleMessage(
      "The carrier payout has been released for this booking.",
    ),
    "notificationPayoutReleasedTitle": MessageLookupByLibrary.simpleMessage(
      "Payout released",
    ),
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Stay up to date with bookings, payments, delivery progress, and account alerts.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "notificationsOnboardingEnableAction": MessageLookupByLibrary.simpleMessage(
      "Enable notifications",
    ),
    "notificationsOnboardingSkipAction": MessageLookupByLibrary.simpleMessage(
      "Skip for now",
    ),
    "notificationsOnboardingValueMessage": MessageLookupByLibrary.simpleMessage(
      "Turn on notifications to follow booking confirmations, payment reviews, delivery milestones, and account alerts without guessing what changed.",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Turn on notifications to get booking updates, delivery milestones, and payment alerts.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Turn on notifications",
    ),
    "notificationsSettingsDisabledMessage": MessageLookupByLibrary.simpleMessage(
      "Notifications stay off for now. You can enable them later from settings.",
    ),
    "notificationsSettingsEnabledMessage": MessageLookupByLibrary.simpleMessage(
      "Notifications are enabled for this device.",
    ),
    "notificationsSettingsEntryDescription":
        MessageLookupByLibrary.simpleMessage(
          "Manage permission status and open your notification inbox.",
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
      "Review this trip before booking.",
    ),
    "oneOffTripDetailTitle": m11,
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
    "openNotificationsAction": MessageLookupByLibrary.simpleMessage(
      "Open notifications",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Follow the payment steps, upload proof, and track the review status.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Payment"),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "Payment instructions",
    ),
    "paymentProofAlreadyReviewedMessage": MessageLookupByLibrary.simpleMessage(
      "This payment proof has already been reviewed.",
    ),
    "paymentProofAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Submitted amount",
    ),
    "paymentProofApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Payment confirmed.",
    ),
    "paymentProofDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Decision note",
    ),
    "paymentProofEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Upload a payment proof after completing your external payment.",
    ),
    "paymentProofExactAmountRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "The verified payment amount must match the booking total exactly.",
        ),
    "paymentProofLatestTitle": MessageLookupByLibrary.simpleMessage(
      "Latest submitted proof",
    ),
    "paymentProofPendingWindowMessage": MessageLookupByLibrary.simpleMessage(
      "Payment proof can only be submitted while payment is still pending.",
    ),
    "paymentProofReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Submitted reference",
    ),
    "paymentProofRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "Payment proof rejected.",
    ),
    "paymentProofRejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Rejection reason",
    ),
    "paymentProofRejectionReasonRequiredMessage":
        MessageLookupByLibrary.simpleMessage("A rejection reason is required."),
    "paymentProofResubmitAction": MessageLookupByLibrary.simpleMessage(
      "Resubmit payment proof",
    ),
    "paymentProofSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Payment proof",
    ),
    "paymentProofStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Proof status",
    ),
    "paymentProofStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "Pending review",
    ),
    "paymentProofStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "paymentProofStatusVerifiedLabel": MessageLookupByLibrary.simpleMessage(
      "Verified",
    ),
    "paymentProofUploadAction": MessageLookupByLibrary.simpleMessage(
      "Upload payment proof",
    ),
    "paymentProofUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Payment proof received.",
    ),
    "paymentProofVerifiedAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Verified amount",
    ),
    "paymentProofVerifiedReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Verified reference",
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
      "Add and manage the accounts where you receive payouts.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Payout accounts",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Add a phone number to keep using FleetFill.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Save phone number",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Phone number saved.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Add phone number",
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
      "Add your details so customers, carriers, and support can reach you.",
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
      "View the payment proof for this booking here or open it in another app.",
    ),
    "proofViewerTitle": m12,
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
    "ratingCommentLabel": MessageLookupByLibrary.simpleMessage(
      "Review comment",
    ),
    "ratingSubmitAction": MessageLookupByLibrary.simpleMessage("Submit review"),
    "ratingSubmittedMessage": MessageLookupByLibrary.simpleMessage(
      "Carrier review submitted.",
    ),
    "retryLabel": MessageLookupByLibrary.simpleMessage("Retry"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publish trips, manage bookings, and keep verification moving.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Continue as a carrier",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choose how you want to use FleetFill. This sets up the right tools for your account.",
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
    "routeDestinationWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Destination wilaya",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review this route before booking.",
    ),
    "routeDetailTitle": m13,
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
    "routeOriginWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Origin wilaya",
    ),
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
      "Choose a shipment and date to find matching trips.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No result matches the current sort and filter selection.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Search"),
    "searchTripsNearestDateMessage": m14,
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
      "Create a shipment before searching for matching trips.",
    ),
    "searchTripsResultsTitle": m15,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage("Search trips"),
    "settingsAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Account",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Manage your language, appearance, notifications, and support options.",
    ),
    "settingsSignOutAction": MessageLookupByLibrary.simpleMessage("Sign out"),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "You have been signed out.",
    ),
    "settingsThemeModeDarkLabel": MessageLookupByLibrary.simpleMessage("Dark"),
    "settingsThemeModeLightLabel": MessageLookupByLibrary.simpleMessage(
      "Light",
    ),
    "settingsThemeModeSystemLabel": MessageLookupByLibrary.simpleMessage(
      "System",
    ),
    "settingsThemeModeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "This feature is on the way.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Coming soon",
    ),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage(
      "Create shipment",
    ),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Create shipment",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Delete shipment",
    ),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Delete this shipment?",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Shipment removed.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Shipment details",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review the route, weight, volume, and shipment details.",
    ),
    "shipmentDetailTitle": m16,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage("Edit shipment"),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage("Edit shipment"),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage("Save shipment"),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Shipment saved.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage("Booked"),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage("Draft"),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Create a shipment draft before searching exact capacity.",
    ),
    "shipperHomeActiveBookingsLabel": MessageLookupByLibrary.simpleMessage(
      "Active bookings",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Track active bookings, check updates, and jump to your most-used actions.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "shipperHomeNoRecentNotificationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Your latest updates will appear here.",
        ),
    "shipperHomeQuickActionsTitle": MessageLookupByLibrary.simpleMessage(
      "Quick actions",
    ),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage("Shipper home"),
    "shipperHomeUnreadNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Unread notifications",
    ),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Manage your contact details, settings, and support options.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "shipperProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Shipper details",
    ),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Shipper profile",
    ),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "Getting FleetFill ready for you.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Getting ready"),
    "startupConfigurationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill is not available right now. Please try again later.",
    ),
    "startupConfigurationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "FleetFill is unavailable",
    ),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage(
      "Needs review",
    ),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Ready"),
    "supportConfiguredEmailMessage": m17,
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Send a question, report a problem, or ask for help with a booking or payment.",
    ),
    "supportMessageLabel": MessageLookupByLibrary.simpleMessage(
      "Support message",
    ),
    "supportMessageSentMessage": MessageLookupByLibrary.simpleMessage(
      "Support message sent.",
    ),
    "supportReferenceHintMessage": MessageLookupByLibrary.simpleMessage(
      "Include any booking ID, tracking number, or payment reference that can help support investigate faster.",
    ),
    "supportSendAction": MessageLookupByLibrary.simpleMessage("Send message"),
    "supportSubjectLabel": MessageLookupByLibrary.simpleMessage(
      "Support subject",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Your account is currently suspended. Contact FleetFill support by email.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Account suspended"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Follow delivery progress, confirm delivery, open a dispute, or leave a review.",
    ),
    "trackingDetailTitle": m18,
    "trackingEventCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Cancelled",
    ),
    "trackingEventCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Completed",
    ),
    "trackingEventConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmed",
    ),
    "trackingEventDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Delivered pending review"),
    "trackingEventDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Disputed",
    ),
    "trackingEventInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "In transit",
    ),
    "trackingEventPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("Payment under review"),
    "trackingEventPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Picked up",
    ),
    "trackingTimelineEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "No tracking events are available yet.",
    ),
    "trackingTimelineTitle": MessageLookupByLibrary.simpleMessage(
      "Tracking timeline",
    ),
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "Update FleetFill to keep using the latest supported version.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Update required",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Review account details, bookings, vehicles, and documents.",
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
      "Keep vehicle details up to date before publishing trips.",
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
    "vehicleVerificationRejectedBanner": m19,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Add and manage the vehicles you use for transport.",
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
        MessageLookupByLibrary.simpleMessage("Your document is ready to open."),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Uploaded and waiting for admin review.",
    ),
    "verificationDocumentRejectedMessage": m20,
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
    "welcomeBackAction": MessageLookupByLibrary.simpleMessage("Back"),
    "welcomeCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publish availability and review matching shipments.",
    ),
    "welcomeCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Have transport capacity",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill connects shipments with available transport.",
    ),
    "welcomeExactMatchDescription": MessageLookupByLibrary.simpleMessage(
      "Search and posting tools connect the right route and date.",
    ),
    "welcomeExactMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Match shipments and transport",
    ),
    "welcomeHighlightsMessage": MessageLookupByLibrary.simpleMessage(
      "Match shipments, confirm payment proof, and follow delivery updates in one place.",
    ),
    "welcomeLanguageAction": MessageLookupByLibrary.simpleMessage(
      "Choose language",
    ),
    "welcomeLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the app language for your account. You can change it later in Settings.",
    ),
    "welcomeLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Choose your language",
    ),
    "welcomeNextAction": MessageLookupByLibrary.simpleMessage("Next"),
    "welcomePaymentDescription": MessageLookupByLibrary.simpleMessage(
      "Payment proof and booking updates stay visible from start to delivery.",
    ),
    "welcomePaymentTitle": MessageLookupByLibrary.simpleMessage(
      "Keep every booking clear",
    ),
    "welcomeShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Create a shipment and review matching transport options.",
    ),
    "welcomeShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Need to move goods",
    ),
    "welcomeSkipAction": MessageLookupByLibrary.simpleMessage("Skip"),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Move goods or offer transport",
    ),
    "welcomeTrackingDescription": MessageLookupByLibrary.simpleMessage(
      "Follow clear status updates from booking to delivery without fake live maps.",
    ),
    "welcomeTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Simple milestone tracking",
    ),
    "welcomeTrustDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill keeps matching and booking updates clear for both sides.",
    ),
    "welcomeTrustTitle": MessageLookupByLibrary.simpleMessage("How it works"),
  };
}
