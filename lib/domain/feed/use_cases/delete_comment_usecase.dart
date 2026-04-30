import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class DeleteCommentUseCase {
  final FeedRepository _repository;

  DeleteCommentUseCase(this._repository);

  Future<Either<Failure, void>> execute(String commentId) {
    return _repository.deleteComment(commentId);
  }
}
