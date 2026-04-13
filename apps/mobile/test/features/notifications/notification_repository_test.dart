import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationRepository', () {
    const environment = AppEnvironmentConfig(
      supabaseUrl: 'http://127.0.0.1:54321',
    );
    const logger = DebugAppLogger();

    test('uses bounded notification page size', () {
      const repository = NotificationRepository(
        environment: environment,
        logger: logger,
      );

      expect(repository.environment.isLocalBackend, isTrue);
      expect(NotificationRepository.notificationsPageSize, 50);
    });

    test('notification feed controller loads additional pages', () async {
      final repository = _FakeNotificationRepository(
        notifications: List.generate(
          55,
          (index) => AppNotificationRecord(
            id: 'notification-$index',
            type: 'booking_confirmed',
            title: 'Notification $index',
            body: 'Body $index',
            data: const <String, dynamic>{},
            isRead: index.isEven,
            createdAt: DateTime.utc(2026, 3, 21).subtract(
              Duration(minutes: index),
            ),
            readAt: index.isEven ? DateTime.utc(2026, 3, 21) : null,
          ),
        ),
      );
      final container = ProviderContainer(
        overrides: [
          notificationRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final initialState = await container.read(myNotificationsProvider.future);

      expect(initialState.items, hasLength(50));
      expect(initialState.hasMore, isTrue);

      await container.read(myNotificationsProvider.notifier).loadMore();

      final loadedState = container.read(myNotificationsProvider).requireValue;
      expect(loadedState.items, hasLength(55));
      expect(loadedState.hasMore, isFalse);
      expect(loadedState.items.last.id, 'notification-54');
    });

    test(
      'notification feed controller stops at exact page boundaries',
      () async {
        final repository = _FakeNotificationRepository(
          notifications: List.generate(
            50,
            (index) => AppNotificationRecord(
              id: 'notification-$index',
              type: 'booking_confirmed',
              title: 'Notification $index',
              body: 'Body $index',
              data: const <String, dynamic>{},
              isRead: index.isEven,
              createdAt: DateTime.utc(2026, 3, 21).subtract(
                Duration(minutes: index),
              ),
              readAt: index.isEven ? DateTime.utc(2026, 3, 21) : null,
            ),
          ),
        );
        final container = ProviderContainer(
          overrides: [
            notificationRepositoryProvider.overrideWithValue(repository),
          ],
        );
        addTearDown(container.dispose);

        final initialState = await container.read(
          myNotificationsProvider.future,
        );

        expect(initialState.items, hasLength(50));
        expect(initialState.hasMore, isFalse);
      },
    );
  });
}

class _FakeNotificationRepository extends NotificationRepository {
  _FakeNotificationRepository({required this.notifications})
    : super(
        environment: const AppEnvironmentConfig(
          supabaseUrl: 'http://127.0.0.1:54321',
        ),
        logger: const DebugAppLogger(),
      );

  final List<AppNotificationRecord> notifications;

  @override
  Future<NotificationPage> fetchMyNotificationsPage({
    int offset = 0,
    int limit = NotificationRepository.notificationsPageSize,
  }) async {
    final start = offset.clamp(0, notifications.length);
    final end = (start + limit).clamp(0, notifications.length);
    final items = notifications.sublist(start, end);
    return NotificationPage(
      items: items,
      offset: start,
      limit: limit,
      hasMore: end < notifications.length,
    );
  }
}
