import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/notification/sources/notification_remote_source.dart';
import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/notifications/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteSource _remoteSource;

  NotificationRepositoryImpl(this._remoteSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final responses = await _remoteSource.getNotifications();
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> readNotification(String notificationId) async {
    try {
      await _remoteSource.readNotification(notificationId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
    String notificationId,
  ) async {
    try {
      await _remoteSource.deleteNotification(notificationId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(const UnknownFailure());
    }
  }
}
