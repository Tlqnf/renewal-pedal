// ============================================================
// FILE: notification_repository.dart
// LAYER: domain
// RESPONSIBILITY: 알림 데이터 접근 인터페이스
// DEPENDENCIES: NotificationEntity, Failure
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class NotificationRepository {
  // GET /notifications
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  // PATCH /notifications/{notification_id}/read
  Future<Either<Failure, void>> readNotification(String notificationId);
}
