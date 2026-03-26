import 'package:fleetfill/core/localization/localization.dart';

class LocalizedNotificationCopy {
  const LocalizedNotificationCopy({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

LocalizedNotificationCopy localizedNotificationCopy({
  required S s,
  required String? type,
  required Map<String, dynamic> data,
  required String? fallbackTitle,
  required String? fallbackBody,
}) {
  final normalizedType = (type ?? '').trim();
  return switch (normalizedType) {
    'booking_confirmed' => LocalizedNotificationCopy(
      title: s.notificationBookingConfirmedTitle,
      body: s.notificationBookingConfirmedBody,
    ),
    'payment_proof_submitted' => LocalizedNotificationCopy(
      title: s.notificationPaymentProofSubmittedTitle,
      body: s.notificationPaymentProofSubmittedBody,
    ),
    'payment_secured' => LocalizedNotificationCopy(
      title: s.notificationPaymentSecuredTitle,
      body: s.notificationPaymentSecuredBody,
    ),
    'payment_rejected' => LocalizedNotificationCopy(
      title: s.notificationPaymentRejectedTitle,
      body: s.notificationPaymentRejectedBody,
    ),
    'booking_milestone_updated' => LocalizedNotificationCopy(
      title: s.notificationBookingMilestoneUpdatedTitle,
      body: s.notificationBookingMilestoneUpdatedBody(
        _milestoneLabel(s, data['milestone'] as String?),
      ),
    ),
    'carrier_review_submitted' => LocalizedNotificationCopy(
      title: s.notificationCarrierReviewSubmittedTitle,
      body: s.notificationCarrierReviewSubmittedBody,
    ),
    'dispute_opened' => LocalizedNotificationCopy(
      title: s.notificationDisputeOpenedTitle,
      body: s.notificationDisputeOpenedBody,
    ),
    'dispute_resolved' => LocalizedNotificationCopy(
      title: s.notificationDisputeResolvedTitle,
      body: s.notificationDisputeResolvedBody,
    ),
    'payout_released' => LocalizedNotificationCopy(
      title: s.notificationPayoutReleasedTitle,
      body: s.notificationPayoutReleasedBody,
    ),
    'generated_document_ready' => LocalizedNotificationCopy(
      title: s.notificationGeneratedDocumentReadyTitle,
      body: s.notificationGeneratedDocumentReadyBody(
        _generatedDocumentTypeLabel(s, data['document_type'] as String?),
      ),
    ),
    'verification_packet_approved' => LocalizedNotificationCopy(
      title: s.notificationVerificationPacketApprovedTitle,
      body: s.notificationVerificationPacketApprovedBody,
    ),
    'verification_document_rejected' => LocalizedNotificationCopy(
      title: s.notificationVerificationDocumentRejectedTitle,
      body: s.notificationVerificationDocumentRejectedBody(
        _verificationDocumentTypeLabel(s, data['document_type'] as String?),
        (data['reason'] as String?)?.trim().isNotEmpty == true
            ? (data['reason'] as String).trim()
            : s.verificationDocumentRejectedFallbackReason,
      ),
    ),
    'support_request_created' => LocalizedNotificationCopy(
      title: s.notificationSupportRequestCreatedTitle,
      body: s.notificationSupportRequestCreatedBody,
    ),
    'support_reply_received' => LocalizedNotificationCopy(
      title: s.notificationSupportReplyReceivedTitle,
      body: s.notificationSupportReplyReceivedBody,
    ),
    'support_user_replied' => LocalizedNotificationCopy(
      title: s.notificationSupportUserRepliedTitle,
      body: s.notificationSupportUserRepliedBody,
    ),
    'support_status_changed' => LocalizedNotificationCopy(
      title: s.notificationSupportStatusChangedTitle,
      body: s.notificationSupportStatusChangedBody(
        _supportStatusLabel(s, data['status'] as String?),
      ),
    ),
    _ => LocalizedNotificationCopy(
      title: (fallbackTitle?.trim().isNotEmpty == true)
          ? fallbackTitle!.trim()
          : s.notificationsCenterTitle,
      body: (fallbackBody?.trim().isNotEmpty == true)
          ? fallbackBody!.trim()
          : s.notificationDetailDescription,
    ),
  };
}

String _generatedDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'payment_receipt' => s.generatedDocumentTypePaymentReceipt,
    'payout_receipt' => s.generatedDocumentTypePayoutReceipt,
    _ => s.generatedDocumentsTitle,
  };
}

String _verificationDocumentTypeLabel(S s, String? documentType) {
  return switch (documentType) {
    'driver_identity_or_license' => s.verificationDocumentDriverIdentityLabel,
    'truck_registration' => s.verificationDocumentTruckRegistrationLabel,
    'truck_insurance' => s.verificationDocumentTruckInsuranceLabel,
    'truck_technical_inspection' => s.verificationDocumentTruckInspectionLabel,
    'transport_license' => s.verificationDocumentTransportLicenseLabel,
    _ => s.verificationDocumentViewerTitle,
  };
}

String _milestoneLabel(S s, String? milestone) {
  return switch (milestone) {
    'payment_under_review' => s.trackingEventPaymentUnderReviewLabel,
    'confirmed' => s.trackingEventConfirmedLabel,
    'picked_up' => s.trackingEventPickedUpLabel,
    'in_transit' => s.trackingEventInTransitLabel,
    'delivered_pending_review' => s.trackingEventDeliveredPendingReviewLabel,
    'completed' => s.trackingEventCompletedLabel,
    'cancelled' => s.trackingEventCancelledLabel,
    'disputed' => s.trackingEventDisputedLabel,
    _ => milestone ?? '',
  };
}

String _supportStatusLabel(S s, String? status) {
  return switch (status) {
    'open' => s.supportStatusOpenLabel,
    'in_progress' => s.supportStatusInProgressLabel,
    'waiting_for_user' => s.supportStatusWaitingForUserLabel,
    'resolved' => s.supportStatusResolvedLabel,
    'closed' => s.supportStatusClosedLabel,
    _ => s.supportStatusOpenLabel,
  };
}
