// ============================================================
// FILE: get_feed_status_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 게시글 좋아요/북마크 상태 조회
// DEPENDENCIES: FeedRepository, FeedStatusEntity
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/feed/entities/feed_status_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class GetFeedStatusUseCase {
  final FeedRepository _repository;

  GetFeedStatusUseCase(this._repository);

  Future<Either<Failure, FeedStatusEntity>> execute(String postId) async {
    return await _repository.getFeedStatus(postId);
  }
}
