import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final shipmentRepositoryProvider = Provider<ShipmentRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return ShipmentRepository(environment: environment, logger: logger);
});

class ShipmentRepository {
  const ShipmentRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;
  static const defaultPageSize = 20;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<ShipmentDraftRecord>> fetchMyShipments({
    int limit = defaultPageSize,
    int offset = 0,
  }) async {
    final response = await _client
        .from('shipments')
        .select()
        .range(offset, offset + limit - 1)
        .order('updated_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(ShipmentDraftRecord.fromJson)
        .toList(growable: false);
  }

  Future<ShipmentDraftRecord?> fetchShipmentById(String shipmentId) async {
    final shipment = await _client
        .from('shipments')
        .select()
        .eq('id', shipmentId)
        .maybeSingle();
    if (shipment == null) {
      return null;
    }

    return ShipmentDraftRecord.fromJson(shipment);
  }

  Future<ShipmentDraftRecord> createShipmentDraft(
    ShipmentDraftInput input,
  ) async {
    final userId = _requireUserId();
    final shipment = await _client
        .from('shipments')
        .insert({
          'shipper_id': userId,
          'origin_commune_id': input.originCommuneId,
          'destination_commune_id': input.destinationCommuneId,
          'total_weight_kg': input.totalWeightKg,
          'total_volume_m3': input.totalVolumeM3,
          'description': _nullable(input.details),
          'status': ShipmentStatus.draft.databaseValue,
        })
        .select()
        .single();

    return ShipmentDraftRecord.fromJson(shipment);
  }

  Future<ShipmentDraftRecord> updateShipmentDraft({
    required String shipmentId,
    required ShipmentDraftInput input,
  }) async {
    await _client
        .from('shipments')
        .update({
          'origin_commune_id': input.originCommuneId,
          'destination_commune_id': input.destinationCommuneId,
          'total_weight_kg': input.totalWeightKg,
          'total_volume_m3': input.totalVolumeM3,
          'description': _nullable(input.details),
        })
        .eq('id', shipmentId);

    final shipment = await _client
        .from('shipments')
        .select()
        .eq('id', shipmentId)
        .single();
    return ShipmentDraftRecord.fromJson(shipment);
  }

  Future<void> deleteShipmentDraft(String shipmentId) async {
    await _client.from('shipments').delete().eq('id', shipmentId);
  }

  Future<ShipmentSearchResponse> searchExactLaneCapacity(
    ShipmentSearchQuery query,
  ) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'search_exact_lane_capacity',
      params: {
        'p_origin_commune_id': query.originCommuneId,
        'p_destination_commune_id': query.destinationCommuneId,
        'p_requested_date': dateOnly(query.requestedDate),
        'p_total_weight_kg': query.totalWeightKg,
        'p_total_volume_m3': query.totalVolumeM3,
        'p_sort': switch (query.sort) {
          SearchSortOption.topRated => 'top_rated',
          SearchSortOption.lowestPrice => 'lowest_price',
          SearchSortOption.nearestDeparture => 'nearest_departure',
          SearchSortOption.recommended => 'recommended',
        },
        'p_limit': query.limit,
        'p_offset': query.offset,
      },
    );
    return ShipmentSearchResponse.fromJson(response);
  }

  String _requireUserId() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('authentication_required');
    }
    return userId;
  }

  String? _nullable(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  String dateOnly(DateTime value) {
    final date = DateTime(value.year, value.month, value.day);
    return date.toIso8601String().split('T').first;
  }
}
