import 'package:pedal/data/models/feed/feed_response.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';

class MyPostsResponse {
  final List<FeedResponse> posts;
  final int total;

  const MyPostsResponse({required this.posts, required this.total});

  factory MyPostsResponse.fromJson(Map<String, dynamic> json) {
    final rawList =
        json['posts'] as List<dynamic>? ??
        json['items'] as List<dynamic>? ??
        [];
    return MyPostsResponse(
      posts: rawList
          .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt() ?? rawList.length,
    );
  }

  List<FeedEntity> toEntities() => posts.map((p) => p.toEntity()).toList();
}
