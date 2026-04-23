import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetChallengeRankingUseCase {
  final ActivityRepository _repository;

  GetChallengeRankingUseCase(this._repository);

  Future<({Failure? failure, List<ChallengeRankingEntity>? data})> call(
    String challengeId,
  ) {
    return _repository.getChallengeRanking(challengeId);
  }
}
