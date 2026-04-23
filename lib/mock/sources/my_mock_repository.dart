import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/my_mock_data.dart';

class MyMockRepository implements MyRepository {
  @override
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: const MyProfileEntity(
        userId: 'user_001',
        nickname: '페달러',
        profileImageUrl: null,
        followerCount: 42,
        followingCount: 18,
        notificationCount: 3,
        scrapCount: 10,
        likeCount: 87,
        ridingDistanceKm: 342.5,
        totalCaloriesKcal: 12800,
        totalHours: 68,
        totalDays: 30,
        postCount: 5,
        postThumbnailUrls: [],
      ),
    );
  }

  @override
  Future<({Failure? failure, List<ChallengeEntity>? data})> getParticipatedChallenges() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (failure: null, data: MyMockData.challengeList);
  }

  @override
  Future<({Failure? failure, List<CrewEntity>? data})> getParticipatedCrews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return (failure: null, data: <CrewEntity>[]);
  }

  @override
  Future<({Failure? failure, List<SavedRouteEntity>? data})> getSavedRoutes() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return (failure: null, data: <SavedRouteEntity>[]);
  }
}
