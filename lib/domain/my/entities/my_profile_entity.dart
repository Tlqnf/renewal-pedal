class MyProfileEntity {
  final String userId;
  final String nickname;
  final String? profileImageUrl;
  final int followerCount;
  final int followingCount;
  final int notificationCount;
  final int scrapCount;
  final int likeCount;
  final double ridingDistanceKm;
  final double totalCaloriesKcal;
  final int totalHours;
  final int totalDays;
  final int postCount;
  final List<String> postThumbnailUrls;

  const MyProfileEntity({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.followerCount,
    required this.followingCount,
    required this.notificationCount,
    required this.scrapCount,
    required this.likeCount,
    required this.ridingDistanceKm,
    required this.totalCaloriesKcal,
    required this.totalHours,
    required this.totalDays,
    required this.postCount,
    required this.postThumbnailUrls,
  });
}
