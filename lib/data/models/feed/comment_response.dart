import 'package:pedal/domain/feed/entities/comment_entity.dart';

class CommentResponse {
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

  CommentResponse({
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

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    final author = json['author'] as Map<String, dynamic>?;
    return CommentResponse(
      id: json['id'] as String,
      postId: (json['post_id'] ?? '') as String,
      authorName:
          (author?['nickname'] ??
                  author?['username'] ??
                  author?['name'] ??
                  json['nickname'] ??
                  json['username'] ??
                  '')
              as String,
      authorAvatarUrl:
          (author?['profile_image'] ??
                  author?['avatar_url'] ??
                  json['profile_image'] ??
                  '')
              as String,
      content: json['content'] as String,
      likeCount: (json['like_count'] ?? json['likes'] ?? 0) as int,
      replyCount: (json['reply_count'] ?? json['replies'] ?? 0) as int,
      parentId: json['parent_id'] as String?,
      createdAt: (json['created_at'] ?? '') as String,
    );
  }

  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      postId: postId,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      content: content,
      likeCount: likeCount,
      replyCount: replyCount,
      parentId: parentId,
      createdAt: createdAt,
    );
  }
}
