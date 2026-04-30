import 'package:pedal/data/map/sources/map_remote_source.dart';
import 'package:pedal/data/models/map/route_response.dart';
import 'package:pedal/mock/data/map_mock_data.dart';

class MapMockRemoteSource implements MapRemoteSource {
  RouteResponse _entityToResponse(dynamic e) => RouteResponse(
    id: e.id,
    rideId: e.rideId,
    routeName: e.routeName,
    distance: e.distance,
    duration: e.duration,
    calories: e.calories,
  );

  @override
  Future<List<RouteResponse>> getSavedRoutes({String? search}) async {
    final routes = MapMockData.routes.map(_entityToResponse).toList();
    if (search == null || search.isEmpty) return routes;
    return routes.where((r) => r.routeName.contains(search)).toList();
  }

  @override
  Future<List<RouteResponse>> aiRecommendRoute(
    Map<String, dynamic> params,
  ) async {
    return MapMockData.routes.take(3).map(_entityToResponse).toList();
  }
}
