import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';

class ActivityChallengeDetailMockData {
  // 단일 챌린지 상세
  static final ChallengeDetailEntity challengeDetail = ChallengeDetailEntity(
    id: 'challenge_001',
    title: '다이어트 작심삼일 챌린지',
    bannerImageUrl: 'https://picsum.photos/seed/challenge_banner/800/400',
    description:
        '봄을 맞이해 자전거로 건강한 다이어트를 시작해보세요! '
        '3주 동안 꾸준히 라이딩을 기록하면 누구나 참여할 수 있는 챌린지입니다. '
        '매일 조금씩 달리다 보면 어느새 몸과 마음이 건강해지는 것을 느낄 수 있습니다. '
        '혼자보다 함께하면 더 즐거운 라이딩, 지금 참여해보세요.',
    tags: ['다이어트', '라이딩', '건강', '자전거'],
    startDate: DateTime(2026, 4, 17),
    endDate: DateTime(2026, 5, 8),
    participantCount: 332,
    totalDistanceKm: 16842.5,
    targetDistanceKm: 50,
    isParticipating: false,
  );

  // 랭킹 리스트 (10명)
  static final List<ChallengeRankingEntity> rankingList = [
    const ChallengeRankingEntity(
      userId: 'user_001',
      nickname: '한강의 제왕',
      profileImageUrl: null,
      rank: 1,
      distanceKm: 312.4,
    ),
    const ChallengeRankingEntity(
      userId: 'user_002',
      nickname: '속도의 악마',
      profileImageUrl: null,
      rank: 2,
      distanceKm: 289.1,
    ),
    const ChallengeRankingEntity(
      userId: 'user_003',
      nickname: '새벽라이더',
      profileImageUrl: null,
      rank: 3,
      distanceKm: 245.8,
    ),
    const ChallengeRankingEntity(
      userId: 'user_004',
      nickname: '페달러123',
      profileImageUrl: null,
      rank: 4,
      distanceKm: 198.3,
    ),
    const ChallengeRankingEntity(
      userId: 'user_005',
      nickname: '자전거여행가',
      profileImageUrl: null,
      rank: 5,
      distanceKm: 175.0,
    ),
    const ChallengeRankingEntity(
      userId: 'user_006',
      nickname: '주말라이더',
      profileImageUrl: null,
      rank: 6,
      distanceKm: 143.7,
    ),
    const ChallengeRankingEntity(
      userId: 'user_007',
      nickname: '건강한자전거',
      profileImageUrl: null,
      rank: 7,
      distanceKm: 121.5,
    ),
    const ChallengeRankingEntity(
      userId: 'user_008',
      nickname: '남산킹',
      profileImageUrl: null,
      rank: 8,
      distanceKm: 98.2,
    ),
    const ChallengeRankingEntity(
      userId: 'user_009',
      nickname: '올림픽라이더',
      profileImageUrl: null,
      rank: 9,
      distanceKm: 76.9,
    ),
    const ChallengeRankingEntity(
      userId: 'user_010',
      nickname: '서울숲cyclist',
      profileImageUrl: null,
      rank: 10,
      distanceKm: 55.4,
    ),
  ];

  // 빈 랭킹 (empty state 테스트용)
  static const List<ChallengeRankingEntity> emptyRankingList = [];
}
