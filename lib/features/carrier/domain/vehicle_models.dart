import 'package:fleetfill/core/auth/auth_state.dart';

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

class CarrierVehicle {
  const CarrierVehicle({
    required this.id,
    required this.carrierId,
    required this.plateNumber,
    required this.vehicleType,
    required this.capacityWeightKg,
    required this.capacityVolumeM3,
    required this.verificationStatus,
    required this.verificationRejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

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

  final String id;
  final String carrierId;
  final String plateNumber;
  final String vehicleType;
  final double capacityWeightKg;
  final double? capacityVolumeM3;
  final AppVerificationState verificationStatus;
  final String? verificationRejectionReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class VerificationDocumentRecord {
  const VerificationDocumentRecord({
    required this.id,
    required this.ownerProfileId,
    required this.entityType,
    required this.entityId,
    required this.documentType,
    required this.storagePath,
    required this.status,
    required this.rejectionReason,
    required this.reviewedBy,
    required this.reviewedAt,
    required this.expiresAt,
    required this.version,
    required this.contentType,
    required this.byteSize,
    required this.checksumSha256,
    required this.uploadedBy,
    required this.uploadSessionId,
    required this.createdAt,
    required this.updatedAt,
  });

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
      version: json['version'] as int? ?? 1,
      contentType: (json['content_type'] as String?)?.trim(),
      byteSize: json['byte_size'] as int?,
      checksumSha256: (json['checksum_sha256'] as String?)?.trim(),
      uploadedBy: json['uploaded_by'] as String?,
      uploadSessionId: json['upload_session_id'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String id;
  final String ownerProfileId;
  final VerificationEntityType entityType;
  final String entityId;
  final VerificationDocumentType documentType;
  final String storagePath;
  final AppVerificationState status;
  final String? rejectionReason;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final DateTime? expiresAt;
  final int version;
  final String? contentType;
  final int? byteSize;
  final String? checksumSha256;
  final String? uploadedBy;
  final String? uploadSessionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

class VehicleVerificationOverview {
  const VehicleVerificationOverview({
    required this.vehicle,
    required this.documents,
  });

  final CarrierVehicle vehicle;
  final List<VerificationDocumentRecord> documents;
}

class VerificationUploadDraft {
  const VerificationUploadDraft({
    required this.path,
    required this.filename,
    required this.extension,
    required this.contentType,
    required this.byteSize,
    this.bytes,
  });

  final String path;
  final String filename;
  final String extension;
  final String contentType;
  final int byteSize;
  final List<int>? bytes;
}

class VerificationReviewPacket {
  const VerificationReviewPacket({
    required this.carrierId,
    required this.displayName,
    required this.companyName,
    required this.profileStatus,
    required this.profileRejectionReason,
    required this.profileDocuments,
    required this.vehicles,
  });

  final String carrierId;
  final String displayName;
  final String? companyName;
  final AppVerificationState profileStatus;
  final String? profileRejectionReason;
  final List<VerificationDocumentRecord> profileDocuments;
  final List<VehicleVerificationOverview> vehicles;

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

class AdminAuditLogRecord {
  const AdminAuditLogRecord({
    required this.id,
    required this.action,
    required this.targetType,
    required this.targetId,
    required this.outcome,
    required this.reason,
    required this.metadata,
    required this.createdAt,
  });

  factory AdminAuditLogRecord.fromJson(Map<String, dynamic> json) {
    return AdminAuditLogRecord(
      id: json['id'] as String,
      action: (json['action'] as String?)?.trim() ?? '',
      targetType: (json['target_type'] as String?)?.trim() ?? '',
      targetId: json['target_id'] as String?,
      outcome: (json['outcome'] as String?)?.trim() ?? '',
      reason: (json['reason'] as String?)?.trim(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  final String id;
  final String action;
  final String targetType;
  final String? targetId;
  final String outcome;
  final String? reason;
  final Map<String, dynamic> metadata;
  final DateTime? createdAt;
}
