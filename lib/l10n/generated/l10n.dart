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

  /// `Audit visibility for sensitive operations lives here.`
  String get adminAuditLogDescription {
    return Intl.message(
      'Audit visibility for sensitive operations lives here.',
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

  /// `Operational backlog health, alerts, and quick counts live here.`
  String get adminDashboardDescription {
    return Intl.message(
      'Operational backlog health, alerts, and quick counts live here.',
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

  /// `Payments, verification, disputes, payouts, and email queues stay segmented inside one page.`
  String get adminQueuesDescription {
    return Intl.message(
      'Payments, verification, disputes, payouts, and email queues stay segmented inside one page.',
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

  /// `Platform settings, maintenance mode, version policy, and monitoring summary live here.`
  String get adminSettingsDescription {
    return Intl.message(
      'Platform settings, maintenance mode, version policy, and monitoring summary live here.',
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

  /// `User search and investigation live here.`
  String get adminUsersDescription {
    return Intl.message(
      'User search and investigation live here.',
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

  /// `Password reset request handling belongs in the auth shell.`
  String get authForgotPasswordDescription {
    return Intl.message(
      'Password reset request handling belongs in the auth shell.',
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

  /// `Password reset confirmation lives here.`
  String get authResetPasswordDescription {
    return Intl.message(
      'Password reset confirmation lives here.',
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

  /// `Email/password and Google sign-in entry points live here.`
  String get authSignInDescription {
    return Intl.message(
      'Email/password and Google sign-in entry points live here.',
      name: 'authSignInDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get authSignInTitle {
    return Intl.message('Sign in', name: 'authSignInTitle', desc: '', args: []);
  }

  /// `Lean account creation stays inside one auth shell.`
  String get authSignUpDescription {
    return Intl.message(
      'Lean account creation stays inside one auth shell.',
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

  /// `Carrier profile`
  String get carrierProfileTitle {
    return Intl.message(
      'Carrier profile',
      name: 'carrierProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Public carrier reputation and trust cues live here.`
  String get carrierPublicProfileDescription {
    return Intl.message(
      'Public carrier reputation and trust cues live here.',
      name: 'carrierPublicProfileDescription',
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

  /// `Private document viewing belongs in one secure shared route.`
  String get documentViewerDescription {
    return Intl.message(
      'Private document viewing belongs in one secure shared route.',
      name: 'documentViewerDescription',
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

  /// `Carrier profile editing lives here.`
  String get editCarrierProfileDescription {
    return Intl.message(
      'Carrier profile editing lives here.',
      name: 'editCarrierProfileDescription',
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

  /// `Shipper profile editing lives here.`
  String get editShipperProfileDescription {
    return Intl.message(
      'Shipper profile editing lives here.',
      name: 'editShipperProfileDescription',
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

  /// `Generated invoice and receipt access stays deep-linkable above the shell.`
  String get generatedDocumentViewerDescription {
    return Intl.message(
      'Generated invoice and receipt access stays deep-linkable above the shell.',
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

  /// `Global maintenance messaging lives here.`
  String get maintenanceDescription {
    return Intl.message(
      'Global maintenance messaging lives here.',
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

  /// `Notification details stay deep-linkable without becoming a tab.`
  String get notificationDetailDescription {
    return Intl.message(
      'Notification details stay deep-linkable without becoming a tab.',
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

  /// `Shared notification history opens above the role shells.`
  String get notificationsCenterDescription {
    return Intl.message(
      'Shared notification history opens above the role shells.',
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

  /// `One-off trip detail routes stay deep-linkable above the shell.`
  String get oneOffTripDetailDescription {
    return Intl.message(
      'One-off trip detail routes stay deep-linkable above the shell.',
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

  /// `Phone completion`
  String get phoneCompletionTitle {
    return Intl.message(
      'Phone completion',
      name: 'phoneCompletionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Role-aware shipper/carrier profile completion stays in one guided flow.`
  String get profileSetupDescription {
    return Intl.message(
      'Role-aware shipper/carrier profile completion stays in one guided flow.',
      name: 'profileSetupDescription',
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

  /// `Private proof viewing belongs in one secure shared route.`
  String get proofViewerDescription {
    return Intl.message(
      'Private proof viewing belongs in one secure shared route.',
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

  /// `One account selects one role before operational access begins.`
  String get roleSelectionDescription {
    return Intl.message(
      'One account selects one role before operational access begins.',
      name: 'roleSelectionDescription',
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

  /// `Language, theme, support, and notification preferences stay inside shared settings.`
  String get settingsDescription {
    return Intl.message(
      'Language, theme, support, and notification preferences stay inside shared settings.',
      name: 'settingsDescription',
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

  /// `Minimum supported version gating lives here.`
  String get updateRequiredDescription {
    return Intl.message(
      'Minimum supported version gating lives here.',
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

  /// `Vehicles remain under the carrier profile branch.`
  String get vehiclesDescription {
    return Intl.message(
      'Vehicles remain under the carrier profile branch.',
      name: 'vehiclesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Vehicles`
  String get vehiclesTitle {
    return Intl.message('Vehicles', name: 'vehiclesTitle', desc: '', args: []);
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

  /// `Arabic, French, and English selection belongs here.`
  String get languageSelectionDescription {
    return Intl.message(
      'Arabic, French, and English selection belongs here.',
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
