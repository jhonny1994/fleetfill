import 'package:fleetfill/core/localization/localization.dart';

String mapAuthErrorMessage(S s, String rawMessage) {
  final message = rawMessage.toLowerCase();

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
