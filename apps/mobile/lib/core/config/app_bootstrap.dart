import 'dart:async';

import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_environment.dart';
import 'package:fleetfill/core/localization/locale_controller.dart';
import 'package:fleetfill/core/theme/theme_controller.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/core/utils/crash_reporter.dart';
import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_bootstrap.g.dart';

const _bootstrapLocalNetworkTimeout = Duration(seconds: 8);

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  throw UnimplementedError('secureStorageProvider must be overridden');
});

final appEnvironmentConfigProvider = Provider<AppEnvironmentConfig>((ref) {
  throw UnimplementedError('appEnvironmentConfigProvider must be overridden');
});
final supabaseInitializedProvider = Provider<bool>((ref) => false);

final appLoggerProvider = Provider<AppLogger>((ref) => const DebugAppLogger());
final crashReporterProvider = Provider<CrashReporter>(
  (ref) => NoopCrashReporter(logger: ref.watch(appLoggerProvider)),
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
      ? const DeferredCrashReporter(logger: logger)
      : const NoopCrashReporter(logger: logger);
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
  if (!environment.hasSupabaseConfig) {
    return false;
  }

  await Supabase.initialize(
    url: environment.supabaseUrl,
    anonKey: environment.supabaseAnonKey,
  );
  return true;
}

Future<ClientSettings> _fetchClientSettings() async {
  final response = await Supabase.instance.client
      .rpc<Map<String, dynamic>>('get_client_settings')
      .timeout(_bootstrapLocalNetworkTimeout);
  return ClientSettings.fromJson(response);
}

Future<({AppEnvironmentConfig environment, ClientSettings clientSettings})>
_resolveRuntimeEnvironment(
  AppEnvironmentConfig environment,
  bool supabaseInitialized,
) async {
  final fallbackClientSettings = ClientSettings.fromJson(
    const <String, dynamic>{},
  );
  if (!environment.hasSupabaseConfig || !supabaseInitialized) {
    return (
      environment: environment,
      clientSettings: fallbackClientSettings,
    );
  }

  try {
    final clientSettings = await _fetchClientSettings();
    final appRuntime = clientSettings.appRuntime;

    return (
      environment: environment.copyWith(
        maintenanceMode: appRuntime.maintenanceMode,
        forceUpdateRequired: appRuntime.forceUpdateRequired,
      ),
      clientSettings: clientSettings,
    );
  } on Object catch (error) {
    if (environment.isLocalBackend) {
      throw AppBootstrapLocalBackendException(
        supabaseUrl: environment.supabaseUrl,
        reason:
            'Failed to load runtime client settings from the local Supabase backend: $error',
      );
    }

    return (
      environment: environment,
      clientSettings: fallbackClientSettings,
    );
  }
}

enum BootstrapStateStatus {
  ready,
  failed,
}

class AppBootstrapState {
  const AppBootstrapState({
    required this.status,
    required this.environment,
    required this.clientSettings,
    required this.auth,
    this.error,
    this.stackTrace,
  });

  final BootstrapStateStatus status;
  final AppEnvironmentConfig environment;
  final ClientSettings clientSettings;
  final AuthSnapshot auth;
  final Object? error;
  final StackTrace? stackTrace;
}

@riverpod
class AppBootstrapController extends _$AppBootstrapController {
  @override
  Future<AppBootstrapState> build() async {
    final configuredEnvironment = ref.watch(appEnvironmentConfigProvider);
    final supabaseInitialized = ref.watch(supabaseInitializedProvider);
    final logger = ref.watch(appLoggerProvider);
    final localAndroidNetworkTarget =
        AppEnvironmentConfig.resolveLocalAndroidNetworkTargetForTesting();

    try {
      logger.info(
        'Starting app bootstrap',
        context: {
          'supabaseTargetKind': configuredEnvironment.supabaseTargetKind,
          'supabaseUrl': configuredEnvironment.supabaseUrl,
          'hasSupabaseConfig': configuredEnvironment.hasSupabaseConfig,
          'localAndroidNetworkTarget': localAndroidNetworkTarget.name,
        },
      );
      final runtime = await _resolveRuntimeEnvironment(
        configuredEnvironment,
        supabaseInitialized,
      );
      final auth = await ref
          .read(authRepositoryProvider)
          .buildSnapshot(
            isPasswordRecovery: false,
            isSessionExpired: false,
          )
          .timeout(
            _bootstrapLocalNetworkTimeout,
            onTimeout: () {
              if (runtime.environment.isLocalBackend) {
                throw AppBootstrapLocalBackendException(
                  supabaseUrl: runtime.environment.supabaseUrl,
                  reason:
                      'Timed out while loading the initial auth/profile bootstrap state from the local backend.',
                );
              }

              throw TimeoutException(
                'Timed out while loading the initial auth/profile bootstrap state.',
              );
            },
          );

      if (supabaseInitialized) {
        logger.info(
          'Supabase initialized for ${runtime.environment.supabaseTargetKind}',
          context: {
            'supabaseUrl': runtime.environment.supabaseUrl,
            'supabaseTargetKind': runtime.environment.supabaseTargetKind,
            'localAndroidNetworkTarget': localAndroidNetworkTarget.name,
          },
        );
      }

      return AppBootstrapState(
        status: BootstrapStateStatus.ready,
        environment: runtime.environment,
        clientSettings: runtime.clientSettings,
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
        environment: configuredEnvironment,
        clientSettings: ClientSettings.fromJson(const <String, dynamic>{}),
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

class AppBootstrapLocalBackendException implements Exception {
  const AppBootstrapLocalBackendException({
    required this.supabaseUrl,
    required this.reason,
  });

  final String supabaseUrl;
  final String reason;

  @override
  String toString() =>
      'Local backend unavailable (url=$supabaseUrl, reason=$reason)';
}
