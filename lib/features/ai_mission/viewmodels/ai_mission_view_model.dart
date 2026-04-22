import 'package:flutter/foundation.dart';
import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';
import 'package:pedal/domain/ai_mission/use_cases/get_ai_missions_use_case.dart';
import 'package:pedal/domain/ai_mission/use_cases/generate_ai_mission_use_case.dart';

class AiMissionViewModel extends ChangeNotifier {
  final GetAiMissionsUseCase _getAiMissionsUseCase;
  final GenerateAiMissionUseCase _generateAiMissionUseCase;

  AiMissionViewModel({
    required GetAiMissionsUseCase getAiMissionsUseCase,
    required GenerateAiMissionUseCase generateAiMissionUseCase,
  })  : _getAiMissionsUseCase = getAiMissionsUseCase,
        _generateAiMissionUseCase = generateAiMissionUseCase;

  List<AiMissionCardEntity> missionCards = [];
  bool isLoading = false;
  String? errorMessage;

  String get currentMissionTitle =>
      missionCards.isNotEmpty ? missionCards.first.title : '';

  String get currentMissionDescription =>
      missionCards.isNotEmpty ? missionCards.first.description : '';

  Future<void> loadMissions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getAiMissionsUseCase();
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      missionCards = result.data ?? [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> onGenerateMission() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _generateAiMissionUseCase();
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else if (result.data != null) {
      missionCards = [result.data!, ...missionCards];
    }

    isLoading = false;
    notifyListeners();
  }
}
