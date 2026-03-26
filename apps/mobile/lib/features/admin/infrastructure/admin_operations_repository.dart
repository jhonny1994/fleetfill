import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/admin/admin.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final adminOperationsRepositoryProvider = Provider<AdminOperationsRepository>((
  ref,
) {
  final logger = ref.watch(appLoggerProvider);
  return AdminOperationsRepository(logger: logger);
});

class AdminOperationsRepository {
  const AdminOperationsRepository({required this.logger});

  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<AdminOperationalSummary> fetchOperationalSummary() async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_get_operational_summary',
    );
    return AdminOperationalSummary.fromJson(response);
  }

  Future<List<AdminUserListItem>> fetchUsers({
    String? query,
    int limit = 50,
  }) async {
    var request = _client.from('profiles').select();

    final trimmedQuery = query?.trim();
    if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
      request = request.or(
        'email.ilike.%$trimmedQuery%,full_name.ilike.%$trimmedQuery%,company_name.ilike.%$trimmedQuery%,phone_number.ilike.%$trimmedQuery%',
      );
    }

    final response = await request
        .order('updated_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AppProfile.fromJson)
        .map((profile) => AdminUserListItem(profile: profile))
        .toList(growable: false);
  }

  Future<AdminUserDetail?> fetchUserDetail(String profileId) async {
    final profileResponse = await _client
        .from('profiles')
        .select()
        .eq('id', profileId)
        .maybeSingle();
    if (profileResponse == null) {
      return null;
    }

    final profile = AppProfile.fromJson(profileResponse);
    final bookingsResponse = await _client
        .from('bookings')
        .select()
        .or('shipper_id.eq.$profileId,carrier_id.eq.$profileId')
        .order('updated_at', ascending: false)
        .limit(25);

    final vehiclesResponse = profile.role == AppUserRole.carrier
        ? await _client
              .from('vehicles')
              .select()
              .eq('carrier_id', profileId)
              .order('updated_at', ascending: false)
        : const <dynamic>[];

    final vehicleMaps = vehiclesResponse.cast<Map<String, dynamic>>();
    final vehicleIds = vehicleMaps
        .map((item) => item['id'] as String)
        .toList(growable: false);

    final documentsResponse = await _fetchUserVerificationDocuments(
      profileId: profileId,
      vehicleIds: vehicleIds,
    );

    final emailLogsResponse = await _client
        .from('email_delivery_logs')
        .select()
        .eq('profile_id', profileId)
        .order('created_at', ascending: false)
        .limit(20);

    return AdminUserDetail(
      profile: profile,
      bookings: (bookingsResponse as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(BookingRecord.fromJson)
          .toList(growable: false),
      vehicles: vehicleIds.isEmpty
          ? const <CarrierVehicle>[]
          : vehicleMaps.map(CarrierVehicle.fromJson).toList(growable: false),
      verificationDocuments: documentsResponse
          .map(VerificationDocumentRecord.fromJson)
          .toList(growable: false),
      emailLogs: (emailLogsResponse as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(EmailDeliveryLogRecord.fromJson)
          .toList(growable: false),
    );
  }

  Future<List<PlatformSettingRecord>> fetchPlatformSettings() async {
    final response = await _client
        .from('platform_settings')
        .select()
        .order('key', ascending: true);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(PlatformSettingRecord.fromJson)
        .toList(growable: false);
  }

  Future<PlatformSettingRecord> upsertPlatformSetting({
    required String key,
    required Map<String, dynamic> value,
    required bool isPublic,
    String? description,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_upsert_platform_setting',
      params: {
        'p_key': key,
        'p_value': value,
        'p_is_public': isPublic,
        'p_description': description,
      },
    );
    return PlatformSettingRecord.fromJson(response);
  }

  Future<List<AdminAuditLogRecord>> fetchAuditLogs({int limit = 100}) async {
    final response = await _client
        .from('admin_audit_logs')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AdminAuditLogRecord.fromJson)
        .toList(growable: false);
  }

  Future<List<EmailDeliveryLogRecord>> fetchEmailLogs({
    String? status,
    String? query,
    int limit = 50,
  }) async {
    var request = _client.from('email_delivery_logs').select();

    final trimmedStatus = status?.trim();
    if (trimmedStatus != null && trimmedStatus.isNotEmpty) {
      request = request.eq('status', trimmedStatus);
    }

    final trimmedQuery = query?.trim();
    if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
      request = request.or(
        'recipient_email.ilike.%$trimmedQuery%,template_key.ilike.%$trimmedQuery%,booking_id.eq.$trimmedQuery,profile_id.eq.$trimmedQuery',
      );
    }

    final response = await request
        .order('created_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(EmailDeliveryLogRecord.fromJson)
        .toList(growable: false);
  }

  Future<List<EmailOutboxJobRecord>> fetchDeadLetterEmailJobs({
    int limit = 50,
  }) async {
    final response = await _client
        .from('email_outbox_jobs')
        .select()
        .eq('status', 'dead_letter')
        .order('updated_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(EmailOutboxJobRecord.fromJson)
        .toList(growable: false);
  }

  Future<EmailOutboxJobRecord> resendDeadLetterEmailJob(String jobId) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_retry_dead_letter_email_job',
      params: {'p_job_id': jobId},
    );
    return EmailOutboxJobRecord.fromJson(response);
  }

  Future<EmailOutboxJobRecord> resendEmailDelivery(String deliveryLogId) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_retry_email_delivery',
      params: {'p_delivery_log_id': deliveryLogId},
    );
    return EmailOutboxJobRecord.fromJson(response);
  }

  Future<AppProfile> setProfileActive({
    required String profileId,
    required bool isActive,
    String? reason,
  }) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'admin_set_profile_active',
      params: {
        'p_profile_id': profileId,
        'p_is_active': isActive,
        'p_reason': reason,
      },
    );
    return AppProfile.fromJson(response);
  }

  Future<List<EligiblePayoutQueueItem>> fetchEligiblePayouts() async {
    final bookingsResponse = await _client
        .from('bookings')
        .select()
        .eq('booking_status', 'completed')
        .eq('payment_status', 'secured')
        .order('updated_at', ascending: false)
        .limit(50);

    final allBookings = (bookingsResponse as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(BookingRecord.fromJson)
        .toList(growable: false);
    if (allBookings.isEmpty) {
      return const <EligiblePayoutQueueItem>[];
    }

    final bookingIds = allBookings
        .map((booking) => booking.id)
        .toList(growable: false);
    final disputesResponse = await _client
        .from('disputes')
        .select('booking_id')
        .eq('status', 'open')
        .inFilter('booking_id', bookingIds);
    final payoutsResponse = await _client
        .from('payouts')
        .select('booking_id')
        .inFilter('booking_id', bookingIds);

    final blockedBookingIds = {
      for (final item
          in (disputesResponse as List<dynamic>).cast<Map<String, dynamic>>())
        item['booking_id'] as String,
      for (final item
          in (payoutsResponse as List<dynamic>).cast<Map<String, dynamic>>())
        item['booking_id'] as String,
    };

    final eligibleBookings = allBookings
        .where((booking) => !blockedBookingIds.contains(booking.id))
        .toList(growable: false);
    if (eligibleBookings.isEmpty) {
      return const <EligiblePayoutQueueItem>[];
    }

    final carrierIds = eligibleBookings
        .map((booking) => booking.carrierId)
        .toSet()
        .toList(growable: false);
    final carriersResponse = await _client
        .from('profiles')
        .select()
        .inFilter('id', carrierIds);
    final carriersById = {
      for (final item
          in (carriersResponse as List<dynamic>).cast<Map<String, dynamic>>())
        (item['id'] as String): AppProfile.fromJson(item),
    };

    return eligibleBookings
        .map(
          (booking) => EligiblePayoutQueueItem(
            booking: booking,
            carrier: carriersById[booking.carrierId],
          ),
        )
        .toList(growable: false);
  }

  Future<List<AdminPaymentProofQueueItem>> fetchPaymentProofQueue({
    String? query,
    int limit = 50,
  }) async {
    final proofsResponse = await _client
        .from('payment_proofs')
        .select()
        .eq('status', 'pending')
        .order('submitted_at', ascending: true)
        .limit(limit * 2);
    final proofMaps = (proofsResponse as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final proofs = proofMaps
        .map(PaymentProofRecord.fromJson)
        .toList(growable: false);
    if (proofs.isEmpty) {
      return const <AdminPaymentProofQueueItem>[];
    }

    final bookingIds = proofs
        .map((proof) => proof.bookingId)
        .toSet()
        .toList(growable: false);
    final bookingsResponse = await _client
        .from('bookings')
        .select()
        .inFilter('id', bookingIds);
    final bookingMap = {
      for (final item
          in (bookingsResponse as List<dynamic>).cast<Map<String, dynamic>>())
        (item['id'] as String): BookingRecord.fromJson(item),
    };

    final items = proofs
        .where((proof) => bookingMap.containsKey(proof.bookingId))
        .map(
          (proof) => AdminPaymentProofQueueItem(
            proof: proof,
            booking: bookingMap[proof.bookingId]!,
          ),
        )
        .toList(growable: false);

    final trimmedQuery = query?.trim().toLowerCase();
    if (trimmedQuery == null || trimmedQuery.isEmpty) {
      return items.take(limit).toList(growable: false);
    }

    return items
        .where(
          (item) =>
              item.booking.trackingNumber.toLowerCase().contains(
                trimmedQuery,
              ) ||
              item.booking.paymentReference.toLowerCase().contains(
                trimmedQuery,
              ) ||
              (item.proof.submittedReference?.toLowerCase().contains(
                    trimmedQuery,
                  ) ??
                  false) ||
              item.booking.id.toLowerCase().contains(trimmedQuery) ||
              item.proof.id.toLowerCase().contains(trimmedQuery),
        )
        .take(limit)
        .toList(growable: false);
  }

  Future<List<VerificationReviewPacket>> fetchVerificationQueue({
    String? query,
    int limit = 20,
  }) async {
    final repository = VerificationAdminRepository(logger: logger);
    final items = await repository.fetchPendingReviewPackets(limit: limit * 2);
    final trimmedQuery = query?.trim().toLowerCase();
    if (trimmedQuery == null || trimmedQuery.isEmpty) {
      return items.take(limit).toList(growable: false);
    }

    return items
        .where(
          (item) =>
              item.displayName.toLowerCase().contains(trimmedQuery) ||
              item.carrierId.toLowerCase().contains(trimmedQuery) ||
              (item.companyName?.toLowerCase().contains(trimmedQuery) ??
                  false) ||
              item.vehicles.any(
                (vehicle) => vehicle.vehicle.plateNumber.toLowerCase().contains(
                  trimmedQuery,
                ),
              ),
        )
        .take(limit)
        .toList(growable: false);
  }

  Future<List<DisputeRecord>> fetchDisputeQueue({
    String? query,
    int limit = 50,
  }) async {
    final response = await _client
        .from('disputes')
        .select()
        .eq('status', 'open')
        .order('created_at', ascending: true)
        .limit(limit);

    final disputes = (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(DisputeRecord.fromJson)
        .toList(growable: false);

    final trimmedQuery = query?.trim().toLowerCase();
    if (trimmedQuery == null || trimmedQuery.isEmpty) {
      return disputes;
    }

    return disputes
        .where(
          (item) =>
              item.bookingId.toLowerCase().contains(trimmedQuery) ||
              item.reason.toLowerCase().contains(trimmedQuery) ||
              (item.description?.toLowerCase().contains(trimmedQuery) ?? false),
        )
        .toList(growable: false);
  }

  Future<List<BookingRecord>> fetchBookings({
    String? query,
    int limit = 50,
  }) async {
    var request = _client.from('bookings').select();

    final trimmedQuery = query?.trim();
    if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
      request = request.or(
        'tracking_number.ilike.%$trimmedQuery%,payment_reference.ilike.%$trimmedQuery%,id.eq.$trimmedQuery,shipper_id.eq.$trimmedQuery,carrier_id.eq.$trimmedQuery',
      );
    }

    final response = await request
        .order('updated_at', ascending: false)
        .limit(limit);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(BookingRecord.fromJson)
        .toList(growable: false);
  }

  Future<List<EligiblePayoutQueueItem>> fetchEligiblePayoutQueue({
    String? query,
    int limit = 50,
  }) async {
    final items = await fetchEligiblePayouts();
    final trimmedQuery = query?.trim().toLowerCase();
    if (trimmedQuery == null || trimmedQuery.isEmpty) {
      return items.take(limit).toList(growable: false);
    }

    return items
        .where(
          (item) =>
              item.booking.trackingNumber.toLowerCase().contains(
                trimmedQuery,
              ) ||
              item.booking.id.toLowerCase().contains(trimmedQuery) ||
              (item.carrier?.companyName?.toLowerCase().contains(
                    trimmedQuery,
                  ) ??
                  false) ||
              (item.carrier?.fullName?.toLowerCase().contains(trimmedQuery) ??
                  false) ||
              item.booking.carrierId.toLowerCase().contains(trimmedQuery),
        )
        .take(limit)
        .toList(growable: false);
  }

  Future<List<AdminAutomationAlertItem>> fetchOverdueAutomationAlerts() async {
    final deliveryGraceHours = await _fetchDeliveryGraceHours();
    final paymentDeadlineHours = await _fetchPaymentDeadlineHours();

    final deliveredResponse = await _client
        .from('bookings')
        .select()
        .eq('booking_status', 'delivered_pending_review')
        .not('delivered_at', 'is', null)
        .order('delivered_at', ascending: true)
        .limit(50);

    final rejectedResponse = await _client
        .from('bookings')
        .select()
        .eq('payment_status', 'rejected')
        .order('updated_at', ascending: true)
        .limit(50);

    final deliveredItems = (deliveredResponse as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map((item) {
          final deliveredAt = DateTime.tryParse(
            item['delivered_at'] as String? ?? '',
          );
          if (deliveredAt == null) {
            return null;
          }
          final booking = BookingRecord.fromJson(item);
          final isOverdue = deliveredAt.isBefore(
            DateTime.now().toUtc().subtract(
              Duration(hours: deliveryGraceHours),
            ),
          );
          if (!isOverdue) {
            return null;
          }
          return AdminAutomationAlertItem(
            booking: booking,
            kind: 'delivery_review_overdue',
            referenceAt: deliveredAt,
            thresholdHours: deliveryGraceHours,
          );
        })
        .whereType<AdminAutomationAlertItem>()
        .toList(growable: false);

    final rejectedBookings = (rejectedResponse as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(BookingRecord.fromJson)
        .toList(growable: false);
    if (rejectedBookings.isEmpty) {
      return deliveredItems;
    }

    final proofResponse = await _client
        .from('payment_proofs')
        .select()
        .eq('status', 'rejected')
        .inFilter(
          'booking_id',
          rejectedBookings.map((e) => e.id).toList(growable: false),
        )
        .order('reviewed_at', ascending: false);

    final latestRejectedByBooking = <String, PaymentProofRecord>{};
    for (final item
        in (proofResponse as List<dynamic>).cast<Map<String, dynamic>>()) {
      final proof = PaymentProofRecord.fromJson(item);
      final current = latestRejectedByBooking[proof.bookingId];
      if (current == null ||
          (proof.reviewedAt != null &&
              (current.reviewedAt == null ||
                  proof.reviewedAt!.isAfter(current.reviewedAt!)))) {
        latestRejectedByBooking[proof.bookingId] = proof;
      }
    }

    final paymentAlerts = rejectedBookings
        .where((booking) {
          final proof = latestRejectedByBooking[booking.id];
          final reviewedAt = proof?.reviewedAt;
          return reviewedAt != null &&
              reviewedAt.isBefore(
                DateTime.now().toUtc().subtract(
                  Duration(hours: paymentDeadlineHours),
                ),
              );
        })
        .map(
          (booking) => AdminAutomationAlertItem(
            booking: booking,
            kind: 'payment_resubmission_overdue',
            referenceAt: latestRejectedByBooking[booking.id]!.reviewedAt!,
            thresholdHours: paymentDeadlineHours,
          ),
        )
        .toList(growable: false);

    return [...deliveredItems, ...paymentAlerts]
      ..sort((a, b) => a.referenceAt.compareTo(b.referenceAt));
  }

  Future<List<Map<String, dynamic>>> _fetchUserVerificationDocuments({
    required String profileId,
    required List<String> vehicleIds,
  }) async {
    if (vehicleIds.isEmpty) {
      final response = await _client
          .from('verification_documents')
          .select()
          .eq('entity_type', 'profile')
          .eq('entity_id', profileId)
          .order('created_at', ascending: false)
          .limit(40);
      return (response as List<dynamic>).cast<Map<String, dynamic>>();
    }

    final response = await _client
        .from('verification_documents')
        .select()
        .or(
          'and(entity_type.eq.profile,entity_id.eq.$profileId),and(entity_type.eq.vehicle,entity_id.in.${_asInList(vehicleIds)})',
        )
        .order('created_at', ascending: false)
        .limit(40);
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  String _asInList(List<String> values) {
    return '(${values.map((value) => '"${value.replaceAll('"', r'\"')}"').join(',')})';
  }

  Future<int> _fetchDeliveryGraceHours() async {
    final response = await _client
        .from('platform_settings')
        .select('value')
        .eq('key', 'delivery_review')
        .maybeSingle();
    final value = Map<String, dynamic>.from(
      (response?['value'] as Map?) ?? const <String, dynamic>{},
    );
    return (value['grace_window_hours'] as num?)?.toInt() ?? 24;
  }

  Future<int> _fetchPaymentDeadlineHours() async {
    final response = await _client
        .from('platform_settings')
        .select('value')
        .eq('key', 'booking_pricing')
        .maybeSingle();
    final value = Map<String, dynamic>.from(
      (response?['value'] as Map?) ?? const <String, dynamic>{},
    );
    return (value['payment_resubmission_deadline_hours'] as num?)?.toInt() ??
        24;
  }
}
