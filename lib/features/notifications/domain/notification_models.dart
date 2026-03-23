import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';

@freezed
abstract class AppNotificationRecord with _$AppNotificationRecord {
  const factory AppNotificationRecord({
    required String id,
    required String type,
    required String title,
    required String body,
    required Map<String, dynamic> data,
    required bool isRead,
    required DateTime createdAt,
    required DateTime? readAt,
  }) = _AppNotificationRecord;

  const AppNotificationRecord._();

  factory AppNotificationRecord.fromJson(Map<String, dynamic> json) {
    return AppNotificationRecord(
      id: json['id'] as String,
      type: (json['type'] as String?)?.trim() ?? '',
      title: (json['title'] as String?)?.trim() ?? '',
      body: (json['body'] as String?)?.trim() ?? '',
      data: Map<String, dynamic>.from(
        (json['data'] as Map?) ?? const <String, dynamic>{},
      ),
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: DateTime.tryParse(json['read_at'] as String? ?? ''),
    );
  }
}

@freezed
abstract class NotificationPage with _$NotificationPage {
  const factory NotificationPage({
    required List<AppNotificationRecord> items,
    required int offset,
    required int limit,
    required bool hasMore,
  }) = _NotificationPage;

  const NotificationPage._();
}
