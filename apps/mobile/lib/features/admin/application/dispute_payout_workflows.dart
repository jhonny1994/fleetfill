import 'package:fleetfill/features/shipper/shipper.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminDisputePayoutWorkflowControllerProvider =
    Provider<AdminDisputePayoutWorkflowController>(
      AdminDisputePayoutWorkflowController.new,
    );

class AdminDisputePayoutWorkflowController {
  const AdminDisputePayoutWorkflowController(this.ref);

  final Ref ref;

  Future<void> resolveDisputeComplete({
    required String disputeId,
    String? resolutionNote,
  }) async {
    await ref
        .read(disputeRepositoryProvider)
        .resolveComplete(
          disputeId: disputeId,
          resolutionNote: resolutionNote,
        );
    ref
      ..invalidate(openDisputesProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminEligiblePayoutsProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }

  Future<void> resolveDisputeRefund({
    required String disputeId,
    required double refundAmountDzd,
    required String refundReason,
    String? externalReference,
    String? resolutionNote,
  }) async {
    await ref
        .read(disputeRepositoryProvider)
        .resolveRefund(
          disputeId: disputeId,
          refundAmountDzd: refundAmountDzd,
          refundReason: refundReason,
          externalReference: externalReference,
          resolutionNote: resolutionNote,
        );
    ref
      ..invalidate(openDisputesProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminEligiblePayoutsProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }

  Future<void> releasePayout({
    required String bookingId,
    String? externalReference,
    String? note,
  }) async {
    await ref
        .read(disputeRepositoryProvider)
        .releasePayout(
          bookingId: bookingId,
          externalReference: externalReference,
          note: note,
        );
    ref
      ..invalidate(payoutsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminEligiblePayoutsProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }
}
