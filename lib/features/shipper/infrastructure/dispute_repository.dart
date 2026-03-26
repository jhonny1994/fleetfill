import 'dart:io';
import 'dart:typed_data';

import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final disputeRepositoryProvider = Provider<DisputeRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return DisputeRepository(environment: environment, logger: logger);
});

class DisputeRepository {
  const DisputeRepository({required this.environment, required this.logger});

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<DisputeRecord>> fetchOpenDisputes() async {
    final response = await _client
        .from('disputes')
        .select('*, dispute_evidence(count)')
        .eq('status', 'open')
        .order('created_at', ascending: true);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(_mapDispute)
        .toList(growable: false);
  }

  Future<DisputeRecord> createDispute({
    required String bookingId,
    required String reason,
    String? description,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'create_dispute_from_delivery',
      params: {
        'p_booking_id': bookingId,
        'p_reason': reason,
        'p_description': description,
      },
    );
    return _mapDispute(response);
  }

  Future<List<DisputeEvidenceRecord>> fetchDisputeEvidence(
    String disputeId,
  ) async {
    final response = await _client
        .from('dispute_evidence')
        .select()
        .eq('dispute_id', disputeId)
        .order('created_at', ascending: false);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(DisputeEvidenceRecord.fromJson)
        .toList(growable: false);
  }

  Future<DisputeEvidenceRecord?> fetchDisputeEvidenceById(
    String evidenceId,
  ) async {
    final response = await _client
        .from('dispute_evidence')
        .select()
        .eq('id', evidenceId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return DisputeEvidenceRecord.fromJson(response);
  }

  Future<DisputeEvidenceRecord> uploadDisputeEvidence({
    required String disputeId,
    required VerificationUploadDraft draft,
    String? note,
  }) async {
    final uploadSessionResponse = await _client.rpc<List<dynamic>>(
      'create_upload_session',
      params: {
        'p_upload_kind': 'dispute_evidence',
        'p_entity_type': 'dispute',
        'p_entity_id': disputeId,
        'p_document_type': 'evidence',
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
    final storage = _client.storage.from(bucketId);
    final fileOptions = FileOptions(contentType: draft.contentType);

    if (draft.bytes != null) {
      await storage.uploadBinary(
        objectPath,
        Uint8List.fromList(draft.bytes!),
        fileOptions: fileOptions,
      );
    } else {
      await storage.upload(
        objectPath,
        File(draft.path),
        fileOptions: fileOptions,
      );
    }

    final response = await _client.rpc<Map<String, dynamic>>(
      'finalize_dispute_evidence',
      params: {
        'p_upload_session_id': sessionId,
        'p_note': note,
      },
    );
    return DisputeEvidenceRecord.fromJson(response);
  }

  Future<String> createSignedDisputeEvidenceUrl(
    DisputeEvidenceRecord evidence,
  ) async {
    final response = await _client.functions.invoke(
      'signed-file-url',
      body: {
        'bucket_id': 'dispute-evidence',
        'object_path': evidence.storagePath,
      },
    );
    final data = response.data as Map<String, dynamic>?;
    if (data == null || data['signed_url'] == null) {
      throw const PostgrestException(
        message: 'document_signed_url_unavailable',
      );
    }
    return data['signed_url'] as String;
  }

  Future<DisputeRecord> resolveComplete({
    required String disputeId,
    String? resolutionNote,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_resolve_dispute_complete',
      params: {'p_dispute_id': disputeId, 'p_resolution_note': resolutionNote},
    );
    return _mapDispute(response);
  }

  Future<DisputeRecord> resolveRefund({
    required String disputeId,
    required double refundAmountDzd,
    required String refundReason,
    String? externalReference,
    String? resolutionNote,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_resolve_dispute_refund',
      params: {
        'p_dispute_id': disputeId,
        'p_refund_amount_dzd': refundAmountDzd,
        'p_refund_reason': refundReason,
        'p_external_reference': externalReference,
        'p_resolution_note': resolutionNote,
      },
    );
    return _mapDispute(response);
  }

  Future<List<PayoutRecord>> fetchPayouts({String? bookingId}) async {
    var query = _client.from('payouts').select();
    if (bookingId != null) {
      query = query.eq('booking_id', bookingId);
    }
    final response = await query.order('created_at', ascending: false);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PayoutRecord.fromJson)
        .toList(growable: false);
  }

  Future<PayoutRecord> releasePayout({
    required String bookingId,
    String? externalReference,
    String? note,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_release_payout',
      params: {
        'p_booking_id': bookingId,
        'p_external_reference': externalReference,
        'p_note': note,
      },
    );
    return PayoutRecord.fromJson(response);
  }

  DisputeRecord _mapDispute(Map<String, dynamic> json) {
    final evidenceRelation = json['dispute_evidence'];
    final evidenceCount = switch (evidenceRelation) {
      final List<dynamic> relation when relation.isNotEmpty =>
        ((relation.first as Map<String, dynamic>)['count'] as num?)?.toInt() ??
            0,
      _ => 0,
    };

    return DisputeRecord.fromJson({
      ...json,
      'evidence_count': evidenceCount,
    });
  }
}
