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

class BookingRecord {
  const BookingRecord({
    required this.id,
    required this.shipmentId,
    required this.routeId,
    required this.routeDepartureDate,
    required this.oneoffTripId,
    required this.shipperId,
    required this.carrierId,
    required this.vehicleId,
    required this.weightKg,
    required this.volumeM3,
    required this.pricePerKgDzd,
    required this.basePriceDzd,
    required this.platformFeeDzd,
    required this.carrierFeeDzd,
    required this.insuranceRate,
    required this.insuranceFeeDzd,
    required this.taxFeeDzd,
    required this.shipperTotalDzd,
    required this.carrierPayoutDzd,
    required this.bookingStatus,
    required this.paymentStatus,
    required this.trackingNumber,
    required this.paymentReference,
    required this.createdAt,
    required this.updatedAt,
  });

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

  final String id;
  final String shipmentId;
  final String? routeId;
  final DateTime? routeDepartureDate;
  final String? oneoffTripId;
  final String shipperId;
  final String carrierId;
  final String vehicleId;
  final double weightKg;
  final double? volumeM3;
  final double pricePerKgDzd;
  final double basePriceDzd;
  final double platformFeeDzd;
  final double carrierFeeDzd;
  final double? insuranceRate;
  final double insuranceFeeDzd;
  final double taxFeeDzd;
  final double shipperTotalDzd;
  final double carrierPayoutDzd;
  final BookingStatus bookingStatus;
  final PaymentStatus paymentStatus;
  final String trackingNumber;
  final String paymentReference;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class BookingPricingQuote {
  const BookingPricingQuote({
    required this.pricePerKgDzd,
    required this.basePriceDzd,
    required this.platformFeeDzd,
    required this.carrierFeeDzd,
    required this.insuranceRate,
    required this.insuranceFeeDzd,
    required this.taxFeeDzd,
    required this.shipperTotalDzd,
    required this.carrierPayoutDzd,
  });

  final double pricePerKgDzd;
  final double basePriceDzd;
  final double platformFeeDzd;
  final double carrierFeeDzd;
  final double? insuranceRate;
  final double insuranceFeeDzd;
  final double taxFeeDzd;
  final double shipperTotalDzd;
  final double carrierPayoutDzd;
}

class PaymentProofRecord {
  const PaymentProofRecord({
    required this.id,
    required this.bookingId,
    required this.storagePath,
    required this.paymentRail,
    required this.submittedReference,
    required this.submittedAmountDzd,
    required this.verifiedAmountDzd,
    required this.verifiedReference,
    required this.status,
    required this.rejectionReason,
    required this.reviewedBy,
    required this.submittedAt,
    required this.reviewedAt,
    required this.decisionNote,
    required this.version,
  });

  factory PaymentProofRecord.fromJson(Map<String, dynamic> json) {
    return PaymentProofRecord(
      id: json['id'] as String,
      bookingId: json['booking_id'] as String,
      storagePath: (json['storage_path'] as String?)?.trim() ?? '',
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

  final String id;
  final String bookingId;
  final String storagePath;
  final String paymentRail;
  final String? submittedReference;
  final double submittedAmountDzd;
  final double? verifiedAmountDzd;
  final String? verifiedReference;
  final String status;
  final String? rejectionReason;
  final String? reviewedBy;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? decisionNote;
  final int version;
}

class GeneratedDocumentRecord {
  const GeneratedDocumentRecord({
    required this.id,
    required this.bookingId,
    required this.documentType,
    required this.storagePath,
    required this.version,
    required this.generatedBy,
    required this.status,
    required this.contentType,
    required this.byteSize,
    required this.availableAt,
    required this.failureReason,
    required this.createdAt,
  });

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

  final String id;
  final String? bookingId;
  final String documentType;
  final String storagePath;
  final int version;
  final String? generatedBy;
  final GeneratedDocumentStatus status;
  final String? contentType;
  final int? byteSize;
  final DateTime? availableAt;
  final String? failureReason;
  final DateTime? createdAt;

  bool get isReady => status == GeneratedDocumentStatus.ready;

  bool get isPending => status == GeneratedDocumentStatus.pending;

  bool get isFailed => status == GeneratedDocumentStatus.failed;
}

class TrackingEventRecord {
  const TrackingEventRecord({
    required this.id,
    required this.bookingId,
    required this.eventType,
    required this.visibility,
    required this.note,
    required this.createdBy,
    required this.recordedAt,
    required this.createdAt,
  });

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

  final String id;
  final String bookingId;
  final String eventType;
  final String visibility;
  final String? note;
  final String? createdBy;
  final DateTime recordedAt;
  final DateTime? createdAt;
}

class DisputeRecord {
  const DisputeRecord({
    required this.id,
    required this.bookingId,
    required this.openedBy,
    required this.reason,
    required this.description,
    required this.status,
    required this.resolution,
    required this.resolutionNote,
    required this.resolvedBy,
    required this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
  });

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
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String id;
  final String bookingId;
  final String openedBy;
  final String reason;
  final String? description;
  final String status;
  final String? resolution;
  final String? resolutionNote;
  final String? resolvedBy;
  final DateTime? resolvedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class RefundRecord {
  const RefundRecord({
    required this.id,
    required this.bookingId,
    required this.disputeId,
    required this.amountDzd,
    required this.status,
    required this.reason,
    required this.externalReference,
    required this.processedBy,
    required this.processedAt,
    required this.createdAt,
    required this.updatedAt,
  });

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

  final String id;
  final String bookingId;
  final String? disputeId;
  final double amountDzd;
  final String status;
  final String reason;
  final String? externalReference;
  final String? processedBy;
  final DateTime? processedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class PayoutRecord {
  const PayoutRecord({
    required this.id,
    required this.bookingId,
    required this.carrierId,
    required this.payoutAccountId,
    required this.payoutAccountSnapshot,
    required this.amountDzd,
    required this.status,
    required this.externalReference,
    required this.processedBy,
    required this.processedAt,
    required this.failureReason,
    required this.createdAt,
    required this.updatedAt,
  });

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

  final String id;
  final String bookingId;
  final String carrierId;
  final String payoutAccountId;
  final Map<String, dynamic> payoutAccountSnapshot;
  final double amountDzd;
  final String status;
  final String? externalReference;
  final String? processedBy;
  final DateTime? processedAt;
  final String? failureReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
