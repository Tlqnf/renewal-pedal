// ============================================================
// FILE: feed_entity.dart
// LAYER: domain/entities
// RESPONSIBILITY: 피드 도메인 엔티티
// DEPENDENCIES: None
// ============================================================

class FeedEntity {
  final String id;
  final String userId;
  final String username;
  final String userAvatarUrl;
  final List<String> imageUrls;
  final String? routeDistance;
  final String title;
  final String description;
  final String date;
  final int likes;
  final int comments;
  final bool isBookmarked;

  const FeedEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrls,
    this.routeDistance,
    required this.title,
    required this.description,
    required this.date,
    required this.likes,
    required this.comments,
    required this.isBookmarked,
  });
}
