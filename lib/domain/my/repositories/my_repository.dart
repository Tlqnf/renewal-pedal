import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class MyRepository {
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile();
  Future<({Failure? failure, List<ChallengeEntity>? data})> getParticipatedChallenges();
  Future<({Failure? failure, List<CrewEntity>? data})> getParticipatedCrews();
  Future<({Failure? failure, List<SavedRouteEntity>? data})> getSavedRoutes();
}
