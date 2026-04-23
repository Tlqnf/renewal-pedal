import 'package:dartz/dartz.dart';
import 'package:pedal/domain/statistics/repositories/statistics_repository.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/statistics_mock_data.dart';

class StatisticsMockRepository implements StatisticsRepository {
  @override
  Future<Either<Failure, List<DailyStatEntity>>> getWeeklyStats({
    required DateTime weekStart,
    required DateTime weekEnd,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(StatisticsMockData.weeklyStats);
  }

  @override
  Future<Either<Failure, List<ChallengeBadgeEntity>>>
  getChallengeBadges() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Right(StatisticsMockData.challengeBadges);
  }
}
