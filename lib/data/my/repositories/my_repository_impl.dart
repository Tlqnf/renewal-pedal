import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class MyRepositoryImpl implements MyRepository {
  @override
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: const MyProfileEntity(
        userId: 'user_me',
        nickname: '페달러',
        followerCount: 128,
        followingCount: 64,
        notificationCount: 3,
        scrapCount: 12,
        likeCount: 2,
        ridingDistanceKm: 324.5,
        totalCaloriesKcal: 8500,
        totalHours: 42,
        totalDays: 18,
        postCount: 12,
        postThumbnailUrls: ['', '', '', '', '', ''],
      ),
    );
  }

  @override
  Future<({Failure? failure, List<ChallengeEntity>? data})>
  getParticipatedChallenges() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        ChallengeEntity(
          id: 'challenge_1',
          title: '4월 100km 완주 챌린지',
          startDate: DateTime(2026, 4, 1),
          endDate: DateTime(2026, 4, 30),
          distanceKm: 100,
          participantCount: 342,
        ),
        ChallengeEntity(
          id: 'challenge_2',
          title: '새벽 라이딩 5회 챌린지',
          startDate: DateTime(2026, 3, 15),
          endDate: DateTime(2026, 3, 31),
          distanceKm: 50,
          participantCount: 178,
        ),
      ],
    );
  }

  @override
  Future<({Failure? failure, List<CrewEntity>? data})>
  getParticipatedCrews() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        const CrewEntity(
          id: 'crew_1',
          name: '한강 라이더스',
          location: '서울 마포구',
          memberCount: 56,
        ),
        const CrewEntity(
          id: 'crew_2',
          name: '새벽 페달단',
          location: '서울 송파구',
          memberCount: 23,
        ),
        const CrewEntity(
          id: 'crew_3',
          name: '주말 힐클라이머',
          location: '경기 하남시',
          memberCount: 41,
        ),
      ],
    );
  }

  @override
  Future<({Failure? failure, List<SavedRouteEntity>? data})>
  getSavedRoutes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        SavedRouteEntity(
          id: 'route_1',
          name: '한강 자전거길',
          distanceKm: 24.3,
          durationMinutes: 72,
          savedAt: DateTime(2026, 4, 15, 7, 30),
        ),
        SavedRouteEntity(
          id: 'route_2',
          name: '북한산 둘레길',
          distanceKm: 18.7,
          durationMinutes: 55,
          savedAt: DateTime(2026, 4, 10, 6, 0),
        ),
      ],
    );
  }
}
