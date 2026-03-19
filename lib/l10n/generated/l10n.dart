// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FleetFill`
  String get appTitle {
    return Intl.message('FleetFill', name: 'appTitle', desc: '', args: []);
  }

  /// `Review the latest sensitive admin actions and their outcomes.`
  String get adminAuditLogDescription {
    return Intl.message(
      'Review the latest sensitive admin actions and their outcomes.',
      name: 'adminAuditLogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Admin audit log`
  String get adminAuditLogTitle {
    return Intl.message(
      'Admin audit log',
      name: 'adminAuditLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monitor queue health, alerts, and the current operational backlog.`
  String get adminDashboardDescription {
    return Intl.message(
      'Monitor queue health, alerts, and the current operational backlog.',
      name: 'adminDashboardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get adminDashboardNavLabel {
    return Intl.message(
      'Dashboard',
      name: 'adminDashboardNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Admin dashboard`
  String get adminDashboardTitle {
    return Intl.message(
      'Admin dashboard',
      name: 'adminDashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review payments, verification, disputes, payouts, and email work from one queue hub.`
  String get adminQueuesDescription {
    return Intl.message(
      'Review payments, verification, disputes, payouts, and email work from one queue hub.',
      name: 'adminQueuesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Queues`
  String get adminQueuesNavLabel {
    return Intl.message(
      'Queues',
      name: 'adminQueuesNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Admin queues`
  String get adminQueuesTitle {
    return Intl.message(
      'Admin queues',
      name: 'adminQueuesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get adminVerificationApproveAction {
    return Intl.message(
      'Approve',
      name: 'adminVerificationApproveAction',
      desc: '',
      args: [],
    );
  }

  /// `Approve all`
  String get adminVerificationApproveAllAction {
    return Intl.message(
      'Approve all',
      name: 'adminVerificationApproveAllAction',
      desc: '',
      args: [],
    );
  }

  /// `Verification packet approved.`
  String get adminVerificationApproveAllSuccess {
    return Intl.message(
      'Verification packet approved.',
      name: 'adminVerificationApproveAllSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Verification document approved.`
  String get adminVerificationApprovedMessage {
    return Intl.message(
      'Verification document approved.',
      name: 'adminVerificationApprovedMessage',
      desc: '',
      args: [],
    );
  }

  /// `No recent verification audit items yet.`
  String get adminVerificationAuditEmptyMessage {
    return Intl.message(
      'No recent verification audit items yet.',
      name: 'adminVerificationAuditEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verification audit`
  String get adminVerificationAuditTitle {
    return Intl.message(
      'Verification audit',
      name: 'adminVerificationAuditTitle',
      desc: '',
      args: [],
    );
  }

  /// `No submitted verification documents yet.`
  String get adminVerificationMissingDocumentsMessage {
    return Intl.message(
      'No submitted verification documents yet.',
      name: 'adminVerificationMissingDocumentsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Review profile and vehicle documents together before approving operational access.`
  String get adminVerificationPacketDescription {
    return Intl.message(
      'Review profile and vehicle documents together before approving operational access.',
      name: 'adminVerificationPacketDescription',
      desc: '',
      args: [],
    );
  }

  /// `Verification packet`
  String get adminVerificationPacketTitle {
    return Intl.message(
      'Verification packet',
      name: 'adminVerificationPacketTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pending documents`
  String get adminVerificationPendingDocumentsLabel {
    return Intl.message(
      'Pending documents',
      name: 'adminVerificationPendingDocumentsLabel',
      desc: '',
      args: [],
    );
  }

  /// `No carrier verification packets need review right now.`
  String get adminVerificationQueueEmptyMessage {
    return Intl.message(
      'No carrier verification packets need review right now.',
      name: 'adminVerificationQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verification queue summary`
  String get adminVerificationQueueSummaryTitle {
    return Intl.message(
      'Verification queue summary',
      name: 'adminVerificationQueueSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Carrier verification queue`
  String get adminVerificationQueueTitle {
    return Intl.message(
      'Carrier verification queue',
      name: 'adminVerificationQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get adminVerificationRejectAction {
    return Intl.message(
      'Reject',
      name: 'adminVerificationRejectAction',
      desc: '',
      args: [],
    );
  }

  /// `Verification document rejected.`
  String get adminVerificationRejectedMessage {
    return Intl.message(
      'Verification document rejected.',
      name: 'adminVerificationRejectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Add the reason the carrier should see.`
  String get adminVerificationRejectReasonHint {
    return Intl.message(
      'Add the reason the carrier should see.',
      name: 'adminVerificationRejectReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Rejection reason`
  String get adminVerificationRejectReasonTitle {
    return Intl.message(
      'Rejection reason',
      name: 'adminVerificationRejectReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `{documentCount} pending documents across {vehicleCount} vehicles`
  String adminVerificationQueueItemSubtitle(
    Object documentCount,
    Object vehicleCount,
  ) {
    return Intl.message(
      '$documentCount pending documents across $vehicleCount vehicles',
      name: 'adminVerificationQueueItemSubtitle',
      desc: '',
      args: [documentCount, vehicleCount],
    );
  }

  /// `Manage platform settings, maintenance controls, version policy, and monitoring summaries.`
  String get adminSettingsDescription {
    return Intl.message(
      'Manage platform settings, maintenance controls, version policy, and monitoring summaries.',
      name: 'adminSettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get adminSettingsNavLabel {
    return Intl.message(
      'Settings',
      name: 'adminSettingsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Admin settings`
  String get adminSettingsTitle {
    return Intl.message(
      'Admin settings',
      name: 'adminSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for users and review account details when operations need context.`
  String get adminUsersDescription {
    return Intl.message(
      'Search for users and review account details when operations need context.',
      name: 'adminUsersDescription',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get adminUsersNavLabel {
    return Intl.message(
      'Users',
      name: 'adminUsersNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get adminUsersTitle {
    return Intl.message('Users', name: 'adminUsersTitle', desc: '', args: []);
  }

  /// `Your account was created. Continue by signing in.`
  String get authAccountCreatedMessage {
    return Intl.message(
      'Your account was created. Continue by signing in.',
      name: 'authAccountCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get authConfirmPasswordLabel {
    return Intl.message(
      'Confirm password',
      name: 'authConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get authCreateAccountAction {
    return Intl.message(
      'Create account',
      name: 'authCreateAccountAction',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get authCreateAccountCta {
    return Intl.message(
      'Create a new account',
      name: 'authCreateAccountCta',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue this action.`
  String get authAuthenticationRequiredMessage {
    return Intl.message(
      'Sign in to continue this action.',
      name: 'authAuthenticationRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `you@example.com`
  String get authEmailHint {
    return Intl.message(
      'you@example.com',
      name: 'authEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get authEmailLabel {
    return Intl.message(
      'Email address',
      name: 'authEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your email before signing in.`
  String get authEmailNotConfirmedMessage {
    return Intl.message(
      'Confirm your email before signing in.',
      name: 'authEmailNotConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get authForgotPasswordCta {
    return Intl.message(
      'Forgot your password?',
      name: 'authForgotPasswordCta',
      desc: '',
      args: [],
    );
  }

  /// `Request a password reset link for your FleetFill account.`
  String get authForgotPasswordDescription {
    return Intl.message(
      'Request a password reset link for your FleetFill account.',
      name: 'authForgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get authForgotPasswordTitle {
    return Intl.message(
      'Forgot password',
      name: 'authForgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill could not complete this auth request.`
  String get authGenericErrorMessage {
    return Intl.message(
      'FleetFill could not complete this auth request.',
      name: 'authGenericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get authGoogleAction {
    return Intl.message(
      'Continue with Google',
      name: 'authGoogleAction',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in is not available in this environment.`
  String get authGoogleUnavailableMessage {
    return Intl.message(
      'Google sign-in is not available in this environment.',
      name: 'authGoogleUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in started. Return here after approval.`
  String get authGoogleStartedMessage {
    return Intl.message(
      'Google sign-in started. Return here after approval.',
      name: 'authGoogleStartedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Keep me signed in`
  String get authKeepSignedInLabel {
    return Intl.message(
      'Keep me signed in',
      name: 'authKeepSignedInLabel',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Sign in`
  String get authHaveAccountCta {
    return Intl.message(
      'Already have an account? Sign in',
      name: 'authHaveAccountCta',
      desc: '',
      args: [],
    );
  }

  /// `Check your email and password, then try again.`
  String get authInvalidCredentialsMessage {
    return Intl.message(
      'Check your email and password, then try again.',
      name: 'authInvalidCredentialsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address.`
  String get authInvalidEmailMessage {
    return Intl.message(
      'Enter a valid email address.',
      name: 'authInvalidEmailMessage',
      desc: '',
      args: [],
    );
  }

  /// `Network issue detected. Try again in a moment.`
  String get authNetworkErrorMessage {
    return Intl.message(
      'Network issue detected. Try again in a moment.',
      name: 'authNetworkErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get authNewPasswordLabel {
    return Intl.message(
      'New password',
      name: 'authNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPasswordLabel {
    return Intl.message(
      'Password',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get authPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'authPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Create a strong password`
  String get authCreatePasswordHint {
    return Intl.message(
      'Create a strong password',
      name: 'authCreatePasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Repeat your password`
  String get authConfirmPasswordHint {
    return Intl.message(
      'Repeat your password',
      name: 'authConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Use at least 8 characters.`
  String get authPasswordMinLengthMessage {
    return Intl.message(
      'Use at least 8 characters.',
      name: 'authPasswordMinLengthMessage',
      desc: '',
      args: [],
    );
  }

  /// `The passwords do not match.`
  String get authPasswordMismatchMessage {
    return Intl.message(
      'The passwords do not match.',
      name: 'authPasswordMismatchMessage',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill will send a reset link to the email address on file.`
  String get authPasswordResetInfoMessage {
    return Intl.message(
      'FleetFill will send a reset link to the email address on file.',
      name: 'authPasswordResetInfoMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your password was updated.`
  String get authPasswordUpdatedMessage {
    return Intl.message(
      'Your password was updated.',
      name: 'authPasswordUpdatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `This field is required.`
  String get authRequiredFieldMessage {
    return Intl.message(
      'This field is required.',
      name: 'authRequiredFieldMessage',
      desc: '',
      args: [],
    );
  }

  /// `Password reset instructions were sent.`
  String get authResetEmailSentMessage {
    return Intl.message(
      'Password reset instructions were sent.',
      name: 'authResetEmailSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password after opening your secure recovery link.`
  String get authResetPasswordDescription {
    return Intl.message(
      'Set a new password after opening your secure recovery link.',
      name: 'authResetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get authResetPasswordTitle {
    return Intl.message(
      'Reset password',
      name: 'authResetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open this screen from the password recovery link to set a new password.`
  String get authResetPasswordUnavailableMessage {
    return Intl.message(
      'Open this screen from the password recovery link to set a new password.',
      name: 'authResetPasswordUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send reset link`
  String get authSendResetAction {
    return Intl.message(
      'Send reset link',
      name: 'authSendResetAction',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get authContinueWithLabel {
    return Intl.message(
      'or continue with',
      name: 'authContinueWithLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign in again`
  String get authSessionExpiredAction {
    return Intl.message(
      'Sign in again',
      name: 'authSessionExpiredAction',
      desc: '',
      args: [],
    );
  }

  /// `Your session ended. Sign in again to continue safely.`
  String get authSessionExpiredMessage {
    return Intl.message(
      'Your session ended. Sign in again to continue safely.',
      name: 'authSessionExpiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Session expired`
  String get authSessionExpiredTitle {
    return Intl.message(
      'Session expired',
      name: 'authSessionExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get authSignInAction {
    return Intl.message(
      'Sign in',
      name: 'authSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with your email and password, or continue with Google when available.`
  String get authSignInDescription {
    return Intl.message(
      'Sign in with your email and password, or continue with Google when available.',
      name: 'authSignInDescription',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully.`
  String get authSignInSuccess {
    return Intl.message(
      'Signed in successfully.',
      name: 'authSignInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get authSignInTitle {
    return Intl.message('Sign in', name: 'authSignInTitle', desc: '', args: []);
  }

  /// `Create your FleetFill account to start shipping or publishing capacity.`
  String get authSignUpDescription {
    return Intl.message(
      'Create your FleetFill account to start shipping or publishing capacity.',
      name: 'authSignUpDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get authSignUpTitle {
    return Intl.message(
      'Create account',
      name: 'authSignUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update password`
  String get authUpdatePasswordAction {
    return Intl.message(
      'Update password',
      name: 'authUpdatePasswordAction',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists for this email.`
  String get authUserAlreadyRegisteredMessage {
    return Intl.message(
      'An account already exists for this email.',
      name: 'authUserAlreadyRegisteredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Check your email to confirm the account before signing in.`
  String get authVerificationEmailSentMessage {
    return Intl.message(
      'Check your email to confirm the account before signing in.',
      name: 'authVerificationEmailSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shared booking detail routes sit above role shells.`
  String get bookingDetailDescription {
    return Intl.message(
      'Shared booking detail routes sit above role shells.',
      name: 'bookingDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Booking {bookingId}`
  String bookingDetailTitle(Object bookingId) {
    return Intl.message(
      'Booking $bookingId',
      name: 'bookingDetailTitle',
      desc: '',
      args: [bookingId],
    );
  }

  /// `Carrier reputation, trip detail, and pricing review live here before payment.`
  String get bookingReviewDescription {
    return Intl.message(
      'Carrier reputation, trip detail, and pricing review live here before payment.',
      name: 'bookingReviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Booking review`
  String get bookingReviewTitle {
    return Intl.message(
      'Booking review',
      name: 'bookingReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message('Cancel', name: 'cancelLabel', desc: '', args: []);
  }

  /// `Active and historical booking worklists live in this branch.`
  String get carrierBookingsDescription {
    return Intl.message(
      'Active and historical booking worklists live in this branch.',
      name: 'carrierBookingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Bookings`
  String get carrierBookingsNavLabel {
    return Intl.message(
      'Bookings',
      name: 'carrierBookingsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier bookings`
  String get carrierBookingsTitle {
    return Intl.message(
      'Carrier bookings',
      name: 'carrierBookingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verification, trips, booking actions, and payout reminders live here.`
  String get carrierHomeDescription {
    return Intl.message(
      'Verification, trips, booking actions, and payout reminders live here.',
      name: 'carrierHomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get carrierHomeNavLabel {
    return Intl.message(
      'Home',
      name: 'carrierHomeNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier home`
  String get carrierHomeTitle {
    return Intl.message(
      'Carrier home',
      name: 'carrierHomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Carrier verification status, payout reminders, and profile tools live here.`
  String get carrierProfileDescription {
    return Intl.message(
      'Carrier verification status, payout reminders, and profile tools live here.',
      name: 'carrierProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get carrierProfileNavLabel {
    return Intl.message(
      'Profile',
      name: 'carrierProfileNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier details`
  String get carrierProfileSectionTitle {
    return Intl.message(
      'Carrier details',
      name: 'carrierProfileSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get carrierProfileVerificationLabel {
    return Intl.message(
      'Verification',
      name: 'carrierProfileVerificationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get carrierProfileVerificationPending {
    return Intl.message(
      'Pending',
      name: 'carrierProfileVerificationPending',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get carrierProfileVerificationRejected {
    return Intl.message(
      'Rejected',
      name: 'carrierProfileVerificationRejected',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get carrierProfileVerificationVerified {
    return Intl.message(
      'Verified',
      name: 'carrierProfileVerificationVerified',
      desc: '',
      args: [],
    );
  }

  /// `Carrier profile`
  String get carrierProfileTitle {
    return Intl.message(
      'Carrier profile',
      name: 'carrierProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload and replace profile or vehicle verification documents from one place.`
  String get carrierVerificationCenterDescription {
    return Intl.message(
      'Upload and replace profile or vehicle verification documents from one place.',
      name: 'carrierVerificationCenterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Verification center`
  String get carrierVerificationCenterTitle {
    return Intl.message(
      'Verification center',
      name: 'carrierVerificationCenterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your verification packet is under review. Upload any missing documents to keep approval moving.`
  String get carrierVerificationPendingBanner {
    return Intl.message(
      'Your verification packet is under review. Upload any missing documents to keep approval moving.',
      name: 'carrierVerificationPendingBanner',
      desc: '',
      args: [],
    );
  }

  /// `Verification requirements and missing documents stay grouped under your profile branch.`
  String get carrierVerificationQueueHint {
    return Intl.message(
      'Verification requirements and missing documents stay grouped under your profile branch.',
      name: 'carrierVerificationQueueHint',
      desc: '',
      args: [],
    );
  }

  /// `Verification needs attention: {reason}`
  String carrierVerificationRejectedBanner(Object reason) {
    return Intl.message(
      'Verification needs attention: $reason',
      name: 'carrierVerificationRejectedBanner',
      desc: '',
      args: [reason],
    );
  }

  /// `Verification summary`
  String get carrierVerificationSummaryTitle {
    return Intl.message(
      'Verification summary',
      name: 'carrierVerificationSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage trucks, upload missing documents, and resolve verification blockers.`
  String get carrierVehiclesShortcutDescription {
    return Intl.message(
      'Manage trucks, upload missing documents, and resolve verification blockers.',
      name: 'carrierVehiclesShortcutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Recent comments`
  String get carrierPublicProfileCommentsTitle {
    return Intl.message(
      'Recent comments',
      name: 'carrierPublicProfileCommentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review this carrier's public reputation, comments, and verification status.`
  String get carrierPublicProfileDescription {
    return Intl.message(
      'Review this carrier\'s public reputation, comments, and verification status.',
      name: 'carrierPublicProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `No review comments are visible yet.`
  String get carrierPublicProfileNoCommentsMessage {
    return Intl.message(
      'No review comments are visible yet.',
      name: 'carrierPublicProfileNoCommentsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Average rating`
  String get carrierPublicProfileRatingLabel {
    return Intl.message(
      'Average rating',
      name: 'carrierPublicProfileRatingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Review count`
  String get carrierPublicProfileReviewCountLabel {
    return Intl.message(
      'Review count',
      name: 'carrierPublicProfileReviewCountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier summary`
  String get carrierPublicProfileSummaryTitle {
    return Intl.message(
      'Carrier summary',
      name: 'carrierPublicProfileSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Carrier {carrierId}`
  String carrierPublicProfileTitle(Object carrierId) {
    return Intl.message(
      'Carrier $carrierId',
      name: 'carrierPublicProfileTitle',
      desc: '',
      args: [carrierId],
    );
  }

  /// `Confirm`
  String get confirmLabel {
    return Intl.message('Confirm', name: 'confirmLabel', desc: '', args: []);
  }

  /// `Open this document in your secure viewer when access is ready.`
  String get documentViewerDescription {
    return Intl.message(
      'Open this document in your secure viewer when access is ready.',
      name: 'documentViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Open Document`
  String get documentViewerOpenAction {
    return Intl.message(
      'Open Document',
      name: 'documentViewerOpenAction',
      desc: '',
      args: [],
    );
  }

  /// `Document {documentId}`
  String documentViewerTitle(Object documentId) {
    return Intl.message(
      'Document $documentId',
      name: 'documentViewerTitle',
      desc: '',
      args: [documentId],
    );
  }

  /// `Secure document access is temporarily unavailable.`
  String get documentViewerUnavailableMessage {
    return Intl.message(
      'Secure document access is temporarily unavailable.',
      name: 'documentViewerUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Update your carrier contact and company details.`
  String get editCarrierProfileDescription {
    return Intl.message(
      'Update your carrier contact and company details.',
      name: 'editCarrierProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Carrier profile updated.`
  String get editCarrierProfileSavedMessage {
    return Intl.message(
      'Carrier profile updated.',
      name: 'editCarrierProfileSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit carrier profile`
  String get editCarrierProfileTitle {
    return Intl.message(
      'Edit carrier profile',
      name: 'editCarrierProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update your shipper contact details.`
  String get editShipperProfileDescription {
    return Intl.message(
      'Update your shipper contact details.',
      name: 'editShipperProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Shipper profile updated.`
  String get editShipperProfileSavedMessage {
    return Intl.message(
      'Shipper profile updated.',
      name: 'editShipperProfileSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit shipper profile`
  String get editShipperProfileTitle {
    return Intl.message(
      'Edit shipper profile',
      name: 'editShipperProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorTitle {
    return Intl.message(
      'Something went wrong',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `This area is not available for your account.`
  String get forbiddenMessage {
    return Intl.message(
      'This area is not available for your account.',
      name: 'forbiddenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Access restricted`
  String get forbiddenTitle {
    return Intl.message(
      'Access restricted',
      name: 'forbiddenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Re-authenticate recently before opening this sensitive admin surface.`
  String get forbiddenAdminStepUpMessage {
    return Intl.message(
      'Re-authenticate recently before opening this sensitive admin surface.',
      name: 'forbiddenAdminStepUpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Open generated invoices and receipts from a secure shared route.`
  String get generatedDocumentViewerDescription {
    return Intl.message(
      'Open generated invoices and receipts from a secure shared route.',
      name: 'generatedDocumentViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Generated document {documentId}`
  String generatedDocumentViewerTitle(Object documentId) {
    return Intl.message(
      'Generated document $documentId',
      name: 'generatedDocumentViewerTitle',
      desc: '',
      args: [documentId],
    );
  }

  /// `Arabic`
  String get languageOptionArabic {
    return Intl.message(
      'Arabic',
      name: 'languageOptionArabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languageOptionEnglish {
    return Intl.message(
      'English',
      name: 'languageOptionEnglish',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get languageOptionFrench {
    return Intl.message(
      'French',
      name: 'languageOptionFrench',
      desc: '',
      args: [],
    );
  }

  /// `Current language: {languageCode}`
  String languageSelectionCurrentMessage(Object languageCode) {
    return Intl.message(
      'Current language: $languageCode',
      name: 'languageSelectionCurrentMessage',
      desc: '',
      args: [languageCode],
    );
  }

  /// `FleetFill is preparing your workspace.`
  String get loadingMessage {
    return Intl.message(
      'FleetFill is preparing your workspace.',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loadingTitle {
    return Intl.message('Loading', name: 'loadingTitle', desc: '', args: []);
  }

  /// `FleetFill is temporarily unavailable while maintenance is in progress.`
  String get maintenanceDescription {
    return Intl.message(
      'FleetFill is temporarily unavailable while maintenance is in progress.',
      name: 'maintenanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance mode`
  String get maintenanceTitle {
    return Intl.message(
      'Maintenance mode',
      name: 'maintenanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Guide the user back to media access when they need to upload proof or documents.`
  String get mediaUploadPermissionDescription {
    return Intl.message(
      'Guide the user back to media access when they need to upload proof or documents.',
      name: 'mediaUploadPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Media upload permission`
  String get mediaUploadPermissionTitle {
    return Intl.message(
      'Media upload permission',
      name: 'mediaUploadPermissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pricing summary`
  String get moneySummaryTitle {
    return Intl.message(
      'Pricing summary',
      name: 'moneySummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recurring routes and one-off trips stay grouped in one branch.`
  String get myRoutesDescription {
    return Intl.message(
      'Recurring routes and one-off trips stay grouped in one branch.',
      name: 'myRoutesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Routes`
  String get myRoutesNavLabel {
    return Intl.message('Routes', name: 'myRoutesNavLabel', desc: '', args: []);
  }

  /// `My routes`
  String get myRoutesTitle {
    return Intl.message('My routes', name: 'myRoutesTitle', desc: '', args: []);
  }

  /// `Active, history, and draft shipment states stay inside this branch.`
  String get myShipmentsDescription {
    return Intl.message(
      'Active, history, and draft shipment states stay inside this branch.',
      name: 'myShipmentsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Shipments`
  String get myShipmentsNavLabel {
    return Intl.message(
      'Shipments',
      name: 'myShipmentsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `My shipments`
  String get myShipmentsTitle {
    return Intl.message(
      'My shipments',
      name: 'myShipmentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No exact route is available for this search yet.`
  String get noExactResultsMessage {
    return Intl.message(
      'No exact route is available for this search yet.',
      name: 'noExactResultsMessage',
      desc: '',
      args: [],
    );
  }

  /// `No exact route found`
  String get noExactResultsTitle {
    return Intl.message(
      'No exact route found',
      name: 'noExactResultsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review the full details for this notification.`
  String get notificationDetailDescription {
    return Intl.message(
      'Review the full details for this notification.',
      name: 'notificationDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notification {notificationId}`
  String notificationDetailTitle(Object notificationId) {
    return Intl.message(
      'Notification $notificationId',
      name: 'notificationDetailTitle',
      desc: '',
      args: [notificationId],
    );
  }

  /// `Review recent alerts, booking updates, and operational reminders.`
  String get notificationsCenterDescription {
    return Intl.message(
      'Review recent alerts, booking updates, and operational reminders.',
      name: 'notificationsCenterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsCenterTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsCenterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explain why tracking and booking updates matter before opening system settings.`
  String get notificationsPermissionDescription {
    return Intl.message(
      'Explain why tracking and booking updates matter before opening system settings.',
      name: 'notificationsPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notifications permission`
  String get notificationsPermissionTitle {
    return Intl.message(
      'Notifications permission',
      name: 'notificationsPermissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `The requested page or entity could not be found.`
  String get notFoundMessage {
    return Intl.message(
      'The requested page or entity could not be found.',
      name: 'notFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get notFoundTitle {
    return Intl.message('Not found', name: 'notFoundTitle', desc: '', args: []);
  }

  /// `You are offline. Some actions are temporarily unavailable.`
  String get offlineMessage {
    return Intl.message(
      'You are offline. Some actions are temporarily unavailable.',
      name: 'offlineMessage',
      desc: '',
      args: [],
    );
  }

  /// `Review this one-off trip before booking or operational follow-up.`
  String get oneOffTripDetailDescription {
    return Intl.message(
      'Review this one-off trip before booking or operational follow-up.',
      name: 'oneOffTripDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip {tripId}`
  String oneOffTripDetailTitle(Object tripId) {
    return Intl.message(
      'One-off trip $tripId',
      name: 'oneOffTripDetailTitle',
      desc: '',
      args: [tripId],
    );
  }

  /// `Instructions, reference, proof upload, and payment status remain in one coherent flow.`
  String get paymentFlowDescription {
    return Intl.message(
      'Instructions, reference, proof upload, and payment status remain in one coherent flow.',
      name: 'paymentFlowDescription',
      desc: '',
      args: [],
    );
  }

  /// `Payment flow`
  String get paymentFlowTitle {
    return Intl.message(
      'Payment flow',
      name: 'paymentFlowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Carrier payout accounts stay grouped under the profile branch.`
  String get payoutAccountsDescription {
    return Intl.message(
      'Carrier payout accounts stay grouped under the profile branch.',
      name: 'payoutAccountsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Payout accounts`
  String get payoutAccountsTitle {
    return Intl.message(
      'Payout accounts',
      name: 'payoutAccountsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Operational actions stay gated until a phone number is present.`
  String get phoneCompletionDescription {
    return Intl.message(
      'Operational actions stay gated until a phone number is present.',
      name: 'phoneCompletionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save phone number`
  String get phoneCompletionSaveAction {
    return Intl.message(
      'Save phone number',
      name: 'phoneCompletionSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Phone number saved.`
  String get phoneCompletionSavedMessage {
    return Intl.message(
      'Phone number saved.',
      name: 'phoneCompletionSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Phone completion`
  String get phoneCompletionTitle {
    return Intl.message(
      'Phone completion',
      name: 'phoneCompletionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add your carrier details now, then upload the required verification documents from your profile.`
  String get profileCarrierVerificationHint {
    return Intl.message(
      'Add your carrier details now, then upload the required verification documents from your profile.',
      name: 'profileCarrierVerificationHint',
      desc: '',
      args: [],
    );
  }

  /// `Profile verification documents`
  String get profileVerificationDocumentsTitle {
    return Intl.message(
      'Profile verification documents',
      name: 'profileVerificationDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Company name`
  String get profileCompanyNameLabel {
    return Intl.message(
      'Company name',
      name: 'profileCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get profileFullNameLabel {
    return Intl.message(
      'Full name',
      name: 'profileFullNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get profilePhoneLabel {
    return Intl.message(
      'Phone number',
      name: 'profilePhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Complete the required profile details before using operational features.`
  String get profileSetupDescription {
    return Intl.message(
      'Complete the required profile details before using operational features.',
      name: 'profileSetupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save profile`
  String get profileSetupSaveAction {
    return Intl.message(
      'Save profile',
      name: 'profileSetupSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Profile details saved.`
  String get profileSetupSavedMessage {
    return Intl.message(
      'Profile details saved.',
      name: 'profileSetupSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Profile setup`
  String get profileSetupTitle {
    return Intl.message(
      'Profile setup',
      name: 'profileSetupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open this proof from a secure shared route when access is ready.`
  String get proofViewerDescription {
    return Intl.message(
      'Open this proof from a secure shared route when access is ready.',
      name: 'proofViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Proof {proofId}`
  String proofViewerTitle(Object proofId) {
    return Intl.message(
      'Proof $proofId',
      name: 'proofViewerTitle',
      desc: '',
      args: [proofId],
    );
  }

  /// `Retry`
  String get retryLabel {
    return Intl.message('Retry', name: 'retryLabel', desc: '', args: []);
  }

  /// `Publish trips, manage bookings, and keep verification moving.`
  String get roleSelectionCarrierDescription {
    return Intl.message(
      'Publish trips, manage bookings, and keep verification moving.',
      name: 'roleSelectionCarrierDescription',
      desc: '',
      args: [],
    );
  }

  /// `Continue as a carrier`
  String get roleSelectionCarrierTitle {
    return Intl.message(
      'Continue as a carrier',
      name: 'roleSelectionCarrierTitle',
      desc: '',
      args: [],
    );
  }

  /// `One account selects one role before operational access begins.`
  String get roleSelectionDescription {
    return Intl.message(
      'One account selects one role before operational access begins.',
      name: 'roleSelectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create shipments, compare exact trips, and follow delivery progress.`
  String get roleSelectionShipperDescription {
    return Intl.message(
      'Create shipments, compare exact trips, and follow delivery progress.',
      name: 'roleSelectionShipperDescription',
      desc: '',
      args: [],
    );
  }

  /// `Continue as a shipper`
  String get roleSelectionShipperTitle {
    return Intl.message(
      'Continue as a shipper',
      name: 'roleSelectionShipperTitle',
      desc: '',
      args: [],
    );
  }

  /// `Role selection`
  String get roleSelectionTitle {
    return Intl.message(
      'Role selection',
      name: 'roleSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shared route detail presentation sits above the role shells.`
  String get routeDetailDescription {
    return Intl.message(
      'Shared route detail presentation sits above the role shells.',
      name: 'routeDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Route {routeId}`
  String routeDetailTitle(Object routeId) {
    return Intl.message(
      'Route $routeId',
      name: 'routeDetailTitle',
      desc: '',
      args: [routeId],
    );
  }

  /// `FleetFill could not open this route.`
  String get routeErrorMessage {
    return Intl.message(
      'FleetFill could not open this route.',
      name: 'routeErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `The search form and exact-route results stay on one page with inline states.`
  String get searchTripsDescription {
    return Intl.message(
      'The search form and exact-route results stay on one page with inline states.',
      name: 'searchTripsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchTripsNavLabel {
    return Intl.message(
      'Search',
      name: 'searchTripsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search trips`
  String get searchTripsTitle {
    return Intl.message(
      'Search trips',
      name: 'searchTripsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Base price`
  String get sampleBasePriceLabel {
    return Intl.message(
      'Base price',
      name: 'sampleBasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Platform fee`
  String get samplePlatformFeeLabel {
    return Intl.message(
      'Platform fee',
      name: 'samplePlatformFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get sampleTotalLabel {
    return Intl.message('Total', name: 'sampleTotalLabel', desc: '', args: []);
  }

  /// `Account`
  String get settingsAccountSectionTitle {
    return Intl.message(
      'Account',
      name: 'settingsAccountSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language, theme, support, and notification preferences stay inside shared settings.`
  String get settingsDescription {
    return Intl.message(
      'Language, theme, support, and notification preferences stay inside shared settings.',
      name: 'settingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `You have been signed out.`
  String get settingsSignedOutMessage {
    return Intl.message(
      'You have been signed out.',
      name: 'settingsSignedOutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get settingsSignOutAction {
    return Intl.message(
      'Sign out',
      name: 'settingsSignOutAction',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Shared cards and shells stay consistent across role surfaces.`
  String get sharedScaffoldPreviewMessage {
    return Intl.message(
      'Shared cards and shells stay consistent across role surfaces.',
      name: 'sharedScaffoldPreviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shared foundation preview`
  String get sharedScaffoldPreviewTitle {
    return Intl.message(
      'Shared foundation preview',
      name: 'sharedScaffoldPreviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `DZD 12,500`
  String get sampleBasePriceAmount {
    return Intl.message(
      'DZD 12,500',
      name: 'sampleBasePriceAmount',
      desc: '',
      args: [],
    );
  }

  /// `DZD 1,200`
  String get samplePlatformFeeAmount {
    return Intl.message(
      'DZD 1,200',
      name: 'samplePlatformFeeAmount',
      desc: '',
      args: [],
    );
  }

  /// `DZD 13,700`
  String get sampleTotalAmount {
    return Intl.message(
      'DZD 13,700',
      name: 'sampleTotalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Shipment summary, items, and linked booking summary live here.`
  String get shipmentDetailDescription {
    return Intl.message(
      'Shipment summary, items, and linked booking summary live here.',
      name: 'shipmentDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Shipment {shipmentId}`
  String shipmentDetailTitle(Object shipmentId) {
    return Intl.message(
      'Shipment $shipmentId',
      name: 'shipmentDetailTitle',
      desc: '',
      args: [shipmentId],
    );
  }

  /// `Active bookings, recent notifications, quick actions, and support shortcut live here.`
  String get shipperHomeDescription {
    return Intl.message(
      'Active bookings, recent notifications, quick actions, and support shortcut live here.',
      name: 'shipperHomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get shipperHomeNavLabel {
    return Intl.message(
      'Home',
      name: 'shipperHomeNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Shipper home`
  String get shipperHomeTitle {
    return Intl.message(
      'Shipper home',
      name: 'shipperHomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile, phone, preferences, and support shortcuts stay in one branch.`
  String get shipperProfileDescription {
    return Intl.message(
      'Profile, phone, preferences, and support shortcuts stay in one branch.',
      name: 'shipperProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get shipperProfileNavLabel {
    return Intl.message(
      'Profile',
      name: 'shipperProfileNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Shipper details`
  String get shipperProfileSectionTitle {
    return Intl.message(
      'Shipper details',
      name: 'shipperProfileSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipper profile`
  String get shipperProfileTitle {
    return Intl.message(
      'Shipper profile',
      name: 'shipperProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bootstrap and blocking initialization states start here.`
  String get splashDescription {
    return Intl.message(
      'Bootstrap and blocking initialization states start here.',
      name: 'splashDescription',
      desc: '',
      args: [],
    );
  }

  /// `Splash`
  String get splashTitle {
    return Intl.message('Splash', name: 'splashTitle', desc: '', args: []);
  }

  /// `Needs review`
  String get statusNeedsReviewLabel {
    return Intl.message(
      'Needs review',
      name: 'statusNeedsReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get statusReadyLabel {
    return Intl.message('Ready', name: 'statusReadyLabel', desc: '', args: []);
  }

  /// `Support starts with clear email guidance and structured issue details.`
  String get supportDescription {
    return Intl.message(
      'Support starts with clear email guidance and structured issue details.',
      name: 'supportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get supportTitle {
    return Intl.message('Support', name: 'supportTitle', desc: '', args: []);
  }

  /// `Your account is currently suspended. Contact FleetFill support by email.`
  String get suspendedMessage {
    return Intl.message(
      'Your account is currently suspended. Contact FleetFill support by email.',
      name: 'suspendedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Account suspended`
  String get suspendedTitle {
    return Intl.message(
      'Account suspended',
      name: 'suspendedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tracking timeline, delivery confirmation, dispute, and rating actions stay together here.`
  String get trackingDetailDescription {
    return Intl.message(
      'Tracking timeline, delivery confirmation, dispute, and rating actions stay together here.',
      name: 'trackingDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tracking {bookingId}`
  String trackingDetailTitle(Object bookingId) {
    return Intl.message(
      'Tracking $bookingId',
      name: 'trackingDetailTitle',
      desc: '',
      args: [bookingId],
    );
  }

  /// `Update FleetFill to continue with the latest supported version.`
  String get updateRequiredDescription {
    return Intl.message(
      'Update FleetFill to continue with the latest supported version.',
      name: 'updateRequiredDescription',
      desc: '',
      args: [],
    );
  }

  /// `Update required`
  String get updateRequiredTitle {
    return Intl.message(
      'Update required',
      name: 'updateRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipper and carrier specifics remain section-based inside one user detail view.`
  String get userDetailDescription {
    return Intl.message(
      'Shipper and carrier specifics remain section-based inside one user detail view.',
      name: 'userDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `User detail`
  String get userDetailTitle {
    return Intl.message(
      'User detail',
      name: 'userDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Capacity volume (m3)`
  String get vehicleCapacityVolumeLabel {
    return Intl.message(
      'Capacity volume (m3)',
      name: 'vehicleCapacityVolumeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Capacity weight (kg)`
  String get vehicleCapacityWeightLabel {
    return Intl.message(
      'Capacity weight (kg)',
      name: 'vehicleCapacityWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add vehicle`
  String get vehicleCreateAction {
    return Intl.message(
      'Add vehicle',
      name: 'vehicleCreateAction',
      desc: '',
      args: [],
    );
  }

  /// `Add vehicle`
  String get vehicleCreateTitle {
    return Intl.message(
      'Add vehicle',
      name: 'vehicleCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle added.`
  String get vehicleCreatedMessage {
    return Intl.message(
      'Vehicle added.',
      name: 'vehicleCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete vehicle`
  String get vehicleDeleteAction {
    return Intl.message(
      'Delete vehicle',
      name: 'vehicleDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle removed.`
  String get vehicleDeletedMessage {
    return Intl.message(
      'Vehicle removed.',
      name: 'vehicleDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle details, documents, and verification status appear here.`
  String get vehicleDetailDescription {
    return Intl.message(
      'Vehicle details, documents, and verification status appear here.',
      name: 'vehicleDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle detail`
  String get vehicleDetailTitle {
    return Intl.message(
      'Vehicle detail',
      name: 'vehicleDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit vehicle`
  String get vehicleEditTitle {
    return Intl.message(
      'Edit vehicle',
      name: 'vehicleEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Keep vehicle data current so route and verification flows stay valid.`
  String get vehicleEditorDescription {
    return Intl.message(
      'Keep vehicle data current so route and verification flows stay valid.',
      name: 'vehicleEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Plate number`
  String get vehiclePlateLabel {
    return Intl.message(
      'Plate number',
      name: 'vehiclePlateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter a number greater than zero.`
  String get vehiclePositiveNumberMessage {
    return Intl.message(
      'Enter a number greater than zero.',
      name: 'vehiclePositiveNumberMessage',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle verification needs attention: {reason}`
  String vehicleVerificationRejectedBanner(Object reason) {
    return Intl.message(
      'Vehicle verification needs attention: $reason',
      name: 'vehicleVerificationRejectedBanner',
      desc: '',
      args: [reason],
    );
  }

  /// `Save vehicle`
  String get vehicleSaveAction {
    return Intl.message(
      'Save vehicle',
      name: 'vehicleSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle updated.`
  String get vehicleSavedMessage {
    return Intl.message(
      'Vehicle updated.',
      name: 'vehicleSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle summary`
  String get vehicleSummaryTitle {
    return Intl.message(
      'Vehicle summary',
      name: 'vehicleSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle type`
  String get vehicleTypeLabel {
    return Intl.message(
      'Vehicle type',
      name: 'vehicleTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vehicles remain under the carrier profile branch.`
  String get vehiclesDescription {
    return Intl.message(
      'Vehicles remain under the carrier profile branch.',
      name: 'vehiclesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add a vehicle before you publish capacity or complete full verification.`
  String get vehiclesEmptyMessage {
    return Intl.message(
      'Add a vehicle before you publish capacity or complete full verification.',
      name: 'vehiclesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Vehicles`
  String get vehiclesTitle {
    return Intl.message('Vehicles', name: 'vehiclesTitle', desc: '', args: []);
  }

  /// `Vehicle verification documents`
  String get vehicleVerificationDocumentsTitle {
    return Intl.message(
      'Vehicle verification documents',
      name: 'vehicleVerificationDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Driver identity or license`
  String get verificationDocumentDriverIdentityLabel {
    return Intl.message(
      'Driver identity or license',
      name: 'verificationDocumentDriverIdentityLabel',
      desc: '',
      args: [],
    );
  }

  /// `No file uploaded yet.`
  String get verificationDocumentMissingMessage {
    return Intl.message(
      'No file uploaded yet.',
      name: 'verificationDocumentMissingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Review the rejection reason and upload a replacement.`
  String get verificationDocumentNeedsAttentionMessage {
    return Intl.message(
      'Review the rejection reason and upload a replacement.',
      name: 'verificationDocumentNeedsAttentionMessage',
      desc: '',
      args: [],
    );
  }

  /// `Secure document access prepared.`
  String get verificationDocumentOpenPreparedMessage {
    return Intl.message(
      'Secure document access prepared.',
      name: 'verificationDocumentOpenPreparedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded and waiting for admin review.`
  String get verificationDocumentPendingMessage {
    return Intl.message(
      'Uploaded and waiting for admin review.',
      name: 'verificationDocumentPendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Rejected: {reason}`
  String verificationDocumentRejectedMessage(Object reason) {
    return Intl.message(
      'Rejected: $reason',
      name: 'verificationDocumentRejectedMessage',
      desc: '',
      args: [reason],
    );
  }

  /// `Verification document replaced.`
  String get verificationDocumentReplacedMessage {
    return Intl.message(
      'Verification document replaced.',
      name: 'verificationDocumentReplacedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Transport license`
  String get verificationDocumentTransportLicenseLabel {
    return Intl.message(
      'Transport license',
      name: 'verificationDocumentTransportLicenseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Truck technical inspection`
  String get verificationDocumentTruckInspectionLabel {
    return Intl.message(
      'Truck technical inspection',
      name: 'verificationDocumentTruckInspectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Truck insurance`
  String get verificationDocumentTruckInsuranceLabel {
    return Intl.message(
      'Truck insurance',
      name: 'verificationDocumentTruckInsuranceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Truck registration`
  String get verificationDocumentTruckRegistrationLabel {
    return Intl.message(
      'Truck registration',
      name: 'verificationDocumentTruckRegistrationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verification document uploaded.`
  String get verificationDocumentUploadedMessage {
    return Intl.message(
      'Verification document uploaded.',
      name: 'verificationDocumentUploadedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verified and accepted.`
  String get verificationDocumentVerifiedMessage {
    return Intl.message(
      'Verified and accepted.',
      name: 'verificationDocumentVerifiedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Replace`
  String get verificationReplaceAction {
    return Intl.message(
      'Replace',
      name: 'verificationReplaceAction',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get verificationUploadAction {
    return Intl.message(
      'Upload',
      name: 'verificationUploadAction',
      desc: '',
      args: [],
    );
  }

  /// `Complete the required verification steps before continuing.`
  String get verificationRequiredMessage {
    return Intl.message(
      'Complete the required verification steps before continuing.',
      name: 'verificationRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Verification required`
  String get verificationRequiredTitle {
    return Intl.message(
      'Verification required',
      name: 'verificationRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose the language you want FleetFill to use.`
  String get languageSelectionDescription {
    return Intl.message(
      'Choose the language you want FleetFill to use.',
      name: 'languageSelectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Language selection`
  String get languageSelectionTitle {
    return Intl.message(
      'Language selection',
      name: 'languageSelectionTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
