class DailyStatEntity {
  final DateTime date;
  final double distanceKm;
  final int durationSeconds;
  final double maxSpeedKmh;

  const DailyStatEntity({
    required this.date,
    required this.distanceKm,
    required this.durationSeconds,
    required this.maxSpeedKmh,
  });
}
