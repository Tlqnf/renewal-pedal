class CalendarRideLogEntity {
  final String id;
  final DateTime date;
  final double distanceKm;
  final int durationMinutes;
  final double avgSpeedKmh;
  final int calorieKcal;

  const CalendarRideLogEntity({
    required this.id,
    required this.date,
    required this.distanceKm,
    required this.durationMinutes,
    required this.avgSpeedKmh,
    required this.calorieKcal,
  });
}
