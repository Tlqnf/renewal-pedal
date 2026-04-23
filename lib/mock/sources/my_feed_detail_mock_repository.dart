import 'package:pedal/domain/my/entities/feed_detail_entity.dart';
import 'package:pedal/domain/my/repositories/my_feed_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/my_feed_detail_mock_data.dart';

class MyFeedDetailMockRepository implements MyFeedDetailRepository {
  @override
  Future<({Failure? failure, FeedDetailEntity? data})> getFeedDetail({
    required String feedId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final feed = MyFeedDetailMockData.feedDetailList.firstWhere(
      (f) => f.id == feedId,
      orElse: () => MyFeedDetailMockData.feedDetail,
    );
    return (failure: null, data: feed);
  }

  @override
  Future<({Failure? failure})> toggleLike({
    required String feedId,
    required bool isLiked,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null);
  }

  @override
  Future<({Failure? failure})> toggleBookmark({
    required String feedId,
    required bool isBookmarked,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null);
  }
}
