import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/support/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  final logger = ref.watch(appLoggerProvider);
  return SupportRepository(logger: logger);
});

class SupportRepository {
  const SupportRepository({required this.logger});

  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<SupportRequestRecord> createSupportRequest({
    required String locale,
    required String subject,
    required String message,
    String? shipmentId,
    String? bookingId,
    String? paymentProofId,
    String? disputeId,
  }) async {
    final normalizedSubject = subject.trim();
    final normalizedMessage = message.trim();
    logger.info(
      'Creating support request',
      context: {
        'locale': locale,
        'subjectLength': normalizedSubject.length,
        'messageLength': normalizedMessage.length,
        'shipmentId': shipmentId,
        'bookingId': bookingId,
        'paymentProofId': paymentProofId,
        'disputeId': disputeId,
      },
    );

    final response = await _client.rpc<Map<String, dynamic>>(
      'create_support_request',
      params: {
        'p_locale': locale,
        'p_subject': normalizedSubject,
        'p_message': normalizedMessage,
        'p_shipment_id': shipmentId,
        'p_booking_id': bookingId,
        'p_payment_proof_id': paymentProofId,
        'p_dispute_id': disputeId,
      },
    );

    return SupportRequestRecord.fromJson(response);
  }

  Future<List<SupportRequestRecord>> fetchMySupportRequests({
    int limit = 50,
  }) async {
    final response = await _client
        .from('support_requests')
        .select()
        .order('last_message_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(SupportRequestRecord.fromJson)
        .toList(growable: false);
  }

  Future<SupportRequestRecord?> fetchSupportRequestById(
    String requestId,
  ) async {
    final response = await _client
        .from('support_requests')
        .select()
        .eq('id', requestId)
        .maybeSingle();
    if (response == null) return null;
    return SupportRequestRecord.fromJson(response);
  }

  Future<List<SupportMessageRecord>> fetchSupportMessages(
    String requestId,
  ) async {
    final response = await _client
        .from('support_messages')
        .select()
        .eq('request_id', requestId)
        .order('created_at', ascending: true);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(SupportMessageRecord.fromJson)
        .toList(growable: false);
  }

  Future<SupportThreadRecord?> fetchSupportThread(String requestId) async {
    final request = await fetchSupportRequestById(requestId);
    if (request == null) {
      return null;
    }
    final messages = await fetchSupportMessages(requestId);
    return SupportThreadRecord(request: request, messages: messages);
  }

  Future<SupportMessageRecord> replyToSupportRequest({
    required String requestId,
    required String message,
  }) async {
    final normalizedMessage = message.trim();
    logger.info(
      'Replying to support request',
      context: {
        'requestId': requestId,
        'messageLength': normalizedMessage.length,
      },
    );

    final response = await _client.rpc<Map<String, dynamic>>(
      'reply_to_support_request',
      params: {
        'p_request_id': requestId,
        'p_message': normalizedMessage,
      },
    );
    return SupportMessageRecord.fromJson(response);
  }

  Future<SupportRequestRecord> markSupportRequestRead(String requestId) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'mark_support_request_read',
      params: {'p_request_id': requestId},
    );
    return SupportRequestRecord.fromJson(response);
  }

  Future<List<SupportRequestRecord>> fetchAdminSupportRequests({
    String? query,
    String? status,
    int limit = 50,
  }) async {
    var request = _client.from('support_requests').select();

    final trimmedStatus = status?.trim();
    if (trimmedStatus != null && trimmedStatus.isNotEmpty) {
      request = request.eq('status', trimmedStatus);
    }

    final trimmedQuery = query?.trim();
    if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
      request = request.or(
        'subject.ilike.%$trimmedQuery%,created_by.eq.$trimmedQuery,booking_id.eq.$trimmedQuery,shipment_id.eq.$trimmedQuery,payment_proof_id.eq.$trimmedQuery,dispute_id.eq.$trimmedQuery',
      );
    }

    final response = await request
        .order('last_message_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(SupportRequestRecord.fromJson)
        .toList(growable: false);
  }

  Future<SupportRequestRecord> adminSetSupportRequestStatus({
    required String requestId,
    required SupportRequestStatus status,
    SupportRequestPriority? priority,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_set_support_request_status',
      params: {
        'p_request_id': requestId,
        'p_status': _supportRequestStatusValue(status),
        'p_priority': priority == null
            ? null
            : _supportRequestPriorityValue(priority),
      },
    );
    return SupportRequestRecord.fromJson(response);
  }

  Future<SupportRequestRecord> adminAssignSupportRequest({
    required String requestId,
    String? assignedAdminId,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_assign_support_request',
      params: {
        'p_request_id': requestId,
        'p_assigned_admin_id': assignedAdminId,
      },
    );
    return SupportRequestRecord.fromJson(response);
  }
}

String _supportRequestStatusValue(SupportRequestStatus status) {
  return switch (status) {
    SupportRequestStatus.open => 'open',
    SupportRequestStatus.inProgress => 'in_progress',
    SupportRequestStatus.waitingForUser => 'waiting_for_user',
    SupportRequestStatus.resolved => 'resolved',
    SupportRequestStatus.closed => 'closed',
  };
}

String _supportRequestPriorityValue(SupportRequestPriority priority) {
  return switch (priority) {
    SupportRequestPriority.normal => 'normal',
    SupportRequestPriority.high => 'high',
    SupportRequestPriority.urgent => 'urgent',
  };
}
