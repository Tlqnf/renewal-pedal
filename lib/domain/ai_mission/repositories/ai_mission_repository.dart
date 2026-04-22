import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class AiMissionRepository {
  Future<({Failure? failure, List<AiMissionCardEntity>? data})> getAiMissions();
  Future<({Failure? failure, AiMissionCardEntity? data})> generateAiMission();
}
