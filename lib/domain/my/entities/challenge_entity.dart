class ChallengeEntity {
  final String id;
  final String title;
  final String? thumbnailUrl;
  final DateTime startDate;
  final DateTime endDate;
  final double distanceKm;
  final int participantCount;

  const ChallengeEntity({
    required this.id,
    required this.title,
    this.thumbnailUrl,
    required this.startDate,
    required this.endDate,
    required this.distanceKm,
    required this.participantCount,
  });
}
