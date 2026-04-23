import 'package:pedal/domain/my/entities/feed_detail_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class MyFeedDetailRepository {
  Future<({Failure? failure, FeedDetailEntity? data})> getFeedDetail({
    required String feedId,
  });

  Future<({Failure? failure})> toggleLike({
    required String feedId,
    required bool isLiked,
  });

  Future<({Failure? failure})> toggleBookmark({
    required String feedId,
    required bool isBookmarked,
  });
}
