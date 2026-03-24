import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/support/support.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supportWorkflowControllerProvider = Provider<SupportWorkflowController>(
  SupportWorkflowController.new,
);

class SupportWorkflowController {
  const SupportWorkflowController(this.ref);

  final Ref ref;

  Future<void> createSupportRequest({
    required String locale,
    required String subject,
    required String message,
    String? shipmentId,
    String? bookingId,
    String? paymentProofId,
    String? disputeId,
  }) async {
    final request = await ref
        .read(supportRepositoryProvider)
        .createSupportRequest(
          locale: locale,
          subject: subject,
          message: message,
          shipmentId: shipmentId,
          bookingId: bookingId,
          paymentProofId: paymentProofId,
          disputeId: disputeId,
        );

    ref
      ..invalidate(mySupportRequestsProvider)
      ..invalidate(supportThreadProvider(request.id))
      ..invalidate(myNotificationsProvider);
  }

  Future<void> replyToSupportRequest({
    required String requestId,
    required String message,
  }) async {
    await ref
        .read(supportRepositoryProvider)
        .replyToSupportRequest(
          requestId: requestId,
          message: message,
        );

    ref
      ..invalidate(mySupportRequestsProvider)
      ..invalidate(adminSupportQueueProvider)
      ..invalidate(
        adminFilteredSupportQueueProvider((status: null, query: null)),
      )
      ..invalidate(supportThreadProvider(requestId))
      ..invalidate(myNotificationsProvider);
  }

  Future<void> markSupportRequestRead(String requestId) async {
    await ref.read(supportRepositoryProvider).markSupportRequestRead(requestId);
    ref
      ..invalidate(mySupportRequestsProvider)
      ..invalidate(adminSupportQueueProvider)
      ..invalidate(
        adminFilteredSupportQueueProvider((status: null, query: null)),
      )
      ..invalidate(supportThreadProvider(requestId))
      ..invalidate(myNotificationsProvider);
  }
}
