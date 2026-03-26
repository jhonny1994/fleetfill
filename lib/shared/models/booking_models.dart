import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_models.freezed.dart';

enum BookingStatus {
  pendingPayment,
  paymentUnderReview,
  confirmed,
  pickedUp,
  inTransit,
  deliveredPendingReview,
  completed,
  cancelled,
  disputed
  ;

  static BookingStatus fromDatabase(Object? value) {
    return switch (value) {
      'payment_under_review' => BookingStatus.paymentUnderReview,
      'confirmed' => BookingStatus.confirmed,
      'picked_up' => BookingStatus.pickedUp,
      'in_transit' => BookingStatus.inTransit,
      'delivered_pending_review' => BookingStatus.deliveredPendingReview,
      'completed' => BookingStatus.completed,
      'cancelled' => BookingStatus.cancelled,
      'disputed' => BookingStatus.disputed,
      _ => BookingStatus.pendingPayment,
    };
  }
}

enum PaymentStatus {
  unpaid,
  proofSubmitted,
  underVerification,
  secured,
  rejected,
  refunded,
  releasedToCarrier
  ;

  static PaymentStatus fromDatabase(Object? value) {
    return switch (value) {
      'proof_submitted' => PaymentStatus.proofSubmitted,
      'under_verification' => PaymentStatus.underVerification,
      'secured' => PaymentStatus.secured,
      'rejected' => PaymentStatus.rejected,
      'refunded' => PaymentStatus.refunded,
      'released_to_carrier' => PaymentStatus.releasedToCarrier,
      _ => PaymentStatus.unpaid,
    };
  }
}

enum GeneratedDocumentStatus {
  pending,
  ready,
  failed
  ;

  static GeneratedDocumentStatus fromDatabase(Object? value) {
    return switch (value) {
      'ready' => GeneratedDocumentStatus.ready,
      'failed' => GeneratedDocumentStatus.failed,
      _ => GeneratedDocumentStatus.pending,
    };
  }
}

@freezed
abstract class BookingRecord with _$BookingRecord {
  const factory BookingRecord({
    required String id,
    required String shipmentId,
    required String? routeId,
    required DateTime? routeDepartureDate,
    required String? oneoffTripId,
    required String shipperId,
    required String carrierId,
    required String vehicleId,
    required double weightKg,
    required double? volumeM3,
    required double pricePerKgDzd,
    required double basePriceDzd,
    required double platformFeeDzd,
    required double carrierFeeDzd,
    required double? insuranceRate,
    required double insuranceFeeDzd,
    required double taxFeeDzd,
    required double shipperTotalDzd,
    required double carrierPayoutDzd,
    required BookingStatus bookingStatus,
    required PaymentStatus paymentStatus,
    required String trackingNumber,
    required String paymentReference,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _BookingRecord;

  const BookingRecord._();

  factory BookingRecord.fromJson(Map<String, dynamic> json) {
    return BookingRecord(
      id: json['id'] as String,
      shipmentId: json['shipment_id'] as String,
      routeId: json['route_id'] as String?,
      routeDepartureDate: json['route_departure_date'] == null
          ? null
          : DateTime.parse(json['route_departure_date'] as String),
      oneoffTripId: json['oneoff_trip_id'] as String?,
      shipperId: json['shipper_id'] as String,
      carrierId: json['carrier_id'] as String,
      vehicleId: json['vehicle_id'] as String,
      weightKg: (json['weight_kg'] as num).toDouble(),
      volumeM3: (json['volume_m3'] as num?)?.toDouble(),
      pricePerKgDzd: (json['price_per_kg_dzd'] as num).toDouble(),
      basePriceDzd: (json['base_price_dzd'] as num).toDouble(),
      platformFeeDzd: (json['platform_fee_dzd'] as num).toDouble(),
      carrierFeeDzd: (json['carrier_fee_dzd'] as num).toDouble(),
      insuranceRate: (json['insurance_rate'] as num?)?.toDouble(),
      insuranceFeeDzd: (json['insurance_fee_dzd'] as num).toDouble(),
      taxFeeDzd: (json['tax_fee_dzd'] as num).toDouble(),
      shipperTotalDzd: (json['shipper_total_dzd'] as num).toDouble(),
      carrierPayoutDzd: (json['carrier_payout_dzd'] as num).toDouble(),
      bookingStatus: BookingStatus.fromDatabase(json['booking_status']),
      paymentStatus: PaymentStatus.fromDatabase(json['payment_status']),
      trackingNumber: (json['tracking_number'] as String?)?.trim() ?? '',
      paymentReference: (json['payment_reference'] as String?)?.trim() ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class BookingPricingQuote with _$BookingPricingQuote {
  const factory BookingPricingQuote({
    required double pricePerKgDzd,
    required double basePriceDzd,
    required double platformFeeDzd,
    required double carrierFeeDzd,
    required double? insuranceRate,
    required double insuranceFeeDzd,
    required double taxFeeDzd,
    required double shipperTotalDzd,
    required double carrierPayoutDzd,
  }) = _BookingPricingQuote;

  const BookingPricingQuote._();
}

@freezed
abstract class PaymentProofRecord with _$PaymentProofRecord {
  const factory PaymentProofRecord({
    required String id,
    required String bookingId,
    required String storagePath,
    required String? contentType,
    required int? byteSize,
    required String paymentRail,
    required String? submittedReference,
    required double submittedAmountDzd,
    required double? verifiedAmountDzd,
    required String? verifiedReference,
    required String status,
    required String? rejectionReason,
    required String? reviewedBy,
    required DateTime submittedAt,
    required DateTime? reviewedAt,
    required String? decisionNote,
    required int version,
  }) = _PaymentProofRecord;

  const PaymentProofRecord._();

  factory PaymentProofRecord.fromJson(Map<String, dynamic> json) {
    return PaymentProofRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      storagePath: (json['storage_path'] as String?)?.trim() ?? '',
      contentType: (json['content_type'] as String?)?.trim(),
      byteSize: (json['byte_size'] as num?)?.toInt(),
      paymentRail: (json['payment_rail'] as String?)?.trim() ?? '',
      submittedReference: (json['submitted_reference'] as String?)?.trim(),
      submittedAmountDzd: (json['submitted_amount_dzd'] as num).toDouble(),
      verifiedAmountDzd: (json['verified_amount_dzd'] as num?)?.toDouble(),
      verifiedReference: (json['verified_reference'] as String?)?.trim(),
      status: (json['status'] as String?)?.trim() ?? 'pending',
      rejectionReason: (json['rejection_reason'] as String?)?.trim(),
      reviewedBy: json['reviewed_by'] as String?,
      submittedAt: DateTime.parse(json['submitted_at'] as String),
      reviewedAt: DateTime.tryParse(json['reviewed_at'] as String? ?? ''),
      decisionNote: (json['decision_note'] as String?)?.trim(),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );
  }
}

@freezed
abstract class GeneratedDocumentRecord with _$GeneratedDocumentRecord {
  const factory GeneratedDocumentRecord({
    required String id,
    required String? bookingId,
    required String documentType,
    required String storagePath,
    required int version,
    required String? generatedBy,
    required GeneratedDocumentStatus status,
    required String? contentType,
    required int? byteSize,
    required DateTime? availableAt,
    required String? failureReason,
    required DateTime? createdAt,
  }) = _GeneratedDocumentRecord;

  const GeneratedDocumentRecord._();

  factory GeneratedDocumentRecord.fromJson(Map<String, dynamic> json) {
    return GeneratedDocumentRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String?,
      documentType: (json['document_type'] as String?)?.trim() ?? '',
      storagePath: (json['storage_path'] as String?)?.trim() ?? '',
      version: (json['version'] as num?)?.toInt() ?? 1,
      generatedBy: json['generated_by'] as String?,
      status: GeneratedDocumentStatus.fromDatabase(json['status']),
      contentType: (json['content_type'] as String?)?.trim(),
      byteSize: (json['byte_size'] as num?)?.toInt(),
      availableAt: DateTime.tryParse(json['available_at'] as String? ?? ''),
      failureReason: (json['failure_reason'] as String?)?.trim(),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  bool get isReady => status == GeneratedDocumentStatus.ready;

  bool get isPending => status == GeneratedDocumentStatus.pending;

  bool get isFailed => status == GeneratedDocumentStatus.failed;
}

@freezed
abstract class TrackingEventRecord with _$TrackingEventRecord {
  const factory TrackingEventRecord({
    required String id,
    required String bookingId,
    required String eventType,
    required String visibility,
    required String? note,
    required String? createdBy,
    required DateTime recordedAt,
    required DateTime? createdAt,
  }) = _TrackingEventRecord;

  const TrackingEventRecord._();

  factory TrackingEventRecord.fromJson(Map<String, dynamic> json) {
    return TrackingEventRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      eventType: (json['event_type'] as String?)?.trim() ?? '',
      visibility: (json['visibility'] as String?)?.trim() ?? '',
      note: (json['note'] as String?)?.trim(),
      createdBy: json['created_by'] as String?,
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class DisputeRecord with _$DisputeRecord {
  const factory DisputeRecord({
    required String id,
    required String bookingId,
    required String openedBy,
    required String reason,
    required String? description,
    required String status,
    required String? resolution,
    required String? resolutionNote,
    required String? resolvedBy,
    required DateTime? resolvedAt,
    required int evidenceCount,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _DisputeRecord;

  const DisputeRecord._();

  factory DisputeRecord.fromJson(Map<String, dynamic> json) {
    return DisputeRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      openedBy: json['opened_by'] as String,
      reason: (json['reason'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim(),
      status: (json['status'] as String?)?.trim() ?? 'open',
      resolution: (json['resolution'] as String?)?.trim(),
      resolutionNote: (json['resolution_note'] as String?)?.trim(),
      resolvedBy: json['resolved_by'] as String?,
      resolvedAt: DateTime.tryParse(json['resolved_at'] as String? ?? ''),
      evidenceCount: (json['evidence_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class DisputeEvidenceRecord with _$DisputeEvidenceRecord {
  const factory DisputeEvidenceRecord({
    required String id,
    required String disputeId,
    required String storagePath,
    required String? note,
    required String? contentType,
    required int? byteSize,
    required String? uploadedBy,
    required DateTime? createdAt,
  }) = _DisputeEvidenceRecord;

  const DisputeEvidenceRecord._();

  factory DisputeEvidenceRecord.fromJson(Map<String, dynamic> json) {
    return DisputeEvidenceRecord(
      id: json['id'] as String,
      disputeId: json['dispute_id'] as String,
      storagePath: (json['storage_path'] as String?)?.trim() ?? '',
      note: (json['note'] as String?)?.trim(),
      contentType: (json['content_type'] as String?)?.trim(),
      byteSize: (json['byte_size'] as num?)?.toInt(),
      uploadedBy: json['uploaded_by'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  bool get isPdf => (contentType ?? '').toLowerCase() == 'application/pdf';
}

@freezed
abstract class RefundRecord with _$RefundRecord {
  const factory RefundRecord({
    required String id,
    required String bookingId,
    required String? disputeId,
    required double amountDzd,
    required String status,
    required String reason,
    required String? externalReference,
    required String? processedBy,
    required DateTime? processedAt,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _RefundRecord;

  const RefundRecord._();

  factory RefundRecord.fromJson(Map<String, dynamic> json) {
    return RefundRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      disputeId: json['dispute_id'] as String?,
      amountDzd: (json['amount_dzd'] as num).toDouble(),
      status: (json['status'] as String?)?.trim() ?? 'pending',
      reason: (json['reason'] as String?)?.trim() ?? '',
      externalReference: (json['external_reference'] as String?)?.trim(),
      processedBy: json['processed_by'] as String?,
      processedAt: DateTime.tryParse(json['processed_at'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class PayoutRecord with _$PayoutRecord {
  const factory PayoutRecord({
    required String id,
    required String bookingId,
    required String carrierId,
    required String payoutAccountId,
    required Map<String, dynamic> payoutAccountSnapshot,
    required double amountDzd,
    required String status,
    required String? externalReference,
    required String? processedBy,
    required DateTime? processedAt,
    required String? failureReason,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _PayoutRecord;

  const PayoutRecord._();

  factory PayoutRecord.fromJson(Map<String, dynamic> json) {
    return PayoutRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      carrierId: json['carrier_id'] as String,
      payoutAccountId: json['payout_account_id'] as String,
      payoutAccountSnapshot: Map<String, dynamic>.from(
        (json['payout_account_snapshot'] as Map?) ?? const <String, dynamic>{},
      ),
      amountDzd: (json['amount_dzd'] as num).toDouble(),
      status: (json['status'] as String?)?.trim() ?? 'pending',
      externalReference: (json['external_reference'] as String?)?.trim(),
      processedBy: json['processed_by'] as String?,
      processedAt: DateTime.tryParse(json['processed_at'] as String? ?? ''),
      failureReason: (json['failure_reason'] as String?)?.trim(),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}

class BookingPayoutRequestContext {
  const BookingPayoutRequestContext({
    required this.bookingId,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.graceWindowHours,
    required this.isEligible,
    required this.blockedReason,
    required this.hasActivePayoutAccount,
    required this.hasOpenDispute,
    required this.requestId,
    required this.requestStatus,
    required this.requestNote,
    required this.requestedAt,
    required this.fulfilledAt,
    required this.payoutId,
    required this.payoutProcessedAt,
  });

  factory BookingPayoutRequestContext.fromJson(Map<String, dynamic> json) {
    return BookingPayoutRequestContext(
      bookingId: (json['booking_id'] as String?)?.trim() ?? '',
      bookingStatus: BookingStatus.fromDatabase(json['booking_status']),
      paymentStatus: PaymentStatus.fromDatabase(json['payment_status']),
      graceWindowHours: (json['grace_window_hours'] as num?)?.toInt() ?? 24,
      isEligible: json['is_eligible'] as bool? ?? false,
      blockedReason: (json['blocked_reason'] as String?)?.trim(),
      hasActivePayoutAccount:
          json['has_active_payout_account'] as bool? ?? false,
      hasOpenDispute: json['has_open_dispute'] as bool? ?? false,
      requestId: (json['request_id'] as String?)?.trim(),
      requestStatus: (json['request_status'] as String?)?.trim(),
      requestNote: (json['request_note'] as String?)?.trim(),
      requestedAt: DateTime.tryParse(json['requested_at'] as String? ?? ''),
      fulfilledAt: DateTime.tryParse(json['fulfilled_at'] as String? ?? ''),
      payoutId: (json['payout_id'] as String?)?.trim(),
      payoutProcessedAt: DateTime.tryParse(
        json['payout_processed_at'] as String? ?? '',
      ),
    );
  }

  final String bookingId;
  final BookingStatus bookingStatus;
  final PaymentStatus paymentStatus;
  final int graceWindowHours;
  final bool isEligible;
  final String? blockedReason;
  final bool hasActivePayoutAccount;
  final bool hasOpenDispute;
  final String? requestId;
  final String? requestStatus;
  final String? requestNote;
  final DateTime? requestedAt;
  final DateTime? fulfilledAt;
  final String? payoutId;
  final DateTime? payoutProcessedAt;

  bool get hasRequestedPayout => requestStatus == 'requested';

  bool get isFulfilled => requestStatus == 'fulfilled' || payoutId != null;
}
