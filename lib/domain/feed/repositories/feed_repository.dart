// ============================================================
// FILE: feed_repository.dart
// LAYER: domain
// RESPONSIBILITY: 피드 데이터 접근 인터페이스
// DEPENDENCIES: FeedEntity, CommentEntity, Failure
// ============================================================

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';
import 'package:pedal/domain/feed/entities/feed_status_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class FeedRepository {
  // GET /feed/
  Future<Either<Failure, List<FeedEntity>>> getFeedList({
    int limit = 20,
    int offset = 0,
  });

  // POST /feed/
  Future<Either<Failure, void>> createFeed({
    required String title,
    String? content,
    String? rideId,
    List<File> files = const [],
  });

  // POST /feed/{post_id}/like
  Future<Either<Failure, void>> toggleLike(String postId);

  // POST /feed/{post_id}/bookmark
  Future<Either<Failure, void>> toggleBookmark(String postId);

  // GET /feed/{post_id}/comments
  Future<Either<Failure, List<CommentEntity>>> getComments(
    String postId, {
    int limit = 20,
    int offset = 0,
  });

  // POST /feed/{post_id}/comments
  Future<Either<Failure, void>> createComment(
    String postId,
    String content, {
    String? parentId,
  });

  // DELETE /feed/comments/{comment_id}
  Future<Either<Failure, void>> deleteComment(String commentId);

  // POST /feed/comments/{comment_id}/like
  Future<Either<Failure, void>> toggleCommentLike(String commentId);

  // GET /feed/comments/{comment_id}/replies
  Future<Either<Failure, List<CommentEntity>>> getReplies(
    String commentId, {
    int limit = 5,
    int offset = 0,
  });

  // PATCH /feed/{post_id}
  Future<Either<Failure, void>> updateFeed(
    String postId, {
    required String title,
    String? content,
  });

  // DELETE /feed/{post_id}
  Future<Either<Failure, void>> deleteFeed(String postId);

  // GET /feed/{post_id}/status
  Future<Either<Failure, FeedStatusEntity>> getFeedStatus(String postId);
}
