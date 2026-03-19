enum BookingStatus {
  pendingPayment,
  paymentUnderReview,
  confirmed,
  pickedUp,
  inTransit,
  deliveredPendingReview,
  completed,
  cancelled,
  disputed;

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
  releasedToCarrier;

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
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
    );
  }

  final String id;
  final String? bookingId;
  final String documentType;
  final String storagePath;
  final int version;
  final String? generatedBy;
  final DateTime? createdAt;
}
