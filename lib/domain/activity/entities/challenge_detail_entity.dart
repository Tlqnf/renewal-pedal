class ChallengeDetailEntity {
  final String id;
  final String title;
  final String? bannerImageUrl;
  final String description;
  final List<String> tags;
  final DateTime startDate;
  final DateTime endDate;
  final int participantCount;
  final double totalDistanceKm;
  final double targetDistanceKm;
  final bool isParticipating;

  const ChallengeDetailEntity({
    required this.id,
    required this.title,
    this.bannerImageUrl,
    required this.description,
    required this.tags,
    required this.startDate,
    required this.endDate,
    required this.participantCount,
    required this.totalDistanceKm,
    required this.targetDistanceKm,
    required this.isParticipating,
  });
}
