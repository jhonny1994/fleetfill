import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dependencies = await prepareAppDependencies();
  installGlobalErrorHandlers(
    logger: dependencies.logger,
    crashReporter: dependencies.crashReporter,
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          dependencies.sharedPreferences,
        ),
        secureStorageProvider.overrideWithValue(dependencies.secureStorage),
        appEnvironmentConfigProvider.overrideWithValue(
          dependencies.environmentConfig,
        ),
        initialThemeModeProvider.overrideWithValue(
          dependencies.initialThemeMode,
        ),
        initialLocaleProvider.overrideWithValue(dependencies.initialLocale),
        appLoggerProvider.overrideWithValue(dependencies.logger),
        crashReporterProvider.overrideWithValue(dependencies.crashReporter),
      ],
      child: const FleetFillApp(),
    ),
  );
}

class FleetFillApp extends ConsumerWidget {
  const FleetFillApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(effectiveLocaleProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return AppLocaleResolver.resolveFromList(
          deviceLocale == null ? null : <Locale>[deviceLocale],
          supportedLocales,
        );
      },
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final bootstrap = ref.watch(appBootstrapControllerProvider);
        final authSession = ref.watch(authSessionControllerProvider);
        final currentLocale = Localizations.localeOf(context);
        final textDirection = currentLocale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr;

        return Directionality(
          textDirection: textDirection,
          child: AppFocusTraversal.largeScreen(
            child: bootstrap.when(
              data: (_) => authSession.when(
                data: (_) => child ?? const SizedBox.shrink(),
                loading: () => const SplashScreen(),
                error: (error, stackTrace) => AppErrorState(
                  error: AppError(
                    code: 'auth_session_failed',
                    message: S.of(context).routeErrorMessage,
                    technicalDetails: BidiFormatters.latinIdentifier(
                      stackTrace.toString(),
                    ),
                  ),
                  onRetry: () => unawaited(
                    ref.read(authSessionControllerProvider.notifier).refresh(),
                  ),
                ),
              ),
              loading: () => const SplashScreen(),
              error: (error, stackTrace) => AppErrorState(
                error: AppError(
                  code: 'bootstrap_failed',
                  message: S.of(context).routeErrorMessage,
                  technicalDetails: BidiFormatters.latinIdentifier(
                    stackTrace.toString(),
                  ),
                ),
                onRetry: () => unawaited(
                  ref.read(appBootstrapControllerProvider.notifier).retry(),
                ),
              ),
            ),
          ),
        );
      },
      routerConfig: router,
    );
  }
}
