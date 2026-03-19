import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final paymentAdminRepositoryProvider = Provider<PaymentAdminRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return PaymentAdminRepository(environment: environment, logger: logger);
});

class AdminPaymentProofQueueItem {
  const AdminPaymentProofQueueItem({
    required this.proof,
    required this.booking,
  });

  final PaymentProofRecord proof;
  final BookingRecord booking;
}

class PaymentAdminRepository {
  const PaymentAdminRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<AdminPaymentProofQueueItem>> fetchPendingPaymentProofs() async {
    final proofsResponse = await _client
        .from('payment_proofs')
        .select()
        .eq('status', 'pending')
        .order('submitted_at', ascending: true)
        .limit(50);
    final proofMaps = (proofsResponse as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final proofs = proofMaps.map(PaymentProofRecord.fromJson).toList(growable: false);
    if (proofs.isEmpty) {
      return const <AdminPaymentProofQueueItem>[];
    }

    final bookingIds = proofs.map((proof) => proof.bookingId).toSet().toList(growable: false);
    final bookingsResponse = await _client
        .from('bookings')
        .select()
        .inFilter('id', bookingIds);
    final bookingMap = {
      for (final item in (bookingsResponse as List<dynamic>).cast<Map<String, dynamic>>())
        (item['id'] as String): BookingRecord.fromJson(item),
    };

    return proofs
        .where((proof) => bookingMap.containsKey(proof.bookingId))
        .map(
          (proof) => AdminPaymentProofQueueItem(
            proof: proof,
            booking: bookingMap[proof.bookingId]!,
          ),
        )
        .toList(growable: false);
  }

  Future<PaymentProofRecord> approvePaymentProof({
    required String proofId,
    required double verifiedAmountDzd,
    String? verifiedReference,
    String? decisionNote,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_approve_payment_proof',
      params: {
        'p_payment_proof_id': proofId,
        'p_verified_amount_dzd': verifiedAmountDzd,
        'p_verified_reference': verifiedReference,
        'p_decision_note': decisionNote,
      },
    );
    return PaymentProofRecord.fromJson(response);
  }

  Future<PaymentProofRecord> rejectPaymentProof({
    required String proofId,
    required String rejectionReason,
    String? decisionNote,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_reject_payment_proof',
      params: {
        'p_payment_proof_id': proofId,
        'p_rejection_reason': rejectionReason,
        'p_decision_note': decisionNote,
      },
    );
    return PaymentProofRecord.fromJson(response);
  }
}
