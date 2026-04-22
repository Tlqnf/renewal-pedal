import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';
import 'package:pedal/domain/ai_mission/repositories/ai_mission_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GenerateAiMissionUseCase {
  final AiMissionRepository _repository;

  GenerateAiMissionUseCase(this._repository);

  Future<({Failure? failure, AiMissionCardEntity? data})> call() {
    return _repository.generateAiMission();
  }
}
