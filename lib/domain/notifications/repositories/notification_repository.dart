import 'package:dartz/dartz.dart';
import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class NotificationRepository {
  // GET /notifications
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  // PATCH /notifications/{notification_id}/read
  Future<Either<Failure, void>> readNotification(String notificationId);
}
