import 'package:pedal/domain/my/entities/feed_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class MyFeedRepository {
  Future<({Failure? failure, List<FeedEntity>? data, int? totalCount})>
      getMyFeedList({required String userId});
}
