import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';

class WeeklyStatDayResponse {
  final String date;
  final int day;
  final double distanceKm;
  final int durationSec;

  const WeeklyStatDayResponse({
    required this.date,
    required this.day,
    required this.distanceKm,
    required this.durationSec,
  });

  factory WeeklyStatDayResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyStatDayResponse(
      date: json['date'] as String? ?? '',
      day: (json['day'] as num?)?.toInt() ?? 0,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      durationSec: (json['duration_sec'] as num?)?.toInt() ?? 0,
    );
  }

  DailyStatEntity toEntity() => DailyStatEntity(
    date: DateTime.tryParse(date) ?? DateTime.now(),
    distanceKm: distanceKm,
    durationSeconds: durationSec,
    maxSpeedKmh: 0.0,
  );
}

class WeeklyStatsResponse {
  final String weekStart;
  final String weekEnd;
  final double totalDistanceKm;
  final int totalDurationSec;
  final List<WeeklyStatDayResponse> days;

  const WeeklyStatsResponse({
    required this.weekStart,
    required this.weekEnd,
    required this.totalDistanceKm,
    required this.totalDurationSec,
    required this.days,
  });

  factory WeeklyStatsResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyStatsResponse(
      weekStart: json['week_start'] as String? ?? '',
      weekEnd: json['week_end'] as String? ?? '',
      totalDistanceKm: (json['total_distance_km'] as num?)?.toDouble() ?? 0.0,
      totalDurationSec: (json['total_duration_sec'] as num?)?.toInt() ?? 0,
      days:
          (json['days'] as List<dynamic>?)
              ?.map(
                (e) =>
                    WeeklyStatDayResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  List<DailyStatEntity> toEntities() => days.map((d) => d.toEntity()).toList();
}
