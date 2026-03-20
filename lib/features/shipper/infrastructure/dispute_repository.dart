import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
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
        .select()
        .eq('status', 'open')
        .order('created_at', ascending: true);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(DisputeRecord.fromJson)
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
    return DisputeRecord.fromJson(response);
  }

  Future<DisputeRecord> resolveComplete({
    required String disputeId,
    String? resolutionNote,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_resolve_dispute_complete',
      params: {'p_dispute_id': disputeId, 'p_resolution_note': resolutionNote},
    );
    return DisputeRecord.fromJson(response);
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
    return DisputeRecord.fromJson(response);
  }

  Future<List<PayoutRecord>> fetchPayouts() async {
    final response = await _client
        .from('payouts')
        .select()
        .order('created_at', ascending: false);
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
}
