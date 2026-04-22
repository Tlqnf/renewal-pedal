import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';
import 'package:pedal/domain/ai_mission/repositories/ai_mission_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class AiMissionRepositoryImpl implements AiMissionRepository {
  @override
  Future<({Failure? failure, List<AiMissionCardEntity>? data})> getAiMissions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        const AiMissionCardEntity(
          id: 'mission_1',
          title: '15일동안 자전거 라이딩 하기',
          description: '매일 꾸준히 라이딩하며 건강한 습관을 만들어보세요.',
          imageUrl: '',
          durationDays: 15,
        ),
        const AiMissionCardEntity(
          id: 'mission_2',
          title: '100km 완주 챌린지',
          description: '일주일 안에 총 100km를 달성해보세요.',
          imageUrl: '',
          durationDays: 7,
        ),
        const AiMissionCardEntity(
          id: 'mission_3',
          title: '새벽 라이딩 5회',
          description: '이른 아침의 상쾌함을 경험해보세요.',
          imageUrl: '',
          durationDays: 10,
        ),
      ],
    );
  }

  @override
  Future<({Failure? failure, AiMissionCardEntity? data})> generateAiMission() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (
      failure: null,
      data: const AiMissionCardEntity(
        id: 'mission_new',
        title: 'AI 생성 미션: 30분 라이딩 10회',
        description: 'AI가 당신의 활동 패턴을 분석해 만든 맞춤 미션입니다.',
        imageUrl: '',
        durationDays: 14,
      ),
    );
  }
}
