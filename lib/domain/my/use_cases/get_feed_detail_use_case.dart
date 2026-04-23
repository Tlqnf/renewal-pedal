import 'package:pedal/domain/my/entities/feed_detail_entity.dart';
import 'package:pedal/domain/my/repositories/my_feed_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetFeedDetailUseCase {
  final MyFeedDetailRepository _repository;

  GetFeedDetailUseCase(this._repository);

  Future<({Failure? failure, FeedDetailEntity? data})> call({
    required String feedId,
  }) {
    return _repository.getFeedDetail(feedId: feedId);
  }
}
