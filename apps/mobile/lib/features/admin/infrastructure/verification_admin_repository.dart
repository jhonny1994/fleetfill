import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final verificationAdminRepositoryProvider =
    Provider<VerificationAdminRepository>((ref) {
      final logger = ref.watch(appLoggerProvider);
      return VerificationAdminRepository(logger: logger);
    });

class VerificationAdminRepository {
  const VerificationAdminRepository({required this.logger});

  final AppLogger logger;
  static const _queuePageSize = 20;
  static const _queueWindowMultiplier = 3;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<VerificationReviewPacket>> fetchPendingReviewPackets({
    int limit = _queuePageSize,
  }) async {
    final normalizedLimit = limit < 1 ? _queuePageSize : limit;
    final windowSize = normalizedLimit * _queueWindowMultiplier;
    final packetMaps = await _fetchCandidateCarrierPackets(limit: windowSize);
    final packetsByCarrierId = {
      for (final packet in packetMaps) packet['carrier_id'] as String: packet,
    };
    final profileMaps = await _fetchCarrierProfiles(
      packetsByCarrierId.keys.toList(growable: false),
    );
    final packets = await _hydratePackets(profileMaps, packetsByCarrierId);
    packets.sort((a, b) {
      final pendingComparison = b.pendingDocumentCount.compareTo(
        a.pendingDocumentCount,
      );
      if (pendingComparison != 0) {
        return pendingComparison;
      }

      final aUpdatedAt = a.latestRelevantUpdateAt;
      final bUpdatedAt = b.latestRelevantUpdateAt;
      if (aUpdatedAt != null && bUpdatedAt != null) {
        final updatedComparison = aUpdatedAt.compareTo(bUpdatedAt);
        if (updatedComparison != 0) {
          return updatedComparison;
        }
      }

      return a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase());
    });
    return packets.take(normalizedLimit).toList(growable: false);
  }

  Future<VerificationReviewPacket?> fetchPendingReviewPacketByCarrierId(
    String carrierId,
  ) async {
    final packetResponse = await _client
        .from('carrier_verification_packets')
        .select()
        .eq('carrier_id', carrierId)
        .or('status.eq.pending,status.eq.rejected')
        .maybeSingle();

    if (packetResponse == null) {
      return null;
    }

    final profileMaps = await _fetchCarrierProfiles(<String>[carrierId]);
    if (profileMaps.isEmpty) {
      return null;
    }

    final packets = await _hydratePackets(profileMaps, {
      carrierId: packetResponse,
    });
    if (packets.isEmpty) {
      return null;
    }

    return packets.first;
  }

  Future<VerificationDocumentRecord> reviewVerificationDocument({
    required VerificationDocumentRecord document,
    required AppVerificationState nextStatus,
    String? reason,
  }) async {
    final normalizedReason = _normalizeReason(reason);
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_review_verification_document',
      params: {
        'p_document_id': document.id,
        'p_status': nextStatus.name,
        'p_reason': normalizedReason,
      },
    );

    logger.info(
      'Reviewed verification document',
      context: {
        'documentId': document.id,
        'nextStatus': nextStatus.name,
      },
    );

    return VerificationDocumentRecord.fromJson(response);
  }

  Future<void> approveAllVerificationPacket({
    required VerificationReviewPacket packet,
  }) async {
    await _client.rpc<List<dynamic>>(
      'admin_approve_verification_packet',
      params: {'p_carrier_id': packet.carrierId},
    );
  }

  Future<List<AdminAuditLogRecord>> fetchLatestVerificationAudit() async {
    final response = await _client
        .from('admin_audit_logs')
        .select()
        .inFilter('action', [
          'verification_document_approved',
          'verification_document_rejected',
          'verification_packet_approved',
        ])
        .order('created_at', ascending: false)
        .limit(30);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AdminAuditLogRecord.fromJson)
        .toList(growable: false);
  }

  String? _normalizeReason(String? reason) {
    final trimmed = reason?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  Future<List<Map<String, dynamic>>> _fetchCandidateCarrierPackets({
    required int limit,
  }) async {
    final response = await _client
        .from('carrier_verification_packets')
        .select()
        .or('status.eq.pending,status.eq.rejected')
        .order('updated_at', ascending: true)
        .limit(limit);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> _fetchCarrierProfiles(
    List<String> carrierIds,
  ) async {
    if (carrierIds.isEmpty) {
      return const <Map<String, dynamic>>[];
    }

    final response = await _client
        .from('profiles')
        .select()
        .eq('role', 'carrier')
        .inFilter('id', carrierIds);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<VerificationReviewPacket>> _hydratePackets(
    List<Map<String, dynamic>> profileMaps,
    Map<String, Map<String, dynamic>> packetsByCarrierId,
  ) async {
    if (profileMaps.isEmpty) {
      return const <VerificationReviewPacket>[];
    }

    final carrierIds = profileMaps
        .map((profile) => profile['id'] as String)
        .toList(growable: false);
    final vehicleMaps = await _fetchCarrierVehicles(carrierIds);
    final vehicles = vehicleMaps
        .map(CarrierVehicle.fromJson)
        .toList(growable: false);
    final vehiclesByCarrier = <String, List<CarrierVehicle>>{};
    for (final vehicle in vehicles) {
      vehiclesByCarrier.putIfAbsent(vehicle.carrierId, () => []).add(vehicle);
    }

    final vehicleIds = vehicles
        .map((vehicle) => vehicle.id)
        .toList(growable: false);
    final latestDocuments = await _fetchVerificationDocuments(
      carrierIds: carrierIds,
      vehicleIds: vehicleIds,
    );

    final documentsByEntity = <String, List<VerificationDocumentRecord>>{};
    for (final document in latestVerificationDocumentsByType(latestDocuments)) {
      final key = '${document.entityType.name}:${document.entityId}';
      documentsByEntity.putIfAbsent(key, () => []).add(document);
    }

    return profileMaps
        .map((profile) {
          final carrierId = profile['id'] as String;
          final packet = packetsByCarrierId[carrierId];
          if (packet == null) {
            return null;
          }
          final companyName = (profile['company_name'] as String?)?.trim();
          final fullName = (profile['full_name'] as String?)?.trim();
          final carrierVehicles =
              vehiclesByCarrier[carrierId] ?? const <CarrierVehicle>[];

          return VerificationReviewPacket(
            carrierId: carrierId,
            displayName: companyName ?? fullName ?? carrierId,
            companyName: companyName,
            carrierStatus: AppVerificationState.fromDatabase(
              packet['status'],
            ),
            carrierRejectionReason: (packet['rejection_reason'] as String?)
                ?.trim(),
            carrierDocuments:
                documentsByEntity['profile:$carrierId'] ??
                const <VerificationDocumentRecord>[],
            vehicles: carrierVehicles
                .map(
                  (vehicle) => VehicleVerificationOverview(
                    vehicle: vehicle,
                    documents:
                        documentsByEntity['vehicle:${vehicle.id}'] ??
                        const <VerificationDocumentRecord>[],
                  ),
                )
                .toList(growable: false),
          );
        })
        .whereType<VerificationReviewPacket>()
        .toList(growable: false);
  }

  Future<List<Map<String, dynamic>>> _fetchCarrierVehicles(
    List<String> carrierIds,
  ) async {
    if (carrierIds.isEmpty) {
      return const <Map<String, dynamic>>[];
    }

    final response = await _client
        .from('vehicles')
        .select()
        .inFilter('carrier_id', carrierIds)
        .or('verification_status.eq.pending,verification_status.eq.rejected')
        .order('updated_at', ascending: true);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<VerificationDocumentRecord>> _fetchVerificationDocuments({
    required List<String> carrierIds,
    required List<String> vehicleIds,
  }) async {
    final filters = <String>[
      'and(entity_type.eq.profile,entity_id.in.${_asInList(carrierIds)})',
      if (vehicleIds.isNotEmpty)
        'and(entity_type.eq.vehicle,entity_id.in.${_asInList(vehicleIds)})',
    ];

    final response = await _client
        .from('verification_documents')
        .select()
        .or(filters.join(','))
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(VerificationDocumentRecord.fromJson)
        .toList(growable: false);
  }

  String _asInList(List<String> values) {
    return '(${values.map(_quotePostgrestValue).join(',')})';
  }

  String _quotePostgrestValue(String value) {
    final slash = String.fromCharCode(92);
    final escaped = value
        .replaceAll(slash, '$slash$slash')
        .replaceAll('"', r'\"');
    return '"$escaped"';
  }
}
