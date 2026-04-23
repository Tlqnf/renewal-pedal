import 'package:dartz/dartz.dart';
import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/notifications/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Either<Failure, List<NotificationEntity>>> execute() async {
    return await _repository.getNotifications();
  }
}
