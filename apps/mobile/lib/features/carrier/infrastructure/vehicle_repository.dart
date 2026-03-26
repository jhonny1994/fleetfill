import 'dart:typed_data';

import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/supabase/direct_storage_upload.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return VehicleRepository(environment: environment, logger: logger);
});

class VehicleRepository {
  const VehicleRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<CarrierVehicle>> fetchMyVehicles() async {
    final response = await _client
        .from('vehicles')
        .select()
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(CarrierVehicle.fromJson)
        .toList(growable: false);
  }

  Future<CarrierVehicle?> fetchVehicleById(String vehicleId) async {
    final response = await _client
        .from('vehicles')
        .select()
        .eq('id', vehicleId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return CarrierVehicle.fromJson(response);
  }

  Future<CarrierVehicle> createVehicle({
    required String plateNumber,
    required String vehicleType,
    required double capacityWeightKg,
    double? capacityVolumeM3,
  }) async {
    final userId = _requireUserId();

    final response = await _client
        .from('vehicles')
        .insert({
          'carrier_id': userId,
          'plate_number': plateNumber.trim(),
          'vehicle_type': vehicleType.trim(),
          'capacity_weight_kg': capacityWeightKg,
          'capacity_volume_m3': capacityVolumeM3,
        })
        .select()
        .single();

    return CarrierVehicle.fromJson(response);
  }

  Future<CarrierVehicle> updateVehicle({
    required String vehicleId,
    required String plateNumber,
    required String vehicleType,
    required double capacityWeightKg,
    double? capacityVolumeM3,
  }) async {
    final response = await _client
        .from('vehicles')
        .update({
          'plate_number': plateNumber.trim(),
          'vehicle_type': vehicleType.trim(),
          'capacity_weight_kg': capacityWeightKg,
          'capacity_volume_m3': capacityVolumeM3,
        })
        .eq('id', vehicleId)
        .select()
        .single();

    return CarrierVehicle.fromJson(response);
  }

  Future<void> deleteVehicle(String vehicleId) {
    return _client.from('vehicles').delete().eq('id', vehicleId);
  }

  Future<List<VerificationDocumentRecord>>
  fetchMyVerificationDocuments() async {
    final userId = _requireUserId();
    final response = await _client
        .from('verification_documents')
        .select()
        .eq('owner_profile_id', userId)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(VerificationDocumentRecord.fromJson)
        .toList(growable: false);
  }

  Future<List<VerificationDocumentRecord>> fetchVerificationDocumentsForEntity({
    required VerificationEntityType entityType,
    required String entityId,
  }) async {
    final response = await _client
        .from('verification_documents')
        .select()
        .eq('entity_type', entityType.name)
        .eq('entity_id', entityId)
        .order('document_type')
        .order('version', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(VerificationDocumentRecord.fromJson)
        .toList(growable: false);
  }

  Future<VerificationDocumentRecord?> fetchVerificationDocumentById(
    String documentId,
  ) async {
    final response = await _client
        .from('verification_documents')
        .select()
        .eq('id', documentId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return VerificationDocumentRecord.fromJson(response);
  }

  Future<VerificationDocumentRecord> uploadVerificationDocument({
    required VerificationEntityType entityType,
    required String entityId,
    required VerificationDocumentType documentType,
    required VerificationUploadDraft draft,
  }) async {
    final uploadSessionResponse = await _client.rpc<List<dynamic>>(
      'create_upload_session',
      params: {
        'p_upload_kind': 'verification_document',
        'p_entity_type': entityType.name,
        'p_entity_id': entityId,
        'p_document_type': documentType.databaseValue,
        'p_file_extension': draft.extension,
        'p_content_type': draft.contentType,
        'p_byte_size': draft.byteSize,
        'p_checksum_sha256': null,
      },
    );

    final uploadSession = uploadSessionResponse
        .cast<Map<String, dynamic>>()
        .single;

    final bucketId = uploadSession['bucket_id'] as String;
    final objectPath = uploadSession['object_path'] as String;
    final sessionId = uploadSession['upload_session_id'] as String;

    final bytes = draft.bytes;
    await uploadToProjectStorage(
      environment: environment,
      client: _client,
      bucketId: bucketId,
      objectPath: objectPath,
      contentType: draft.contentType,
      bytes: bytes != null ? Uint8List.fromList(bytes) : null,
      filePath: bytes == null ? draft.path : null,
    );

    final response = await _client.rpc<Map<String, dynamic>>(
      'finalize_verification_document',
      params: {'p_upload_session_id': sessionId},
    );

    logger.info(
      'Uploaded verification document',
      context: {
        'entityType': entityType.name,
        'entityId': entityId,
        'documentType': documentType.databaseValue,
      },
    );

    return VerificationDocumentRecord.fromJson(response);
  }

  Future<String> createSignedDocumentUrl(
    VerificationDocumentRecord document,
  ) async {
    try {
      final response = await _client.functions.invoke(
        'signed-file-url',
        body: {
          'bucket_id': 'verification-documents',
          'object_path': document.storagePath,
          'public_base_url': environment.supabaseUrl,
        },
      );

      final data = response.data as Map<String, dynamic>?;
      if (data == null || data['signed_url'] == null) {
        throw const PostgrestException(
          message: 'document_signed_url_unavailable',
        );
      }

      return data['signed_url'] as String;
    } catch (error, stackTrace) {
      logger.warning(
        'Verification document URL failed',
        error: error,
        stackTrace: stackTrace,
        context: {
          'documentId': document.id,
          'storagePath': document.storagePath,
          'documentType': document.documentType.databaseValue,
        },
      );
      rethrow;
    }
  }

  String _requireUserId() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('authentication_required');
    }
    return userId;
  }
}
