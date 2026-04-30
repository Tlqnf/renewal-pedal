import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/activity_mock_data.dart';

class ActivityMockRepository implements ActivityRepository {
  @override
  Future<Either<Failure, List<CrewEntity>>> getRecommendedCrews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return Right(ActivityMockData.recommendedCrews);
  }

  @override
  Future<Either<Failure, ActivityStatsEntity>> getActivityStats() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Right(ActivityMockData.stats);
  }
}
