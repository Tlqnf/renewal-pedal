import 'package:pedal/domain/my/entities/crew_entity.dart';

class MyCrewMockData {
  static final List<CrewEntity> crewList = [
    CrewEntity(
      id: 'crew_001',
      name: '자전거 크루',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_002',
      name: '한강 라이더스',
      imageUrl: null,
      location: '서울',
      memberCount: 342,
    ),
    CrewEntity(
      id: 'crew_003',
      name: '남산 싸이클',
      imageUrl: null,
      location: '서울 용산구',
      memberCount: 87,
    ),
    CrewEntity(
      id: 'crew_004',
      name: '부산 해안 크루',
      imageUrl: null,
      location: '부산 해운대',
      memberCount: 215,
    ),
    CrewEntity(
      id: 'crew_005',
      name: '판교 MTB팀',
      imageUrl: null,
      location: '경기 성남시',
      memberCount: 56,
    ),
    CrewEntity(
      id: 'crew_006',
      name: '세종 업힐 클럽',
      imageUrl: null,
      location: '세종시',
      memberCount: 130,
    ),
  ];

  static const List<CrewEntity> emptyList = [];
}
