import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/shared/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminPaymentWorkflowControllerProvider =
    Provider<AdminPaymentWorkflowController>(
      AdminPaymentWorkflowController.new,
    );

class AdminPaymentWorkflowController {
  const AdminPaymentWorkflowController(this.ref);

  final Ref ref;

  Future<void> approvePaymentProof({
    required String proofId,
    required double verifiedAmountDzd,
    String? verifiedReference,
    String? decisionNote,
  }) async {
    await ref
        .read(paymentAdminRepositoryProvider)
        .approvePaymentProof(
          proofId: proofId,
          verifiedAmountDzd: verifiedAmountDzd,
          verifiedReference: verifiedReference,
          decisionNote: decisionNote,
        );
    ref
      ..invalidate(pendingPaymentProofsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }

  Future<void> rejectPaymentProof({
    required String proofId,
    required String rejectionReason,
    String? decisionNote,
  }) async {
    await ref
        .read(paymentAdminRepositoryProvider)
        .rejectPaymentProof(
          proofId: proofId,
          rejectionReason: rejectionReason,
          decisionNote: decisionNote,
        );
    ref
      ..invalidate(pendingPaymentProofsProvider)
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAutomationAlertsProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }
}
