import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/crew/crew_create_request.dart';
import 'package:pedal/data/models/crew/crew_detail_response.dart';
import 'package:pedal/data/models/crew/crew_member_response.dart';
import 'package:pedal/data/models/crew/crew_post_create_request.dart';
import 'package:pedal/data/models/crew/crew_response.dart';
import 'package:pedal/data/models/crew/crew_update_request.dart';
import 'package:pedal/data/models/feed/feed_response.dart';

class CrewRemoteSource {
  final DioClient _client;

  CrewRemoteSource(this._client);

  Future<List<CrewResponse>> getMyCrews() async {
    final response = await _client.get('/crews/my');
    debugPrint('[CrewRemoteSource] GET /crews/my 응답: ${response.statusCode}');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => CrewResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<CrewResponse>> getCrews({int limit = 10, int offset = 0}) async {
    final response = await _client.get(
      '/crews',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    debugPrint('[CrewRemoteSource] GET /crews 응답: ${response.statusCode}');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => CrewResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<CrewResponse>> getRecommendCrews() async {
    final response = await _client.get('/crews/recommend');
    debugPrint(
      '[CrewRemoteSource] GET /crews/recommend 응답: ${response.statusCode}',
    );
    final list = response.data as List<dynamic>;
    return list
        .map((item) => CrewResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> joinCrew(String crewId) async {
    await _client.post('/crews/$crewId/join');
    debugPrint('[CrewRemoteSource] POST /crews/$crewId/join 완료');
  }

  Future<String> createCrew(CrewCreateRequest request) async {
    final formData = await request.toFormData();
    final response = await _client.post(
      '/crews',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    debugPrint('[CrewRemoteSource] POST /crews 응답: ${response.statusCode}');
    debugPrint('[createCrew] raw response data: ${response.data}');
    final data = response.data as Map<String, dynamic>;
    final id = data['id'];
    debugPrint('[createCrew] id 타입: ${id.runtimeType}, 값: $id');
    return data['id'] as String;
  }

  Future<CrewDetailResponse> getCrewById(String crewId) async {
    final response = await _client.get('/crews/$crewId');
    debugPrint(
      '[CrewRemoteSource] GET /crews/$crewId 응답: ${response.statusCode}',
    );
    return CrewDetailResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> updateCrew(String crewId, CrewUpdateRequest request) async {
    final formData = await request.toFormData();
    await _client.patch(
      '/crews/$crewId',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    debugPrint('[CrewRemoteSource] PATCH /crews/$crewId 완료');
  }

  Future<void> deleteCrew(String crewId) async {
    await _client.delete('/crews/$crewId');
    debugPrint('[CrewRemoteSource] DELETE /crews/$crewId 완료');
  }

  Future<void> leaveCrew(String crewId) async {
    await _client.delete('/crews/$crewId/leave');
    debugPrint('[CrewRemoteSource] DELETE /crews/$crewId/leave 완료');
  }

  Future<List<CrewMemberResponse>> getCrewMembers(
    String crewId, {
    int limit = 100,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/crews/$crewId/members',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    debugPrint(
      '[CrewRemoteSource] GET /crews/$crewId/members 응답: ${response.statusCode}',
    );
    final list = response.data as List<dynamic>;
    return list
        .map(
          (item) => CrewMemberResponse.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<FeedResponse>> getCrewFeeds(
    String crewId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      '/crews/$crewId/feeds',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    debugPrint(
      '[CrewRemoteSource] GET /crews/$crewId/feeds 응답: ${response.statusCode}',
    );
    final data = response.data;
    List<dynamic> list;
    if (data is List) {
      list = data;
    } else {
      list =
          (data as Map<String, dynamic>)['items'] as List<dynamic>? ??
          (data)['feeds'] as List<dynamic>? ??
          [];
    }
    return list
        .map((item) => FeedResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> createCrewPost(
    String crewId,
    CrewPostCreateRequest request,
  ) async {
    final formData = await request.toFormData();
    await _client.post(
      '/crews/$crewId/posts',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    debugPrint('[CrewRemoteSource] POST /crews/$crewId/posts 완료');
  }
}
