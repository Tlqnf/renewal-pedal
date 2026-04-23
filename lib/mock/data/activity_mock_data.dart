import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class ActivityMockData {
  static final List<ChallengeEntity> challenges = [
    ChallengeEntity(
      id: 'challenge_001',
      title: '다이어트 작심삼일 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 17),
      endDate: DateTime(2026, 5, 8),
      distanceKm: 50.0,
      participantCount: 332,
    ),
    ChallengeEntity(
      id: 'challenge_002',
      title: '상대방 돈 뺏고 튀기 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 17),
      endDate: DateTime(2026, 5, 8),
      distanceKm: 30.0,
      participantCount: 332,
    ),
    ChallengeEntity(
      id: 'challenge_003',
      title: '상대방 질문날리는 척 ㅗㅗ 날리기 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 17),
      endDate: DateTime(2026, 5, 8),
      distanceKm: 20.0,
      participantCount: 332,
    ),
    ChallengeEntity(
      id: 'challenge_004',
      title: '아군 한명 잃었고 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 17),
      endDate: DateTime(2026, 5, 8),
      distanceKm: 100.0,
      participantCount: 332,
    ),
    ChallengeEntity(
      id: 'challenge_005',
      title: '한강 100km 완주 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 20),
      endDate: DateTime(2026, 5, 20),
      distanceKm: 100.0,
      participantCount: 512,
    ),
  ];

  static final List<CrewEntity> recommendedCrews = [
    CrewEntity(
      id: 'crew_001',
      name: '자전거 크루',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_002',
      name: '자전거 크루',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_003',
      name: '자전거 크루',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_004',
      name: '자전거 크루',
      imageUrl: null,
      location: '대전',
      memberCount: 1000,
    ),
    CrewEntity(
      id: 'crew_005',
      name: '한강 라이더',
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

  static final List<ChallengeRankingEntity> challengeRanking = [
    ChallengeRankingEntity(
      userId: 'user_001',
      nickname: '페달왕',
      profileImageUrl: null,
      rank: 1,
      distanceKm: 48.5,
    ),
    ChallengeRankingEntity(
      userId: 'user_002',
      nickname: '라이딩러',
      profileImageUrl: null,
      rank: 2,
      distanceKm: 42.1,
    ),
    ChallengeRankingEntity(
      userId: 'user_003',
      nickname: '자전거맨',
      profileImageUrl: null,
      rank: 3,
      distanceKm: 38.7,
    ),
  ];
}
