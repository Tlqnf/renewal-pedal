import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class BookmarkPostUseCase {
  final FeedRepository _repository;

  BookmarkPostUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.bookmarkPost(postId);
  }
}

class UnbookmarkPostUseCase {
  final FeedRepository _repository;

  UnbookmarkPostUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.unbookmarkPost(postId);
  }
}
