import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/my_routes_mock_data.dart';

class MyRoutesMockRepository implements MyRepository {
  @override
  Future<({Failure? failure, List<SavedRouteEntity>? data})>
  getSavedRoutes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (failure: null, data: MyRoutesMockData.routeList);
  }

  @override
  Future<({Failure? failure, MyProfileEntity? data})> getMyProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null, data: null);
  }

  @override
  Future<({Failure? failure, List<CrewEntity>? data})>
  getParticipatedCrews() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null, data: null);
  }
}
