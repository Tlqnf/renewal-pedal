import 'package:pedal/data/api/failure_mapper.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/models/feed/feed_create_request.dart';
import 'package:pedal/data/models/feed/feed_update_request.dart';
import 'package:pedal/data/feed/sources/feed_remote_source.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';
import 'package:pedal/domain/feed/entities/feed_status_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteSource _remoteSource;

  FeedRepositoryImpl(this._remoteSource);

  @override
  Future<Either<Failure, List<FeedEntity>>> getFeedList({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final responses = await _remoteSource.getFeedList(
        limit: limit,
        offset: offset,
      );
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createFeed({
    required String title,
    String? content,
    String? rideId,
    List<File> files = const [],
  }) async {
    try {
      final request = FeedCreateRequest(
        title: title,
        content: content,
        rideId: rideId,
        files: files,
      );
      await _remoteSource.createFeed(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likePost(String postId) async {
    try {
      await _remoteSource.likePost(postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unlikePost(String postId) async {
    try {
      await _remoteSource.unlikePost(postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> bookmarkPost(String postId) async {
    try {
      await _remoteSource.bookmarkPost(postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unbookmarkPost(String postId) async {
    try {
      await _remoteSource.unbookmarkPost(postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
    String postId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final responses = await _remoteSource.getComments(
        postId,
        limit: limit,
        offset: offset,
      );
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createComment(
    String postId,
    String content, {
    String? parentId,
  }) async {
    try {
      await _remoteSource.createComment(postId, content, parentId: parentId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) async {
    try {
      await _remoteSource.deleteComment(commentId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleCommentLike(String commentId) async {
    try {
      await _remoteSource.toggleCommentLike(commentId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getReplies(
    String commentId, {
    int limit = 5,
    int offset = 0,
  }) async {
    try {
      final responses = await _remoteSource.getReplies(
        commentId,
        limit: limit,
        offset: offset,
      );
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateFeed(
    String postId, {
    required String title,
    String? content,
  }) async {
    try {
      final request = FeedUpdateRequest(title: title, content: content);
      await _remoteSource.updateFeed(postId, request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeed(String postId) async {
    try {
      await _remoteSource.deleteFeed(postId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, FeedStatusEntity>> getFeedStatus(String postId) async {
    try {
      final response = await _remoteSource.getFeedStatus(postId);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<FeedEntity>>> getMyFeed({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final responses = await _remoteSource.getMyFeed(
        limit: limit,
        offset: offset,
      );
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<FeedEntity>>> getUserFeed(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final responses = await _remoteSource.getUserFeed(
        userId,
        limit: limit,
        offset: offset,
      );
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
