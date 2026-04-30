import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class CreateCommentUseCase {
  final FeedRepository _repository;

  CreateCommentUseCase(this._repository);

  Future<Either<Failure, void>> execute(
    String postId,
    String content, {
    String? parentId,
  }) {
    return _repository.createComment(postId, content, parentId: parentId);
  }
}
