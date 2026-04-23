// ============================================================
// FILE: comment_entity.dart
// LAYER: domain
// RESPONSIBILITY: 댓글 도메인 엔티티
// DEPENDENCIES: -
// ============================================================

class CommentEntity {
  final String id;
  final String postId;
  final String authorName;
  final String authorAvatarUrl;
  final String content;
  final int likeCount;
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
    required this.replyCount,
    this.parentId,
    required this.createdAt,
  });
}
