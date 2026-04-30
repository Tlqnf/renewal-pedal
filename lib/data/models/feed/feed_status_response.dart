import 'package:pedal/domain/feed/entities/feed_status_entity.dart';

class FeedStatusResponse {
  final bool isLiked;
  final bool isBookmarked;

  const FeedStatusResponse({required this.isLiked, required this.isBookmarked});

  factory FeedStatusResponse.fromJson(Map<String, dynamic> json) {
    return FeedStatusResponse(
      isLiked: json['is_liked'] as bool? ?? false,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
    );
  }

  FeedStatusEntity toEntity() =>
      FeedStatusEntity(isLiked: isLiked, isBookmarked: isBookmarked);
}
