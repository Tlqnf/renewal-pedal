import 'package:pedal/domain/my/entities/crew_entity.dart';

class CrewMockData {
  // 가입한 크루 목록 (2x2 그리드)
  static final List<CrewEntity> joinedCrews = [
    const CrewEntity(
      id: 'crew_joined_001',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_joined_002',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_joined_003',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_joined_004',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
  ];

  // 추천 크루 목록 (2x2 그리드)
  static final List<CrewEntity> recommendedCrews = [
    const CrewEntity(
      id: 'crew_recommended_001',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_recommended_002',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_recommended_003',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
    const CrewEntity(
      id: 'crew_recommended_004',
      imageUrl: null,
      name: '자전거 크루',
      location: '대전',
      memberCount: 1000,
    ),
  ];
}
