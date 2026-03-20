import 'dart:io';
import 'dart:typed_data';

import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final paymentProofRepositoryProvider = Provider<PaymentProofRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return PaymentProofRepository(environment: environment, logger: logger);
});

class PaymentProofRepository {
  const PaymentProofRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<PaymentProofRecord>> fetchPaymentProofsForBooking(String bookingId) async {
    final response = await _client
        .from('payment_proofs')
        .select()
        .eq('booking_id', bookingId)
        .order('version', ascending: false)
        .order('submitted_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PaymentProofRecord.fromJson)
        .toList(growable: false);
  }

  Future<PaymentProofRecord?> fetchPaymentProofById(String proofId) async {
    final response = await _client
        .from('payment_proofs')
        .select()
        .eq('id', proofId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return PaymentProofRecord.fromJson(response);
  }

  Future<PaymentProofRecord> uploadPaymentProof({
    required String bookingId,
    required String paymentRail,
    required VerificationUploadDraft draft,
    required double submittedAmountDzd,
    String? submittedReference,
  }) async {
    final uploadSessionResponse = await _client.rpc<List<dynamic>>(
      'create_upload_session',
      params: {
        'p_upload_kind': 'payment_proof',
        'p_entity_type': 'booking',
        'p_entity_id': bookingId,
        'p_document_type': paymentRail,
        'p_file_extension': draft.extension,
        'p_content_type': draft.contentType,
        'p_byte_size': draft.byteSize,
        'p_checksum_sha256': null,
      },
    );

    final uploadSession = uploadSessionResponse.cast<Map<String, dynamic>>().single;
    final bucketId = uploadSession['bucket_id'] as String;
    final objectPath = uploadSession['object_path'] as String;
    final sessionId = uploadSession['upload_session_id'] as String;

    final storage = _client.storage.from(bucketId);
    final fileOptions = FileOptions(contentType: draft.contentType);
    final bytes = draft.bytes;
    final sourceFile = File(draft.path);

    if (bytes != null) {
      await storage.uploadBinary(
        objectPath,
        Uint8List.fromList(bytes),
        fileOptions: fileOptions,
      );
    } else {
      await storage.upload(objectPath, sourceFile, fileOptions: fileOptions);
    }

    final response = await _client.rpc<Map<String, dynamic>>(
      'finalize_payment_proof',
      params: {
        'p_upload_session_id': sessionId,
        'p_submitted_amount_dzd': submittedAmountDzd,
        'p_submitted_reference': submittedReference,
      },
    );

    logger.info('Uploaded payment proof', context: {'bookingId': bookingId});
    return PaymentProofRecord.fromJson(response);
  }

  Future<String> createSignedPaymentProofUrl(PaymentProofRecord proof) async {
    final response = await _client.functions.invoke(
      'signed-file-url',
      body: {
        'bucket_id': 'payment-proofs',
        'object_path': proof.storagePath,
      },
    );
    final data = response.data as Map<String, dynamic>?;
    if (data == null || data['signed_url'] == null) {
      throw const PostgrestException(message: 'document_signed_url_unavailable');
    }
    return data['signed_url'] as String;
  }

  Future<List<GeneratedDocumentRecord>> fetchGeneratedDocumentsForBooking(String bookingId) async {
    final response = await _client
        .from('generated_documents')
        .select()
        .eq('booking_id', bookingId)
        .order('created_at', ascending: false);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(GeneratedDocumentRecord.fromJson)
        .toList(growable: false);
  }

  Future<GeneratedDocumentRecord?> fetchGeneratedDocumentById(String documentId) async {
    final response = await _client
        .from('generated_documents')
        .select()
        .eq('id', documentId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return GeneratedDocumentRecord.fromJson(response);
  }

  Future<String> createSignedGeneratedDocumentUrl(GeneratedDocumentRecord document) async {
    final response = await _client.functions.invoke(
      'signed-file-url',
      body: {
        'bucket_id': 'generated-documents',
        'object_path': document.storagePath,
      },
    );
    final data = response.data as Map<String, dynamic>?;
    if (data == null || data['signed_url'] == null) {
      throw const PostgrestException(message: 'document_signed_url_unavailable');
    }
    return data['signed_url'] as String;
  }
}
