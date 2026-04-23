import 'package:pedal/domain/my/entities/feed_entity.dart';
import 'package:pedal/domain/my/repositories/my_feed_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetMyFeedListUseCase {
  final MyFeedRepository _repository;

  GetMyFeedListUseCase(this._repository);

  Future<({Failure? failure, List<FeedEntity>? data, int? totalCount})> call({
    required String userId,
  }) {
    return _repository.getMyFeedList(userId: userId);
  }
}
