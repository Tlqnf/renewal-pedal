import 'package:pedal/domain/my/repositories/my_feed_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class ToggleFeedBookmarkUseCase {
  final MyFeedDetailRepository _repository;

  ToggleFeedBookmarkUseCase(this._repository);

  Future<({Failure? failure})> call({
    required String feedId,
    required bool isBookmarked,
  }) {
    return _repository.toggleBookmark(feedId: feedId, isBookmarked: isBookmarked);
  }
}
