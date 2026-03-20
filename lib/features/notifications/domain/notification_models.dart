class AppNotificationRecord {
  const AppNotificationRecord({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.data,
    required this.isRead,
    required this.createdAt,
    required this.readAt,
  });

  factory AppNotificationRecord.fromJson(Map<String, dynamic> json) {
    return AppNotificationRecord(
      id: json['id'] as String,
      type: (json['type'] as String?)?.trim() ?? '',
      title: (json['title'] as String?)?.trim() ?? '',
      body: (json['body'] as String?)?.trim() ?? '',
      data: Map<String, dynamic>.from((json['data'] as Map?) ?? const <String, dynamic>{}),
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: DateTime.tryParse(json['read_at'] as String? ?? ''),
    );
  }

  final String id;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
}
