import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final publicCarrierProfileProvider =
    FutureProvider.family<CarrierPublicProfileView, String>((ref, carrierId) {
      return ref
          .read(authRepositoryProvider)
          .fetchCarrierPublicProfile(carrierId);
    });

final myVehiclesProvider = FutureProvider<List<CarrierVehicle>>((ref) {
  return ref.read(vehicleRepositoryProvider).fetchMyVehicles();
});

final vehicleDetailProvider = FutureProvider.family<CarrierVehicle?, String>((
  ref,
  vehicleId,
) {
  return ref.read(vehicleRepositoryProvider).fetchVehicleById(vehicleId);
});

final myVerificationDocumentsProvider =
    FutureProvider<List<VerificationDocumentRecord>>((ref) {
      return ref.read(vehicleRepositoryProvider).fetchMyVerificationDocuments();
    });

final verificationDocumentDetailProvider =
    FutureProvider.family<VerificationDocumentRecord?, String>((
      ref,
      documentId,
    ) {
      return ref
          .read(vehicleRepositoryProvider)
          .fetchVerificationDocumentById(documentId);
    });

final verificationDocumentsForEntityProvider =
    FutureProvider.family<
      List<VerificationDocumentRecord>,
      ({
        VerificationEntityType entityType,
        String entityId,
      })
    >((ref, request) {
      return ref
          .read(vehicleRepositoryProvider)
          .fetchVerificationDocumentsForEntity(
            entityType: request.entityType,
            entityId: request.entityId,
          );
    });

final pendingVerificationPacketsProvider =
    FutureProvider<List<VerificationReviewPacket>>((ref) {
      return ref
          .read(verificationAdminRepositoryProvider)
          .fetchPendingReviewPackets();
    });

final pendingVerificationPacketProvider =
    FutureProvider.family<VerificationReviewPacket?, String>((ref, carrierId) {
      return ref
          .read(verificationAdminRepositoryProvider)
          .fetchPendingReviewPacketByCarrierId(carrierId);
    });

final verificationAuditProvider = FutureProvider<List<AdminAuditLogRecord>>((
  ref,
) {
  return ref
      .read(verificationAdminRepositoryProvider)
      .fetchLatestVerificationAudit();
});
