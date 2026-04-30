import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';

class MyStreakResponse {
  final int currentStreak;
  final int longestStreak;

  const MyStreakResponse({
    required this.currentStreak,
    required this.longestStreak,
  });

  factory MyStreakResponse.fromJson(Map<String, dynamic> json) {
    return MyStreakResponse(
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
    );
  }

  /// CalendarMonthlyStatsEntity로 변환 (streak 필드만 채움)
  CalendarMonthlyStatsEntity toEntity() {
    final now = DateTime.now();
    return CalendarMonthlyStatsEntity(
      year: now.year,
      month: now.month,
      totalDistanceKm: 0.0,
      avgPace: '',
      totalDurationMinutes: 0,
      totalCalorieKcal: 0,
    );
  }
}
