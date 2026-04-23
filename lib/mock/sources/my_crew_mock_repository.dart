import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/my_crew_mock_data.dart';

class MyCrewMockRepository implements MyRepository {
  @override
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile() async {
    throw UnimplementedError('MyCrewMockRepository: getMyProfile not implemented');
  }

  @override
  Future<({Failure? failure, List<ChallengeEntity>? data})> getParticipatedChallenges() async {
    throw UnimplementedError('MyCrewMockRepository: getParticipatedChallenges not implemented');
  }

  @override
  Future<({Failure? failure, List<CrewEntity>? data})> getParticipatedCrews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (failure: null, data: MyCrewMockData.crewList);
  }

  @override
  Future<({Failure? failure, List<SavedRouteEntity>? data})> getSavedRoutes() async {
    throw UnimplementedError('MyCrewMockRepository: getSavedRoutes not implemented');
  }
}
