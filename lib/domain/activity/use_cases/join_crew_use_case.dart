import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/crew_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class JoinCrewUseCase {
  final CrewDetailRepository _repository;

  JoinCrewUseCase(this._repository);

  Future<Either<Failure, void>> execute(String crewId) async {
    return await _repository.joinCrew(crewId);
  }
}
