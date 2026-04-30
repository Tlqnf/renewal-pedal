import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class LikePostUseCase {
  final FeedRepository _repository;

  LikePostUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.likePost(postId);
  }
}

class UnlikePostUseCase {
  final FeedRepository _repository;

  UnlikePostUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.unlikePost(postId);
  }
}
