import 'package:dartz/dartz.dart';
import 'package:pedal/domain/statistics/repositories/statistics_repository.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetWeeklyStatsUseCase {
  final StatisticsRepository _repository;

  GetWeeklyStatsUseCase(this._repository);

  Future<Either<Failure, List<DailyStatEntity>>> execute({
    required DateTime weekStart,
    required DateTime weekEnd,
  }) async {
    return await _repository.getWeeklyStats(
      weekStart: weekStart,
      weekEnd: weekEnd,
    );
  }
}
