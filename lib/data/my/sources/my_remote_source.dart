import 'package:dio/dio.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/auth/me_response.dart';
import 'package:pedal/data/models/map/route_response.dart';
import 'package:pedal/data/models/my/activity_calendar_response.dart';
import 'package:pedal/data/models/my/my_post_response.dart';
import 'package:pedal/data/models/my/my_profile_update_request.dart';
import 'package:pedal/data/models/my/my_streak_response.dart';
import 'package:pedal/data/models/my/weekly_stats_response.dart';

class MyRemoteSource {
  final DioClient _client;

  MyRemoteSource(this._client);

  /// GET /users/me
  Future<MeResponse> getMe() async {
    final response = await _client.get('/users/me');
    return MeResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// PUT /users/me
  Future<void> updateMyProfile(MyProfileUpdateRequest request) async {
    final formData = await request.toFormData();
    await _client.put(
      '/users/me',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  /// GET /users/me/activity-calendar?year=&month=
  Future<ActivityCalendarResponse> getActivityCalendar({
    int? year,
    int? month,
  }) async {
    final queryParams = <String, dynamic>{};
    if (year != null) queryParams['year'] = year;
    if (month != null) queryParams['month'] = month;

    final response = await _client.get(
      '/users/me/activity-calendar',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
    return ActivityCalendarResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  /// GET /users/me/streak
  Future<MyStreakResponse> getMyStreak() async {
    final response = await _client.get('/users/me/streak');
    return MyStreakResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /users/me/posts?limit=&offset=
  Future<MyPostsResponse> getMyPosts({int limit = 20, int offset = 0}) async {
    final response = await _client.get(
      '/users/me/posts',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    return MyPostsResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /users/me/routes
  Future<List<RouteResponse>> getMyRoutes() async {
    final response = await _client.get('/users/me/routes');
    final data = response.data;
    // SavedRoutesResponse: { "routes": [...] } 또는 직접 리스트
    if (data is Map<String, dynamic> && data.containsKey('routes')) {
      return (data['routes'] as List<dynamic>)
          .map((e) => RouteResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (data is List) {
      return data
          .map((e) => RouteResponse.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// POST /users/me/fcm-token
  Future<void> updateFcmToken(String token) async {
    await _client.post('/users/me/fcm-token?token=$token');
  }

  /// GET /users/me/stats/weekly?week_start=YYYY-MM-DD
  Future<WeeklyStatsResponse> getWeeklyStats({String? weekStart}) async {
    final response = await _client.get(
      '/users/me/stats/weekly',
      queryParameters: {'week_start': weekStart ?? '2026-01-19'},
    );
    return WeeklyStatsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
