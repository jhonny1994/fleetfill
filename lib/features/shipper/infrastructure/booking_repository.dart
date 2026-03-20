import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return BookingRepository(environment: environment, logger: logger);
});

class BookingRepository {
  const BookingRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<BookingRecord>> fetchCarrierBookings({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client
        .from('bookings')
        .select()
        .range(offset, offset + limit - 1)
        .order('updated_at', ascending: false);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(BookingRecord.fromJson)
        .toList(growable: false);
  }

  Future<List<TrackingEventRecord>> fetchTrackingEvents(String bookingId) async {
    final response = await _client
        .from('tracking_events')
        .select()
        .eq('booking_id', bookingId)
        .order('recorded_at', ascending: false)
        .order('created_at', ascending: false);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(TrackingEventRecord.fromJson)
        .toList(growable: false);
  }

  Future<BookingRecord?> fetchBookingById(String bookingId) async {
    final response = await _client
        .from('bookings')
        .select()
        .eq('id', bookingId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return BookingRecord.fromJson(response);
  }

  Future<Map<String, dynamic>> fetchClientSettings() async {
    final response = await _client.rpc<Map<String, dynamic>>('get_client_settings');
    return response;
  }

  Future<BookingRecord> createBooking({
    required String shipmentId,
    required String sourceType,
    required String sourceId,
    required bool includeInsurance,
    DateTime? departureDate,
    String? idempotencyKey,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'create_booking_from_search_result',
      params: {
        'p_shipment_id': shipmentId,
        'p_source_type': sourceType,
        'p_source_id': sourceId,
        'p_departure_date': departureDate == null
            ? null
            : DateTime(departureDate.year, departureDate.month, departureDate.day)
                .toIso8601String()
                .split('T')
                .first,
        'p_include_insurance': includeInsurance,
        'p_idempotency_key': idempotencyKey,
      },
    );
    return BookingRecord.fromJson(response);
  }

  Future<BookingRecord> carrierRecordMilestone({
    required String bookingId,
    required String milestone,
    String? note,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'carrier_record_booking_milestone',
      params: {
        'p_booking_id': bookingId,
        'p_milestone': milestone,
        'p_note': note,
      },
    );
    return BookingRecord.fromJson(response);
  }

  Future<BookingRecord> shipperConfirmDelivery({
    required String bookingId,
    String? note,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'shipper_confirm_delivery',
      params: {
        'p_booking_id': bookingId,
        'p_note': note,
      },
    );
    return BookingRecord.fromJson(response);
  }
}
