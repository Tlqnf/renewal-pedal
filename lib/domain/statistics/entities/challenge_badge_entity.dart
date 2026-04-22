class ChallengeBadgeEntity {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime achievedAt;

  const ChallengeBadgeEntity({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.achievedAt,
  });
}
