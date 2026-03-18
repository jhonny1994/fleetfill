import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_environment.dart';
import 'package:fleetfill/core/localization/locale_controller.dart';
import 'package:fleetfill/core/theme/theme_controller.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/core/utils/crash_reporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_bootstrap.g.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw UnimplementedError('secureStorageProvider must be overridden');
});

final appEnvironmentConfigProvider = Provider<AppEnvironmentConfig>((ref) {
  throw UnimplementedError('appEnvironmentConfigProvider must be overridden');
});

final appLoggerProvider = Provider<AppLogger>((ref) => const DebugAppLogger());
final crashReporterProvider = Provider<CrashReporter>(
  (ref) => const NoopCrashReporter(),
);

class PreparedAppDependencies {
  const PreparedAppDependencies({
    required this.sharedPreferences,
    required this.secureStorage,
    required this.environmentConfig,
    required this.initialThemeMode,
    required this.initialLocale,
    required this.logger,
    required this.crashReporter,
    required this.supabaseInitialized,
  });

  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;
  final AppEnvironmentConfig environmentConfig;
  final ThemeMode initialThemeMode;
  final Locale? initialLocale;
  final AppLogger logger;
  final CrashReporter crashReporter;
  final bool supabaseInitialized;
}

Future<PreparedAppDependencies> prepareAppDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  final environmentConfig = AppEnvironmentConfig.fromDefines();
  const logger = DebugAppLogger();
  final crashReporter = environmentConfig.crashReportingEnabled
      ? const DeferredCrashReporter()
      : const NoopCrashReporter();
  final supabaseInitialized = await _initializeSupabase(environmentConfig);

  return PreparedAppDependencies(
    sharedPreferences: sharedPreferences,
    secureStorage: secureStorage,
    environmentConfig: environmentConfig,
    initialThemeMode: ThemeModePreference.fromStorage(
      sharedPreferences.getString(themeModeStorageKey),
    ).themeMode,
    initialLocale: LocaleController.localeFromStorage(
      sharedPreferences.getString(localeStorageKey),
    ),
    logger: logger,
    crashReporter: crashReporter,
    supabaseInitialized: supabaseInitialized,
  );
}

Future<bool> _initializeSupabase(AppEnvironmentConfig environment) async {
  if (!environment.hasSupabaseConfig ||
      AppBootstrapController.supabaseInitialized) {
    return false;
  }

  await Supabase.initialize(
    url: environment.supabaseUrl,
    anonKey: environment.supabaseAnonKey,
  );
  AppBootstrapController.supabaseInitialized = true;
  return true;
}

enum BootstrapStateStatus {
  ready,
  failed,
}

class AppBootstrapState {
  const AppBootstrapState({
    required this.status,
    required this.environment,
    required this.auth,
    this.error,
    this.stackTrace,
  });

  final BootstrapStateStatus status;
  final AppEnvironmentConfig environment;
  final AuthSnapshot auth;
  final Object? error;
  final StackTrace? stackTrace;
}

@riverpod
class AppBootstrapController extends _$AppBootstrapController {
  static bool supabaseInitialized = false;

  @override
  Future<AppBootstrapState> build() async {
    final environment = ref.watch(appEnvironmentConfigProvider);
    final logger = ref.watch(appLoggerProvider);

    try {
      final auth = await ref
          .read(authRepositoryProvider)
          .buildSnapshot(
            isPasswordRecovery: false,
            isSessionExpired: false,
          );

      if (supabaseInitialized) {
        logger.info('Supabase initialized for ${environment.environment.name}');
      }

      return AppBootstrapState(
        status: BootstrapStateStatus.ready,
        environment: environment,
        auth: auth,
      );
    } on Object catch (error, stackTrace) {
      logger.error(
        'App bootstrap failed',
        error: error,
        stackTrace: stackTrace,
      );

      return AppBootstrapState(
        status: BootstrapStateStatus.failed,
        environment: environment,
        auth: const AuthSnapshot(status: AuthStatus.unauthenticated),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
  }
}
