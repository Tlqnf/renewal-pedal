// ============================================================
// FILE: feed_status_entity.dart
// LAYER: domain/entities
// RESPONSIBILITY: 피드 상태(좋아요/북마크) 도메인 엔티티
// DEPENDENCIES: None
// ============================================================

class FeedStatusEntity {
  final bool isLiked;
  final bool isBookmarked;

  const FeedStatusEntity({required this.isLiked, required this.isBookmarked});
}
