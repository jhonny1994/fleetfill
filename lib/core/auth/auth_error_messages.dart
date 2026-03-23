import 'package:fleetfill/core/localization/localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String mapAuthErrorMessage(
  S s,
  String rawMessage, {
  String? code,
  String? statusCode,
}) {
  final normalizedCode = code?.trim().toLowerCase();
  final normalizedStatusCode = statusCode?.trim().toLowerCase();
  final message = rawMessage.toLowerCase();

  if (normalizedCode == 'email_exists' ||
      normalizedCode == 'user_already_exists' ||
      message.contains('user already registered')) {
    return s.authUserAlreadyRegisteredMessage;
  }
  if (normalizedCode == 'email_not_confirmed' ||
      message.contains('email not confirmed')) {
    return s.authEmailNotConfirmedMessage;
  }
  if (normalizedCode == 'email_address_invalid' ||
      normalizedCode == 'validation_failed') {
    return s.authInvalidEmailMessage;
  }
  if (normalizedCode == 'signup_disabled' ||
      normalizedCode == 'email_provider_disabled') {
    return s.authSignUpUnavailableMessage;
  }
  if (normalizedCode == 'over_email_send_rate_limit' ||
      normalizedCode == 'over_request_rate_limit' ||
      normalizedCode == 'rate_limit_exceeded' ||
      normalizedStatusCode == '429') {
    return s.authRateLimitedMessage;
  }
  if (normalizedCode == 'email_rate_limit_exceeded' ||
      message.contains('error sending confirmation email') ||
      message.contains('error sending recovery email') ||
      message.contains('redirect url')) {
    return s.authEmailDeliveryIssueMessage;
  }
  if (normalizedCode == 'weak_password' || message.contains('weak password')) {
    return s.authWeakPasswordMessage;
  }

  if (message.contains('authentication_required')) {
    return s.authAuthenticationRequiredMessage;
  }
  if (message.contains('invalid login credentials')) {
    return s.authInvalidCredentialsMessage;
  }
  if (message.contains('email not confirmed')) {
    return s.authEmailNotConfirmedMessage;
  }
  if (message.contains('user already registered')) {
    return s.authUserAlreadyRegisteredMessage;
  }
  if (message.contains('google_auth_disabled')) {
    return s.authGoogleUnavailableMessage;
  }
  if (message.contains('user_cancelled')) {
    return s.authCancelledMessage;
  }
  if (message.contains('role_already_assigned')) {
    return s.authRoleAlreadyAssignedMessage;
  }
  if (message.contains('document_signed_url_unavailable')) {
    return s.documentViewerUnavailableMessage;
  }
  if (message.contains('generated_document_not_ready')) {
    return s.generatedDocumentPendingMessage;
  }
  if (message.contains('generated_document_failed')) {
    return s.generatedDocumentFailedMessage;
  }
  if (message.contains('network')) {
    return s.authNetworkErrorMessage;
  }

  return s.authGenericErrorMessage;
}

String mapAuthExceptionMessage(S s, AuthException error) {
  return mapAuthErrorMessage(
    s,
    error.message,
    code: error.code,
    statusCode: error.statusCode,
  );
}
