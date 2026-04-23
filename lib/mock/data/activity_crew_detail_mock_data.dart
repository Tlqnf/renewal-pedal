import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';

class ActivityCrewDetailMockData {
  static final CrewDetailEntity crewDetail = CrewDetailEntity(
    id: 'crew_001',
    name: '숲에서 낭만깊은 자전거 라이딩 크루',
    coverImageUrl: null,
    location: '모든 지역',
    hashtags: ['씨발', '섹소상', '자구인들아'],
    description: '숲을 좋아하는 사람들이 만나 숲속에서 정신건강과 마음가짐을 건전히 하고 힐링할 수 있는 최고의 크루',
    memberCount: 4629,
    crewPoint: 4629,
    memberRankings: [
      CrewMemberRankingEntity(
        userId: 'user_001',
        nickname: '라이딩왕',
        profileImageUrl: null,
        rank: 1,
        distanceKm: 312.5,
      ),
      CrewMemberRankingEntity(
        userId: 'user_002',
        nickname: '페달러',
        profileImageUrl: null,
        rank: 2,
        distanceKm: 287.0,
      ),
      CrewMemberRankingEntity(
        userId: 'user_003',
        nickname: '숲속라이더',
        profileImageUrl: null,
        rank: 3,
        distanceKm: 245.8,
      ),
      CrewMemberRankingEntity(
        userId: 'user_004',
        nickname: '힐링바이커',
        profileImageUrl: null,
        rank: 4,
        distanceKm: 198.3,
      ),
      CrewMemberRankingEntity(
        userId: 'user_005',
        nickname: '자전거여행자',
        profileImageUrl: null,
        rank: 5,
        distanceKm: 176.1,
      ),
    ],
  );
}
