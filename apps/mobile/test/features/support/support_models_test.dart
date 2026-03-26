import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/features/support/domain/support_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('support thread helpers', () {
    SupportRequestRecord request({
      required DateTime lastMessageAt,
      SupportMessageSenderType lastMessageSenderType =
          SupportMessageSenderType.admin,
      DateTime? userLastReadAt,
      DateTime? adminLastReadAt,
      String? disputeId,
    }) {
      return SupportRequestRecord(
        id: 'support-1',
        createdBy: 'user-1',
        requesterRole: AppUserRole.shipper,
        subject: 'Payment issue',
        status: SupportRequestStatus.open,
        priority: SupportRequestPriority.normal,
        shipmentId: null,
        bookingId: null,
        paymentProofId: null,
        disputeId: disputeId,
        assignedAdminId: null,
        lastMessagePreview: 'Latest message',
        lastMessageSenderType: lastMessageSenderType,
        lastMessageAt: lastMessageAt,
        userLastReadAt: userLastReadAt,
        adminLastReadAt: adminLastReadAt,
        createdAt: DateTime.utc(2026, 3, 24, 10),
        updatedAt: DateTime.utc(2026, 3, 24, 10),
      );
    }

    test('marks unread user thread on first view', () {
      final supportRequest = request(
        lastMessageAt: DateTime.utc(2026, 3, 24, 12),
      );

      expect(
        shouldMarkSupportThreadRead(
          request: supportRequest,
          isAdmin: false,
        ),
        isTrue,
      );
    });

    test(
      'does not re-mark when already marked at latest message timestamp',
      () {
        final lastMessageAt = DateTime.utc(2026, 3, 24, 12);
        final supportRequest = request(lastMessageAt: lastMessageAt);

        expect(
          shouldMarkSupportThreadRead(
            request: supportRequest,
            isAdmin: false,
            lastMarkedMessageAt: lastMessageAt,
          ),
          isFalse,
        );
      },
    );

    test('re-marks when a newer unread reply arrives after the last mark', () {
      final supportRequest = request(
        lastMessageAt: DateTime.utc(2026, 3, 24, 13),
      );

      expect(
        shouldMarkSupportThreadRead(
          request: supportRequest,
          isAdmin: false,
          lastMarkedMessageAt: DateTime.utc(2026, 3, 24, 12),
        ),
        isTrue,
      );
    });

    test('hides dispute action for non-admin support threads', () {
      final supportRequest = request(
        lastMessageAt: DateTime.utc(2026, 3, 24, 12),
        disputeId: 'dispute-1',
      );

      expect(
        shouldShowSupportDisputeAction(
          request: supportRequest,
          isAdmin: false,
        ),
        isFalse,
      );
    });

    test(
      'shows dispute action for admin support threads with a linked dispute',
      () {
        final supportRequest = request(
          lastMessageAt: DateTime.utc(2026, 3, 24, 12),
          disputeId: 'dispute-1',
        );

        expect(
          shouldShowSupportDisputeAction(
            request: supportRequest,
            isAdmin: true,
          ),
          isTrue,
        );
      },
    );
  });
}
