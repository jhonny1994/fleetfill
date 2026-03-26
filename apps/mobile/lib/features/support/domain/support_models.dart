import 'package:fleetfill/core/auth/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_models.freezed.dart';

enum SupportRequestStatus {
  open,
  inProgress,
  waitingForUser,
  resolved,
  closed,
}

enum SupportRequestPriority { normal, high, urgent }

enum SupportMessageSenderType { user, admin, system }

SupportRequestStatus _supportRequestStatusFromString(String? value) {
  return switch ((value ?? '').trim()) {
    'open' => SupportRequestStatus.open,
    'in_progress' => SupportRequestStatus.inProgress,
    'waiting_for_user' => SupportRequestStatus.waitingForUser,
    'resolved' => SupportRequestStatus.resolved,
    'closed' => SupportRequestStatus.closed,
    _ => SupportRequestStatus.open,
  };
}

SupportRequestPriority _supportRequestPriorityFromString(String? value) {
  return switch ((value ?? '').trim()) {
    'high' => SupportRequestPriority.high,
    'urgent' => SupportRequestPriority.urgent,
    _ => SupportRequestPriority.normal,
  };
}

SupportMessageSenderType _supportMessageSenderTypeFromString(String? value) {
  return switch ((value ?? '').trim()) {
    'admin' => SupportMessageSenderType.admin,
    'system' => SupportMessageSenderType.system,
    _ => SupportMessageSenderType.user,
  };
}

AppUserRole? _appUserRoleFromString(String? value) {
  return switch ((value ?? '').trim()) {
    'shipper' => AppUserRole.shipper,
    'carrier' => AppUserRole.carrier,
    'admin' => AppUserRole.admin,
    _ => null,
  };
}

@freezed
abstract class SupportRequestRecord with _$SupportRequestRecord {
  const factory SupportRequestRecord({
    required String id,
    required String createdBy,
    required AppUserRole? requesterRole,
    required String subject,
    required SupportRequestStatus status,
    required SupportRequestPriority priority,
    required String? shipmentId,
    required String? bookingId,
    required String? paymentProofId,
    required String? disputeId,
    required String? assignedAdminId,
    required String? lastMessagePreview,
    required SupportMessageSenderType lastMessageSenderType,
    required DateTime lastMessageAt,
    required DateTime? userLastReadAt,
    required DateTime? adminLastReadAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SupportRequestRecord;
  factory SupportRequestRecord.fromJson(Map<String, dynamic> json) {
    return SupportRequestRecord(
      id: json['id'] as String,
      createdBy: json['created_by'] as String,
      requesterRole: _appUserRoleFromString(json['requester_role'] as String?),
      subject: (json['subject'] as String?)?.trim() ?? '',
      status: _supportRequestStatusFromString(json['status'] as String?),
      priority: _supportRequestPriorityFromString(json['priority'] as String?),
      shipmentId: json['shipment_id'] as String?,
      bookingId: json['booking_id'] as String?,
      paymentProofId: json['payment_proof_id'] as String?,
      disputeId: json['dispute_id'] as String?,
      assignedAdminId: json['assigned_admin_id'] as String?,
      lastMessagePreview: (json['last_message_preview'] as String?)?.trim(),
      lastMessageSenderType: _supportMessageSenderTypeFromString(
        json['last_message_sender_type'] as String?,
      ),
      lastMessageAt: DateTime.parse(json['last_message_at'] as String),
      userLastReadAt: DateTime.tryParse(
        json['user_last_read_at'] as String? ?? '',
      ),
      adminLastReadAt: DateTime.tryParse(
        json['admin_last_read_at'] as String? ?? '',
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  const SupportRequestRecord._();

  bool get hasUnreadForUser =>
      lastMessageSenderType == SupportMessageSenderType.admin &&
      (userLastReadAt == null || lastMessageAt.isAfter(userLastReadAt!));

  bool get hasUnreadForAdmin =>
      lastMessageSenderType == SupportMessageSenderType.user &&
      (adminLastReadAt == null || lastMessageAt.isAfter(adminLastReadAt!));
}

@freezed
abstract class SupportMessageRecord with _$SupportMessageRecord {
  const factory SupportMessageRecord({
    required String id,
    required String requestId,
    required String? senderProfileId,
    required SupportMessageSenderType senderType,
    required String body,
    required DateTime createdAt,
  }) = _SupportMessageRecord;

  const SupportMessageRecord._();

  factory SupportMessageRecord.fromJson(Map<String, dynamic> json) {
    return SupportMessageRecord(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      senderProfileId: json['sender_profile_id'] as String?,
      senderType: _supportMessageSenderTypeFromString(
        json['sender_type'] as String?,
      ),
      body: (json['body'] as String?)?.trim() ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

@freezed
abstract class SupportThreadRecord with _$SupportThreadRecord {
  const factory SupportThreadRecord({
    required SupportRequestRecord request,
    required List<SupportMessageRecord> messages,
  }) = _SupportThreadRecord;
}

bool shouldMarkSupportThreadRead({
  required SupportRequestRecord request,
  required bool isAdmin,
  DateTime? lastMarkedMessageAt,
}) {
  final hasUnread = isAdmin
      ? request.hasUnreadForAdmin
      : request.hasUnreadForUser;
  if (!hasUnread) {
    return false;
  }

  if (lastMarkedMessageAt == null) {
    return true;
  }

  return request.lastMessageAt.isAfter(lastMarkedMessageAt);
}

bool shouldShowSupportDisputeAction({
  required SupportRequestRecord request,
  required bool isAdmin,
}) {
  return isAdmin && request.disputeId != null;
}
