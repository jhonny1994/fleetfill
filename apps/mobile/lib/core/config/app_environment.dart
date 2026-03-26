import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_environment.freezed.dart';
part 'app_environment.g.dart';

enum LocalAndroidNetworkTarget { emulator, device, unspecified }

@freezed
abstract class AppEnvironmentConfig with _$AppEnvironmentConfig {
  const factory AppEnvironmentConfig({
    @Default('') String supabaseUrl,
    @Default('') String supabaseAnonKey,
    @Default('') String firebaseApiKey,
    @Default('') String firebaseMessagingSenderId,
    @Default('') String firebaseProjectId,
    @Default('') String firebaseStorageBucket,
    @Default('') String firebaseAndroidAppId,
    @Default('') String firebaseIosAppId,
    @Default('') String googleWebClientId,
    @Default('') String googleIosClientId,
    @Default(false) bool maintenanceMode,
    @Default(false) bool forceUpdateRequired,
    @Default(false) bool crashReportingEnabled,
  }) = _AppEnvironmentConfig;
  const AppEnvironmentConfig._();

  factory AppEnvironmentConfig.fromJson(Map<String, dynamic> json) =>
      _$AppEnvironmentConfigFromJson(json);

  factory AppEnvironmentConfig.fromDefines() {
    final supabaseUrl = _normalizeSupabaseUrl(
      _firstNonEmpty([
        const String.fromEnvironment('SUPABASE_URL'),
        const String.fromEnvironment('APP_SUPABASE_URL'),
      ]),
    );
    final publishableKey = _firstNonEmpty([
      const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY'),
      const String.fromEnvironment('APP_SUPABASE_PUBLISHABLE_KEY'),
    ]);
    final anonKey = _firstNonEmpty([
      const String.fromEnvironment('SUPABASE_ANON_KEY'),
      const String.fromEnvironment('APP_SUPABASE_ANON_KEY'),
    ]);

    return AppEnvironmentConfig(
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: _resolveClientKey(
        supabaseUrl: supabaseUrl,
        publishableKey: publishableKey,
        anonKey: anonKey,
      ),
      firebaseApiKey: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_API_KEY'),
        const String.fromEnvironment('APP_FIREBASE_API_KEY'),
      ]),
      firebaseMessagingSenderId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        const String.fromEnvironment('APP_FIREBASE_MESSAGING_SENDER_ID'),
      ]),
      firebaseProjectId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_PROJECT_ID'),
        const String.fromEnvironment('APP_FIREBASE_PROJECT_ID'),
      ]),
      firebaseStorageBucket: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        const String.fromEnvironment('APP_FIREBASE_STORAGE_BUCKET'),
      ]),
      firebaseAndroidAppId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_ANDROID_APP_ID'),
        const String.fromEnvironment('APP_FIREBASE_ANDROID_APP_ID'),
      ]),
      firebaseIosAppId: _firstNonEmpty([
        const String.fromEnvironment('FIREBASE_IOS_APP_ID'),
        const String.fromEnvironment('APP_FIREBASE_IOS_APP_ID'),
      ]),
      googleWebClientId: _firstNonEmpty([
        const String.fromEnvironment('GOOGLE_WEB_CLIENT_ID'),
        const String.fromEnvironment('APP_GOOGLE_WEB_CLIENT_ID'),
        const String.fromEnvironment('SUPABASE_AUTH_EXTERNAL_GOOGLE_CLIENT_ID'),
      ]),
      googleIosClientId: _firstNonEmpty([
        const String.fromEnvironment('GOOGLE_IOS_CLIENT_ID'),
        const String.fromEnvironment('APP_GOOGLE_IOS_CLIENT_ID'),
      ]),
      maintenanceMode: _parseBool(
        const String.fromEnvironment('MAINTENANCE_MODE'),
      ),
      forceUpdateRequired: _parseBool(
        const String.fromEnvironment('FORCE_UPDATE_REQUIRED'),
      ),
      crashReportingEnabled: _parseBool(
        const String.fromEnvironment('CRASH_REPORTING_ENABLED'),
      ),
    );
  }

  bool get hasSupabaseConfig =>
      supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;

  bool get isLocalBackend => _isLocalBackendUrl(supabaseUrl);

  String get supabaseTargetKind => isLocalBackend ? 'local' : 'hosted';

  static bool _parseBool(String value) => value.toLowerCase() == 'true';

  static String resolveClientKeyForTesting({
    required String supabaseUrl,
    String publishableKey = '',
    String anonKey = '',
  }) {
    return _resolveClientKey(
      supabaseUrl: supabaseUrl,
      publishableKey: publishableKey,
      anonKey: anonKey,
    );
  }

  static String _resolveClientKey({
    required String supabaseUrl,
    required String publishableKey,
    required String anonKey,
  }) {
    final normalizedPublishableKey = publishableKey.trim();
    final normalizedAnonKey = anonKey.trim();

    if (_isLocalBackendUrl(supabaseUrl)) {
      return _firstNonEmpty([
        normalizedAnonKey,
        normalizedPublishableKey,
      ]);
    }

    return _firstNonEmpty([
      normalizedPublishableKey,
      normalizedAnonKey,
    ]);
  }

  static String _firstNonEmpty(List<String> values) {
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) {
        return trimmed;
      }
    }

    return '';
  }

  static String normalizeSupabaseUrlForTesting(
    String url, {
    required bool isAndroid,
    bool isWeb = false,
    LocalAndroidNetworkTarget localAndroidNetworkTarget =
        LocalAndroidNetworkTarget.unspecified,
  }) {
    return _normalizeSupabaseUrl(
      url,
      isAndroidOverride: isAndroid,
      isWebOverride: isWeb,
      localAndroidNetworkTargetOverride: localAndroidNetworkTarget,
    );
  }

  static bool isLocalBackendUrlForTesting(String url) =>
      _isLocalBackendUrl(url);

  static LocalAndroidNetworkTarget resolveLocalAndroidNetworkTargetForTesting({
    LocalAndroidNetworkTarget? override,
  }) {
    return _resolveLocalAndroidNetworkTarget(override: override);
  }

  static String _normalizeSupabaseUrl(
    String url, {
    bool? isAndroidOverride,
    bool? isWebOverride,
    LocalAndroidNetworkTarget? localAndroidNetworkTargetOverride,
  }) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null || !_isLoopbackHost(uri.host.toLowerCase())) {
      return trimmed;
    }

    final isWebPlatform = isWebOverride ?? kIsWeb;
    final isAndroidPlatform =
        isAndroidOverride ??
        (!isWebPlatform && defaultTargetPlatform == TargetPlatform.android);
    if (!isAndroidPlatform) {
      return trimmed;
    }

    // Android emulators reach the host machine through 10.0.2.2.
    // Real devices must use a reachable LAN host directly.
    if (_resolveLocalAndroidNetworkTarget(
          override: localAndroidNetworkTargetOverride,
        ) !=
        LocalAndroidNetworkTarget.emulator) {
      return trimmed;
    }

    return uri.replace(host: '10.0.2.2').toString();
  }

  static bool _isLocalBackendUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null) {
      return false;
    }

    final host = uri.host.toLowerCase();
    return _isLoopbackHost(host) ||
        host.endsWith('.local') ||
        _isPrivateIpv4(host);
  }

  static bool _isLoopbackHost(String host) =>
      host == 'localhost' ||
      host == '127.0.0.1' ||
      host == '::1' ||
      host == '10.0.2.2';

  static bool _isPrivateIpv4(String host) {
    final parts = host.split('.');
    if (parts.length != 4) {
      return false;
    }

    final octets = <int>[];
    for (final part in parts) {
      final value = int.tryParse(part);
      if (value == null || value < 0 || value > 255) {
        return false;
      }
      octets.add(value);
    }

    final first = octets[0];
    final second = octets[1];
    if (first == 10) {
      return true;
    }
    if (first == 172 && second >= 16 && second <= 31) {
      return true;
    }
    if (first == 192 && second == 168) {
      return true;
    }

    return false;
  }

  static LocalAndroidNetworkTarget _resolveLocalAndroidNetworkTarget({
    LocalAndroidNetworkTarget? override,
  }) {
    if (override != null) {
      return override;
    }

    final configuredValue = const String.fromEnvironment(
      'LOCAL_ANDROID_NETWORK_TARGET',
    ).trim().toLowerCase();
    return switch (configuredValue) {
      'emulator' => LocalAndroidNetworkTarget.emulator,
      'device' => LocalAndroidNetworkTarget.device,
      _ => LocalAndroidNetworkTarget.unspecified,
    };
  }
}
