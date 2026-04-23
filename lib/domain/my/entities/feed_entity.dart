class FeedEntity {
  final String id;
  final String thumbnailUrl;
  final bool hasMultipleImages;
  final int imageCount;
  final String? content;
  final DateTime createdAt;

  const FeedEntity({
    required this.id,
    required this.thumbnailUrl,
    required this.hasMultipleImages,
    required this.imageCount,
    this.content,
    required this.createdAt,
  });
}
