import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetActivityChallengesUseCase {
  final ActivityRepository _repository;

  GetActivityChallengesUseCase(this._repository);

  Future<Either<Failure, List<ChallengeEntity>>> execute() async {
    return await _repository.getChallenges();
  }
}
