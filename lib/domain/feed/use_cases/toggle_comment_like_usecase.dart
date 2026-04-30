import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class ToggleCommentLikeUseCase {
  final FeedRepository _repository;

  ToggleCommentLikeUseCase(this._repository);

  Future<Either<Failure, void>> execute(String commentId) {
    return _repository.toggleCommentLike(commentId);
  }
}
