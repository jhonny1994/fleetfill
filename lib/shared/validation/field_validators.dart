import 'package:fleetfill/core/localization/localization.dart';

String? validateRequiredField(S s, String? value) {
  return (value ?? '').trim().isEmpty ? s.authRequiredFieldMessage : null;
}

String? validatePositiveNumberField(
  S s,
  String? value, {
  String? invalidMessage,
}) {
  final normalized = double.tryParse((value ?? '').trim());
  if (normalized == null || normalized <= 0) {
    return invalidMessage ?? s.appGenericErrorMessage;
  }
  return null;
}

String? validateOptionalPositiveNumberField(
  S s,
  String? value, {
  String? invalidMessage,
}) {
  final trimmed = (value ?? '').trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return validatePositiveNumberField(
    s,
    trimmed,
    invalidMessage: invalidMessage,
  );
}
