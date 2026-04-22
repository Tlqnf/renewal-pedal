import 'package:dartz/dartz.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, List<DailyStatEntity>>> getWeeklyStats({
    required DateTime weekStart,
    required DateTime weekEnd,
  });

  Future<Either<Failure, List<ChallengeBadgeEntity>>> getChallengeBadges();
}
