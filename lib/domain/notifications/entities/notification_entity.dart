// ============================================================
// FILE: notification_entity.dart
// LAYER: domain/entities
// RESPONSIBILITY: 알림 엔티티
// DEPENDENCIES: NotificationType
// ============================================================

import 'package:pedal/domain/notifications/enums/notification_type.dart';

class NotificationEntity {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String date;
  final String timeAgo;
  final bool isRead;

  NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    required this.timeAgo,
    this.isRead = false,
  });
}
