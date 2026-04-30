import 'package:dartz/dartz.dart';
import 'package:pedal/domain/map/entities/ride_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/ride_repository.dart';

class FinishRideUseCase {
  final RideRepository _repository;

  FinishRideUseCase(this._repository);

  Future<Either<Failure, RideEntity>> execute({
    required String? title,
    required DateTime startedAt,
    required DateTime endedAt,
    required int distanceM,
    required int durationSec,
    required int? caloriesKcal,
    required String visibility,
    required List<Map<String, double>> points,
    required bool saveAsRoute,
    required String? routeName,
  }) async {
    if (distanceM <= 0) {
      return Left(ValidationFailure('거리는 0보다 커야 합니다'));
    }
    if (durationSec <= 0) {
      return Left(ValidationFailure('기록 시간은 0보다 커야 합니다'));
    }

    return _repository.finishRide(
      title: title,
      startedAt: startedAt,
      endedAt: endedAt,
      distanceM: distanceM,
      durationSec: durationSec,
      caloriesKcal: caloriesKcal,
      visibility: visibility,
      points: points,
      saveAsRoute: saveAsRoute,
      routeName: routeName,
    );
  }
}
