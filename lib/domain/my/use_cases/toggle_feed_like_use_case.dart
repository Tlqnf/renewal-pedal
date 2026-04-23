import 'package:pedal/domain/my/repositories/my_feed_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class ToggleFeedLikeUseCase {
  final MyFeedDetailRepository _repository;

  ToggleFeedLikeUseCase(this._repository);

  Future<({Failure? failure})> call({
    required String feedId,
    required bool isLiked,
  }) {
    return _repository.toggleLike(feedId: feedId, isLiked: isLiked);
  }
}
