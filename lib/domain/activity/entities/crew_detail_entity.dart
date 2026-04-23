class CrewDetailEntity {
  final String id;
  final String name;
  final String? coverImageUrl;
  final String location;
  final List<String> hashtags;
  final String description;
  final int memberCount;
  final int crewPoint;
  final List<CrewMemberRankingEntity> memberRankings;

  const CrewDetailEntity({
    required this.id,
    required this.name,
    this.coverImageUrl,
    required this.location,
    required this.hashtags,
    required this.description,
    required this.memberCount,
    required this.crewPoint,
    required this.memberRankings,
  });
}

class CrewMemberRankingEntity {
  final String userId;
  final String nickname;
  final String? profileImageUrl;
  final int rank;
  final double distanceKm;

  const CrewMemberRankingEntity({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.rank,
    required this.distanceKm,
  });
}
