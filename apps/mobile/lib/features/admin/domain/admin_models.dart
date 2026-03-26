import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/carrier/domain/vehicle_models.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_models.freezed.dart';

enum AdminQueueSegment {
  payments,
  verification,
  disputes,
  payouts,
  support,
  email,
}

@freezed
abstract class AdminQueueFilters with _$AdminQueueFilters {
  const factory AdminQueueFilters({
    String? query,
    String? status,
  }) = _AdminQueueFilters;

  const AdminQueueFilters._();
}

@freezed
abstract class AdminOperationalSummary with _$AdminOperationalSummary {
  const factory AdminOperationalSummary({
    required int verificationPackets,
    required int pendingVerificationDocuments,
    required int paymentProofs,
    required int disputes,
    required int eligiblePayouts,
    required int supportNeedsReply,
    required int emailBacklog,
    required int emailDeadLetter,
    required int auditEventsLast24h,
    required int overdueDeliveryReviews,
    required int overduePaymentResubmissions,
  }) = _AdminOperationalSummary;

  const AdminOperationalSummary._();

  factory AdminOperationalSummary.fromJson(Map<String, dynamic> json) {
    return AdminOperationalSummary(
      verificationPackets: (json['verification_packets'] as num?)?.toInt() ?? 0,
      pendingVerificationDocuments:
          (json['pending_verification_documents'] as num?)?.toInt() ?? 0,
      paymentProofs: (json['payment_proofs'] as num?)?.toInt() ?? 0,
      disputes: (json['disputes'] as num?)?.toInt() ?? 0,
      eligiblePayouts: (json['eligible_payouts'] as num?)?.toInt() ?? 0,
      supportNeedsReply: (json['support_needs_reply'] as num?)?.toInt() ?? 0,
      emailBacklog: (json['email_backlog'] as num?)?.toInt() ?? 0,
      emailDeadLetter: (json['email_dead_letter'] as num?)?.toInt() ?? 0,
      auditEventsLast24h: (json['audit_events_last_24h'] as num?)?.toInt() ?? 0,
      overdueDeliveryReviews:
          (json['overdue_delivery_reviews'] as num?)?.toInt() ?? 0,
      overduePaymentResubmissions:
          (json['overdue_payment_resubmissions'] as num?)?.toInt() ?? 0,
    );
  }
}

@freezed
abstract class PlatformSettingRecord with _$PlatformSettingRecord {
  const factory PlatformSettingRecord({
    required String key,
    required Map<String, dynamic> value,
    required bool isPublic,
    required String? description,
    required String? updatedBy,
    required DateTime? updatedAt,
  }) = _PlatformSettingRecord;

  const PlatformSettingRecord._();

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
}

@freezed
abstract class AdminUserListItem with _$AdminUserListItem {
  const factory AdminUserListItem({
    required AppProfile profile,
  }) = _AdminUserListItem;

  const AdminUserListItem._();

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

@freezed
abstract class AdminUserDetail with _$AdminUserDetail {
  const factory AdminUserDetail({
    required AppProfile profile,
    required List<BookingRecord> bookings,
    required List<CarrierVehicle> vehicles,
    required List<VerificationDocumentRecord> verificationDocuments,
    required List<EmailDeliveryLogRecord> emailLogs,
  }) = _AdminUserDetail;

  const AdminUserDetail._();
}

@freezed
abstract class EmailDeliveryLogRecord with _$EmailDeliveryLogRecord {
  const factory EmailDeliveryLogRecord({
    required String id,
    required String? profileId,
    required String? bookingId,
    required String templateKey,
    required String? templateLanguageCode,
    required String locale,
    required String recipientEmail,
    required String? subjectPreview,
    required String? providerMessageId,
    required String status,
    required String provider,
    required int attemptCount,
    required DateTime? lastAttemptAt,
    required DateTime? nextRetryAt,
    required DateTime? lastErrorAt,
    required String? errorCode,
    required String? errorMessage,
    required Map<String, dynamic> payloadSnapshot,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _EmailDeliveryLogRecord;

  const EmailDeliveryLogRecord._();

  factory EmailDeliveryLogRecord.fromJson(Map<String, dynamic> json) {
    return EmailDeliveryLogRecord(
      id: json['id'] as String,
      profileId: json['profile_id'] as String?,
      bookingId: json['booking_id'] as String?,
      templateKey: (json['template_key'] as String?)?.trim() ?? '',
      templateLanguageCode: (json['template_language_code'] as String?)?.trim(),
      locale: (json['locale'] as String?)?.trim() ?? 'en',
      recipientEmail: (json['recipient_email'] as String?)?.trim() ?? '',
      subjectPreview: (json['subject_preview'] as String?)?.trim(),
      providerMessageId: (json['provider_message_id'] as String?)?.trim(),
      status: (json['status'] as String?)?.trim() ?? 'queued',
      provider: (json['provider'] as String?)?.trim() ?? '',
      attemptCount: (json['attempt_count'] as num?)?.toInt() ?? 0,
      lastAttemptAt: DateTime.tryParse(
        json['last_attempt_at'] as String? ?? '',
      ),
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
}

@freezed
abstract class EmailOutboxJobRecord with _$EmailOutboxJobRecord {
  const factory EmailOutboxJobRecord({
    required String id,
    required String eventKey,
    required String dedupeKey,
    required String? profileId,
    required String? bookingId,
    required String templateKey,
    required String? templateLanguageCode,
    required String locale,
    required String recipientEmail,
    required String priority,
    required String status,
    required int attemptCount,
    required int maxAttempts,
    required DateTime? availableAt,
    required DateTime? lockedAt,
    required String? lockedBy,
    required String? lastErrorCode,
    required String? lastErrorMessage,
    required Map<String, dynamic> payloadSnapshot,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _EmailOutboxJobRecord;

  const EmailOutboxJobRecord._();

  factory EmailOutboxJobRecord.fromJson(Map<String, dynamic> json) {
    return EmailOutboxJobRecord(
      id: json['id'] as String,
      eventKey: (json['event_key'] as String?)?.trim() ?? '',
      dedupeKey: (json['dedupe_key'] as String?)?.trim() ?? '',
      profileId: json['profile_id'] as String?,
      bookingId: json['booking_id'] as String?,
      templateKey: (json['template_key'] as String?)?.trim() ?? '',
      templateLanguageCode: (json['template_language_code'] as String?)?.trim(),
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
}

@freezed
abstract class EligiblePayoutQueueItem with _$EligiblePayoutQueueItem {
  const factory EligiblePayoutQueueItem({
    required BookingRecord booking,
    required AppProfile? carrier,
  }) = _EligiblePayoutQueueItem;

  const EligiblePayoutQueueItem._();
}

@freezed
abstract class AdminAutomationAlertItem with _$AdminAutomationAlertItem {
  const factory AdminAutomationAlertItem({
    required BookingRecord booking,
    required String kind,
    required DateTime referenceAt,
    required int thresholdHours,
  }) = _AdminAutomationAlertItem;

  const AdminAutomationAlertItem._();
}
