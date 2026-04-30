class RideEntity {
  final String id;
  final String userId;
  final String? title;
  final DateTime startedAt;
  final DateTime endedAt;
  final int distanceM;
  final int durationSec;
  final int? caloriesKcal;
  final String visibility;

  const RideEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.startedAt,
    required this.endedAt,
    required this.distanceM,
    required this.durationSec,
    required this.caloriesKcal,
    required this.visibility,
  });
}
