import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/notifications/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return NotificationRepository(environment: environment, logger: logger);
});

class NotificationRepository {
  const NotificationRepository({required this.environment, required this.logger});

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<AppNotificationRecord>> fetchMyNotifications() async {
    final response = await _client
        .from('notifications')
        .select()
        .order('created_at', ascending: false)
        .limit(100);
    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(AppNotificationRecord.fromJson)
        .toList(growable: false);
  }

  Future<AppNotificationRecord?> fetchNotificationById(String notificationId) async {
    final response = await _client
        .from('notifications')
        .select()
        .eq('id', notificationId)
        .maybeSingle();
    if (response == null) return null;
    return AppNotificationRecord.fromJson(response);
  }

  Future<AppNotificationRecord> markNotificationRead(String notificationId) async {
    final response = await _client.rpc<Map<String, dynamic>>(
      'mark_notification_read',
      params: {'p_notification_id': notificationId},
    );
    return AppNotificationRecord.fromJson(response);
  }

  Future<void> registerDeviceToken({
    required String pushToken,
    required String platform,
    String? locale,
  }) async {
    await _client.rpc<Map<String, dynamic>>('register_user_device', params: {
      'p_push_token': pushToken,
      'p_platform': platform,
      'p_locale': locale,
    });
  }
}
