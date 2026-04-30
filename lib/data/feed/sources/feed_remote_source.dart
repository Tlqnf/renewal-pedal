import 'package:dio/dio.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/feed/comment_response.dart';
import 'package:pedal/data/models/feed/feed_create_request.dart';
import 'package:pedal/data/models/feed/feed_response.dart';
import 'package:pedal/data/models/feed/feed_status_response.dart';
import 'package:pedal/data/models/feed/feed_update_request.dart';

class FeedRemoteSource {
  final DioClient _client;

  FeedRemoteSource(this._client);

  Future<List<FeedResponse>> getFeedList({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/feed/',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data;
    if (data is List) {
      return data
          .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    // 서버가 { items: [...] } 형태로 응답할 경우 대응
    final items = data['items'] as List? ?? data['feeds'] as List? ?? [];
    return items
        .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createFeed(FeedCreateRequest request) async {
    final formData = await request.toFormData();
    await _client.post('/feed/', data: formData);
  }

  Future<void> likePost(String postId) async {
    await _client.post('/feed/$postId/like');
  }

  Future<void> unlikePost(String postId) async {
    await _client.delete('/feed/$postId/like');
  }

  Future<void> bookmarkPost(String postId) async {
    await _client.post('/feed/$postId/bookmark');
  }

  Future<void> unbookmarkPost(String postId) async {
    await _client.delete('/feed/$postId/bookmark');
  }

  Future<List<CommentResponse>> getComments(
    String postId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/feed/$postId/comments',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data;
    if (data is List) {
      return data
          .map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    final items = data['items'] as List? ?? data['comments'] as List? ?? [];
    return items
        .map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createComment(
    String postId,
    String content, {
    String? parentId,
  }) async {
    await _client.post(
      '/feed/$postId/comments',
      data: {'content': content, 'parent_id': ?parentId},
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
  }

  Future<void> deleteComment(String commentId) async {
    await _client.delete('/feed/comments/$commentId');
  }

  Future<void> toggleCommentLike(String commentId) async {
    await _client.post('/feed/comments/$commentId/like');
  }

  Future<List<CommentResponse>> getReplies(
    String commentId, {
    int limit = 5,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/feed/comments/$commentId/replies',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data;
    if (data is List) {
      return data
          .map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    final items = data['items'] as List? ?? data['replies'] as List? ?? [];
    return items
        .map((e) => CommentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateFeed(String postId, FeedUpdateRequest request) async {
    await _client.patch(
      '/feed/$postId',
      data: request.toFormFields(),
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );
  }

  Future<void> deleteFeed(String postId) async {
    await _client.delete('/feed/$postId');
  }

  Future<FeedStatusResponse> getFeedStatus(String postId) async {
    final response = await _client.get('/feed/$postId/status');
    return FeedStatusResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<FeedResponse>> getMyFeed({int limit = 20, int offset = 0}) async {
    final response = await _client.get(
      '/feed/me',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data;
    if (data is List) {
      return data
          .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    final items = data['items'] as List? ?? data['feeds'] as List? ?? [];
    return items
        .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<FeedResponse>> getUserFeed(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/feed/users/$userId',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data;
    if (data is List) {
      return data
          .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    final items = data['items'] as List? ?? data['feeds'] as List? ?? [];
    return items
        .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
