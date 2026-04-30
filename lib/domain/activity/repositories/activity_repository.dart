import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<CrewEntity>>> getRecommendedCrews();
  Future<Either<Failure, ActivityStatsEntity>> getActivityStats();
}
