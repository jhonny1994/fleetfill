import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:fleetfill/shared/models/models.dart';

enum AdminQueueSegment { payments, verification, disputes, payouts, email }

class AdminQueueFilters {
  const AdminQueueFilters({this.query, this.status});

  final String? query;
  final String? status;
}

class AdminOperationalSummary {
  const AdminOperationalSummary({
    required this.verificationPackets,
    required this.pendingVerificationDocuments,
    required this.paymentProofs,
    required this.disputes,
    required this.eligiblePayouts,
    required this.emailBacklog,
    required this.emailDeadLetter,
    required this.auditEventsLast24h,
    required this.overdueDeliveryReviews,
    required this.overduePaymentResubmissions,
  });

  factory AdminOperationalSummary.fromJson(Map<String, dynamic> json) {
    return AdminOperationalSummary(
      verificationPackets: (json['verification_packets'] as num?)?.toInt() ?? 0,
      pendingVerificationDocuments:
          (json['pending_verification_documents'] as num?)?.toInt() ?? 0,
      paymentProofs: (json['payment_proofs'] as num?)?.toInt() ?? 0,
      disputes: (json['disputes'] as num?)?.toInt() ?? 0,
      eligiblePayouts: (json['eligible_payouts'] as num?)?.toInt() ?? 0,
      emailBacklog: (json['email_backlog'] as num?)?.toInt() ?? 0,
      emailDeadLetter: (json['email_dead_letter'] as num?)?.toInt() ?? 0,
      auditEventsLast24h:
          (json['audit_events_last_24h'] as num?)?.toInt() ?? 0,
      overdueDeliveryReviews:
          (json['overdue_delivery_reviews'] as num?)?.toInt() ?? 0,
      overduePaymentResubmissions:
          (json['overdue_payment_resubmissions'] as num?)?.toInt() ?? 0,
    );
  }

  final int verificationPackets;
  final int pendingVerificationDocuments;
  final int paymentProofs;
  final int disputes;
  final int eligiblePayouts;
  final int emailBacklog;
  final int emailDeadLetter;
  final int auditEventsLast24h;
  final int overdueDeliveryReviews;
  final int overduePaymentResubmissions;
}

class PlatformSettingRecord {
  const PlatformSettingRecord({
    required this.key,
    required this.value,
    required this.isPublic,
    required this.description,
    required this.updatedBy,
    required this.updatedAt,
  });

  factory PlatformSettingRecord.fromJson(Map<String, dynamic> json) {
    return PlatformSettingRecord(
      key: (json['key'] as String?)?.trim() ?? '',
      value: Map<String, dynamic>.from(
        (json['value'] as Map?) ?? const <String, dynamic>{},
      ),
      isPublic: json['is_public'] as bool? ?? false,
      description: (json['description'] as String?)?.trim(),
      updatedBy: json['updated_by'] as String?,
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String key;
  final Map<String, dynamic> value;
  final bool isPublic;
  final String? description;
  final String? updatedBy;
  final DateTime? updatedAt;
}

class AdminUserListItem {
  const AdminUserListItem({required this.profile});

  final AppProfile profile;

  String get displayName {
    final companyName = profile.companyName?.trim();
    if (companyName != null && companyName.isNotEmpty) {
      return companyName;
    }

    final fullName = profile.fullName?.trim();
    if (fullName != null && fullName.isNotEmpty) {
      return fullName;
    }

    return profile.email;
  }
}

class AdminUserDetail {
  const AdminUserDetail({
    required this.profile,
    required this.bookings,
    required this.vehicles,
    required this.verificationDocuments,
    required this.emailLogs,
  });

  final AppProfile profile;
  final List<BookingRecord> bookings;
  final List<CarrierVehicle> vehicles;
  final List<VerificationDocumentRecord> verificationDocuments;
  final List<EmailDeliveryLogRecord> emailLogs;
}

class EmailDeliveryLogRecord {
  const EmailDeliveryLogRecord({
    required this.id,
    required this.profileId,
    required this.bookingId,
    required this.templateKey,
    required this.locale,
    required this.recipientEmail,
    required this.subjectPreview,
    required this.providerMessageId,
    required this.status,
    required this.provider,
    required this.attemptCount,
    required this.lastAttemptAt,
    required this.nextRetryAt,
    required this.lastErrorAt,
    required this.errorCode,
    required this.errorMessage,
    required this.payloadSnapshot,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmailDeliveryLogRecord.fromJson(Map<String, dynamic> json) {
    return EmailDeliveryLogRecord(
      id: json['id'] as String,
      profileId: json['profile_id'] as String?,
      bookingId: json['booking_id'] as String?,
      templateKey: (json['template_key'] as String?)?.trim() ?? '',
      locale: (json['locale'] as String?)?.trim() ?? 'en',
      recipientEmail: (json['recipient_email'] as String?)?.trim() ?? '',
      subjectPreview: (json['subject_preview'] as String?)?.trim(),
      providerMessageId: (json['provider_message_id'] as String?)?.trim(),
      status: (json['status'] as String?)?.trim() ?? 'queued',
      provider: (json['provider'] as String?)?.trim() ?? '',
      attemptCount: (json['attempt_count'] as num?)?.toInt() ?? 0,
      lastAttemptAt: DateTime.tryParse(json['last_attempt_at'] as String? ?? ''),
      nextRetryAt: DateTime.tryParse(json['next_retry_at'] as String? ?? ''),
      lastErrorAt: DateTime.tryParse(json['last_error_at'] as String? ?? ''),
      errorCode: (json['error_code'] as String?)?.trim(),
      errorMessage: (json['error_message'] as String?)?.trim(),
      payloadSnapshot: Map<String, dynamic>.from(
        (json['payload_snapshot'] as Map?) ?? const <String, dynamic>{},
      ),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String id;
  final String? profileId;
  final String? bookingId;
  final String templateKey;
  final String locale;
  final String recipientEmail;
  final String? subjectPreview;
  final String? providerMessageId;
  final String status;
  final String provider;
  final int attemptCount;
  final DateTime? lastAttemptAt;
  final DateTime? nextRetryAt;
  final DateTime? lastErrorAt;
  final String? errorCode;
  final String? errorMessage;
  final Map<String, dynamic> payloadSnapshot;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class EmailOutboxJobRecord {
  const EmailOutboxJobRecord({
    required this.id,
    required this.eventKey,
    required this.dedupeKey,
    required this.profileId,
    required this.bookingId,
    required this.templateKey,
    required this.locale,
    required this.recipientEmail,
    required this.priority,
    required this.status,
    required this.attemptCount,
    required this.maxAttempts,
    required this.availableAt,
    required this.lockedAt,
    required this.lockedBy,
    required this.lastErrorCode,
    required this.lastErrorMessage,
    required this.payloadSnapshot,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmailOutboxJobRecord.fromJson(Map<String, dynamic> json) {
    return EmailOutboxJobRecord(
      id: json['id'] as String,
      eventKey: (json['event_key'] as String?)?.trim() ?? '',
      dedupeKey: (json['dedupe_key'] as String?)?.trim() ?? '',
      profileId: json['profile_id'] as String?,
      bookingId: json['booking_id'] as String?,
      templateKey: (json['template_key'] as String?)?.trim() ?? '',
      locale: (json['locale'] as String?)?.trim() ?? 'en',
      recipientEmail: (json['recipient_email'] as String?)?.trim() ?? '',
      priority: (json['priority'] as String?)?.trim() ?? 'normal',
      status: (json['status'] as String?)?.trim() ?? 'queued',
      attemptCount: (json['attempt_count'] as num?)?.toInt() ?? 0,
      maxAttempts: (json['max_attempts'] as num?)?.toInt() ?? 0,
      availableAt: DateTime.tryParse(json['available_at'] as String? ?? ''),
      lockedAt: DateTime.tryParse(json['locked_at'] as String? ?? ''),
      lockedBy: (json['locked_by'] as String?)?.trim(),
      lastErrorCode: (json['last_error_code'] as String?)?.trim(),
      lastErrorMessage: (json['last_error_message'] as String?)?.trim(),
      payloadSnapshot: Map<String, dynamic>.from(
        (json['payload_snapshot'] as Map?) ?? const <String, dynamic>{},
      ),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String id;
  final String eventKey;
  final String dedupeKey;
  final String? profileId;
  final String? bookingId;
  final String templateKey;
  final String locale;
  final String recipientEmail;
  final String priority;
  final String status;
  final int attemptCount;
  final int maxAttempts;
  final DateTime? availableAt;
  final DateTime? lockedAt;
  final String? lockedBy;
  final String? lastErrorCode;
  final String? lastErrorMessage;
  final Map<String, dynamic> payloadSnapshot;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class EligiblePayoutQueueItem {
  const EligiblePayoutQueueItem({required this.booking, required this.carrier});

  final BookingRecord booking;
  final AppProfile? carrier;
}

class AdminAutomationAlertItem {
  const AdminAutomationAlertItem({
    required this.booking,
    required this.kind,
    required this.referenceAt,
    required this.thresholdHours,
  });

  final BookingRecord booking;
  final String kind;
  final DateTime referenceAt;
  final int thresholdHours;
}
