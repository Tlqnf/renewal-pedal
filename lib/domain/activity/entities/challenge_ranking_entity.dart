class ChallengeRankingEntity {
  final String userId;
  final String nickname;
  final String? profileImageUrl;
  final int rank;
  final double distanceKm;

  const ChallengeRankingEntity({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.rank,
    required this.distanceKm,
  });
}
