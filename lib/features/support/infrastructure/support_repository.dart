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
    final normalizedSubject = subject.trim();
    final normalizedMessage = message.trim();
    logger.info(
      'Sending support message',
      context: {
        'locale': locale,
        'subjectLength': normalizedSubject.length,
        'messageLength': normalizedMessage.length,
        'supabaseUrl': environment.supabaseUrl,
      },
    );

    try {
      final response = await _client.functions.invoke(
        'support-email-dispatch',
        body: {
          'locale': locale,
          'subject': normalizedSubject,
          'message': normalizedMessage,
        },
      );

      logger.info(
        'Support message queued',
        context: {
          'status': response.status,
          'response': response.data,
        },
      );
    } on FunctionException catch (error, stackTrace) {
      logger.warning(
        'Support message failed',
        error: error,
        stackTrace: stackTrace,
        context: {
          'status': error.status,
          'reasonPhrase': error.reasonPhrase,
          'details': error.details,
          'locale': locale,
          'subjectLength': normalizedSubject.length,
          'messageLength': normalizedMessage.length,
        },
      );
      rethrow;
    } on Exception catch (error, stackTrace) {
      logger.warning(
        'Support message failed',
        error: error,
        stackTrace: stackTrace,
        context: {
          'locale': locale,
          'subjectLength': normalizedSubject.length,
          'messageLength': normalizedMessage.length,
        },
      );
      rethrow;
    }
  }
}
