import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/my/sources/my_remote_source.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class MyRepositoryImpl implements MyRepository {
  final MyRemoteSource _remoteSource;

  MyRepositoryImpl(this._remoteSource);

  @override
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile() async {
    try {
      final me = await _remoteSource.getMe();
      return (
        failure: null,
        data: MyProfileEntity(
          userId: me.id,
          nickname: me.username,
          profileImageUrl: me.avatarUrl.isNotEmpty ? me.avatarUrl : null,
          followerCount: 0,
          followingCount: 0,
          notificationCount: 0,
          scrapCount: 0,
          likeCount: 0,
          ridingDistanceKm: 0,
          totalCaloriesKcal: 0,
          totalHours: 0,
          totalDays: 0,
          postCount: 0,
          postThumbnailUrls: const [],
        ),
      );
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, List<CrewEntity>? data})>
  getParticipatedCrews() async {
    return (failure: null, data: const <CrewEntity>[]);
  }

  @override
  Future<({Failure? failure, List<SavedRouteEntity>? data})>
  getSavedRoutes() async {
    try {
      final routes = await _remoteSource.getMyRoutes();
      final entities = routes.map((r) {
        final durationMinutes = _parseDurationToMinutes(r.duration);
        return SavedRouteEntity(
          id: r.id,
          name: r.routeName,
          distanceKm: r.distance,
          durationMinutes: durationMinutes,
          savedAt: DateTime.now(),
        );
      }).toList();
      return (failure: null, data: entities);
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  /// "2h 30m" → 150, "45m" → 45, 기타 → 0
  int _parseDurationToMinutes(String duration) {
    final hourMatch = RegExp(r'(\d+)h').firstMatch(duration);
    final minMatch = RegExp(r'(\d+)m').firstMatch(duration);
    final hours = hourMatch != null ? int.parse(hourMatch.group(1)!) : 0;
    final minutes = minMatch != null ? int.parse(minMatch.group(1)!) : 0;
    return hours * 60 + minutes;
  }
}
