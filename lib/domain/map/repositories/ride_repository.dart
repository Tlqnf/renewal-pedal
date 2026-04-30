import 'package:dartz/dartz.dart';
import 'package:pedal/domain/map/entities/ride_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class RideRepository {
  // POST /rides/finish
  Future<Either<Failure, RideEntity>> finishRide({
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
  });

  // GET /rides/{ride_id}/track
  Future<Either<Failure, List<List<double>>>> getRideTrack(String rideId);

  // GET /rides/{ride_id}
  Future<Either<Failure, RideEntity>> getRide(String rideId);

  // DELETE /rides/{ride_id}
  Future<Either<Failure, void>> deleteRide(String rideId);
}
