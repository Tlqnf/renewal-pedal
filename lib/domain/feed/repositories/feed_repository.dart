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
  Future<Either<Failure, void>> likePost(String postId);

  // DELETE /feed/{post_id}/like
  Future<Either<Failure, void>> unlikePost(String postId);

  // POST /feed/{post_id}/bookmark
  Future<Either<Failure, void>> bookmarkPost(String postId);

  // DELETE /feed/{post_id}/bookmark
  Future<Either<Failure, void>> unbookmarkPost(String postId);

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

  // GET /feed/me
  Future<Either<Failure, List<FeedEntity>>> getMyFeed({
    int limit = 20,
    int offset = 0,
  });

  // GET /feed/users/{user_id}
  Future<Either<Failure, List<FeedEntity>>> getUserFeed(
    String userId, {
    int limit = 20,
    int offset = 0,
  });
}
