import 'package:fleetfill/core/config/app_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEnvironmentConfig backend classification', () {
    test('treats loopback and local hostnames as local backends', () {
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://127.0.0.1:54321',
        ),
        isTrue,
      );
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://localhost:54321',
        ),
        isTrue,
      );
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://fleetfill.local:54321',
        ),
        isTrue,
      );
    });

    test('treats Android emulator and LAN hosts as local backends', () {
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://10.0.2.2:54321',
        ),
        isTrue,
      );
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://192.168.100.13:54321',
        ),
        isTrue,
      );
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'http://10.10.1.25:54321',
        ),
        isTrue,
      );
    });

    test('treats hosted Supabase URLs as hosted backends', () {
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'https://fleetfill.supabase.co',
        ),
        isFalse,
      );
      expect(
        AppEnvironmentConfig.isLocalBackendUrlForTesting(
          'https://example.com',
        ),
        isFalse,
      );
    });
  });

  group('AppEnvironmentConfig client key resolution', () {
    test('prefers anon key for local backends', () {
      final key = AppEnvironmentConfig.resolveClientKeyForTesting(
        supabaseUrl: 'http://127.0.0.1:54321',
        publishableKey: 'sb_publishable_local',
        anonKey: 'legacy_anon_local',
      );

      expect(key, 'legacy_anon_local');
    });

    test(
      'falls back to publishable key for local backends when anon is missing',
      () {
        final key = AppEnvironmentConfig.resolveClientKeyForTesting(
          supabaseUrl: 'http://localhost:54321',
          publishableKey: 'sb_publishable_local',
        );

        expect(key, 'sb_publishable_local');
      },
    );

    test('prefers publishable key for hosted backends', () {
      final key = AppEnvironmentConfig.resolveClientKeyForTesting(
        supabaseUrl: 'https://fleetfill.supabase.co',
        publishableKey: 'sb_publishable_prod',
        anonKey: 'legacy_anon_prod',
      );

      expect(key, 'sb_publishable_prod');
    });

    test(
      'falls back to anon key for hosted backends when publishable is missing',
      () {
        final key = AppEnvironmentConfig.resolveClientKeyForTesting(
          supabaseUrl: 'https://fleetfill.supabase.co',
          anonKey: 'legacy_anon_prod',
        );

        expect(key, 'legacy_anon_prod');
      },
    );
  });

  group('AppEnvironmentConfig Google client ID resolution', () {
    test('serializes optional Google client IDs from JSON payloads', () {
      final config = AppEnvironmentConfig.fromJson(<String, dynamic>{
        'googleWebClientId': 'web-client-id',
        'googleIosClientId': 'ios-client-id',
      });

      expect(config.googleWebClientId, 'web-client-id');
      expect(config.googleIosClientId, 'ios-client-id');
    });

    test('defaults Google client IDs to empty strings when absent', () {
      final config = AppEnvironmentConfig.fromJson(<String, dynamic>{});

      expect(config.googleWebClientId, isEmpty);
      expect(config.googleIosClientId, isEmpty);
    });
  });

  group('AppEnvironmentConfig local Supabase URL normalization', () {
    test(
      'maps loopback to 10.0.2.2 only for Android emulator local builds',
      () {
        final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
          'http://127.0.0.1:54321',
          isAndroid: true,
          localAndroidNetworkTarget: LocalAndroidNetworkTarget.emulator,
        );

        expect(normalized, 'http://10.0.2.2:54321');
      },
    );

    test('keeps loopback unchanged for Android real-device local builds', () {
      final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'http://127.0.0.1:54321',
        isAndroid: true,
        localAndroidNetworkTarget: LocalAndroidNetworkTarget.device,
      );

      expect(normalized, 'http://127.0.0.1:54321');
    });

    test('keeps LAN and hosted URLs unchanged', () {
      final lanUrl = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'http://192.168.100.13:54321',
        isAndroid: true,
        localAndroidNetworkTarget: LocalAndroidNetworkTarget.emulator,
      );
      final hostedUrl = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'https://fleetfill.supabase.co',
        isAndroid: true,
        localAndroidNetworkTarget: LocalAndroidNetworkTarget.emulator,
      );

      expect(lanUrl, 'http://192.168.100.13:54321');
      expect(hostedUrl, 'https://fleetfill.supabase.co');
    });

    test('keeps loopback unchanged outside Android builds', () {
      final normalized = AppEnvironmentConfig.normalizeSupabaseUrlForTesting(
        'http://localhost:54321',
        isAndroid: false,
      );

      expect(normalized, 'http://localhost:54321');
    });
  });
}
