import 'package:pedal/domain/my/entities/feed_entity.dart';
import 'package:pedal/domain/my/repositories/my_feed_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/my_feed_mock_data.dart';

class MyFeedMockRepository implements MyFeedRepository {
  @override
  Future<({Failure? failure, List<FeedEntity>? data, int? totalCount})>
      getMyFeedList({required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (
      failure: null,
      data: MyFeedMockData.feedList,
      totalCount: MyFeedMockData.totalCount,
    );
  }
}
