import 'package:dartz/dartz.dart';
import 'package:pedal/domain/statistics/repositories/statistics_repository.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetChallengeBadgesUseCase {
  final StatisticsRepository _repository;

  GetChallengeBadgesUseCase(this._repository);

  Future<Either<Failure, List<ChallengeBadgeEntity>>> execute() async {
    return await _repository.getChallengeBadges();
  }
}
