import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/ride_repository.dart';

class GetRideTrackUseCase {
  final RideRepository _repository;

  GetRideTrackUseCase(this._repository);

  Future<Either<Failure, List<List<double>>>> execute(String rideId) =>
      _repository.getRideTrack(rideId);
}
