import 'package:dartz/dartz.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class GetCommentsUseCase {
  final FeedRepository _repository;

  GetCommentsUseCase(this._repository);

  Future<Either<Failure, List<CommentEntity>>> execute(
    String postId, {
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.getComments(postId, limit: limit, offset: offset);
  }
}
