import 'package:fleetfill/core/routing/app_routes.dart';
import 'package:fleetfill/features/notifications/infrastructure/push_notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('routeForPushMessageData', () {
    test('prefers explicit route when present', () {
      final route = routeForPushMessageData(const {
        'route': '/shared/notifications',
      });

      expect(route, AppRoutePath.sharedNotifications);
    });

    test('falls back to notification detail route', () {
      final route = routeForPushMessageData(const {
        'notification_id': 'note-1',
      });

      expect(
        route,
        AppRoutePath.sharedNotificationDetail.replaceFirst(':id', 'note-1'),
      );
    });
  });
}
