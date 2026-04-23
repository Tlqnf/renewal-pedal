import 'package:pedal/domain/my/entities/challenge_entity.dart';

class MyMockData {
  static final List<ChallengeEntity> challengeList = [
    ChallengeEntity(
      id: 'challenge_001',
      title: '다이어트 작심삼일 챌린지',
      thumbnailUrl: 'https://picsum.photos/seed/challenge1/200/200',
      startDate: DateTime(2026, 4, 17),
      endDate: DateTime(2026, 5, 8),
      distanceKm: 50,
      participantCount: 332,
    ),
    ChallengeEntity(
      id: 'challenge_002',
      title: '한강 완주 챌린지',
      thumbnailUrl: 'https://picsum.photos/seed/challenge2/200/200',
      startDate: DateTime(2026, 4, 1),
      endDate: DateTime(2026, 4, 30),
      distanceKm: 100,
      participantCount: 218,
    ),
    ChallengeEntity(
      id: 'challenge_003',
      title: '봄맞이 100km 챌린지',
      thumbnailUrl: 'https://picsum.photos/seed/challenge3/200/200',
      startDate: DateTime(2026, 3, 20),
      endDate: DateTime(2026, 4, 20),
      distanceKm: 100,
      participantCount: 541,
    ),
    ChallengeEntity(
      id: 'challenge_004',
      title: '출퇴근 자전거 챌린지',
      thumbnailUrl: 'https://picsum.photos/seed/challenge4/200/200',
      startDate: DateTime(2026, 4, 7),
      endDate: DateTime(2026, 4, 28),
      distanceKm: 30,
      participantCount: 87,
    ),
    ChallengeEntity(
      id: 'challenge_005',
      title: '주말 라이더 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 12),
      endDate: DateTime(2026, 5, 3),
      distanceKm: 60,
      participantCount: 155,
    ),
    ChallengeEntity(
      id: 'challenge_006',
      title: '야간 라이딩 챌린지',
      thumbnailUrl: null,
      startDate: DateTime(2026, 4, 10),
      endDate: DateTime(2026, 5, 10),
      distanceKm: 20,
      participantCount: 73,
    ),
  ];

  static const List<ChallengeEntity> emptyChallengeList = [];
}
