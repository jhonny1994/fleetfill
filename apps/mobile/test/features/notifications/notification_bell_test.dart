import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('AppPageScaffold bell opens notifications center', (
    tester,
  ) async {
    final repository = _FakeNotificationRepository(
      notifications: [
        AppNotificationRecord(
          id: 'notification-1',
          type: 'booking_confirmed',
          title: 'Booking confirmed',
          body: 'Body',
          data: const <String, dynamic>{},
          isRead: false,
          createdAt: DateTime.utc(2026, 3, 23),
          readAt: null,
        ),
      ],
    );
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const AppPageScaffold(
            title: 'Home',
            child: SizedBox.shrink(),
          ),
        ),
        GoRoute(
          path: AppRoutePath.sharedNotifications,
          builder: (_, _) => const Scaffold(body: Text('notifications-center')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authSessionControllerProvider.overrideWith(
            _FakeAuthSessionController.new,
          ),
          notificationRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: const Locale('en'),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.notifications_none_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.notifications_none_rounded));
    await tester.pumpAndSettle();

    expect(find.text('notifications-center'), findsOneWidget);
  });
}

class _FakeAuthSessionController extends AuthSessionController {
  @override
  Future<AuthSnapshot> build() async {
    return const AuthSnapshot(
      status: AuthStatus.authenticated,
      userId: 'user-1',
      email: 'shipper@example.com',
      role: AppUserRole.shipper,
      hasCompletedOnboarding: true,
      hasPhoneNumber: true,
    );
  }
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
    return NotificationPage(
      items: notifications,
      offset: 0,
      limit: notifications.length,
      hasMore: false,
    );
  }
}
