import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/notifications/repositories/notification_repository.dart';

class ReadNotificationUseCase {
  final NotificationRepository _repository;

  ReadNotificationUseCase(this._repository);

  Future<Either<Failure, void>> execute(String notificationId) async {
    return await _repository.readNotification(notificationId);
  }
}
