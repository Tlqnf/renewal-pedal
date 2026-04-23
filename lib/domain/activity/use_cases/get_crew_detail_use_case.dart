import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/crew_detail_repository.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetCrewDetailUseCase {
  final CrewDetailRepository _repository;

  GetCrewDetailUseCase(this._repository);

  Future<Either<Failure, CrewDetailEntity>> execute(String crewId) async {
    return await _repository.getCrewDetail(crewId);
  }
}
