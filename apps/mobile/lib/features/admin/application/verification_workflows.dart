import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminVerificationWorkflowControllerProvider =
    Provider<AdminVerificationWorkflowController>(
      AdminVerificationWorkflowController.new,
    );

class AdminVerificationWorkflowController {
  const AdminVerificationWorkflowController(this.ref);

  final Ref ref;

  Future<void> approveAll(VerificationReviewPacket packet) async {
    await ref
        .read(verificationAdminRepositoryProvider)
        .approveAllVerificationPacket(packet: packet);
    ref
      ..invalidate(pendingVerificationPacketsProvider)
      ..invalidate(pendingVerificationPacketProvider(packet.carrierId))
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }

  Future<void> reviewDocument({
    required VerificationDocumentRecord document,
    required AppVerificationState nextStatus,
    String? reason,
  }) async {
    await ref
        .read(verificationAdminRepositoryProvider)
        .reviewVerificationDocument(
          document: document,
          nextStatus: nextStatus,
          reason: reason,
        );
    ref
      ..invalidate(pendingVerificationPacketsProvider)
      ..invalidate(pendingVerificationPacketProvider(document.ownerProfileId))
      ..invalidate(adminOperationalSummaryProvider)
      ..invalidate(adminAuditLogsProvider)
      ..invalidate(verificationAuditProvider);
  }
}
