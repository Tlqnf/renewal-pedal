import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/feed_detail_entity.dart';
import 'package:pedal/domain/my/use_cases/get_feed_detail_use_case.dart';
import 'package:pedal/domain/my/use_cases/toggle_feed_like_use_case.dart';
import 'package:pedal/domain/my/use_cases/toggle_feed_bookmark_use_case.dart';

class MyFeedDetailViewModel extends ChangeNotifier {
  final GetFeedDetailUseCase _getFeedDetailUseCase;
  final ToggleFeedLikeUseCase _toggleFeedLikeUseCase;
  final ToggleFeedBookmarkUseCase _toggleFeedBookmarkUseCase;

  MyFeedDetailViewModel({
    required GetFeedDetailUseCase getFeedDetailUseCase,
    required ToggleFeedLikeUseCase toggleFeedLikeUseCase,
    required ToggleFeedBookmarkUseCase toggleFeedBookmarkUseCase,
  })  : _getFeedDetailUseCase = getFeedDetailUseCase,
        _toggleFeedLikeUseCase = toggleFeedLikeUseCase,
        _toggleFeedBookmarkUseCase = toggleFeedBookmarkUseCase;

  // 상태 (View props에서 역추적)
  FeedDetailEntity? _feed;
  bool _isContentExpanded = false;
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  FeedDetailEntity? get feed => _feed;
  bool get isContentExpanded => _isContentExpanded;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // FeedDetailEntity 필드 단축 getter (View 연결 편의)
  String get feedId => _feed?.id ?? '';
  String? get authorProfileImageUrl => _feed?.authorProfileImageUrl;
  String get authorNickname => _feed?.authorNickname ?? '';
  String get feedImageUrl => _feed?.feedImageUrl ?? '';
  int get likeCount => _feed?.likeCount ?? 0;
  int get commentCount => _feed?.commentCount ?? 0;
  bool get isLiked => _feed?.isLiked ?? false;
  bool get isBookmarked => _feed?.isBookmarked ?? false;
  List<String> get hashtags => _feed?.hashtags ?? [];
  String get title => _feed?.title ?? '';
  String get content => _feed?.content ?? '';
  DateTime get createdAt => _feed?.createdAt ?? DateTime.now();

  /// 초기 데이터 로드
  Future<void> loadFeedDetail({required String feedId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getFeedDetailUseCase(feedId: feedId);

    if (result.failure != null) {
      _errorMessage = result.failure!.message;
    } else {
      _feed = result.data;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 좋아요 토글
  Future<void> onLikeTap() async {
    if (_feed == null) return;
    final currentIsLiked = _feed!.isLiked;
    final currentLikeCount = _feed!.likeCount;

    // Optimistic update
    _feed = FeedDetailEntity(
      id: _feed!.id,
      authorUserId: _feed!.authorUserId,
      authorNickname: _feed!.authorNickname,
      authorProfileImageUrl: _feed!.authorProfileImageUrl,
      feedImageUrl: _feed!.feedImageUrl,
      likeCount: currentIsLiked ? currentLikeCount - 1 : currentLikeCount + 1,
      commentCount: _feed!.commentCount,
      isLiked: !currentIsLiked,
      isBookmarked: _feed!.isBookmarked,
      hashtags: _feed!.hashtags,
      title: _feed!.title,
      content: _feed!.content,
      createdAt: _feed!.createdAt,
    );
    notifyListeners();

    final result = await _toggleFeedLikeUseCase(
      feedId: _feed!.id,
      isLiked: !currentIsLiked,
    );

    if (result.failure != null) {
      // 롤백
      _feed = FeedDetailEntity(
        id: _feed!.id,
        authorUserId: _feed!.authorUserId,
        authorNickname: _feed!.authorNickname,
        authorProfileImageUrl: _feed!.authorProfileImageUrl,
        feedImageUrl: _feed!.feedImageUrl,
        likeCount: currentLikeCount,
        commentCount: _feed!.commentCount,
        isLiked: currentIsLiked,
        isBookmarked: _feed!.isBookmarked,
        hashtags: _feed!.hashtags,
        title: _feed!.title,
        content: _feed!.content,
        createdAt: _feed!.createdAt,
      );
      _errorMessage = result.failure!.message;
      notifyListeners();
    }
  }

  /// 북마크 토글
  Future<void> onBookmarkTap() async {
    if (_feed == null) return;
    final currentIsBookmarked = _feed!.isBookmarked;

    // Optimistic update
    _feed = FeedDetailEntity(
      id: _feed!.id,
      authorUserId: _feed!.authorUserId,
      authorNickname: _feed!.authorNickname,
      authorProfileImageUrl: _feed!.authorProfileImageUrl,
      feedImageUrl: _feed!.feedImageUrl,
      likeCount: _feed!.likeCount,
      commentCount: _feed!.commentCount,
      isLiked: _feed!.isLiked,
      isBookmarked: !currentIsBookmarked,
      hashtags: _feed!.hashtags,
      title: _feed!.title,
      content: _feed!.content,
      createdAt: _feed!.createdAt,
    );
    notifyListeners();

    final result = await _toggleFeedBookmarkUseCase(
      feedId: _feed!.id,
      isBookmarked: !currentIsBookmarked,
    );

    if (result.failure != null) {
      // 롤백
      _feed = FeedDetailEntity(
        id: _feed!.id,
        authorUserId: _feed!.authorUserId,
        authorNickname: _feed!.authorNickname,
        authorProfileImageUrl: _feed!.authorProfileImageUrl,
        feedImageUrl: _feed!.feedImageUrl,
        likeCount: _feed!.likeCount,
        commentCount: _feed!.commentCount,
        isLiked: _feed!.isLiked,
        isBookmarked: currentIsBookmarked,
        hashtags: _feed!.hashtags,
        title: _feed!.title,
        content: _feed!.content,
        createdAt: _feed!.createdAt,
      );
      _errorMessage = result.failure!.message;
      notifyListeners();
    }
  }

  /// 본문 더보기/접기 토글
  void onExpandContent() {
    _isContentExpanded = !_isContentExpanded;
    notifyListeners();
  }

  /// 더보기 메뉴 — 라우팅은 Connected에서 처리
  void onMoreTap() {}

  /// 댓글 화면 이동 — 라우팅은 Connected에서 처리
  void onCommentTap() {}

  /// 뒤로 이동 — 라우팅은 Connected에서 처리
  void onBack() {}
}
