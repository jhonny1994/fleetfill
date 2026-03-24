import 'package:fleetfill/core/auth/auth_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_models.freezed.dart';

enum VerificationEntityType { profile, vehicle }

enum VerificationDocumentType {
  driverIdentityOrLicense,
  truckRegistration,
  truckInsurance,
  truckTechnicalInspection,
  transportLicense,
}

extension VerificationDocumentTypeX on VerificationDocumentType {
  String get databaseValue => switch (this) {
    VerificationDocumentType.driverIdentityOrLicense =>
      'driver_identity_or_license',
    VerificationDocumentType.truckRegistration => 'truck_registration',
    VerificationDocumentType.truckInsurance => 'truck_insurance',
    VerificationDocumentType.truckTechnicalInspection =>
      'truck_technical_inspection',
    VerificationDocumentType.transportLicense => 'transport_license',
  };

  bool get isProfileDocument =>
      this == VerificationDocumentType.driverIdentityOrLicense;

  bool get isLiveDocument => this != VerificationDocumentType.transportLicense;

  static VerificationDocumentType fromDatabase(String value) {
    return switch (value) {
      'driver_identity_or_license' =>
        VerificationDocumentType.driverIdentityOrLicense,
      'truck_registration' => VerificationDocumentType.truckRegistration,
      'truck_insurance' => VerificationDocumentType.truckInsurance,
      'truck_technical_inspection' =>
        VerificationDocumentType.truckTechnicalInspection,
      'transport_license' => VerificationDocumentType.transportLicense,
      _ => VerificationDocumentType.driverIdentityOrLicense,
    };
  }
}

@freezed
abstract class CarrierVehicle with _$CarrierVehicle {
  const factory CarrierVehicle({
    required String id,
    required String carrierId,
    required String plateNumber,
    required String vehicleType,
    required double capacityWeightKg,
    required double? capacityVolumeM3,
    required AppVerificationState verificationStatus,
    required String? verificationRejectionReason,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _CarrierVehicle;

  const CarrierVehicle._();

  factory CarrierVehicle.fromJson(Map<String, dynamic> json) {
    return CarrierVehicle(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      plateNumber: (json['plate_number'] as String?)?.trim() ?? '',
      vehicleType: (json['vehicle_type'] as String?)?.trim() ?? '',
      capacityWeightKg: (json['capacity_weight_kg'] as num?)?.toDouble() ?? 0,
      capacityVolumeM3: (json['capacity_volume_m3'] as num?)?.toDouble(),
      verificationStatus: AppVerificationState.fromDatabase(
        json['verification_status'],
      ),
      verificationRejectionReason:
          (json['verification_rejection_reason'] as String?)?.trim(),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class VerificationDocumentRecord with _$VerificationDocumentRecord {
  const factory VerificationDocumentRecord({
    required String id,
    required String ownerProfileId,
    required VerificationEntityType entityType,
    required String entityId,
    required VerificationDocumentType documentType,
    required String storagePath,
    required AppVerificationState status,
    required String? rejectionReason,
    required String? reviewedBy,
    required DateTime? reviewedAt,
    required DateTime? expiresAt,
    required int version,
    required String? contentType,
    required int? byteSize,
    required String? checksumSha256,
    required String? uploadedBy,
    required String? uploadSessionId,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _VerificationDocumentRecord;

  const VerificationDocumentRecord._();

  factory VerificationDocumentRecord.fromJson(Map<String, dynamic> json) {
    return VerificationDocumentRecord(
      id: json['id'] as String,
      ownerProfileId: json['owner_profile_id'] as String,
      entityType: switch (json['entity_type']) {
        'vehicle' => VerificationEntityType.vehicle,
        _ => VerificationEntityType.profile,
      },
      entityId: json['entity_id'] as String,
      documentType: VerificationDocumentTypeX.fromDatabase(
        json['document_type'] as String? ?? '',
      ),
      storagePath: (json['storage_path'] as String?)?.trim() ?? '',
      status: AppVerificationState.fromDatabase(json['status']),
      rejectionReason: (json['rejection_reason'] as String?)?.trim(),
      reviewedBy: json['reviewed_by'] as String?,
      reviewedAt: DateTime.tryParse(json['reviewed_at'] as String? ?? ''),
      expiresAt: DateTime.tryParse(json['expires_at'] as String? ?? ''),
      version: (json['version'] as num?)?.toInt() ?? 1,
      contentType: (json['content_type'] as String?)?.trim(),
      byteSize: (json['byte_size'] as num?)?.toInt(),
      checksumSha256: (json['checksum_sha256'] as String?)?.trim(),
      uploadedBy: json['uploaded_by'] as String?,
      uploadSessionId: json['upload_session_id'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  bool isNewerThan(VerificationDocumentRecord other) {
    if (version != other.version) {
      return version > other.version;
    }

    final createdAtValue = createdAt;
    final otherCreatedAtValue = other.createdAt;
    if (createdAtValue != null && otherCreatedAtValue != null) {
      return createdAtValue.isAfter(otherCreatedAtValue);
    }

    return id.compareTo(other.id) > 0;
  }
}

List<VerificationDocumentRecord> latestVerificationDocumentsByType(
  Iterable<VerificationDocumentRecord> documents,
) {
  final latestByType = <VerificationDocumentType, VerificationDocumentRecord>{};

  for (final document in documents) {
    final current = latestByType[document.documentType];
    if (current == null || document.isNewerThan(current)) {
      latestByType[document.documentType] = document;
    }
  }

  return latestByType.values.toList(growable: false)
    ..sort((a, b) => a.documentType.index.compareTo(b.documentType.index));
}

@freezed
abstract class VehicleVerificationOverview with _$VehicleVerificationOverview {
  const factory VehicleVerificationOverview({
    required CarrierVehicle vehicle,
    required List<VerificationDocumentRecord> documents,
  }) = _VehicleVerificationOverview;

  const VehicleVerificationOverview._();
}

@freezed
abstract class VerificationUploadDraft with _$VerificationUploadDraft {
  const factory VerificationUploadDraft({
    required String path,
    required String filename,
    required String extension,
    required String contentType,
    required int byteSize,
    List<int>? bytes,
  }) = _VerificationUploadDraft;

  const VerificationUploadDraft._();
}

@freezed
abstract class VerificationReviewPacket with _$VerificationReviewPacket {
  const factory VerificationReviewPacket({
    required String carrierId,
    required String displayName,
    required String? companyName,
    required AppVerificationState profileStatus,
    required String? profileRejectionReason,
    required List<VerificationDocumentRecord> profileDocuments,
    required List<VehicleVerificationOverview> vehicles,
  }) = _VerificationReviewPacket;

  const VerificationReviewPacket._();

  int get vehicleCount => vehicles.length;

  int get pendingDocumentCount => [
    ...profileDocuments,
    for (final vehicle in vehicles) ...vehicle.documents,
  ].where((document) => document.status == AppVerificationState.pending).length;

  DateTime? get latestRelevantUpdateAt {
    final candidates = <DateTime>[
      for (final document in profileDocuments)
        if (document.updatedAt != null) document.updatedAt!,
      for (final vehicle in vehicles)
        if (vehicle.vehicle.updatedAt != null) vehicle.vehicle.updatedAt!,
      for (final vehicle in vehicles)
        for (final document in vehicle.documents)
          if (document.updatedAt != null) document.updatedAt!,
    ];

    if (candidates.isEmpty) {
      return null;
    }

    candidates.sort();
    return candidates.last;
  }
}

@freezed
abstract class AdminAuditLogRecord with _$AdminAuditLogRecord {
  const factory AdminAuditLogRecord({
    required String id,
    required String action,
    required String targetType,
    required String? targetId,
    required String outcome,
    required String? reason,
    required Map<String, dynamic> metadata,
    required DateTime? createdAt,
  }) = _AdminAuditLogRecord;

  const AdminAuditLogRecord._();

  factory AdminAuditLogRecord.fromJson(Map<String, dynamic> json) {
    return AdminAuditLogRecord(
      id: json['id'] as String,
      action: (json['action'] as String?)?.trim() ?? '',
      targetType: (json['target_type'] as String?)?.trim() ?? '',
      targetId: json['target_id'] as String?,
      outcome: (json['outcome'] as String?)?.trim() ?? '',
      reason: (json['reason'] as String?)?.trim(),
      metadata: Map<String, dynamic>.from(
        (json['metadata'] as Map?) ?? const <String, dynamic>{},
      ),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }
}
