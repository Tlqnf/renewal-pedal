import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetChallengeDetailUseCase {
  final ActivityRepository _repository;

  GetChallengeDetailUseCase(this._repository);

  Future<({Failure? failure, ChallengeDetailEntity? data})> call(String challengeId) {
    return _repository.getChallengeDetail(challengeId);
  }
}
