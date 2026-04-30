import 'package:pedal/data/feed/sources/feed_remote_source.dart';
import 'package:pedal/data/models/feed/comment_response.dart';
import 'package:pedal/data/models/feed/feed_create_request.dart';
import 'package:pedal/data/models/feed/feed_response.dart';
import 'package:pedal/data/models/feed/feed_status_response.dart';
import 'package:pedal/data/models/feed/feed_update_request.dart';
import 'package:pedal/mock/data/feed_mock_data.dart';

class FeedMockRemoteSource implements FeedRemoteSource {
  @override
  Future<List<FeedResponse>> getFeedList({
    int limit = 20,
    int offset = 0,
  }) async {
    return FeedMockData.feeds
        .map(
          (e) => FeedResponse(
            id: e.id,
            userId: e.userId,
            username: e.username,
            userAvatarUrl: e.userAvatarUrl,
            imageUrls: e.imageUrls,
            routeDistance: e.routeDistance,
            title: e.title,
            description: e.description,
            date: e.date,
            likes: e.likes,
            comments: e.comments,
            isBookmarked: e.isBookmarked,
          ),
        )
        .toList();
  }

  @override
  Future<void> createFeed(FeedCreateRequest request) async {}

  @override
  Future<void> likePost(String postId) async {}

  @override
  Future<void> unlikePost(String postId) async {}

  @override
  Future<void> bookmarkPost(String postId) async {}

  @override
  Future<void> unbookmarkPost(String postId) async {}

  @override
  Future<List<CommentResponse>> getComments(
    String postId, {
    int limit = 20,
    int offset = 0,
  }) async {
    return [
      CommentResponse(
        id: 'comment_001',
        postId: postId,
        authorName: '댓글러1',
        authorAvatarUrl: '',
        content: '정말 멋진 라이딩이네요!',
        likeCount: 3,
        replyCount: 1,
        createdAt: '2026-04-01T10:00:00',
      ),
      CommentResponse(
        id: 'comment_002',
        postId: postId,
        authorName: '댓글러2',
        authorAvatarUrl: '',
        content: '저도 이 코스 가보고 싶어요.',
        likeCount: 1,
        replyCount: 0,
        createdAt: '2026-04-01T11:00:00',
      ),
    ];
  }

  @override
  Future<void> createComment(
    String postId,
    String content, {
    String? parentId,
  }) async {}

  @override
  Future<void> deleteComment(String commentId) async {}

  @override
  Future<void> toggleCommentLike(String commentId) async {}

  @override
  Future<List<CommentResponse>> getReplies(
    String commentId, {
    int limit = 5,
    int offset = 0,
  }) async {
    return [];
  }

  @override
  Future<void> updateFeed(String postId, FeedUpdateRequest request) async {}

  @override
  Future<void> deleteFeed(String postId) async {}

  @override
  Future<FeedStatusResponse> getFeedStatus(String postId) async {
    return FeedStatusResponse(isLiked: false, isBookmarked: false);
  }

  @override
  Future<List<FeedResponse>> getMyFeed({int limit = 20, int offset = 0}) async {
    return FeedMockData.feeds
        .map(
          (e) => FeedResponse(
            id: e.id,
            userId: e.userId,
            username: e.username,
            userAvatarUrl: e.userAvatarUrl,
            imageUrls: e.imageUrls,
            routeDistance: e.routeDistance,
            title: e.title,
            description: e.description,
            date: e.date,
            likes: e.likes,
            comments: e.comments,
            isBookmarked: e.isBookmarked,
          ),
        )
        .toList();
  }

  @override
  Future<List<FeedResponse>> getUserFeed(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    return FeedMockData.feeds
        .map(
          (e) => FeedResponse(
            id: e.id,
            userId: e.userId,
            username: e.username,
            userAvatarUrl: e.userAvatarUrl,
            imageUrls: e.imageUrls,
            routeDistance: e.routeDistance,
            title: e.title,
            description: e.description,
            date: e.date,
            likes: e.likes,
            comments: e.comments,
            isBookmarked: e.isBookmarked,
          ),
        )
        .toList();
  }
}
