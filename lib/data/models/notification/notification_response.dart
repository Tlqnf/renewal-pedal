import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/notifications/enums/notification_type.dart';

class NotificationResponse {
  final String id;
  final String userId;
  final String title;
  final String content;
  final bool isRead;
  final DateTime createdAt;

  NotificationResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      title: json['title'] as String,
      content: json['content'] as String,
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  NotificationEntity toEntity() => NotificationEntity(
    id: id,
    type: NotificationType.alert,
    title: title,
    message: content,
    date: _formatDate(createdAt),
    timeAgo: _formatTimeAgo(createdAt),
    isRead: isRead,
  );

  static String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }

  static String _formatTimeAgo(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt.toLocal());

    if (diff.inMinutes < 1) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 7) return '${diff.inDays}일 전';
    return _formatDate(dt);
  }
}
