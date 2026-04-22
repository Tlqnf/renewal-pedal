class CalendarMonthlyStatsEntity {
  final int year;
  final int month;
  final double totalDistanceKm;
  final String avgPace;
  final int totalDurationMinutes;
  final int totalCalorieKcal;

  const CalendarMonthlyStatsEntity({
    required this.year,
    required this.month,
    required this.totalDistanceKm,
    required this.avgPace,
    required this.totalDurationMinutes,
    required this.totalCalorieKcal,
  });
}
