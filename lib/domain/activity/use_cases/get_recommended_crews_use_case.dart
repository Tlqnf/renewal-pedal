import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetRecommendedCrewsUseCase {
  final ActivityRepository _repository;

  GetRecommendedCrewsUseCase(this._repository);

  Future<Either<Failure, List<CrewEntity>>> execute() async {
    return await _repository.getRecommendedCrews();
  }
}
