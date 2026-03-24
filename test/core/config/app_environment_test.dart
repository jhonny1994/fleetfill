import 'package:fleetfill/core/config/app_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEnvironmentConfig client key resolution', () {
    test('prefers anon key in local environment', () {
      final key = AppEnvironmentConfig.resolveClientKeyForTesting(
        environment: AppEnvironment.local,
        publishableKey: 'sb_publishable_local',
        anonKey: 'legacy_anon_local',
      );

      expect(key, 'legacy_anon_local');
    });

    test('falls back to publishable key locally when anon is missing', () {
      final key = AppEnvironmentConfig.resolveClientKeyForTesting(
        environment: AppEnvironment.local,
        publishableKey: 'sb_publishable_local',
      );

      expect(key, 'sb_publishable_local');
    });

    test('prefers publishable key in production-like environments', () {
      final stagingKey = AppEnvironmentConfig.resolveClientKeyForTesting(
        environment: AppEnvironment.staging,
        publishableKey: 'sb_publishable_stage',
        anonKey: 'legacy_anon_stage',
      );
      final productionKey = AppEnvironmentConfig.resolveClientKeyForTesting(
        environment: AppEnvironment.production,
        publishableKey: 'sb_publishable_prod',
        anonKey: 'legacy_anon_prod',
      );

      expect(stagingKey, 'sb_publishable_stage');
      expect(productionKey, 'sb_publishable_prod');
    });

    test('falls back to anon key in production-like environments', () {
      final key = AppEnvironmentConfig.resolveClientKeyForTesting(
        environment: AppEnvironment.production,
        anonKey: 'legacy_anon_prod',
      );

      expect(key, 'legacy_anon_prod');
    });
  });

  group('AppEnvironmentConfig Google client ID resolution', () {
    test('serializes optional Google client IDs from JSON payloads', () {
      final config = AppEnvironmentConfig.fromJson(<String, dynamic>{
        'environment': 'production',
        'googleWebClientId': 'web-client-id',
        'googleIosClientId': 'ios-client-id',
      });

      expect(config.googleWebClientId, 'web-client-id');
      expect(config.googleIosClientId, 'ios-client-id');
    });

    test('defaults Google client IDs to empty strings when absent', () {
      final config = AppEnvironmentConfig.fromJson(<String, dynamic>{
        'environment': 'local',
      });

      expect(config.googleWebClientId, isEmpty);
      expect(config.googleIosClientId, isEmpty);
    });
  });

  group('AppEnvironmentConfig local Supabase URL normalization', () {
    test(
      'maps localhost to 10.0.2.2 only for Android emulator local builds',
      () {
        final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
          'http://127.0.0.1:54321',
          environment: AppEnvironment.local,
          isAndroid: true,
          localAndroidNetworkTarget: LocalAndroidNetworkTarget.emulator,
        );

        expect(normalized, 'http://10.0.2.2:54321');
      },
    );

    test('keeps loopback unchanged for Android real-device local builds', () {
      final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'http://127.0.0.1:54321',
        environment: AppEnvironment.local,
        isAndroid: true,
        localAndroidNetworkTarget: LocalAndroidNetworkTarget.device,
      );

      expect(normalized, 'http://127.0.0.1:54321');
    });

    test('keeps hosted URLs unchanged', () {
      final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'https://example.supabase.co',
        environment: AppEnvironment.local,
        isAndroid: true,
        localAndroidNetworkTarget: LocalAndroidNetworkTarget.emulator,
      );

      expect(normalized, 'https://example.supabase.co');
    });

    test('keeps localhost unchanged outside Android local builds', () {
      final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'http://localhost:54321',
        environment: AppEnvironment.production,
        isAndroid: true,
      );

      expect(normalized, 'http://localhost:54321');
    });
  });
}
