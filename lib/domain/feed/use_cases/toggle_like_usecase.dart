// ============================================================
// FILE: toggle_like_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 피드 좋아요 토글
// DEPENDENCIES: FeedRepository
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class ToggleLikeUseCase {
  final FeedRepository _repository;

  ToggleLikeUseCase(this._repository);

  Future<Either<Failure, void>> execute(String postId) {
    return _repository.toggleLike(postId);
  }
}
