import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetParticipatedCrewsUseCase {
  final MyRepository _repository;

  GetParticipatedCrewsUseCase(this._repository);

  Future<({Failure? failure, List<CrewEntity>? data})> call() {
    return _repository.getParticipatedCrews();
  }
}
