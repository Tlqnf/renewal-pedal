import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';

class ActivityCalendarResponse {
  final int year;
  final int month;
  final List<int> activityDays;
  final int monthlyActivityCount;
  final int currentStreak;
  final int longestStreak;

  const ActivityCalendarResponse({
    required this.year,
    required this.month,
    required this.activityDays,
    required this.monthlyActivityCount,
    required this.currentStreak,
    required this.longestStreak,
  });

  factory ActivityCalendarResponse.fromJson(Map<String, dynamic> json) {
    return ActivityCalendarResponse(
      year: (json['year'] as num?)?.toInt() ?? 0,
      month: (json['month'] as num?)?.toInt() ?? 0,
      activityDays:
          (json['activity_days'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      monthlyActivityCount:
          (json['monthly_activity_count'] as num?)?.toInt() ?? 0,
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
    );
  }

  CalendarMonthlyStatsEntity toEntity() => CalendarMonthlyStatsEntity(
    year: year,
    month: month,
    totalDistanceKm: 0.0,
    avgPace: '',
    totalDurationMinutes: 0,
    totalCalorieKcal: 0,
  );
}
