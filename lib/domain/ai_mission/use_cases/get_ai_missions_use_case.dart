import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';
import 'package:pedal/domain/ai_mission/repositories/ai_mission_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetAiMissionsUseCase {
  final AiMissionRepository _repository;

  GetAiMissionsUseCase(this._repository);

  Future<({Failure? failure, List<AiMissionCardEntity>? data})> call() {
    return _repository.getAiMissions();
  }
}
