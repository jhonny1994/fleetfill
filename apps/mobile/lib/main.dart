import 'dart:async';

import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

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
        supabaseInitializedProvider.overrideWithValue(
          dependencies.supabaseInitialized,
        ),
      ],
      child: const FleetFillApp(),
    ),
  );
}

bool shouldShowBootstrapFailure(AsyncValue<AppBootstrapState> bootstrap) {
  if (bootstrap.hasError && !bootstrap.hasValue) {
    return true;
  }

  return bootstrap.asData?.value.status == BootstrapStateStatus.failed;
}

class FleetFillApp extends ConsumerWidget {
  const FleetFillApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(effectiveLocaleProvider);
    final localeRegistry = ref.watch(localeRegistryProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: localeRegistry.enabledLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        return AppLocaleResolver.resolveFromList(
          deviceLocale == null ? null : <Locale>[deviceLocale],
          supportedLocales,
          fallbackLocale: localeRegistry.fallbackLocale,
        );
      },
      localizationsDelegates: const [
        S.delegate,
        LocaleNamesLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final bootstrap = ref.watch(appBootstrapControllerProvider);
        final currentLocale = Localizations.localeOf(context);
        final textDirection =
            intl.Bidi.isRtlLanguage(currentLocale.languageCode)
            ? TextDirection.rtl
            : TextDirection.ltr;

        return Directionality(
          textDirection: textDirection,
          child: PushNotificationCoordinator(
            child: AppFocusTraversal.largeScreen(
              child: _buildBootstrapAwareChild(
                context,
                ref,
                child,
                bootstrap,
              ),
            ),
          ),
        );
      },
      routerConfig: router,
    );
  }

  Widget _buildBootstrapAwareChild(
    BuildContext context,
    WidgetRef ref,
    Widget? child,
    AsyncValue<AppBootstrapState> bootstrap,
  ) {
    if (shouldShowBootstrapFailure(bootstrap)) {
      final bootstrapError = bootstrap.asData?.value.error ?? bootstrap.error;
      final bootstrapStackTrace =
          bootstrap.asData?.value.stackTrace ?? bootstrap.stackTrace;
      final message = bootstrapError is AppBootstrapLocalBackendException
          ? S.of(context).localBackendUnavailableMessage
          : S.of(context).routeErrorMessage;

      return AppErrorState(
        error: AppError(
          code: 'bootstrap_failed',
          message: message,
          technicalDetails: BidiFormatters.latinIdentifier(
            bootstrapStackTrace?.toString() ?? bootstrapError.toString(),
          ),
        ),
        onRetry: () => unawaited(
          ref.read(appBootstrapControllerProvider.notifier).retry(),
        ),
      );
    }

    if (!bootstrap.hasValue) {
      return const SplashScreen();
    }

    return child ?? const SizedBox.shrink();
  }
}
