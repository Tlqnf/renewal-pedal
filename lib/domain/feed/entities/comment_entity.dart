class CommentEntity {
  final String id;
  final String postId;
  final String authorName;
  final String authorAvatarUrl;
  final String content;
  final int likeCount;
  final bool isLiked;
  final int replyCount;
  final String? parentId;
  final String createdAt;

  const CommentEntity({
    required this.id,
    required this.postId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.content,
    required this.likeCount,
    this.isLiked = false,
    required this.replyCount,
    this.parentId,
    required this.createdAt,
  });
}
