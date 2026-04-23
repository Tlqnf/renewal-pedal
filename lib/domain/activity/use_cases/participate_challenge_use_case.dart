import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class ParticipateChallengeUseCase {
  final ActivityRepository _repository;

  ParticipateChallengeUseCase(this._repository);

  Future<({Failure? failure})> call(String challengeId) {
    return _repository.participateChallenge(challengeId);
  }
}
