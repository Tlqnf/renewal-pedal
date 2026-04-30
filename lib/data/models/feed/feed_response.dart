import 'package:pedal/domain/feed/entities/feed_entity.dart';

class FeedResponse {
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

  const FeedResponse({
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

  factory FeedResponse.fromJson(Map<String, dynamic> json) {
    final author = json['author'] as Map<String, dynamic>?;
    return FeedResponse(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      username:
          author?['username'] as String? ?? json['username'] as String? ?? '',
      userAvatarUrl:
          author?['profile_image_url'] as String? ??
          json['user_avatar_url'] as String? ??
          '',
      imageUrls:
          (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      routeDistance: json['route_distance'] as String?,
      title: json['title'] as String? ?? '',
      description: json['content'] as String? ?? '',
      date: json['created_at'] as String? ?? '',
      likes: json['like_count'] as int? ?? json['likes'] as int? ?? 0,
      comments: json['comment_count'] as int? ?? json['comments'] as int? ?? 0,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
    );
  }

  FeedEntity toEntity() => FeedEntity(
    id: id,
    userId: userId,
    username: username,
    userAvatarUrl: userAvatarUrl,
    imageUrls: imageUrls,
    routeDistance: routeDistance,
    title: title,
    description: description,
    date: date,
    likes: likes,
    comments: comments,
    isBookmarked: isBookmarked,
  );
}
