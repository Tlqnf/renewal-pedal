import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetActivityStatsUseCase {
  final ActivityRepository _repository;

  GetActivityStatsUseCase(this._repository);

  Future<Either<Failure, ActivityStatsEntity>> execute() async {
    return await _repository.getActivityStats();
  }
}
