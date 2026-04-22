import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';

class StatisticsMockData {
  static final List<DailyStatEntity> weeklyStats = () {
    final monday = DateTime(2026, 1, 19);
    return [
      DailyStatEntity(
        date: monday,
        distanceKm: 15.2,
        durationSeconds: 3240,
        maxSpeedKmh: 28.5,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 1)),
        distanceKm: 8.7,
        durationSeconds: 1980,
        maxSpeedKmh: 22.0,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 2)),
        distanceKm: 0.0,
        durationSeconds: 0,
        maxSpeedKmh: 0.0,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 3)),
        distanceKm: 22.4,
        durationSeconds: 4800,
        maxSpeedKmh: 32.0,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 4)),
        distanceKm: 4.73,
        durationSeconds: 1080,
        maxSpeedKmh: 18.3,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 5)),
        distanceKm: 11.0,
        durationSeconds: 2520,
        maxSpeedKmh: 26.7,
      ),
      DailyStatEntity(
        date: monday.add(const Duration(days: 6)),
        distanceKm: 18.5,
        durationSeconds: 3960,
        maxSpeedKmh: 30.1,
      ),
    ];
  }();

  static final List<ChallengeBadgeEntity> challengeBadges = [
    ChallengeBadgeEntity(
      id: 'badge_001',
      title: '고양이 낚시 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_002',
      title: '돈 수금하기 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_003',
      title: '성취왕 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_004',
      title: '악마로 재달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_005',
      title: '할 수없는것들 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_006',
      title: '전설의 비밀 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_007',
      title: '너도? 할도? 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_008',
      title: '앉자리 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
    ChallengeBadgeEntity(
      id: 'badge_009',
      title: '100kg 달성',
      imageUrl: null,
      achievedAt: DateTime(2026, 1, 17),
    ),
  ];
}
