import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/localization/localization.dart';

String mapAppErrorMessage(S s, Object error) {
  final rawMessage = error.toString();
  final message = rawMessage.toLowerCase();

  if (message.contains('carrier_profile_not_found')) {
    return s.notFoundMessage;
  }
  if (message.contains('route_not_found') ||
      message.contains('oneoff_trip_not_found') ||
      message.contains('one-off trip not found') ||
      message.contains('route not found')) {
    return s.notFoundMessage;
  }
  if (message.contains('verified vehicle')) {
    return s.publicationVerifiedVehicleRequiredMessage;
  }
  if (message.contains('vehicle is unavailable for this carrier')) {
    return s.publicationVehicleUnavailableMessage;
  }
  if (message.contains('active verified carriers may publish capacity')) {
    return s.publicationVerifiedCarrierRequiredMessage;
  }
  if (message.contains('route effective date must be now or later')) {
    return s.publicationEffectiveDateFutureMessage;
  }
  if (message.contains('departure must be in the future')) {
    return s.publicationEffectiveDateFutureMessage;
  }
  if (message.contains('origin and destination must be different')) {
    return s.publicationSameLaneErrorMessage;
  }
  if (message.contains('route has active bookings')) {
    return s.routeDeleteBlockedMessage;
  }
  if (message.contains('trip has active bookings')) {
    return s.oneOffTripDeleteBlockedMessage;
  }
  if (message.contains(
    'payment proof can only be submitted while payment is pending',
  )) {
    return s.paymentProofPendingWindowMessage;
  }
  if (message.contains(
    'payment proof cannot be submitted for this booking state',
  )) {
    return s.paymentProofPendingWindowMessage;
  }
  if (message.contains(
    'verified amount must match the expected booking amount exactly',
  )) {
    return s.paymentProofExactAmountRequiredMessage;
  }
  if (message.contains('payment proof rejection requires a reason')) {
    return s.paymentProofRejectionReasonRequiredMessage;
  }
  if (message.contains('only pending payment proofs can be approved') ||
      message.contains('only pending payment proofs can be rejected')) {
    return s.paymentProofAlreadyReviewedMessage;
  }
  if (message.contains('payout account has operational usage')) {
    return s.payoutAccountDeleteBlockedMessage;
  }
  if (message.contains('rejection requires a reason')) {
    return s.adminVerificationRejectReasonHint;
  }

  final authMapped = mapAuthErrorMessage(s, rawMessage);
  if (authMapped != s.authGenericErrorMessage) {
    return authMapped;
  }

  return s.appGenericErrorMessage;
}
