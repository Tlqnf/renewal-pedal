import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class ActivityMockData {
  static final List<CrewEntity> recommendedCrews = [
    CrewEntity(
      id: 'crew_001',
      name: '대전 페달러스',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_002',
      name: '갑천 라이더스',
      imageUrl: null,
      location: '대전 유성구',
      memberCount: 430,
    ),
    CrewEntity(
      id: 'crew_003',
      name: '계룡 MTB 클럽',
      imageUrl: null,
      location: '충남 계룡시',
      memberCount: 285,
    ),
    CrewEntity(
      id: 'crew_004',
      name: '세종 업힐 크루',
      imageUrl: null,
      location: '세종시',
      memberCount: 312,
    ),
    CrewEntity(
      id: 'crew_005',
      name: '한강 라이더스',
      imageUrl: null,
      location: '서울',
      memberCount: 2500,
    ),
    CrewEntity(
      id: 'crew_006',
      name: '부산 바이크 클럽',
      imageUrl: null,
      location: '부산',
      memberCount: 800,
    ),
  ];

  static const ActivityStatsEntity stats = ActivityStatsEntity(
    officialCount: 65,
    unofficialCount: 718,
    totalParticipants: 21928,
  );
}
