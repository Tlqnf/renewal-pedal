import 'package:dartz/dartz.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class GetRepliesUseCase {
  final FeedRepository _repository;

  GetRepliesUseCase(this._repository);

  Future<Either<Failure, List<CommentEntity>>> execute(
    String commentId, {
    int limit = 5,
    int offset = 0,
  }) {
    return _repository.getReplies(commentId, limit: limit, offset: offset);
  }
}
