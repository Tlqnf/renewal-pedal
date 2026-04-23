// ============================================================
// FILE: toggle_bookmark_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 피드 북마크 토글
// DEPENDENCIES: FeedRepository
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class ToggleBookmarkUseCase {
  final FeedRepository _repository;

  ToggleBookmarkUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.toggleBookmark(postId);
  }
}
