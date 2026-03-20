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

  /// `FleetFill could not complete this action right now.`
  String get appGenericErrorMessage {
    return Intl.message(
      'FleetFill could not complete this action right now.',
      name: 'appGenericErrorMessage',
      desc: '',
      args: [],
    );
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

  /// `Show password`
  String get authShowPasswordAction {
    return Intl.message(
      'Show password',
      name: 'authShowPasswordAction',
      desc: '',
      args: [],
    );
  }

  /// `Hide password`
  String get authHidePasswordAction {
    return Intl.message(
      'Hide password',
      name: 'authHidePasswordAction',
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

  /// `Add payout account`
  String get payoutAccountAddAction {
    return Intl.message(
      'Add payout account',
      name: 'payoutAccountAddAction',
      desc: '',
      args: [],
    );
  }

  /// `Delete payout account`
  String get payoutAccountDeleteAction {
    return Intl.message(
      'Delete payout account',
      name: 'payoutAccountDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `This payout account cannot be removed right now.`
  String get payoutAccountDeleteBlockedMessage {
    return Intl.message(
      'This payout account cannot be removed right now.',
      name: 'payoutAccountDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Remove this payout account from FleetFill?`
  String get payoutAccountDeleteConfirmationMessage {
    return Intl.message(
      'Remove this payout account from FleetFill?',
      name: 'payoutAccountDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payout account removed.`
  String get payoutAccountDeletedMessage {
    return Intl.message(
      'Payout account removed.',
      name: 'payoutAccountDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Edit payout account`
  String get payoutAccountEditAction {
    return Intl.message(
      'Edit payout account',
      name: 'payoutAccountEditAction',
      desc: '',
      args: [],
    );
  }

  /// `Account holder name`
  String get payoutAccountHolderLabel {
    return Intl.message(
      'Account holder name',
      name: 'payoutAccountHolderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Account number or identifier`
  String get payoutAccountIdentifierLabel {
    return Intl.message(
      'Account number or identifier',
      name: 'payoutAccountIdentifierLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bank or CCP name`
  String get payoutAccountInstitutionLabel {
    return Intl.message(
      'Bank or CCP name',
      name: 'payoutAccountInstitutionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save payout account`
  String get payoutAccountSaveAction {
    return Intl.message(
      'Save payout account',
      name: 'payoutAccountSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Payout account saved.`
  String get payoutAccountSavedMessage {
    return Intl.message(
      'Payout account saved.',
      name: 'payoutAccountSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payout rail`
  String get payoutAccountTypeLabel {
    return Intl.message(
      'Payout rail',
      name: 'payoutAccountTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Bank transfer`
  String get payoutAccountTypeBankLabel {
    return Intl.message(
      'Bank transfer',
      name: 'payoutAccountTypeBankLabel',
      desc: '',
      args: [],
    );
  }

  /// `CCP`
  String get payoutAccountTypeCcpLabel {
    return Intl.message(
      'CCP',
      name: 'payoutAccountTypeCcpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dahabia`
  String get payoutAccountTypeDahabiaLabel {
    return Intl.message(
      'Dahabia',
      name: 'payoutAccountTypeDahabiaLabel',
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

  /// `Delete this vehicle from FleetFill?`
  String get vehicleDeleteConfirmationMessage {
    return Intl.message(
      'Delete this vehicle from FleetFill?',
      name: 'vehicleDeleteConfirmationMessage',
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

  /// `Add capacity`
  String get myRoutesAddAction {
    return Intl.message(
      'Add capacity',
      name: 'myRoutesAddAction',
      desc: '',
      args: [],
    );
  }

  /// `Active recurring routes`
  String get myRoutesActiveRoutesLabel {
    return Intl.message(
      'Active recurring routes',
      name: 'myRoutesActiveRoutesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Active one-off trips`
  String get myRoutesActiveTripsLabel {
    return Intl.message(
      'Active one-off trips',
      name: 'myRoutesActiveTripsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add recurring route`
  String get myRoutesCreateRouteAction {
    return Intl.message(
      'Add recurring route',
      name: 'myRoutesCreateRouteAction',
      desc: '',
      args: [],
    );
  }

  /// `Add one-off trip`
  String get myRoutesCreateTripAction {
    return Intl.message(
      'Add one-off trip',
      name: 'myRoutesCreateTripAction',
      desc: '',
      args: [],
    );
  }

  /// `Publish a recurring route or one-off trip to start offering capacity.`
  String get myRoutesEmptyMessage {
    return Intl.message(
      'Publish a recurring route or one-off trip to start offering capacity.',
      name: 'myRoutesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `One-off trips`
  String get myRoutesOneOffTab {
    return Intl.message(
      'One-off trips',
      name: 'myRoutesOneOffTab',
      desc: '',
      args: [],
    );
  }

  /// `Published capacity`
  String get myRoutesPublishedCapacityLabel {
    return Intl.message(
      'Published capacity',
      name: 'myRoutesPublishedCapacityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recurring routes`
  String get myRoutesRecurringTab {
    return Intl.message(
      'Recurring routes',
      name: 'myRoutesRecurringTab',
      desc: '',
      args: [],
    );
  }

  /// `Reserved capacity`
  String get myRoutesReservedCapacityLabel {
    return Intl.message(
      'Reserved capacity',
      name: 'myRoutesReservedCapacityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recurring routes`
  String get myRoutesRouteListTitle {
    return Intl.message(
      'Recurring routes',
      name: 'myRoutesRouteListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Capacity publication summary`
  String get myRoutesSummaryTitle {
    return Intl.message(
      'Capacity publication summary',
      name: 'myRoutesSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `One-off trips`
  String get myRoutesTripListTitle {
    return Intl.message(
      'One-off trips',
      name: 'myRoutesTripListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming departures`
  String get myRoutesUpcomingDeparturesLabel {
    return Intl.message(
      'Upcoming departures',
      name: 'myRoutesUpcomingDeparturesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Utilization`
  String get myRoutesUtilizationLabel {
    return Intl.message(
      'Utilization',
      name: 'myRoutesUtilizationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Activate trip`
  String get oneOffTripActivateAction {
    return Intl.message(
      'Activate trip',
      name: 'oneOffTripActivateAction',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip activated.`
  String get oneOffTripActivatedMessage {
    return Intl.message(
      'One-off trip activated.',
      name: 'oneOffTripActivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Add one-off trip`
  String get oneOffTripCreateTitle {
    return Intl.message(
      'Add one-off trip',
      name: 'oneOffTripCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip added.`
  String get oneOffTripCreatedMessage {
    return Intl.message(
      'One-off trip added.',
      name: 'oneOffTripCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate trip`
  String get oneOffTripDeactivateAction {
    return Intl.message(
      'Deactivate trip',
      name: 'oneOffTripDeactivateAction',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip deactivated.`
  String get oneOffTripDeactivatedMessage {
    return Intl.message(
      'One-off trip deactivated.',
      name: 'oneOffTripDeactivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete trip`
  String get oneOffTripDeleteAction {
    return Intl.message(
      'Delete trip',
      name: 'oneOffTripDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `This trip cannot be deleted because it already has bookings.`
  String get oneOffTripDeleteBlockedMessage {
    return Intl.message(
      'This trip cannot be deleted because it already has bookings.',
      name: 'oneOffTripDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip removed.`
  String get oneOffTripDeletedMessage {
    return Intl.message(
      'One-off trip removed.',
      name: 'oneOffTripDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get oneOffTripDepartureLabel {
    return Intl.message(
      'Departure',
      name: 'oneOffTripDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `Publish one dated trip with vehicle, lane, departure, and capacity details.`
  String get oneOffTripEditorDescription {
    return Intl.message(
      'Publish one dated trip with vehicle, lane, departure, and capacity details.',
      name: 'oneOffTripEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit one-off trip`
  String get oneOffTripEditTitle {
    return Intl.message(
      'Edit one-off trip',
      name: 'oneOffTripEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save trip`
  String get oneOffTripSaveAction {
    return Intl.message(
      'Save trip',
      name: 'oneOffTripSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip updated.`
  String get oneOffTripSavedMessage {
    return Intl.message(
      'One-off trip updated.',
      name: 'oneOffTripSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get publicationActiveLabel {
    return Intl.message(
      'Active',
      name: 'publicationActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Choose an effective date and time that is now or later.`
  String get publicationEffectiveDateFutureMessage {
    return Intl.message(
      'Choose an effective date and time that is now or later.',
      name: 'publicationEffectiveDateFutureMessage',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get publicationInactiveLabel {
    return Intl.message(
      'Inactive',
      name: 'publicationInactiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `No route revisions recorded yet.`
  String get publicationNoRevisionsMessage {
    return Intl.message(
      'No route revisions recorded yet.',
      name: 'publicationNoRevisionsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Revision history`
  String get publicationRevisionHistoryTitle {
    return Intl.message(
      'Revision history',
      name: 'publicationRevisionHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Origin and destination must be different communes.`
  String get publicationSameLaneErrorMessage {
    return Intl.message(
      'Origin and destination must be different communes.',
      name: 'publicationSameLaneErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search communes`
  String get publicationSearchCommunesHint {
    return Intl.message(
      'Search communes',
      name: 'publicationSearchCommunesHint',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get publicationSelectValueAction {
    return Intl.message(
      'Select',
      name: 'publicationSelectValueAction',
      desc: '',
      args: [],
    );
  }

  /// `Choose one of your available vehicles for this publication.`
  String get publicationVehicleUnavailableMessage {
    return Intl.message(
      'Choose one of your available vehicles for this publication.',
      name: 'publicationVehicleUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `Complete carrier verification before publishing capacity.`
  String get publicationVerifiedCarrierRequiredMessage {
    return Intl.message(
      'Complete carrier verification before publishing capacity.',
      name: 'publicationVerifiedCarrierRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choose a verified vehicle before publishing capacity.`
  String get publicationVerifiedVehicleRequiredMessage {
    return Intl.message(
      'Choose a verified vehicle before publishing capacity.',
      name: 'publicationVerifiedVehicleRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select at least one departure day.`
  String get publicationWeekdaysRequiredMessage {
    return Intl.message(
      'Select at least one departure day.',
      name: 'publicationWeekdaysRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Activate route`
  String get routeActivateAction {
    return Intl.message(
      'Activate route',
      name: 'routeActivateAction',
      desc: '',
      args: [],
    );
  }

  /// `Route activated.`
  String get routeActivatedMessage {
    return Intl.message(
      'Route activated.',
      name: 'routeActivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Add recurring route`
  String get routeCreateTitle {
    return Intl.message(
      'Add recurring route',
      name: 'routeCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recurring route added.`
  String get routeCreatedMessage {
    return Intl.message(
      'Recurring route added.',
      name: 'routeCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate route`
  String get routeDeactivateAction {
    return Intl.message(
      'Deactivate route',
      name: 'routeDeactivateAction',
      desc: '',
      args: [],
    );
  }

  /// `Route deactivated.`
  String get routeDeactivatedMessage {
    return Intl.message(
      'Route deactivated.',
      name: 'routeDeactivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete route`
  String get routeDeleteAction {
    return Intl.message(
      'Delete route',
      name: 'routeDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `This route cannot be deleted because it already has bookings.`
  String get routeDeleteBlockedMessage {
    return Intl.message(
      'This route cannot be deleted because it already has bookings.',
      name: 'routeDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Recurring route removed.`
  String get routeDeletedMessage {
    return Intl.message(
      'Recurring route removed.',
      name: 'routeDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Default departure time`
  String get routeDepartureTimeLabel {
    return Intl.message(
      'Default departure time',
      name: 'routeDepartureTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Activate this route for new bookings?`
  String get routeActivateConfirmationMessage {
    return Intl.message(
      'Activate this route for new bookings?',
      name: 'routeActivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate this route for new bookings? Existing bookings will stay unchanged.`
  String get routeDeactivateConfirmationMessage {
    return Intl.message(
      'Deactivate this route for new bookings? Existing bookings will stay unchanged.',
      name: 'routeDeactivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete this recurring route from FleetFill?`
  String get routeDeleteConfirmationMessage {
    return Intl.message(
      'Delete this recurring route from FleetFill?',
      name: 'routeDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Destination commune`
  String get routeDestinationLabel {
    return Intl.message(
      'Destination commune',
      name: 'routeDestinationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Publish a recurring lane with vehicle, schedule, and capacity details.`
  String get routeEditorDescription {
    return Intl.message(
      'Publish a recurring lane with vehicle, schedule, and capacity details.',
      name: 'routeEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit recurring route`
  String get routeEditTitle {
    return Intl.message(
      'Edit recurring route',
      name: 'routeEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Effective from`
  String get routeEffectiveFromLabel {
    return Intl.message(
      'Effective from',
      name: 'routeEffectiveFromLabel',
      desc: '',
      args: [],
    );
  }

  /// `Origin commune`
  String get routeOriginLabel {
    return Intl.message(
      'Origin commune',
      name: 'routeOriginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Price per kg (DZD)`
  String get routePricePerKgLabel {
    return Intl.message(
      'Price per kg (DZD)',
      name: 'routePricePerKgLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recurring days`
  String get routeRecurringDaysLabel {
    return Intl.message(
      'Recurring days',
      name: 'routeRecurringDaysLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save route`
  String get routeSaveAction {
    return Intl.message(
      'Save route',
      name: 'routeSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Recurring route updated.`
  String get routeSavedMessage {
    return Intl.message(
      'Recurring route updated.',
      name: 'routeSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Publication status`
  String get routeStatusLabel {
    return Intl.message(
      'Publication status',
      name: 'routeStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Assigned vehicle`
  String get routeVehicleLabel {
    return Intl.message(
      'Assigned vehicle',
      name: 'routeVehicleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Load more`
  String get loadMoreLabel {
    return Intl.message('Load more', name: 'loadMoreLabel', desc: '', args: []);
  }

  /// `DZD/kg`
  String get pricePerKgUnitLabel {
    return Intl.message(
      'DZD/kg',
      name: 'pricePerKgUnitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Activate this trip for new bookings?`
  String get oneOffTripActivateConfirmationMessage {
    return Intl.message(
      'Activate this trip for new bookings?',
      name: 'oneOffTripActivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Deactivate this trip for new bookings? Existing bookings will stay unchanged.`
  String get oneOffTripDeactivateConfirmationMessage {
    return Intl.message(
      'Deactivate this trip for new bookings? Existing bookings will stay unchanged.',
      name: 'oneOffTripDeactivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete this one-off trip from FleetFill?`
  String get oneOffTripDeleteConfirmationMessage {
    return Intl.message(
      'Delete this one-off trip from FleetFill?',
      name: 'oneOffTripDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `DZD`
  String get priceCurrencyLabel {
    return Intl.message('DZD', name: 'priceCurrencyLabel', desc: '', args: []);
  }

  /// `Create shipment`
  String get shipmentCreateAction {
    return Intl.message(
      'Create shipment',
      name: 'shipmentCreateAction',
      desc: '',
      args: [],
    );
  }

  /// `Create shipment draft`
  String get shipmentCreateTitle {
    return Intl.message(
      'Create shipment draft',
      name: 'shipmentCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit shipment`
  String get shipmentEditAction {
    return Intl.message(
      'Edit shipment',
      name: 'shipmentEditAction',
      desc: '',
      args: [],
    );
  }

  /// `Edit shipment draft`
  String get shipmentEditTitle {
    return Intl.message(
      'Edit shipment draft',
      name: 'shipmentEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save shipment`
  String get shipmentSaveAction {
    return Intl.message(
      'Save shipment',
      name: 'shipmentSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `Shipment draft saved.`
  String get shipmentSavedMessage {
    return Intl.message(
      'Shipment draft saved.',
      name: 'shipmentSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete shipment`
  String get shipmentDeleteAction {
    return Intl.message(
      'Delete shipment',
      name: 'shipmentDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `Delete this shipment draft from FleetFill?`
  String get shipmentDeleteConfirmationMessage {
    return Intl.message(
      'Delete this shipment draft from FleetFill?',
      name: 'shipmentDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shipment draft removed.`
  String get shipmentDeletedMessage {
    return Intl.message(
      'Shipment draft removed.',
      name: 'shipmentDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create a shipment draft before searching exact capacity.`
  String get shipmentsEmptyMessage {
    return Intl.message(
      'Create a shipment draft before searching exact capacity.',
      name: 'shipmentsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get shipmentCategoryLabel {
    return Intl.message(
      'Category',
      name: 'shipmentCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get shipmentDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'shipmentDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pickup window start`
  String get shipmentPickupStartLabel {
    return Intl.message(
      'Pickup window start',
      name: 'shipmentPickupStartLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pickup window end`
  String get shipmentPickupEndLabel {
    return Intl.message(
      'Pickup window end',
      name: 'shipmentPickupEndLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pickup window end must be after pickup window start.`
  String get shipmentPickupWindowOrderMessage {
    return Intl.message(
      'Pickup window end must be after pickup window start.',
      name: 'shipmentPickupWindowOrderMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shipment items`
  String get shipmentItemsTitle {
    return Intl.message(
      'Shipment items',
      name: 'shipmentItemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Item {index}`
  String shipmentItemTitle(Object index) {
    return Intl.message(
      'Item $index',
      name: 'shipmentItemTitle',
      desc: '',
      args: [index],
    );
  }

  /// `Add item`
  String get shipmentAddItemAction {
    return Intl.message(
      'Add item',
      name: 'shipmentAddItemAction',
      desc: '',
      args: [],
    );
  }

  /// `Remove item`
  String get shipmentRemoveItemAction {
    return Intl.message(
      'Remove item',
      name: 'shipmentRemoveItemAction',
      desc: '',
      args: [],
    );
  }

  /// `Item label`
  String get shipmentItemLabelField {
    return Intl.message(
      'Item label',
      name: 'shipmentItemLabelField',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get shipmentItemQuantityLabel {
    return Intl.message(
      'Quantity',
      name: 'shipmentItemQuantityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Item weight (kg)`
  String get shipmentItemWeightLabel {
    return Intl.message(
      'Item weight (kg)',
      name: 'shipmentItemWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `Item volume (m3)`
  String get shipmentItemVolumeLabel {
    return Intl.message(
      'Item volume (m3)',
      name: 'shipmentItemVolumeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Item notes`
  String get shipmentItemNotesLabel {
    return Intl.message(
      'Item notes',
      name: 'shipmentItemNotesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Draft`
  String get shipmentStatusDraftLabel {
    return Intl.message(
      'Draft',
      name: 'shipmentStatusDraftLabel',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get shipmentStatusBookedLabel {
    return Intl.message(
      'Booked',
      name: 'shipmentStatusBookedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get shipmentStatusCancelledLabel {
    return Intl.message(
      'Cancelled',
      name: 'shipmentStatusCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create at least one shipment draft to search exact lane capacity.`
  String get searchTripsRequiresDraftMessage {
    return Intl.message(
      'Create at least one shipment draft to search exact lane capacity.',
      name: 'searchTripsRequiresDraftMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shipment draft`
  String get searchShipmentSelectorLabel {
    return Intl.message(
      'Shipment draft',
      name: 'searchShipmentSelectorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Requested departure date`
  String get searchRequestedDateLabel {
    return Intl.message(
      'Requested departure date',
      name: 'searchRequestedDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Shipment summary`
  String get searchShipmentSummaryTitle {
    return Intl.message(
      'Shipment summary',
      name: 'searchShipmentSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search exact capacity`
  String get searchTripsAction {
    return Intl.message(
      'Search exact capacity',
      name: 'searchTripsAction',
      desc: '',
      args: [],
    );
  }

  /// `Sort and filters`
  String get searchTripsControlsAction {
    return Intl.message(
      'Sort and filters',
      name: 'searchTripsControlsAction',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get searchSortRecommendedLabel {
    return Intl.message(
      'Recommended',
      name: 'searchSortRecommendedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Top rated`
  String get searchSortTopRatedLabel {
    return Intl.message(
      'Top rated',
      name: 'searchSortTopRatedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Lowest price`
  String get searchSortLowestPriceLabel {
    return Intl.message(
      'Lowest price',
      name: 'searchSortLowestPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nearest departure`
  String get searchSortNearestDepartureLabel {
    return Intl.message(
      'Nearest departure',
      name: 'searchSortNearestDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier`
  String get searchCarrierLabel {
    return Intl.message(
      'Carrier',
      name: 'searchCarrierLabel',
      desc: '',
      args: [],
    );
  }

  /// `Estimated total`
  String get searchEstimatedPriceLabel {
    return Intl.message(
      'Estimated total',
      name: 'searchEstimatedPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get searchDepartureLabel {
    return Intl.message(
      'Departure',
      name: 'searchDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nearest exact dates found`
  String get searchTripsNearestDateTitle {
    return Intl.message(
      'Nearest exact dates found',
      name: 'searchTripsNearestDateTitle',
      desc: '',
      args: [],
    );
  }

  /// `No same-day exact result is available. Showing nearest exact dates: {dates}`
  String searchTripsNearestDateMessage(Object dates) {
    return Intl.message(
      'No same-day exact result is available. Showing nearest exact dates: $dates',
      name: 'searchTripsNearestDateMessage',
      desc: '',
      args: [dates],
    );
  }

  /// `Redefine your search`
  String get searchTripsNoRouteTitle {
    return Intl.message(
      'Redefine your search',
      name: 'searchTripsNoRouteTitle',
      desc: '',
      args: [],
    );
  }

  /// `No exact route exists for this lane in the nearby search window.`
  String get searchTripsNoRouteMessage {
    return Intl.message(
      'No exact route exists for this lane in the nearby search window.',
      name: 'searchTripsNoRouteMessage',
      desc: '',
      args: [],
    );
  }

  /// `No result matches the current sort and filter selection.`
  String get searchTripsFilterEmptyMessage {
    return Intl.message(
      'No result matches the current sort and filter selection.',
      name: 'searchTripsFilterEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search results ({count})`
  String searchTripsResultsTitle(Object count) {
    return Intl.message(
      'Search results ($count)',
      name: 'searchTripsResultsTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Recurring route`
  String get searchTripsRecurringLabel {
    return Intl.message(
      'Recurring route',
      name: 'searchTripsRecurringLabel',
      desc: '',
      args: [],
    );
  }

  /// `One-off trip`
  String get searchTripsOneOffLabel {
    return Intl.message(
      'One-off trip',
      name: 'searchTripsOneOffLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm booking`
  String get bookingConfirmAction {
    return Intl.message(
      'Confirm booking',
      name: 'bookingConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Booking created. Continue to payment instructions.`
  String get bookingCreatedMessage {
    return Intl.message(
      'Booking created. Continue to payment instructions.',
      name: 'bookingCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Insurance option`
  String get bookingInsuranceAction {
    return Intl.message(
      'Insurance option',
      name: 'bookingInsuranceAction',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get bookingInsuranceLabel {
    return Intl.message(
      'Insurance',
      name: 'bookingInsuranceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Insurance is optional and calculated as a percentage with a minimum fee floor.`
  String get bookingInsuranceDescription {
    return Intl.message(
      'Insurance is optional and calculated as a percentage with a minimum fee floor.',
      name: 'bookingInsuranceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Included`
  String get bookingInsuranceIncludedLabel {
    return Intl.message(
      'Included',
      name: 'bookingInsuranceIncludedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Not included`
  String get bookingInsuranceNotIncludedLabel {
    return Intl.message(
      'Not included',
      name: 'bookingInsuranceNotIncludedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pricing breakdown`
  String get bookingPricingBreakdownAction {
    return Intl.message(
      'Pricing breakdown',
      name: 'bookingPricingBreakdownAction',
      desc: '',
      args: [],
    );
  }

  /// `Base price`
  String get bookingBasePriceLabel {
    return Intl.message(
      'Base price',
      name: 'bookingBasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Platform fee`
  String get bookingPlatformFeeLabel {
    return Intl.message(
      'Platform fee',
      name: 'bookingPlatformFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier fee`
  String get bookingCarrierFeeLabel {
    return Intl.message(
      'Carrier fee',
      name: 'bookingCarrierFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Insurance fee`
  String get bookingInsuranceFeeLabel {
    return Intl.message(
      'Insurance fee',
      name: 'bookingInsuranceFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tax fee`
  String get bookingTaxFeeLabel {
    return Intl.message(
      'Tax fee',
      name: 'bookingTaxFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier payout`
  String get bookingCarrierPayoutLabel {
    return Intl.message(
      'Carrier payout',
      name: 'bookingCarrierPayoutLabel',
      desc: '',
      args: [],
    );
  }

  /// `Final total`
  String get bookingTotalLabel {
    return Intl.message(
      'Final total',
      name: 'bookingTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment reference`
  String get bookingPaymentReferenceLabel {
    return Intl.message(
      'Payment reference',
      name: 'bookingPaymentReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tracking number`
  String get bookingTrackingNumberLabel {
    return Intl.message(
      'Tracking number',
      name: 'bookingTrackingNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment instructions`
  String get paymentInstructionsTitle {
    return Intl.message(
      'Payment instructions',
      name: 'paymentInstructionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof review`
  String get adminPaymentProofQueueTitle {
    return Intl.message(
      'Payment proof review',
      name: 'adminPaymentProofQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `No payment proofs need review right now.`
  String get adminPaymentProofQueueEmptyMessage {
    return Intl.message(
      'No payment proofs need review right now.',
      name: 'adminPaymentProofQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof`
  String get paymentProofSectionTitle {
    return Intl.message(
      'Payment proof',
      name: 'paymentProofSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Latest submitted proof`
  String get paymentProofLatestTitle {
    return Intl.message(
      'Latest submitted proof',
      name: 'paymentProofLatestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload a payment proof after completing your external payment.`
  String get paymentProofEmptyMessage {
    return Intl.message(
      'Upload a payment proof after completing your external payment.',
      name: 'paymentProofEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Upload payment proof`
  String get paymentProofUploadAction {
    return Intl.message(
      'Upload payment proof',
      name: 'paymentProofUploadAction',
      desc: '',
      args: [],
    );
  }

  /// `Resubmit payment proof`
  String get paymentProofResubmitAction {
    return Intl.message(
      'Resubmit payment proof',
      name: 'paymentProofResubmitAction',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof uploaded.`
  String get paymentProofUploadedMessage {
    return Intl.message(
      'Payment proof uploaded.',
      name: 'paymentProofUploadedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submitted amount`
  String get paymentProofAmountLabel {
    return Intl.message(
      'Submitted amount',
      name: 'paymentProofAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Submitted reference`
  String get paymentProofReferenceLabel {
    return Intl.message(
      'Submitted reference',
      name: 'paymentProofReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Proof status`
  String get paymentProofStatusLabel {
    return Intl.message(
      'Proof status',
      name: 'paymentProofStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pending review`
  String get paymentProofStatusPendingLabel {
    return Intl.message(
      'Pending review',
      name: 'paymentProofStatusPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get paymentProofStatusVerifiedLabel {
    return Intl.message(
      'Verified',
      name: 'paymentProofStatusVerifiedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get paymentProofStatusRejectedLabel {
    return Intl.message(
      'Rejected',
      name: 'paymentProofStatusRejectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verified amount`
  String get paymentProofVerifiedAmountLabel {
    return Intl.message(
      'Verified amount',
      name: 'paymentProofVerifiedAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verified reference`
  String get paymentProofVerifiedReferenceLabel {
    return Intl.message(
      'Verified reference',
      name: 'paymentProofVerifiedReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Decision note`
  String get paymentProofDecisionNoteLabel {
    return Intl.message(
      'Decision note',
      name: 'paymentProofDecisionNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rejection reason`
  String get paymentProofRejectionReasonLabel {
    return Intl.message(
      'Rejection reason',
      name: 'paymentProofRejectionReasonLabel',
      desc: '',
      args: [],
    );
  }

  /// `A rejection reason is required.`
  String get paymentProofRejectionReasonRequiredMessage {
    return Intl.message(
      'A rejection reason is required.',
      name: 'paymentProofRejectionReasonRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof approved.`
  String get paymentProofApprovedMessage {
    return Intl.message(
      'Payment proof approved.',
      name: 'paymentProofApprovedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof rejected.`
  String get paymentProofRejectedMessage {
    return Intl.message(
      'Payment proof rejected.',
      name: 'paymentProofRejectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Generated documents`
  String get generatedDocumentsTitle {
    return Intl.message(
      'Generated documents',
      name: 'generatedDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Generated invoice and receipt documents will appear here when available.`
  String get generatedDocumentsEmptyMessage {
    return Intl.message(
      'Generated invoice and receipt documents will appear here when available.',
      name: 'generatedDocumentsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment proof can only be submitted while payment is still pending.`
  String get paymentProofPendingWindowMessage {
    return Intl.message(
      'Payment proof can only be submitted while payment is still pending.',
      name: 'paymentProofPendingWindowMessage',
      desc: '',
      args: [],
    );
  }

  /// `The verified payment amount must match the booking total exactly.`
  String get paymentProofExactAmountRequiredMessage {
    return Intl.message(
      'The verified payment amount must match the booking total exactly.',
      name: 'paymentProofExactAmountRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `This payment proof has already been reviewed.`
  String get paymentProofAlreadyReviewedMessage {
    return Intl.message(
      'This payment proof has already been reviewed.',
      name: 'paymentProofAlreadyReviewedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Tracking timeline`
  String get trackingTimelineTitle {
    return Intl.message(
      'Tracking timeline',
      name: 'trackingTimelineTitle',
      desc: '',
      args: [],
    );
  }

  /// `No tracking events are available yet.`
  String get trackingTimelineEmptyMessage {
    return Intl.message(
      'No tracking events are available yet.',
      name: 'trackingTimelineEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delivery`
  String get deliveryConfirmAction {
    return Intl.message(
      'Confirm delivery',
      name: 'deliveryConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Delivery confirmed.`
  String get deliveryConfirmedMessage {
    return Intl.message(
      'Delivery confirmed.',
      name: 'deliveryConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Booking milestone updated.`
  String get carrierMilestoneUpdatedMessage {
    return Intl.message(
      'Booking milestone updated.',
      name: 'carrierMilestoneUpdatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment under review`
  String get trackingEventPaymentUnderReviewLabel {
    return Intl.message(
      'Payment under review',
      name: 'trackingEventPaymentUnderReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get trackingEventConfirmedLabel {
    return Intl.message(
      'Confirmed',
      name: 'trackingEventConfirmedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Picked up`
  String get trackingEventPickedUpLabel {
    return Intl.message(
      'Picked up',
      name: 'trackingEventPickedUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `In transit`
  String get trackingEventInTransitLabel {
    return Intl.message(
      'In transit',
      name: 'trackingEventInTransitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delivered pending review`
  String get trackingEventDeliveredPendingReviewLabel {
    return Intl.message(
      'Delivered pending review',
      name: 'trackingEventDeliveredPendingReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get trackingEventCompletedLabel {
    return Intl.message(
      'Completed',
      name: 'trackingEventCompletedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get trackingEventCancelledLabel {
    return Intl.message(
      'Cancelled',
      name: 'trackingEventCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `Disputed`
  String get trackingEventDisputedLabel {
    return Intl.message(
      'Disputed',
      name: 'trackingEventDisputedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Carrier rating`
  String get searchCarrierRatingLabel {
    return Intl.message(
      'Carrier rating',
      name: 'searchCarrierRatingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Capacity type`
  String get searchResultTypeLabel {
    return Intl.message(
      'Capacity type',
      name: 'searchResultTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for payment`
  String get bookingStatusPendingPaymentLabel {
    return Intl.message(
      'Waiting for payment',
      name: 'bookingStatusPendingPaymentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment under review`
  String get bookingStatusPaymentUnderReviewLabel {
    return Intl.message(
      'Payment under review',
      name: 'bookingStatusPaymentUnderReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get bookingStatusConfirmedLabel {
    return Intl.message(
      'Confirmed',
      name: 'bookingStatusConfirmedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Picked up`
  String get bookingStatusPickedUpLabel {
    return Intl.message(
      'Picked up',
      name: 'bookingStatusPickedUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `In transit`
  String get bookingStatusInTransitLabel {
    return Intl.message(
      'In transit',
      name: 'bookingStatusInTransitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delivered pending review`
  String get bookingStatusDeliveredPendingReviewLabel {
    return Intl.message(
      'Delivered pending review',
      name: 'bookingStatusDeliveredPendingReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get bookingStatusCompletedLabel {
    return Intl.message(
      'Completed',
      name: 'bookingStatusCompletedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get bookingStatusCancelledLabel {
    return Intl.message(
      'Cancelled',
      name: 'bookingStatusCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `Disputed`
  String get bookingStatusDisputedLabel {
    return Intl.message(
      'Disputed',
      name: 'bookingStatusDisputedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get paymentStatusUnpaidLabel {
    return Intl.message(
      'Unpaid',
      name: 'paymentStatusUnpaidLabel',
      desc: '',
      args: [],
    );
  }

  /// `Proof submitted`
  String get paymentStatusProofSubmittedLabel {
    return Intl.message(
      'Proof submitted',
      name: 'paymentStatusProofSubmittedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Under verification`
  String get paymentStatusUnderVerificationLabel {
    return Intl.message(
      'Under verification',
      name: 'paymentStatusUnderVerificationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Secured`
  String get paymentStatusSecuredLabel {
    return Intl.message(
      'Secured',
      name: 'paymentStatusSecuredLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get paymentStatusRejectedLabel {
    return Intl.message(
      'Rejected',
      name: 'paymentStatusRejectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Refunded`
  String get paymentStatusRefundedLabel {
    return Intl.message(
      'Refunded',
      name: 'paymentStatusRefundedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Released to carrier`
  String get paymentStatusReleasedToCarrierLabel {
    return Intl.message(
      'Released to carrier',
      name: 'paymentStatusReleasedToCarrierLabel',
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
