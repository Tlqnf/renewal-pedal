enum RankingTab { distance, streak, duration, calorie }

class RankingEntity {
  final String userId;
  final String nickname;
  final String? profileImageUrl;
  final int rank;
  final double value;
  final String unit;

  const RankingEntity({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.rank,
    required this.value,
    required this.unit,
  });
}
