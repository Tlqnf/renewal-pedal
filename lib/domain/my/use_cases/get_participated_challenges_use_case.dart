import 'package:dartz/dartz.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetParticipatedChallengesUseCase {
  final MyRepository _repository;

  GetParticipatedChallengesUseCase(this._repository);

  Future<Either<Failure, List<ChallengeEntity>>> execute() async {
    final result = await _repository.getParticipatedChallenges();
    if (result.failure != null) {
      return Left(result.failure!);
    }
    return Right(result.data ?? []);
  }
}
