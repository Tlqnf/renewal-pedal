class FeedDetailEntity {
  final String id;
  final String authorUserId;
  final String authorNickname;
  final String? authorProfileImageUrl;
  final String feedImageUrl;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isBookmarked;
  final List<String> hashtags;
  final String title;
  final String content;
  final DateTime createdAt;

  const FeedDetailEntity({
    required this.id,
    required this.authorUserId,
    required this.authorNickname,
    this.authorProfileImageUrl,
    required this.feedImageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.isBookmarked,
    required this.hashtags,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}
