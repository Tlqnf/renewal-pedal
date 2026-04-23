// ============================================================
// FILE: update_feed_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 게시글 수정
// DEPENDENCIES: FeedRepository
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class UpdateFeedUseCase {
  final FeedRepository _repository;

  UpdateFeedUseCase(this._repository);

  Future<Either<Failure, void>> execute(
    String postId, {
    required String title,
    String? content,
  }) async {
    if (title.trim().isEmpty) {
      return const Left(ValidationFailure('제목을 입력해주세요'));
    }
    return await _repository.updateFeed(postId, title: title, content: content);
  }
}
