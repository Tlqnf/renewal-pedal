import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';
import 'package:pedal/domain/feed/entities/feed_status_entity.dart';
import 'package:pedal/domain/feed/use_cases/toggle_bookmark_usecase.dart';
import 'package:pedal/domain/feed/use_cases/create_comment_usecase.dart';
import 'package:pedal/domain/feed/use_cases/create_feed_usecase.dart';
import 'package:pedal/domain/feed/use_cases/delete_feed_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_comments_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_feed_list_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_feed_status_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_replies_usecase.dart';
import 'package:pedal/domain/feed/use_cases/toggle_like_usecase.dart';
import 'package:pedal/domain/feed/use_cases/toggle_comment_like_usecase.dart';
import 'package:pedal/domain/feed/use_cases/update_feed_usecase.dart';

class FeedViewModel extends ChangeNotifier {
  final GetFeedListUseCase _getFeedListUseCase;
  final LikePostUseCase _likePostUseCase;
  final UnlikePostUseCase _unlikePostUseCase;
  final BookmarkPostUseCase _bookmarkPostUseCase;
  final UnbookmarkPostUseCase _unbookmarkPostUseCase;
  final GetCommentsUseCase _getCommentsUseCase;
  final CreateCommentUseCase _createCommentUseCase;
  final ToggleCommentLikeUseCase _toggleCommentLikeUseCase;
  final GetRepliesUseCase _getRepliesUseCase;
  final CreateFeedUseCase _createFeedUseCase;
  final UpdateFeedUseCase _updateFeedUseCase;
  final DeleteFeedUseCase _deleteFeedUseCase;
  final GetFeedStatusUseCase _getFeedStatusUseCase;
  final String? _initialUserId;

  FeedViewModel(
    this._getFeedListUseCase,
    this._likePostUseCase,
    this._unlikePostUseCase,
    this._bookmarkPostUseCase,
    this._unbookmarkPostUseCase,
    this._getCommentsUseCase,
    this._createCommentUseCase,
    this._toggleCommentLikeUseCase,
    this._getRepliesUseCase,
    this._createFeedUseCase,
    this._updateFeedUseCase,
    this._deleteFeedUseCase,
    this._getFeedStatusUseCase, {
    String? currentUserId,
  }) : _initialUserId = currentUserId;

  List<FeedEntity> _feeds = [];
  FeedEntity? _feedDetail;
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentUserId;

  List<CommentEntity> _comments = [];
  bool _isLoadingComments = false;

  bool _isCreatingFeed = false;
  String? _createFeedError;

  // 피드 상태: postId → FeedStatusEntity
  final Map<String, FeedStatusEntity> _feedStatuses = {};

  // 대댓글: commentId → replies
  final Map<String, List<CommentEntity>> _replies = {};
  final Set<String> _loadingReplies = {};
  final Set<String> _expandedReplies = {};

  List<FeedEntity> get feeds => _feeds;
  FeedEntity? get feedDetail => _feedDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool isAuthor(String feedUserId) =>
      _currentUserId != null && _currentUserId == feedUserId;
  List<CommentEntity> get comments => _comments;
  bool get isLoadingComments => _isLoadingComments;
  bool get isCreatingFeed => _isCreatingFeed;
  String? get createFeedError => _createFeedError;

  FeedStatusEntity? getFeedStatus(String postId) => _feedStatuses[postId];

  List<CommentEntity> getRepliesFor(String commentId) =>
      _replies[commentId] ?? [];
  bool isLoadingRepliesFor(String commentId) =>
      _loadingReplies.contains(commentId);
  bool isRepliesExpanded(String commentId) =>
      _expandedReplies.contains(commentId);

  Future<void> loadFeeds() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _currentUserId ??= _initialUserId;

    final result = await _getFeedListUseCase.execute();

    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _feeds = list,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshFeeds() async {
    await loadFeeds();
  }

  void loadFeedDetail(String feedId) {
    if (_feeds.isEmpty) return;
    _feedDetail = _feeds.firstWhere(
      (feed) => feed.id == feedId,
      orElse: () => _feeds.first,
    );
    notifyListeners();
  }

  /// 좋아요 상태에 따라 likePost / unlikePost 호출
  Future<void> toggleLike(String feedId) async {
    final status = _feedStatuses[feedId];
    final isCurrentlyLiked = status?.isLiked ?? false;

    final result = isCurrentlyLiked
        ? await _unlikePostUseCase.execute(feedId)
        : await _likePostUseCase.execute(feedId);

    result.fold((failure) => debugPrint('좋아요 토글 실패: ${failure.message}'), (_) {
      final index = _feeds.indexWhere((f) => f.id == feedId);
      if (index != -1) {
        final feed = _feeds[index];
        final delta = isCurrentlyLiked ? -1 : 1;
        _feeds[index] = FeedEntity(
          id: feed.id,
          userId: feed.userId,
          username: feed.username,
          userAvatarUrl: feed.userAvatarUrl,
          imageUrls: feed.imageUrls,
          routeDistance: feed.routeDistance,
          title: feed.title,
          description: feed.description,
          date: feed.date,
          likes: feed.likes + delta,
          comments: feed.comments,
          isBookmarked: feed.isBookmarked,
        );
      }
      // 상태 캐시 업데이트
      _feedStatuses[feedId] = FeedStatusEntity(
        isLiked: !isCurrentlyLiked,
        isBookmarked: status?.isBookmarked ?? false,
      );
      notifyListeners();
    });
  }

  /// 북마크 상태에 따라 bookmarkPost / unbookmarkPost 호출
  Future<void> toggleBookmark(String feedId) async {
    final status = _feedStatuses[feedId];
    final isCurrentlyBookmarked = status?.isBookmarked ?? false;

    final result = isCurrentlyBookmarked
        ? await _unbookmarkPostUseCase.execute(feedId)
        : await _bookmarkPostUseCase.execute(feedId);

    result.fold((failure) => debugPrint('북마크 토글 실패: ${failure.message}'), (_) {
      final index = _feeds.indexWhere((f) => f.id == feedId);
      if (index != -1) {
        final feed = _feeds[index];
        _feeds[index] = FeedEntity(
          id: feed.id,
          userId: feed.userId,
          username: feed.username,
          userAvatarUrl: feed.userAvatarUrl,
          imageUrls: feed.imageUrls,
          routeDistance: feed.routeDistance,
          title: feed.title,
          description: feed.description,
          date: feed.date,
          likes: feed.likes,
          comments: feed.comments,
          isBookmarked: !isCurrentlyBookmarked,
        );
      }
      // 상태 캐시 업데이트
      _feedStatuses[feedId] = FeedStatusEntity(
        isLiked: status?.isLiked ?? false,
        isBookmarked: !isCurrentlyBookmarked,
      );
      notifyListeners();
    });
  }

  Future<void> loadComments(String postId) async {
    _isLoadingComments = true;
    notifyListeners();

    final result = await _getCommentsUseCase.execute(postId);
    result.fold(
      (failure) => debugPrint('댓글 로드 실패: ${failure.message}'),
      (list) => _comments = list,
    );

    _isLoadingComments = false;
    notifyListeners();
  }

  Future<void> createComment(String postId, String content) async {
    if (content.trim().isEmpty) return;

    final result = await _createCommentUseCase.execute(postId, content.trim());
    result.fold(
      (failure) => debugPrint('댓글 작성 실패: ${failure.message}'),
      (_) => loadComments(postId),
    );
  }

  Future<void> toggleCommentLike(String commentId) async {
    final result = await _toggleCommentLikeUseCase.execute(commentId);
    result.fold((failure) => debugPrint('댓글 좋아요 토글 실패: ${failure.message}'), (
      _,
    ) {
      final index = _comments.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        final comment = _comments[index];
        _comments[index] = CommentEntity(
          id: comment.id,
          postId: comment.postId,
          authorName: comment.authorName,
          authorAvatarUrl: comment.authorAvatarUrl,
          content: comment.content,
          likeCount: comment.likeCount + 1,
          replyCount: comment.replyCount,
          parentId: comment.parentId,
          createdAt: comment.createdAt,
        );
        notifyListeners();
      }
    });
  }

  void clearComments() {
    _comments = [];
    _replies.clear();
    _expandedReplies.clear();
    notifyListeners();
  }

  Future<void> toggleRepliesExpanded(String commentId, String postId) async {
    if (_expandedReplies.contains(commentId)) {
      _expandedReplies.remove(commentId);
      notifyListeners();
      return;
    }
    _expandedReplies.add(commentId);
    await loadReplies(commentId);
  }

  Future<void> loadReplies(String commentId) async {
    _loadingReplies.add(commentId);
    notifyListeners();

    final result = await _getRepliesUseCase.execute(commentId);
    result.fold(
      (failure) => debugPrint('대댓글 로드 실패: ${failure.message}'),
      (list) => _replies[commentId] = list,
    );

    _loadingReplies.remove(commentId);
    notifyListeners();
  }

  Future<void> createReply(
    String postId,
    String commentId,
    String content,
  ) async {
    if (content.trim().isEmpty) return;

    final result = await _createCommentUseCase.execute(
      postId,
      content.trim(),
      parentId: commentId,
    );
    result.fold(
      (failure) => debugPrint('대댓글 작성 실패: ${failure.message}'),
      (_) => loadReplies(commentId),
    );
  }

  /// 게시글 생성. 성공 시 true, 실패 시 false 반환.
  Future<bool> createFeed({
    required String title,
    String? content,
    String? rideId,
    required List<File> files,
  }) async {
    _isCreatingFeed = true;
    _createFeedError = null;
    notifyListeners();

    final result = await _createFeedUseCase.execute(
      title: title,
      content: content,
      rideId: rideId,
      files: files,
    );

    bool success = false;
    result.fold((failure) => _createFeedError = failure.message, (_) {
      success = true;
      loadFeeds();
    });

    _isCreatingFeed = false;
    notifyListeners();
    return success;
  }

  /// 게시글 수정. 성공 시 true 반환.
  Future<bool> updateFeed(
    String postId, {
    required String title,
    String? content,
  }) async {
    final result = await _updateFeedUseCase.execute(
      postId,
      title: title,
      content: content,
    );
    bool success = false;
    result.fold((failure) => debugPrint('게시글 수정 실패: ${failure.message}'), (_) {
      success = true;
      loadFeeds();
    });
    return success;
  }

  /// 게시글 삭제. 성공 시 true 반환.
  Future<bool> deleteFeed(String postId) async {
    final result = await _deleteFeedUseCase.execute(postId);
    bool success = false;
    result.fold((failure) => debugPrint('게시글 삭제 실패: ${failure.message}'), (_) {
      success = true;
      _feeds.removeWhere((f) => f.id == postId);
      notifyListeners();
    });
    return success;
  }

  /// 게시글 상태(좋아요/북마크) 로드 후 캐시에 저장.
  Future<void> loadFeedStatus(String postId) async {
    final result = await _getFeedStatusUseCase.execute(postId);
    result.fold((failure) => debugPrint('피드 상태 로드 실패: ${failure.message}'), (
      status,
    ) {
      _feedStatuses[postId] = status;
      notifyListeners();
    });
  }
}
