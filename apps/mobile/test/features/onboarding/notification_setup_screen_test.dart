import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:fleetfill/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'NotificationSetupScreen skip continues without permission call',
    (
      tester,
    ) async {
      final pushService = _FakePushNotificationService();
      final tracker = _WorkflowTracker();

      await tester.pumpWidget(
        _buildHarness(pushService: pushService, tracker: tracker),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Skip for now'));
      await tester.pumpAndSettle();

      expect(pushService.requestCallCount, 0);
      expect(tracker.completeCalls, 1);
      expect(find.text('shipper-home'), findsOneWidget);
    },
  );

  testWidgets(
    'NotificationSetupScreen enable requests permission before continuing',
    (tester) async {
      final pushService = _FakePushNotificationService();
      final tracker = _WorkflowTracker();

      await tester.pumpWidget(
        _buildHarness(pushService: pushService, tracker: tracker),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Enable notifications'));
      await tester.pumpAndSettle();

      expect(pushService.requestCallCount, 1);
      expect(tracker.completeCalls, 1);
      expect(find.text('shipper-home'), findsOneWidget);
    },
  );
}

Widget _buildHarness({
  required _FakePushNotificationService pushService,
  required _WorkflowTracker tracker,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutePath.notificationSetup,
        builder: (_, _) => const NotificationSetupScreen(),
      ),
      GoRoute(
        path: AppRoutePath.shipperHome,
        builder: (_, _) => const Scaffold(body: Text('shipper-home')),
      ),
    ],
    initialLocation: AppRoutePath.notificationSetup,
  );

  return ProviderScope(
    overrides: [
      authSessionControllerProvider.overrideWith(
        _FakeAuthSessionController.new,
      ),
      notificationRepositoryProvider.overrideWithValue(
        _EmptyNotificationRepository(),
      ),
      pushNotificationServiceProvider.overrideWithValue(pushService),
      onboardingWorkflowControllerProvider.overrideWith(
        (ref) => _FakeOnboardingWorkflowController(
          ref,
          tracker: tracker,
          nextStep: OnboardingNextStep.shipperHome,
        ),
      ),
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
  );
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

class _FakeOnboardingWorkflowController extends OnboardingWorkflowController {
  _FakeOnboardingWorkflowController(
    super.ref, {
    required this.tracker,
    required this.nextStep,
  });

  final _WorkflowTracker tracker;
  final OnboardingNextStep nextStep;

  @override
  Future<OnboardingNextStep> completeNotificationSetup() async {
    tracker.completeCalls += 1;
    return nextStep;
  }
}

class _WorkflowTracker {
  int completeCalls = 0;
}

class _FakePushNotificationService extends PushNotificationService {
  _FakePushNotificationService()
    : super(
        environment: const AppEnvironmentConfig(
          supabaseUrl: 'http://127.0.0.1:54321',
        ),
        logger: const DebugAppLogger(),
        repository: _EmptyNotificationRepository(),
      );

  int requestCallCount = 0;

  @override
  Future<AuthorizationStatus> requestPermissionAndSync({
    required AuthSnapshot auth,
    required Locale locale,
  }) async {
    requestCallCount += 1;
    return AuthorizationStatus.authorized;
  }
}

class _EmptyNotificationRepository extends NotificationRepository {
  _EmptyNotificationRepository()
    : super(
        environment: const AppEnvironmentConfig(
          supabaseUrl: 'http://127.0.0.1:54321',
        ),
        logger: const DebugAppLogger(),
      );

  @override
  Future<NotificationPage> fetchMyNotificationsPage({
    int offset = 0,
    int limit = NotificationRepository.notificationsPageSize,
  }) async {
    return const NotificationPage(
      items: <AppNotificationRecord>[],
      offset: 0,
      limit: NotificationRepository.notificationsPageSize,
      hasMore: false,
    );
  }
}
