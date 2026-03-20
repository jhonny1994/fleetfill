import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return SupportRepository(environment: environment, logger: logger);
});

class SupportRepository {
  const SupportRepository({required this.environment, required this.logger});

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> sendSupportMessage({
    required String locale,
    required String subject,
    required String message,
  }) async {
    await _client.functions.invoke(
      'support-email-dispatch',
      body: {
        'locale': locale,
        'subject': subject,
        'message': message,
      },
    );
  }
}
